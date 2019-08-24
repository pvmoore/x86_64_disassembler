module disassembler.enums;

import disassembler.all;

enum Hint : uint {
    NONE = 0,           // No hint
    SIZE_8,             // Use 8 bit
    SIZE_16,            // Use 16 bit
    SIZE_32,            // Use 32 bit
    SIZE_64,            // Use 64 bit
    PTR_SIZE_32,        // Ptr size is dword
    PTR_SIZE_128,       // Ptr size is xmmword
    PTR_SIZE_256,       // Ptr size is ymmword
    PTR_SIZE_L256_128,  // Ptr size is 256 if L=1 otherwise 128
    PTR_SIZE_L128_64,   // Ptr size is 128 if L=1 otherwise 64
}
bool hasHint(inout Hint[] hints, Hint h) {
    foreach(hint; hints) if(h==hint) return true;
    return false;
}
Hint getPtrSizeHint(inout Hint[] hints) {
    foreach(hint; hints) with(Hint) {
        switch(hint) {
            case PTR_SIZE_32:
            case PTR_SIZE_128:
            case PTR_SIZE_256:
            case PTR_SIZE_L256_128:
            case PTR_SIZE_L128_64:
                return hint;
            default: break;
        }
    }
    return Hint.NONE;
}

// https://en.wikipedia.org/wiki/X86_instruction_listings
enum IS : uint {
    /* x86_64 Standard Instructions */
    STD = 0,

    MMX,
    SSE,
    SSE2,
    /* Instruction sets after x86_64/SSE2 */
    SSE3,       // (Prescott)
    SSSE3,      // (Sandy Bridge)

    SSE4_1,     // (Penryn)
    SSE4_2,     // (Nehalem)

    AVX,        // (Sandy Bridge)
    AVX2,       // (Haswell)
    AVX_512,    // Knights Landing, Skylake-X, Cannon Lake

    FMA3,       // (Haswell, Piledriver)        https://en.wikipedia.org/wiki/FMA_instruction_set
    FMA4,       // AMD only. Removed
    XOP,        // AMD only. Removed with Zen

    F16C,       // CVT16 Half precision float conversions (Ivy Bridge)  https://en.wikipedia.org/wiki/F16C
    AES,        // Advanced Encryption Standard (Westmere)    https://en.wikipedia.org/wiki/AES_instruction_set
    CLMUL,      // Carry-less Multiplication (Westmere)
    SHA,        // Secure Hash Algorithm (Goldmont, Zen) https://en.wikipedia.org/wiki/Intel_SHA_extensions
    TXT,        // Trusted Execution Technology
    TSX,        // Transactional Synchronization Extensions (Broadwell)
    SGX,        // Software Guard Extensions
    RDRAND,     // Random number generator (Ivy Bridge) https://en.wikipedia.org/wiki/RdRand

    AMD_V,      // AMD Virtualization
    VT_x,       // Intel Virtualization
    VT_d,       // ?
}

enum Reg {
    NONE = 0,

    AL, AH, AX, EAX, RAX,
    BL, BH, BX, EBX, RBX,
    CL, CH, CX, ECX, RCX,
    DL, DH, DX, EDX, RDX,

    DIL, DI, EDI, RDI,
    SIL, SI, ESI, RSI,

    BPL, BP, EBP, RBP,

    SPL, SP, ESP, RSP,

    IP, EIP, RIP,

    R8B,  R8W,  R8D,  R8,
    R9B,  R9W,  R9D,  R9,
    R10B, R10W, R10D, R10,
    R11B, R11W, R11D, R11,
    R12B, R12W, R12D, R12,
    R13B, R13W, R13D, R13,
    R14B, R14W, R14D, R14,
    R15B, R15W, R15D, R15,

    CS, DS, ES, FS, GS, SS,

    CR0, CR1, CR2, CR3, CR4, CR5, CR6, CR7, CR8, CR9, CR10, CR11, CR12, CR13, CR14, CR15,
    DR0, DR1, DR2, DR3, DR4, DR5, DR6, DR7, DR8, DR9, DR10, DR11, DR12, DR13, DR14, DR15,
    TR0, TR1, TR2, TR3, TR4, TR5, TR6, TR7,

    /* MMX (64 bits) */
    MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7,

    /* SSE (128 bits) */
    XMM0, XMM1, XMM2,  XMM3,  XMM4,  XMM5,  XMM6,  XMM7,
    XMM8, XMM9, XMM10, XMM11, XMM12, XMM13, XMM14, XMM15,

    /* AVX (256 bits) */
    YMM0, YMM1, YMM2,  YMM3,  YMM4,  YMM5,  YMM6,  YMM7,
    YMM8, YMM9, YMM10, YMM11, YMM12, YMM13, YMM14, YMM15,

    /* AVX 512 (512 bits) */
    ZMM0, ZMM1, ZMM2, ZMM3, ZMM4, ZMM5, ZMM6, ZMM7, // etc
}
string toString(Reg r) {
    return "%s".format(r);
}
bool isReg(string s) {
    import std.traits : EnumMembers;

    static foreach(r; EnumMembers!Reg) {
        if(s==r.toString()) return true;
    }
    return false;
}

enum Nibble : uint { _00=0, _01, _02, _03, _04, _05, _06, _07, _08, _09, _0A, _0B, _0C, _0D, _0E, _0F }


/*
    Note: AH could be SPL, CH could be BPL, DH could be SIL and BH could be DIL
*/
__gshared immutable Reg8 = [
    Reg.AL,  Reg.CL,  Reg.DL,   Reg.BL,   Reg.AH,   Reg.CH,   Reg.DH,   Reg.BH,     // REX.R == 0
    Reg.R8B, Reg.R9B, Reg.R10B, Reg.R11B, Reg.R12B, Reg.R13B, Reg.R14B, Reg.R15B    // REX.R == 1
];
__gshared immutable Reg8_rex = [
    Reg.AL,  Reg.CL,  Reg.DL,   Reg.BL,   Reg.SPL,  Reg.BPL,  Reg.SIL,  Reg.DIL,    // REX.R == 0
    Reg.R8B, Reg.R9B, Reg.R10B, Reg.R11B, Reg.R12B, Reg.R13B, Reg.R14B, Reg.R15B    // REX.R == 1
];
__gshared immutable Reg16 = [
    Reg.AX,  Reg.CX,  Reg.DX,   Reg.BX,   Reg.SP,   Reg.BP,   Reg.SI,   Reg.DI,     // REX.R == 0
    Reg.R8W, Reg.R9W, Reg.R10W, Reg.R11W, Reg.R12W, Reg.R13W, Reg.R14W, Reg.R15W    // REX.R == 1
];
__gshared immutable Reg32 = [
    Reg.EAX, Reg.ECX, Reg.EDX,  Reg.EBX,  Reg.ESP,  Reg.EBP,  Reg.ESI,  Reg.EDI,    // REX.R == 0
    Reg.R8D, Reg.R9D, Reg.R10D, Reg.R11D, Reg.R12D, Reg.R13D, Reg.R14D, Reg.R15D    // REX.R == 1
];
__gshared immutable Reg64 = [
    Reg.RAX, Reg.RCX, Reg.RDX, Reg.RBX, Reg.RSP, Reg.RBP, Reg.RSI, Reg.RDI,         // REX.R == 0
    Reg.R8,  Reg.R9,  Reg.R10, Reg.R11, Reg.R12, Reg.R13, Reg.R14, Reg.R15          // REX.R == 1
];
__gshared immutable RegMMX = [
	Reg.MM0, Reg.MM1, Reg.MM2, Reg.MM3, Reg.MM4, Reg.MM5, Reg.MM6, Reg.MM7
];
__gshared immutable RegXMM = [
	Reg.XMM0, Reg.XMM1, Reg.XMM2,  Reg.XMM3,  Reg.XMM4,  Reg.XMM5,  Reg.XMM6,  Reg.XMM7,     // REX.R == 0
    Reg.XMM8, Reg.XMM9, Reg.XMM10, Reg.XMM11, Reg.XMM12, Reg.XMM13, Reg.XMM14, Reg.XMM15     // REX.R == 1
];
__gshared immutable RegYMM = [
	Reg.YMM0, Reg.YMM1, Reg.YMM2,  Reg.YMM3,  Reg.YMM4,  Reg.YMM5,  Reg.YMM6,  Reg.YMM7,     // REX.R == 0
    Reg.YMM8, Reg.YMM9, Reg.YMM10, Reg.YMM11, Reg.YMM12, Reg.YMM13, Reg.YMM14, Reg.YMM15     // REX.R == 1
];
__gshared immutable RegSeg = [
	Reg.ES, Reg.CS, Reg.SS, Reg.DS, Reg.FS, Reg.GS, Reg.NONE, Reg.NONE
];
__gshared immutable RegC = [
	Reg.CR0, Reg.CR1, Reg.CR2, Reg.CR3, Reg.CR4, Reg.CR5, Reg.CR6, Reg.CR7,         // REX.R == 0
    Reg.CR8, Reg.CR9, Reg.CR10, Reg.CR11, Reg.CR12, Reg.CR13, Reg.CR14, Reg.CR15,   // REX.R == 1
];
__gshared immutable RegD = [
	Reg.DR0, Reg.DR1, Reg.DR2, Reg.DR3, Reg.DR4, Reg.DR5, Reg.DR6, Reg.DR7,         // REX.R == 0
    Reg.DR8, Reg.DR9, Reg.DR10, Reg.DR11, Reg.DR12, Reg.DR13, Reg.DR14, Reg.DR15    // REX.R == 1
];
__gshared immutable RegT = [
	Reg.TR0, Reg.TR1, Reg.TR2, Reg.TR3, Reg.TR4, Reg.TR5, Reg.TR6, Reg.TR7
];

string toString(immutable(Reg)* ptr) {
    return
        ptr==RegC.ptr ? "RegC" :
        ptr==RegD.ptr ? "RegD" :
        ptr==RegT.ptr ? "RegT" :
        ptr==Reg8.ptr ? "Reg8" :
        ptr==Reg8_rex.ptr ? "Reg8_rex" :
        ptr==Reg16.ptr ? "Reg16" :
        ptr==Reg32.ptr ? "Reg32" :
        ptr==Reg64.ptr ? "Reg64" :
        ptr==RegSeg.ptr ? "RegSeg" :
        ptr==RegMMX.ptr ? "RegMMX" :
        ptr==RegXMM.ptr ? "RegXMM" :
        ptr==RegYMM.ptr ? "RegYMM" :
        "???";
}
