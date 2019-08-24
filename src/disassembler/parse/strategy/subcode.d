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
	pw,		// packed 16-bit.
	pdw,	// packed 32-bit (unsigned?)
	pqw,	// packed 64-bit (unsigned?)

	pk,		// packed 8-bit
	pi,		// packed 16-bit
	pj,		// packed 32-bit
	pq, 	// packed 64-bit
	ph,		// packed 16-bit float

	pd,		// packed 64-bit (doubles)
	ps,		// packed 32-bit (floats)
	sd,		// scalar (double)
	ss,		// scalar (float)

	v,		// 16/32/64-bit depends on operand size
	w,		// 16-bit
	y,		// 32/64-bit depends on operand size
	z,		// 16/32-bit depends on operand size

	x,
	pbx,	// pb  - 128/256 bit depending on VEX.L
	pwx,	// pw  - 128/256 bit depending on VEX.L
	pdwx,	// pdw - 128/256 bit depending on VEX.L
	pdx,	// pd  - 128/256 bit depending on VEX.L
	phx,	// ph  - 128/256 bit depending on VEX.L
	pix,	// pi  - 128/256 bit depending on VEX.L
	pkx,	// pk  - 128/256 bit depending on VEX.L
	pqx,	// pq  - 128/256 bit depending on VEX.L
	psx,	// ps  - 128/256 bit depending on VEX.L
    pjx,    // pj  - 128/256 bit depending on VEX.L
	pqwx,	// pqw - 128/256 bit depending on VEX.L
	o_qx,	// o_q - 128/256 bit depending on VEX.L
}
Sub toSub(string ch) {
	import std.traits : EnumMembers;
    foreach(e; EnumMembers!Sub) {
        auto s = "%s".format(e);
		if(s == ch) return e;
	}
	if(ch=="do") return Sub.do_;

	assert(false, "sub not found %s".format(ch));
}
uint getRegSize(Sub s, Parser p) {
	switch(s) {
		case Sub.ph:
			return 16;
        case Sub.b: return 8;
        case Sub.w: return 16;
        case Sub.d:
        case Sub.ss:
            return 32;
        case Sub.sd:
        case Sub.q:
        case Sub.o_q:
            return 64;
		case Sub.o:
			return 128;
        case Sub.do_:
			return 256;
        case Sub.p: return p.prefix.opSize ? 32 : 48;
		case Sub.pb:
		case Sub.pdw:
		case Sub.pqw:
		case Sub.pw:
		case Sub.pi:
        case Sub.ps:
        case Sub.pd:
		case Sub.pq:
            return p.avxW() ? 256 : 128;
		case Sub.x:
		case Sub.pbx:
		case Sub.phx:
		case Sub.pix:
		case Sub.pkx:
		case Sub.pwx:
		case Sub.pdwx:
        case Sub.psx:
        case Sub.pdx:
		case Sub.pqx:
		case Sub.pjx:
		case Sub.pqwx:
		case Sub.o_qx:
            return p.avxL() ? 256 : 128;
        case Sub.v: return p.instr.getOperandSize();
        case Sub.y: return maxOf(32, p.instr.getOperandSize());
        case Sub.z: return minOf(32, p.instr.getOperandSize());

        case Sub.none: return 0;

		default: assert(false, "implement me %s".format(s));
	}
}
uint getMemSize(Sub s, Parser p) {
	switch(s) {
		case Sub.b:
		case Sub.pb:
			return 8;
		case Sub.w:
		case Sub.ph:
		case Sub.pw:
			return 16;
        case Sub.d:
        case Sub.ss:
		case Sub.ps:
		case Sub.pi:
		case Sub.pdw:
            return 32;
        case Sub.sd:
        case Sub.q:
        case Sub.o_q:
		case Sub.pd:
		case Sub.pq:
		case Sub.pqw:
            return 64;
		case Sub.o:
			return 128;
        case Sub.do_:
			return 256;
        case Sub.p:
			return p.prefix.opSize ? 32 : 48;

		case Sub.x:
		case Sub.psx:
		case Sub.pbx:
		case Sub.pdx:
		case Sub.pkx:
		case Sub.pix:
		case Sub.pqx:
		case Sub.o_qx:
		case Sub.pqwx:
		case Sub.pdwx:
		case Sub.pjx:
		case Sub.pwx:
		case Sub.phx:
			return p.avxL() ? 256 : 128;

        case Sub.v: return p.instr.getOperandSize();
        case Sub.y: return maxOf(32, p.instr.getOperandSize());
        case Sub.z: return minOf(32, p.instr.getOperandSize());

        case Sub.none:
			return 0;

		default: assert(false, "implement me %s".format(s));
	}
}
