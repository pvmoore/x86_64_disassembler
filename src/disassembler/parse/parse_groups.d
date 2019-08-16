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
    if(modrm.reg==0) p.instr.copy(Instruction("pop", ps_Ev, 64));
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
            if(modrm.rm==0) p.instr.copy(Instruction("monitor", ps_none, 0, IS.SSE3));
            if(modrm.rm==1) p.instr.copy(Instruction("mwait", ps_none, 0, IS.SSE3));
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
            case 2: p.instr.copy(Instruction("ldmxcsr", ps_Md, 0, IS.SSE)); break;
            case 3: p.instr.copy(Instruction("stmxcsr", ps_Md, 0, IS.SSE)); break;
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
                if(modrm.mod==0b11) p.instr.copy(Instruction("sfence", ps_none, 0, IS.SSE));
                else                p.instr.copy(Instruction("clflush", ps_Mb));
                break;
            default: break;
        }
    }
}
void group16(Parser p) {
    auto modrm = ModRM(p.peekByte());
    switch(modrm.reg) {
        case 0: p.instr.copy(Instruction("prefetchnta", ps_M, 0, IS.SSE)); break;
        case 1: p.instr.copy(Instruction("prefetcht0", ps_M, 0, IS.SSE)); break;
        case 2: p.instr.copy(Instruction("prefetcht1", ps_M, 0, IS.SSE)); break;
        case 3: p.instr.copy(Instruction("prefetcht2", ps_M, 0, IS.SSE)); break;
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