module disassembler.parse.parse_groups;

import disassembler.all;

void group1(Parser p, uint byte1) {
     auto modrm = ModRM(p.peekByte());
     switch(byte1) {
        case 0x80: p.instr.copy(INSTRUCTIONS_80[modrm.reg]); break;
        case 0x81: p.instr.copy(INSTRUCTIONS_81[modrm.reg]); break;
        case 0x82: p.instr.copy(INSTRUCTIONS_82[modrm.reg]); break;
        case 0x83: p.instr.copy(INSTRUCTIONS_83[modrm.reg]); break;
        default: assert(false);
     }
}
void group1a(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(modrm.reg==0) p.instr.copy(Instruction("pop", ps_Ev, [Hint.SIZE_64]));
    else if(modrm.reg==1) {
        // XOP
    }
}
void group2(Parser p, uint byte1) {
    auto modrm = ModRM(p.peekByte());
    switch(byte1) {
        case 0xC0: p.instr.copy(INSTRUCTIONS_C0[modrm.reg]); break;
        case 0xC1: p.instr.copy(INSTRUCTIONS_C1[modrm.reg]); break;
        case 0xD0: p.instr.copy(INSTRUCTIONS_D0[modrm.reg]); break;
        case 0xD1: p.instr.copy(INSTRUCTIONS_D1[modrm.reg]); break;
        case 0xD2: p.instr.copy(INSTRUCTIONS_D2[modrm.reg]); break;
        case 0xD3: p.instr.copy(INSTRUCTIONS_D3[modrm.reg]); break;
        default: assert(false);
    }
}
void group3(Parser p, uint byte1) {
    auto modrm = ModRM(p.peekByte());
    switch(byte1) {
        case 0xF6: p.instr.copy(INSTRUCTIONS_F6[modrm.reg]); break;
        case 0xF7: p.instr.copy(INSTRUCTIONS_F7[modrm.reg]); break;
        default: assert(false);
    }
}
void group4(Parser p) {
    auto modrm = ModRM(p.peekByte());

    if(modrm.reg==0) p.instr.copy(Instruction("inc", ps_Eb));
    else if(modrm.reg==1) p.instr.copy(Instruction("dec", ps_Eb));
}
void group5(Parser p) {
    auto modrm = ModRM(p.peekByte());
    p.instr.copy(INSTRUCTIONS_FF[modrm.reg]);
}
void group6(Parser p) {
    auto modrm = ModRM(p.peekByte());
    p.instr.copy(INSTRUCTIONS_0F_00_grp6[modrm.reg]);
}
void group7(Parser p) {
    auto modrm = ModRM(p.peekByte());
    switch(modrm.reg) {
        case 1:
            p.readByte();
            if(modrm.rm==0) p.instr.copy(Instruction("monitor", ps_none));
            if(modrm.rm==1) p.instr.copy(Instruction("mwait", ps_none));
            return;
        case 2:
            p.readByte();
            if(modrm.rm==0) p.instr.copy(Instruction("xgetbv", ps_none));
            if(modrm.rm==1) p.instr.copy(Instruction("xsetbv", ps_none));
            return;
        case 3:
            p.readByte();
            switch(modrm.rm) {
                case 0:  p.instr.copy(Instruction("vmrun", ps_none)); break;
                case 1:  p.instr.copy(Instruction("vmmcall", ps_none)); break;
                case 2:  p.instr.copy(Instruction("vmload", ps_none)); break;
                case 3:  p.instr.copy(Instruction("vmsave", ps_none)); break;
                case 4:  p.instr.copy(Instruction("stgi", ps_none)); break;
                case 5:  p.instr.copy(Instruction("clgi", ps_none)); break;
                case 6:  p.instr.copy(Instruction("skinit", ps_none)); break;
                default: p.instr.copy(Instruction("invlpga", ps_none)); break;
            }
            return;
        case 7:
            p.readByte();
            switch(modrm.rm) {
                case 0:  p.instr.copy(Instruction("swapgs", ps_none)); break;
                case 1:  p.instr.copy(Instruction("rdtscp", ps_none)); break;
                case 2:  p.instr.copy(Instruction("monitorx", ps_none)); break;
                case 3:  p.instr.copy(Instruction("mwaitx", ps_none)); break;
                case 5:  p.instr.copy(Instruction("rdpru", ps_none)); break;
                default: break;
            }
            return;
        default:
            p.instr.copy(INSTRUCTIONS_0F_01_grp7[modrm.reg]);
            break;
    }
}
void group8(Parser p) {
    auto modrm = ModRM(p.peekByte());
    p.instr.copy(INSTRUCTIONS_B_grp8[modrm.reg]);
}
void group9(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(modrm.reg==0x1) {
        if(p.prefix.rexW()) p.instr.copy(Instruction("cmpxchg16b", ps_Mo));
        else p.instr.copy(Instruction("cmpxchg8b", ps_Mq));
    }
    else if(modrm.reg==0x6) p.instr.copy(Instruction("rdrand", ps_Rv));
}
void group10(Parser p) {
    auto modrm = ModRM(p.peekByte());
    /* All UD1 */
}
void group11(Parser p, uint byte1) {
    auto modrm = ModRM(p.peekByte());
    if(byte1==0xC6 && modrm.reg==0) p.instr.copy(Instruction("mov", ps_EbIb));
    else if(byte1==0xC7 && modrm.reg==0) p.instr.copy(Instruction("mov", ps_EvIz));
}
void group12(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(p.prefix.opSize) {
        /* 66 */
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrlw", ps_UoIb)); break;
            case 4: p.instr.copy(Instruction("psraw", ps_UoIb)); break;
            case 6: p.instr.copy(Instruction("psllw", ps_UoIb)); break;
            default: break;
        }
    } else {
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrlw", ps_NqIb)); break;
            case 4: p.instr.copy(Instruction("psraw", ps_NqIb)); break;
            case 6: p.instr.copy(Instruction("psllw", ps_NqIb)); break;
            default: break;
        }
    }
}
void group13(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(p.prefix.opSize) {
        /* 66 */
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrld", ps_UoIb)); break;
            case 4: p.instr.copy(Instruction("psrad", ps_UoIb)); break;
            case 6: p.instr.copy(Instruction("pslld", ps_UoIb)); break;
            default: break;
        }
    } else {
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrld", ps_NqIb)); break;
            case 4: p.instr.copy(Instruction("psrad", ps_NqIb)); break;
            case 6: p.instr.copy(Instruction("pslld", ps_NqIb)); break;
            default: break;
        }
    }
}
void group14(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(p.prefix.opSize) {
        /* 66 */
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrlq", ps_UoIb)); break;
            case 3: p.instr.copy(Instruction("psrldq", ps_UoIb)); break;
            case 6: p.instr.copy(Instruction("psllq", ps_UoIb)); break;
            case 7: p.instr.copy(Instruction("pslldq", ps_UoIb)); break;
            default: break;
        }
    } else {
        switch(modrm.reg) {
            case 2: p.instr.copy(Instruction("psrlq", ps_NqIb)); break;
            case 6: p.instr.copy(Instruction("psllq", ps_NqIb)); break;
            default: break;
        }
    }
}
void group15(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(p.prefix.rep) {
        /* F3 */
        switch(modrm.reg) {
            case 0: p.instr.copy(Instruction("rdfsbase", ps_Rv)); break;
            case 1: p.instr.copy(Instruction("rdgsbase", ps_Rv)); break;
            case 2: p.instr.copy(Instruction("wrfsbase", ps_Rv)); break;
            case 3: p.instr.copy(Instruction("wrgsbase", ps_Rv)); break;
            default: break;
        }
    } else if(p.prefix.opSize) {
        /* 66 */
        if(modrm.reg==0x6 && modrm.mod!=0b11) p.instr.copy(Instruction("clwb", ps_Mb));
    } else {
        switch(modrm.reg) {
            case 0: p.instr.copy(Instruction("fxsave", ps_M)); break;
            case 1: p.instr.copy(Instruction("fxrstor", ps_M)); break;
            case 2: p.instr.copy(Instruction("ldmxcsr", ps_Md)); break;
            case 3: p.instr.copy(Instruction("stmxcsr", ps_Md)); break;
            case 4:
                if(modrm.mod!=0b11) p.instr.copy(Instruction("xsave", ps_M));
                break;
            case 5:
                if(modrm.mod==0b11) p.instr.copy(Instruction("lfence", ps_none));
                else                p.instr.copy(Instruction("xrstor", ps_M));
                break;
            case 6:
                if(modrm.mod==0b11) p.instr.copy(Instruction("mfence", ps_none));
                else                p.instr.copy(Instruction("xsaveopt", ps_M));
                break;
            case 7:
                if(modrm.mod==0b11) p.instr.copy(Instruction("sfence", ps_none));
                else                p.instr.copy(Instruction("clflush", ps_Mb));
                break;
            default: break;
        }
    }
}
void group16(Parser p) {
    auto modrm = ModRM(p.peekByte());
    switch(modrm.reg) {
        case 0: p.instr.copy(Instruction("prefetchnta", ps_M)); break;
        case 1: p.instr.copy(Instruction("prefetcht0", ps_M)); break;
        case 2: p.instr.copy(Instruction("prefetcht1", ps_M)); break;
        case 3: p.instr.copy(Instruction("prefetcht2", ps_M)); break;
        /* aliased to prefetch exclusive */
        case 4:
        case 5:
        case 6:
        case 7:
            groupP(p);
            break;
        default: break;
    }
}
void group17(Parser p) {
    auto modrm = ModRM(p.peekByte());
    if(p.prefix.opSize && modrm.reg==0) {
        /* 66 */
        p.instr.copy(Instruction("extrq", ps_VoqIbIb));
    }
}
void groupP(Parser p) {
    p.instr.copy(Instruction("prefetch", ps_none));
}

private:

/* group 1 */
__gshared Instruction[] INSTRUCTIONS_80 = [
    Instruction("add", ps_EbIb),            /* 0x81 reg=0 */
    Instruction("or",  ps_EbIb),            /* 0x81 reg=1 */
    Instruction("adc", ps_EbIb),            /* 0x81 reg=2 */
    Instruction("sbb", ps_EbIb),            /* 0x81 reg=3 */
    Instruction("and", ps_EbIb),            /* 0x81 reg=4 */
    Instruction("sub", ps_EbIb),            /* 0x81 reg=5 */
    Instruction("xor", ps_EbIb),            /* 0x81 reg=6 */
    Instruction("cmp", ps_EbIb),            /* 0x81 reg=7 */
];

__gshared Instruction[] INSTRUCTIONS_81 = [
    Instruction("add", ps_EvIz),            /* 0x81 reg=0 */
    Instruction("or",  ps_EvIz),            /* 0x81 reg=1 */
    Instruction("adc", ps_EvIz),            /* 0x81 reg=2 */
    Instruction("sbb", ps_EvIz),            /* 0x81 reg=3 */
    Instruction("and", ps_EvIz),            /* 0x81 reg=4 */
    Instruction("sub", ps_EvIz),            /* 0x81 reg=5 */
    Instruction("xor", ps_EvIz),            /* 0x81 reg=6 */
    Instruction("cmp", ps_EvIz),            /* 0x81 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_82 = [
    Instruction("add", ps_EbIb),            /* 0x82 reg=0 */
    Instruction("or",  ps_EbIb),            /* 0x82 reg=1 */
    Instruction("adc", ps_EbIb),            /* 0x82 reg=2 */
    Instruction("sbb", ps_EbIb),            /* 0x82 reg=3 */
    Instruction("and", ps_EbIb),            /* 0x82 reg=4 */
    Instruction("sub", ps_EbIb),            /* 0x82 reg=5 */
    Instruction("xor", ps_EbIb),            /* 0x82 reg=6 */
    Instruction("cmp", ps_EbIb),            /* 0x82 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_83 = [
    Instruction("add", ps_EvIb),            /* 0x83 reg=0 */
    Instruction("or",  ps_EvIb),            /* 0x83 reg=1 */
    Instruction("adc", ps_EvIb),            /* 0x83 reg=2 */
    Instruction("sbb", ps_EvIb),            /* 0x83 reg=3 */
    Instruction("and", ps_EvIb),            /* 0x83 reg=4 */
    Instruction("sub", ps_EvIb),            /* 0x83 reg=5 */
    Instruction("xor", ps_EvIb),            /* 0x83 reg=6 */
    Instruction("cmp", ps_EvIb),            /* 0x83 reg=7 */
];
/* group 2 */
__gshared Instruction[] INSTRUCTIONS_C0 = [
    Instruction("rol", ps_EbIb),            /* 0xC0 reg=0 */
    Instruction("ror", ps_EbIb),            /* 0xC0 reg=1 */
    Instruction("rcl", ps_EbIb),            /* 0xC0 reg=2 */
    Instruction("rcr", ps_EbIb),            /* 0xC0 reg=3 */
    Instruction("shl", ps_EbIb),            /* 0xC0 reg=4 */
    Instruction("shr", ps_EbIb),            /* 0xC0 reg=5 */
    Instruction("sal", ps_EbIb),            /* 0xC0 reg=6 */
    Instruction("sar", ps_EbIb),            /* 0xC0 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_C1 = [
    Instruction("rol", ps_EvIb),            /* 0xC1 reg=0 */
    Instruction("ror", ps_EvIb),            /* 0xC1 reg=1 */
    Instruction("rcl", ps_EvIb),            /* 0xC1 reg=2 */
    Instruction("rcr", ps_EvIb),            /* 0xC1 reg=3 */
    Instruction("shl", ps_EvIb),            /* 0xC1 reg=4 */
    Instruction("shr", ps_EvIb),            /* 0xC1 reg=5 */
    Instruction("sal", ps_EvIb),            /* 0xC1 reg=6 */
    Instruction("sar", ps_EvIb),            /* 0xC1 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_D0 = [
    Instruction("rol", ps_Eb_1),            /* 0xD0 reg=0 */
    Instruction("ror", ps_Eb_1),            /* 0xD0 reg=1 */
    Instruction("rcl", ps_Eb_1),            /* 0xD0 reg=2 */
    Instruction("rcr", ps_Eb_1),            /* 0xD0 reg=3 */
    Instruction("shl", ps_Eb_1),            /* 0xD0 reg=4 */
    Instruction("shr", ps_Eb_1),            /* 0xD0 reg=5 */
    Instruction("sal", ps_Eb_1),            /* 0xD0 reg=6 */
    Instruction("sar", ps_Eb_1),            /* 0xD0 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_D1 = [
    Instruction("rol", ps_Ev_1),            /* 0xD1 reg=0 */
    Instruction("ror", ps_Ev_1),            /* 0xD1 reg=1 */
    Instruction("rcl", ps_Ev_1),            /* 0xD1 reg=2 */
    Instruction("rcr", ps_Ev_1),            /* 0xD1 reg=3 */
    Instruction("shl", ps_Ev_1),            /* 0xD1 reg=4 */
    Instruction("shr", ps_Ev_1),            /* 0xD1 reg=5 */
    Instruction("sal", ps_Ev_1),            /* 0xD1 reg=6 */
    Instruction("sar", ps_Ev_1),            /* 0xD1 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_D2 = [
    Instruction("rol", ps_EbCL),            /* 0xD2 reg=0 */
    Instruction("ror", ps_EbCL),            /* 0xD2 reg=1 */
    Instruction("rcl", ps_EbCL),            /* 0xD2 reg=2 */
    Instruction("rcr", ps_EbCL),            /* 0xD2 reg=3 */
    Instruction("shl", ps_EbCL),            /* 0xD2 reg=4 */
    Instruction("shr", ps_EbCL),            /* 0xD2 reg=5 */
    Instruction("sal", ps_EbCL),            /* 0xD2 reg=6 */
    Instruction("sar", ps_EbCL),            /* 0xD2 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_D3 = [
    Instruction("rol", ps_EvCL),            /* 0xD3 reg=0 */
    Instruction("ror", ps_EvCL),            /* 0xD3 reg=1 */
    Instruction("rcl", ps_EvCL),            /* 0xD3 reg=2 */
    Instruction("rcr", ps_EvCL),            /* 0xD3 reg=3 */
    Instruction("shl", ps_EvCL),            /* 0xD3 reg=4 */
    Instruction("shr", ps_EvCL),            /* 0xD3 reg=5 */
    Instruction("sal", ps_EvCL),            /* 0xD3 reg=6 */
    Instruction("sar", ps_EvCL),            /* 0xD3 reg=7 */
];
/* group 3 */
__gshared Instruction[] INSTRUCTIONS_F6 = [
    Instruction("test", ps_EbIb),           /* 0xF6 reg=0 */
    Instruction("test", ps_EbIb),           /* 0xF6 reg=1 */
    Instruction("not",  ps_Eb),             /* 0xF6 reg=2 */
    Instruction("neg",  ps_Eb),             /* 0xF6 reg=3 */
    Instruction("mul",  ps_Eb),             /* 0xF6 reg=4 */
    Instruction("imul", ps_Eb),             /* 0xF6 reg=5 */
    Instruction("div",  ps_Eb),             /* 0xF6 reg=6 */
    Instruction("idiv", ps_Eb),             /* 0xF6 reg=7 */
];
__gshared Instruction[] INSTRUCTIONS_F7 = [
    Instruction("test", ps_EvIz),           /* 0xF7 reg=0 */
    Instruction("test", ps_EvIz),           /* 0xF7 reg=1 */
    Instruction("not",  ps_Ev),             /* 0xF7 reg=2 */
    Instruction("neg",  ps_Ev),             /* 0xF7 reg=3 */
    Instruction("mul",  ps_Ev),             /* 0xF7 reg=4 */
    Instruction("imul", ps_Ev),             /* 0xF7 reg=5 */
    Instruction("div",  ps_Ev),             /* 0xF7 reg=6 */
    Instruction("idiv", ps_Ev),             /* 0xF7 reg=7 */
];
/* group 5 */
__gshared Instruction[] INSTRUCTIONS_FF = [
    Instruction("inc", ps_Ev),                      /* 0xFF reg=0 */
    Instruction("dec",  ps_Ev),                     /* 0xFF reg=1 */
    Instruction("call", ps_Ev, [Hint.SIZE_64]),     /* 0xFF reg=2 */
    Instruction("call", ps_Mp),                     /* 0xFF reg=3 */
    Instruction("jmp", ps_Ev, [Hint.SIZE_64]),      /* 0xFF reg=4 */
    Instruction("jmp", ps_Mp),                      /* 0xFF reg=5 */
    Instruction("push", ps_Ev, [Hint.SIZE_64]),     /* 0xFF reg=6 */
    Instruction("nop", null),                       /* 0xFF reg=7 */
];
/* group 6 */
__gshared Instruction[] INSTRUCTIONS_0F_00_grp6 = [
    Instruction("sldt", ps_Mw_or_Rv),       /* reg=0 */
    Instruction("str", ps_Mw_or_Rv),        /* reg=1 */
    Instruction("lldt", ps_Ew),             /* reg=2 */
    Instruction("ltr", ps_Ew),              /* reg=3 */
    Instruction("verr", ps_Ew),             /* reg=4 */
    Instruction("verw", ps_Ew),             /* reg=5 */
    Instruction("", null),                  /* reg=6 - invalid */
    Instruction("", null),                  /* reg=7 - invalid */
];
/* group 7 */
__gshared Instruction[] INSTRUCTIONS_0F_01_grp7 = [
    Instruction("sgdt", ps_Ms),             /* reg=0 */
    Instruction("sidt", ps_Ms),             /* reg=1 */
    Instruction("lgdt", ps_Ms),             /* reg=2 */
    Instruction("lidt", ps_Ms),             /* reg=3 */
    Instruction("smsw", ps_Mw_or_Rv),       /* reg=4 */
    Instruction("", null),                  /* reg=5 - invalid*/
    Instruction("lmsw", ps_Ew),             /* reg=6 */
    Instruction("invlpg", ps_Mb),           /* reg=7 */
];
/* group 8 */
__gshared Instruction[] INSTRUCTIONS_B_grp8 = [
    Instruction("", null),                  /* reg=0 - invalid */
    Instruction("", null),                  /* reg=1 - invalid */
    Instruction("", null),                  /* reg=2 - invalid */
    Instruction("", null),                  /* reg=3 - invalid */
    Instruction("bt", ps_EvIb),             /* reg=4 */
    Instruction("bts", ps_EvIb),            /* reg=5 */
    Instruction("btr", ps_EvIb),            /* reg=6 */
    Instruction("btc", ps_EvIb),            /* reg=7 */
];