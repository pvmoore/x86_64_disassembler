module disassembler.prefix;

import disassembler.all;

struct Prefix {
	enum Branch { UNKNOWN, TAKE, DONTTAKE }

	ubyte[] bytes;

	bool lock;
	bool rep;		// 0xF3
	bool repne; 	// 0xF2
	bool opSize;	// 0x66 true = 16 bit, false = 32 bit
	bool addrSize;	// 0x67 true = 16 bit, false = 32 bit
	Reg segreg    = Reg.NONE;
	Branch branch = Branch.UNKNOWN;

	// REX.W (bit 3) 0 = Default operand size, 1 = 64-bit operand size
	// REX.R (bit 2) 1-bit (msb) extension of the ModRM reg field1, permitting access to 16 registers.
	// REX.X (bit 1) 1-bit (msb) extension of the SIB index field1, permitting access to 16 registers.
	// REX.B (bit 0) 1-bit (msb) extension of the ModRM r/m field1, SIB base field1, or opcode reg field, permitting access to 16 registers.
	bool hasRexBits;
	uint rexBits;
	uint rexB() const { return (rexBits & 1); }
	uint rexX() const { return (rexBits & 2) >> 1; }
	uint rexR() const { return (rexBits & 4) >> 2; }
	uint rexW() const { return (rexBits & 8) >> 3; }

	bool hasVexBits;
	uint vexBits;
	bool vex2Byte() { return hasVexBits && vexBits==1; }
	bool vex3Byte() { return hasVexBits && vexBits==0; }

	bool hasXopBits;

	bool hasPrefix()  	  { return bytes.length>0; }
	bool hasSegOverride() { return segreg != Reg.NONE; }

	string toString() const  {
		if(bytes.length==0) return "";

		string s;
		if(rep) s   ~= "(F3 rep) ";
		if(repne) s ~= "(F2 repne) ";
		if(opSize) s ~= "(66 opSize) ";
		if(addrSize) s ~= "(67 addrSize) ";
		if(lock) s ~= "(lock) ";
		if(hasRexBits) s~="(rex %s%s%s%s) ".format(rexB()?"B":".", rexX()?"X":".", rexR()?"R":".", rexW()?"W":".");
		if(hasXopBits) s~="(xop) ";
		if(segreg!=Reg.NONE) s~="(%s)".format(segreg);

		return "%s".format(s);
	}
}
