module disassembler.parse.parse_modrm_sib;

import disassembler.all;
/**
 * 	See AMD64 Architecture Programmer's Manual Volume 3 - Page 534
 *
 *
 */
void parseModrmSib(Parser p,
				   Operand* op1,
				   Operand* op2,
				   CodeAndSub op1Code,
				   CodeAndSub op2Code = CodeAndSub(Code.none, Sub.none))
{
	auto modrm = ModRM(p.readByte(), p);

	p.instr.modrm    = modrm;
	p.instr.hasModrm = true;

	if(modrm.mod==0b11) {
		/* reg, reg */

		*op1 = new RegOperand(getReg(p, modrm.rm, op1Code));

		if(op2) {
			*op2 = new RegOperand(getReg(p, modrm.reg, op2Code));
		}

		return;
	}

	/* One side is memory and the other is a reg */

	if(modrm.mod==0b00 && (modrm.rm&0b111)==0b101) {
		/* RIP */

		auto disp32 = p.readDword();

		p.instr.displacement = Displacement(disp32, 32);

		*op1 = new RIPOperand(p.instr.getAddressSize()==64 ? Reg.RIP : Reg.EIP, disp32);
		if(op2) {
			*op2 = new RegOperand(getReg(p, modrm.reg, op2Code));
		}
		return;
	}

	if(modrm.rm==0b100) {
		/* SIB */
		SIB sib 	   = SIB(p.readByte(), p);
		p.instr.sib    = sib;
		p.instr.hasSib = true;

		auto hasDisp8  = modrm.mod==0b01;
		auto hasDisp32 = modrm.mod==0b10;
		hasDisp32     |= (modrm.mod==0b00 && (sib.base==0b101 || sib.base==0b1101));

		auto hasBase  = modrm.mod!=0b00 || (sib.base&0b111)!=0b101;
		auto hasIndex = sib.index!=0b100;

		int disp;
		uint dispNumBits = 0;

		if(hasDisp8) {
			disp = p.readByte();
			dispNumBits = 8;

			p.instr.displacement = Displacement(disp, 8);
		} else if(hasDisp32) {
			disp = p.readDword();
			dispNumBits = 32;

			p.instr.displacement = Displacement(disp, 32);
		}

		auto base  = hasBase ? getReg(p, sib.base) : Reg.NONE;
		auto index = hasIndex ? getReg(p, sib.index) : Reg.NONE;

		*op1 = new SIBOperand(base, index, p.prefix.segreg, sib.scale, disp, dispNumBits);

		if(op2) {
			*op2 = new RegOperand(getReg(p, modrm.reg, op2Code));
		}

		return;
	}

	/* rm + disp8/32 */
	auto hasDisp8  = modrm.mod==0b01;
	auto hasDisp32 = modrm.mod==0b10;

	int disp;
	uint dispNumBits = 0;

	if(hasDisp8) {
		disp 		= p.readByte();
		dispNumBits = 8;

		p.instr.displacement = Displacement(disp, 8);
	} else if(hasDisp32) {
		disp 		= p.readDword();
		dispNumBits = 32;

		p.instr.displacement = Displacement(disp, 32);
	}

	*op1 = new RegIndexOperand(getReg(p, modrm.rm), disp, dispNumBits);

	if(op2) {
		*op2 = new RegOperand(getReg(p, modrm.reg, op2Code));
	}
}
