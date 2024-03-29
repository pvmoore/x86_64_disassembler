module disassembler.sib;

import disassembler.all;
/**
 *  Scale Index Base
 *
 * |  7 6  | 5 4 3 | 2 1 0 |
 * | scale | index | base  |
 *
 */
struct SIB {
	uint scale;
	uint index;
	uint base;

	this(uint i, Parser p) {
		scale = (i >>> 6) & 0b11;
		index = (i >>> 3) & 0b111;
		base  = (i & 0b111);

        index |= (p.prefix.rexX()<<3);	// REX.X
		index |= (p.avxX()<<3);			// VEX.X

		base  |= (p.prefix.rexB()<<3);	// REX.B
		base  |= (p.avxB()<<3);		    // VEX.B
	}
	string toString() const {
		return "scale=%02b index=%04b base=%04b".format(scale, index, base);
	}
}
