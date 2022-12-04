module disassembler.parse.strategy.parse_strategy;

import disassembler.all;

interface ParseStrategy {
    void parse(Parser p);
}

final class Composite : ParseStrategy {
	private ParseStrategy[] strategies;

	this() {

	}
	this(const ParseStrategy s1, const ParseStrategy s2) {
		this.strategies = cast(ParseStrategy[])[s1, s2];
	}
	this(const ParseStrategy s1, const ParseStrategy s2, const ParseStrategy s3) {
		this.strategies = cast(ParseStrategy[])[s1, s2, s3];
	}
	void parse(Parser p) {
		foreach(s; strategies) {
			s.parse(p);
		}
	}
}

final class Eb : ParseStrategy {
	// reg/mem8
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.E, Sub.b));
		assert(op1);

		op1.ptrSize = 8;

		p.instr.addOperand(op1);
	}
}
final class Ew : ParseStrategy {

	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p,  &op1, null, CodeAndSub(Code.E, Sub.w));
		assert(op1);

		op1.ptrSize = 16;

		p.instr.addOperand(op1);
	}
}
final class Ev : ParseStrategy {
	// reg/mem (16/32/64)
	void parse(Parser p) {
		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.E, Sub.v));
		assert(op1);

		op1.ptrSize = p.instr.getOperandSize();

		p.instr.addOperand(op1);
	}
}
final class EvIb : ParseStrategy {
	// reg/mem (16/32/64), 8 bit imm
	void parse(Parser p) {
		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.E, Sub.v));
		assert(op1);

		op1.ptrSize = p.instr.getOperandSize();

		p.instr.addOperand(op1);

		// Ib
		auto value = p.readByte();
		p.instr.addOperand(new ImmOperand(value, 8));
		p.instr.immediate = Immediate(value, 8);
	}
}
final class EvIz : ParseStrategy {
	// reg/mem (16/32/64), 16/32 bits
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.E, Sub.v));
		assert(op1);

		op1.ptrSize = minOf(32, p.instr.getOperandSize());

		p.instr.addOperand(op1);

		// Iz
		auto numBits = minOf(32, p.instr.getOperandSize());
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Ov : ParseStrategy {
	// offset coded in the instruction
	void parse(Parser p) {
		todo("implement me");
	}
}

/* 8 bit reg */
final class bReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		auto r = register + 8*p.prefix.rexB();
		p.instr.addOperand(new RegOperand(getReg(r , 8, p.prefix.hasRexBits)));
	}
}
/* 16 bit reg */
final class wReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		p.instr.addOperand(new RegOperand(getReg(register , 16)));
	}
}
/* 16/32 bit reg */
final class eReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		p.instr.addOperand(new RegOperand(getReg(register , minOf(32, p.instr.getOperandSize()))));
	}
}
/* 64 or 32 bit register specified by the register argument */
final class rReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		auto r = p.prefix.rexB() ? register+8 : register;

		p.instr.addOperand(new RegOperand(getReg(r, p.instr.getOperandSize())));
	}
}
final class b1 : ParseStrategy {
	// 8 bit value of 1
	void parse(Parser p) {
		p.instr.addOperand(new ImmOperand(1, 8));
	}
}
final class _b : ParseStrategy {
	// 8 bit postfix eg. stosb
	void parse(Parser p) {
		p.instr.mnemonic ~= "b";
	}
}
final class _v : ParseStrategy {
	// 16/32/64 bit postfix eg. stosw/d
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(p.instr.getOperandSize());
	}
}
final class _z : ParseStrategy {
	// 16/32 bit postfix eg. stosw/d
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(minOf(32, p.instr.getOperandSize()));
	}
}
final class Fv : ParseStrategy {
	// rFLAGS 16/32/64 bit postfix eg. pushfd
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(p.instr.getOperandSize());
	}
}

final class I_sub : ParseStrategy {
	Sub sub;
	this(Sub sub) { this.sub = sub; }

	void parse(Parser p) {
		uint numBits;

		switch(sub) {
			case Sub.b: numBits = 8; break;
			case Sub.w: numBits = 16; break;
			case Sub.q:
			case Sub.v: numBits = p.instr.getOperandSize(); break;
			case Sub.z: numBits = minOf(p.instr.getOperandSize(), 32); break;

			default: assert(false, "implement me");
		}

		auto value = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}

final class Ib : ParseStrategy {
	// imm8
	void parse(Parser p) {
		auto value = p.readByte();

		p.instr.addOperand(new ImmOperand(value, 8));

		p.instr.immediate = Immediate(value, 8);
	}
}
final class Iw : ParseStrategy {
	// imm16
	void parse(Parser p) {
		auto value = p.readWord();

		p.instr.addOperand(new ImmOperand(value, 16));

		p.instr.immediate = Immediate(value, 16);
	}
}
final class Iv : ParseStrategy {
	// imm (16/32/64)
	void parse(Parser p) {
		auto numBits = p.instr.getOperandSize();
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Iz : ParseStrategy {
	// imm (16/32)
	void parse(Parser p) {
		auto numBits = minOf(p.instr.getOperandSize(), 32);
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Jb : ParseStrategy {
	// 8 bit offset relative to RIP
	void parse(Parser p) {
		int value = cast(byte)p.readByte();

		p.instr.addOperand(new ImmOperand(value, 8));

		p.instr.immediate = Immediate(value, 8);

		p.addJumpTarget(value);
	}
}
final class Jz : ParseStrategy {
	// 16/32 bit offset relative to RIP

	void parse(Parser p) {
		auto numBits = minOf(p.instr.getOperandSize(), 32);
		auto value   = cast(int)p.read(numBits);

		auto op = new RIPOperand(p.instr.getAddressSize()==64 ? Reg.RIP : Reg.EIP, value);
		p.instr.addOperand(op);

		p.instr.displacement = Displacement(value, numBits);

		p.addJumpTarget(value);

		/* TODO - fixme
		if(state.instr.opcode=="call" && state.instr.offset+1 in state.objFile.getFixupsForSegment(1))
		{
			//writefln("call @ offset %d",state.instr.offset+1);
			state.instr.str = state.instr.opcode ~ " ";
			EXTDEF[] externs = state.objFile.getExterns();
			FIXUPP[int] fixupsForSegment = state.objFile.getFixupsForSegment(1);
			int targetIndex = fixupsForSegment[state.instr.offset+1].targetIndex;
			//writefln("targetIndex=%d",targetIndex);
			state.instr.str ~= Utils.demangleMethod(externs[targetIndex-1].name);
		}
		else
		{
			// TODO - display a label here instead of an offset
			int off = state.instr.prefix.opSize ? Utils.signExtendWord(a) : a;
			uint labelOffset = state.instr.offset + state.instr.bytes.length + off;
			state.labels.add(labelOffset);
			//state.instr.str = state.instr.opcode ~ " " ~
			//	Utils.formatNumber(state.instr.offset + state.instr.bytes.length + off, 32);
			state.instr.str = state.instr.opcode ~  " " ~ state.labels.get(labelOffset);
		}

		// if(state.instr.prefix.branch==Branch.TAKE)
		// {
		// 	state.instr.comment ~= "HINT: take branch";
		// }
		// else if(state.instr.prefix.branch==Branch.DONTTAKE)
		// {
		// 	state.instr.comment ~= "HINT: don't take branch";
		// }
		*/
	}
}

final class M_sub : ParseStrategy {
	// mem
	Sub sub;

	this(Sub sub = Sub.none) {
		this.sub = sub;
	}

	void parse(Parser p) {

		uint size = p.instr.getOperandSize();
		switch(sub) {
			case Sub.b: size = 8; break;
			case Sub.w: size = 16; break;
			case Sub.d: size = 32; break;
			case Sub.q: size = 64; break;
			case Sub.o: size = 128; break;
			case Sub.p: size = p.prefix.opSize ? 32 : 48; break; // check this
			default: break;
		}

		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.M, sub));
		assert(op1);

		op1.ptrSize = size;

		p.instr.addOperand(op1);
	}
}
final class Mw_or_Rv : ParseStrategy {
	void parse(Parser p) {

		//uint size = p.prefix.rexW() ? 64 : 16;

		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.R, p.prefix.rexW() ? Sub.v : Sub.w));
		assert(op1);

		p.instr.addOperand(op1);
	}
}

final class Rv : ParseStrategy {
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, &op1, null, CodeAndSub(Code.R, Sub.v));
		assert(op1);

		p.instr.addOperand(op1);
	}
}
final class Nq : ParseStrategy {
	// MMX reg (modrm.rm)
	void parse(Parser p) {

		auto rm    = ModRM(p.readByte()).rm;
		Operand op = new RegOperand(RegMMX[rm]);

		p.instr.addOperand(op);
	}
}
final class Uo : ParseStrategy {
	// XMM/YMM reg (modrm.rm)
	void parse(Parser p) {

		auto rm    = ModRM(p.readByte()).rm;
		auto regs  = p.prefix.hasVexBits ? RegYMM : RegXMM;
		Operand op = new RegOperand(regs[rm]);

		p.instr.addOperand(op);
	}
}
final class Voq : ParseStrategy {
	// XMM/YMM reg (modrm.reg)
	void parse(Parser p) {

		auto reg = ModRM(p.readByte()).reg;
		auto regs  = p.prefix.hasVexBits ? RegYMM : RegXMM;
		Operand op = new RegOperand(regs[reg]);

		p.instr.addOperand(op);
	}
}

final class VPERMIL2XX : ParseStrategy {
	ParseStrategy decorated;
	this(const ParseStrategy decorated) { this.decorated = cast(ParseStrategy)decorated; }

	void parse(Parser p) {
		/* Handle the operands */
		decorated.parse(p);

		/* Read the Ib */
		// auto Ib = p.readByte();

		// string perm;
		// switch(Ib) {
		// 	case 0: perm = "td"; break;
		// 	case 1: perm = "td"; break;
		// 	case 2: perm = "mo"; break;
		// 	case 3: perm = "mz"; break;
		// 	default: break;
		// }

		// todo - do something with _perm_ information

		//p.instr.addOperand(new ImmOperand(Ib, 8));

		//p.instr.immediate = Immediate(Ib, 8);
	}
}

final class VCMPccXX : ParseStrategy {
	ParseStrategy vhw;
	this(const ParseStrategy vhw) { this.vhw = cast(ParseStrategy)vhw; }

	void parse(Parser p) {
		/* Handle the operands */
		vhw.parse(p);

		/* Read the Ib and set the mnemonic */
		auto Ib = p.readByte();

		string cond;
		switch(Ib) {
			case 0: cond = "eq"; break;
			case 1: cond = "lt"; break;
			case 2: cond = "le"; break;
			case 3: cond = "unord"; break;
			case 4: cond = "neq"; break;
			case 5: cond = "nlt"; break;
			case 6: cond = "nle"; break;
			case 7: cond = "ord"; break;

			case 8: cond = "eq_uq"; break;
			case 9: cond = "nge"; break;
			case 10: cond = "ngt"; break;
			case 11: cond = "false"; break;
			case 12: cond = "neq_oq"; break;
			case 13: cond = "ge"; break;
			case 14: cond = "gt"; break;
			case 15: cond = "true"; break;

			case 16: cond = "eq_os"; break;
			case 17: cond = "lt_oq"; break;
			case 18: cond = "le_oq"; break;
			case 19: cond = "unord_s"; break;
			case 20: cond = "neq_us"; break;
			case 21: cond = "nlt_uq"; break;
			case 22: cond = "nle_uq"; break;
			case 23: cond = "ord_s"; break;

			case 24: cond = "eq_us"; break;
			case 25: cond = "nge_uq"; break;
			case 26: cond = "ngt_uq"; break;
			case 27: cond = "false_os"; break;
			case 28: cond = "neq_os"; break;
			case 29: cond = "ge_oq"; break;
			case 30: cond = "gt_oq"; break;
			case 31: cond = "true_us"; break;

			default: cond = "???"; break;
		}
		/* mnemonic should be something like "vcmp%sps" */
		p.instr.mnemonic = p.instr.mnemonic.format(cond);
	}
}


public final class ModRMSIB : ParseStrategy {
	CodeAndSub[] codes;
	CodeAndSub codeH;	// avx third operand specified by vvvv
	CodeAndSub codeL;	// avx fourth operand (Code.L) specified by an immediate value
	uint opHIndex;		// index of third operand (0,1 or 2 = left, middle or right)
	uint opLIndex;		// index of L operand (0,1,2,3 or 4)
	bool swap;			// true if the reg op is the src otherwise reg is the dest

	this(string[] strings...) {

		foreach(i, str; strings) {
			auto cas = CodeAndSub(str);
			if(cas.code.isVVVV()) {
				this.setH(cas, i.as!uint);
			} else if(cas.code==Code.L) {
				this.setL(cas, i.as!uint);
			} else {
				this.addOp(cas);
			}
		}
		//assert(instance.codes.length==2, "%s".format(strings));
		if(strings.length>2) assert(this.codeH.code != Code.none);
		if(strings.length>3) assert(this.codeL.code != Code.none);
	}

	void addOp(CodeAndSub cas) {
		if(this.codes.length==1) {
			this.swap = !this.codes[0].code.isReg();

			if(this.swap) {
				/* Swap the operands*/
				auto temp = this.codes[0];
				this.codes[0] = cas;
				cas = temp;
			}
		}
		this.codes ~= cas;
	}
	void setH(CodeAndSub code, uint index) {
		this.codeH    = code;
		this.opHIndex = index;
	}
	void setL(CodeAndSub code, uint index) {
		this.codeL    = code;
		this.opLIndex = index;
	}
	void parse(Parser p) {

		Operand op1, op2;

		//chat("%s ---> %s %s %s", p.instr.mnemonic, codes, codeH, codeL);
		//chat("codes=%s swap=%s avx=%s rex=%s", codes, swap, p.instr.avx, p.prefix.rexBits);

		if(codes.length==2) {
			parseModrmSib(p, &op2, &op1, codes[1], codes[0]);

			op2.ptrSize = getPtrSize(p, codes[0], codes[1]);

			//chat("ptrSize = %s", op2.ptrSize);

			if(swap) {
				p.instr.addOperand(op2);
				p.instr.addOperand(op1);
			} else {
				p.instr.addOperand(op1);
				p.instr.addOperand(op2);
			}
		} else {
			parseModrmSib(p, &op1, null, codes[0]);
			op1.ptrSize = getPtrSize(p, codes[0], codes[0]);

			p.instr.addOperand(op1);
		}

		auto _handleH() {
			/* Handle operand 3 */
			Operand op;
			uint vvvvSize = codeH.code.getSize(p);

			if(codeH.code==Code.B) {
				/* GP reg */
				auto reg = Reg64[15-p.instr.avx.vvvv];
				op = new RegOperand(reg);
			} else {
				/* XMM/YMM reg */
				auto regs = vvvvSize==128 ? RegXMM : RegYMM;
				auto reg = regs[15-p.instr.avx.vvvv];
				op = new RegOperand(reg);
			}

			return op;
		}
		auto _handleL() {
			/* Handle operand 4 */
			uint index = p.readByte() >>> 4;
			auto regs  = getRegs(p, codeL.code, codeL.sub);
			auto reg   = regs[index];
			return new RegOperand(reg);
		}

		Operand opH, opL;

		if(codeH.code!=Code.none) {
			opH = _handleH();
		}
		if(codeL.code!=Code.none) {
			opL = _handleL();
		}

		if(opL && opH) {

			if(opLIndex < opHIndex) {
				/* swap them round - not sure why this is necessary?? */
				auto temp = opLIndex;
				opLIndex = opHIndex;
				opHIndex = temp;
			}

			p.instr.insertOperandAt(opHIndex, opH);
			p.instr.insertOperandAt(opLIndex, opL);

		} else if(opH) {
			p.instr.insertOperandAt(opHIndex, opH);
		} else if(opL) {
			p.instr.insertOperandAt(opLIndex, opL);
		}
	}
}
