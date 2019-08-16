module disassembler.parse.parse_modrm_sib;

import disassembler.all;
/**
 * 	See AMD64 Architecture Programmer's Manual Volume 3 - Page 534
 *
 *
 *
 */
void parseModrmSib(Parser p,
				   uint op1Size, uint op2Size,
				   Operand* op1 = null, Operand* op2 = null)
{
	auto modrm = ModRM(p.readByte(), p.prefix);

	p.instr.modrm    = modrm;
	p.instr.hasModrm = true;

	if(modrm.mod==0b11) {
		/* reg, reg */

		*op1 = new RegOperand(reg(modrm.rm, op1Size, p.prefix.hasRexBits));

		if(op2) {
			*op2 = new RegOperand(reg(modrm.reg, op2Size, p.prefix.hasRexBits));
		}

		return;
	}

	/* one side is memory and the other is a reg */

	if(modrm.mod==0b00 && (modrm.rm&0b111)==0b101) {
		/* RIP */

		auto disp32 = p.readDword();

		p.instr.displacement = Displacement(disp32, 32);

		*op1 = new RIPOperand(p.instr.getAddressSize()==64 ? Reg.RIP : Reg.EIP, disp32);
		if(op2) {
			*op2 = new RegOperand(reg(modrm.reg, op2Size, p.prefix.hasRexBits));
		}
		return;
	}

	if(modrm.rm==0b100) {
		/* SIB */
		SIB sib 	   = SIB(p.readByte(), p.prefix);
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

		auto base  = hasBase ? reg(sib.base, 64) : Reg.NONE;
		auto index = hasIndex ? reg(sib.index, 64) : Reg.NONE;

		*op1 = new SIBOperand(base, index, p.prefix.segreg, sib.scale, disp, dispNumBits);

		if(op2) {
			*op2 = new RegOperand(reg(modrm.reg, op2Size, p.prefix.hasRexBits));
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

	*op1 = new RegIndexOperand(reg(modrm.rm, 64), disp, dispNumBits);

	if(op2) {
		*op2 = new RegOperand(reg(modrm.reg, op2Size, p.prefix.hasRexBits));
	}
}


Reg reg(uint index, uint regSize, bool rex = false) {
	switch(regSize) {
		case 256: return RegYMM[index];
		case 128: return RegXMM[index];
		case 64: return Reg64[index];
		case 32: return Reg32[index];
		case 16: return Reg16[index];
		case 8:
			if(rex) return Reg8_rex[index];
			return Reg8[index];
		default: assert(false);
	}
}