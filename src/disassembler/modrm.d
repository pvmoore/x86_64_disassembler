module disassembler.modrm;

import disassembler.all;
/**
 *	Mode-Register-Memory
 *
 *  | 7 6 | 5 4 3 | 2 1 0 |
 *  | mod |  reg  |  r/m  |
 */
struct ModRM {
	uint mod;
	uint reg;
	uint rm;

	this(uint i) {
		mod = (i >>> 6) & 0b11;
		reg = (i >>> 3) & 0b111;
		rm  = (i & 0b111);
	}
	this(uint i, Parser p) {
		this(i);

		reg |= (p.prefix.rexR()<<3);	// REX.R
		reg |= ((p.avxR())<<3);			// VEX.R

		rm  |= (p.prefix.rexB()<<3);	// REX.B
		rm  |= ((p.avxB())<<3);			// VEX.B
	}

	string toString() const {
		return "mod=%02b reg=%04b rm=%04b".format(mod, reg, rm);
	}
}