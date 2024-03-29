module disassembler.parse.strategy.code;

import disassembler.all;

struct CodeAndSub {
	Code code;
	Sub sub;
	this(Code code, Sub sub) {
		this.code = code;
		this.sub  = sub;
	}
	this(string s) {
		string codeCh, subCh;
		if(s.startsWith("MSTAR")) {
			codeCh = "MSTAR";
			subCh  = s[5..$];
		} else {
			codeCh = s[0..1];
		 	subCh  = s[1..$];
		}
		this(codeCh.toCode(), subCh.toSub());
	}
	string toString() { return "%s%s".format(code, sub); }
}

enum Code {
	none,
	A,		// A far pointer encoded in the instruction. No ModRM byte in the instruction encoding
	B,		// General purpose reg (VEX/XOP.vvvv)
	C,		// Control reg (modrm.reg)
	D,		// Debug reg (modrm.reg)
	E,		// general purpose reg or mem (modrm.rm)
	F,		// rFLAGS reg
	G,		// general purpose reg (modrm.reg)
	H,		// YMM or XMM reg (VEX/XOP.vvvv)
	I,		// Immediate value
	J,		// The instruction includes a relative offset that is added to the rIP
	L,		// YMM/XMM register specified using the most-significant 4 bits of an 8-bit immediate value
	M,		// A memory operand specified by the ModRM byte. ModRM.mod ≠ 11b
	MSTAR,	// A sparse array of memory operands addressed using the VSIB addressing mode
	N,		// 64-bit MMX reg (modrm.rm) - The ModRM.mod field must be 11b
	P,		// 64-bit MMX reg (modrm.reg)
	Q,		// 64-bit MMX reg or mem (modrm.rm)
	R,		// General purpose reg (modrm.rm) - The ModRM mod field must be 11b
	S,		// segment reg (modrm.reg)
	U,		// YMM/XMM reg (modrm.rm) - The ModRM.mod field must be 11b
	V,		// YMM/XMM reg (modrm.reg) - The ModRM mod field must be 11b
	W,	    // YMM/XMM reg or mem (modrm.rm)
}
Code toCode(string ch) {
	import std.traits : EnumMembers;
    foreach(e; EnumMembers!Code) {
        auto s = "%s".format(e);
		if(s == ch) return e;
	}
	assert(false, "code not found %s".format(ch));
}
bool isReg(Code c) {
	switch(c) with(Code) {
		case B: case C: case D: case G: case H: case L: case N: case P: case R: case S: case U: case V: return true;
		default: return false;
	}
}
bool isVVVV(Code c) {
	return c==Code.B || c==Code.H;
}
uint getSize(Code c, Parser p) {
	switch(c) with(Code) {
		case B:
			return p.avxW() ? 64 : 32;
		case C:
		case D:
		case G:
		case R:
		case E:
		case M:
			return p.instr.getOperandSize();
		case N:
		case P:
		case Q:
			return 64;
		case S:
			return 16;
		case H:
		case U:
		case V:
		case W:
		case MSTAR:
		case L:
			return p.avxL() ? 256 : 128;

		default: assert(false, "implement me %s".format(c));
	}
	assert(false);
}
