module disassembler.parse.strategy.subcode;

import disassembler.all;

enum Sub {
	none,
	b,		// 8-bit
	d,		// 32-bit
	do_,    // 256-bit
	d_q,	// d/q - 32-bit or 64-bit
	o,		// 128-bit
	o_q,	// upper/lower half of 128 bits --> 64 bits
	q,		// 64-bit
	p,		// 32-bit or 48-bit far pointer
	pb,		// packed 8-bit
	pdw,	// packed 32-bit (unsigned?)
	pi,		// packed 16-bit
	pj,		// packed 32-bit
	pk,		// packed 8-bit
	pq, 	// packed 64-bit
	pqw,	// packed 64-bit (unsigned?)
	pd,		// packed 64-bit
	ps,		// packed 32-bit
	pw,		// packed 16-bit.
	sd,		// double-scalar
	ss,		// single-scalar
	v,		// 16/32/64-bit depends on operand size
	w,		// 16-bit
	y,		// 32/64-bit depends on operand size
	z,		// 16/32-bit depends on operand size

	pdx,	// pd - 128/256 bit depending on VEX.L
	psx,	// ps - 128/256 bit depending on VEX.L
    pjx,    // pj - 128/256 bit depending on VEX.L
}
Sub toSub(string ch) {
	import std.traits : EnumMembers;
    foreach(e; EnumMembers!Sub) {
        auto s = "%s".format(e);
		if(s == ch) return e;
	}
	if(ch=="do") return Sub.do_;
	return Sub.none;
}
uint getSize(Sub s, Parser p) {
	switch(s) {
        case Sub.b: return 8;
        case Sub.w: return 16;
        case Sub.d:
        case Sub.ss:
            return 32;
        case Sub.sd:
        case Sub.q:
        case Sub.o_q:
            return 64;
		case Sub.o: return 128;
        case Sub.do_: return 256;
        case Sub.p: return p.prefix.opSize ? 32 : 48;
        case Sub.ps:
        case Sub.pd:
            return p.avxW() ? 256 : 128;
        case Sub.psx:
        case Sub.pdx:
            return p.avxL() ? 256 : 128;
        case Sub.v: return p.instr.getOperandSize();
        case Sub.y: return maxOf(32, p.instr.getOperandSize());
        case Sub.z: return minOf(32, p.instr.getOperandSize());

        case Sub.none: return 0;

		default: assert(false, "implement me %s".format(s));
	}
}