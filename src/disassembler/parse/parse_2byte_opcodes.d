module disassembler.parse.parse_2byte_opcodes;

import disassembler.all;

void parseTwoByteOpcode(Parser p, uint byte1, uint byte2) {

    uint hiNibble = (byte2 >>> 4) & 0b1111;
    uint loNibble = byte2 & 0b1111;

    switch(hiNibble) {
        case 0x0:
            switch(loNibble) {
                case 0x0:
                    group6(p);
                    break;
                case 0x1:
                    group7(p);
                    break;
                case 0x9:
                    if(p.prefix.rep) { /* F3 */
                        p.instr.copy(Instruction("wbinvd", ps_none, IS.STD));
                    } else {
                        p.instr.copy(Instruction("wbnoinvd", ps_none, IS.STD));
                    }
                    break;
                case 0xD:
                    groupP(p);
                    break;
                case 0xF:
                    parse3dnow(p, loNibble);
                    break;
                default:
                    p.instr.copy(INSTRUCTIONS_row_0[loNibble]);
                    break;
            }
            break;
        case 0x1:
            if(loNibble==8) {
                group16(p);
            } else if(p.prefix.rep) {
                /* F3 */
                p.instr.copy(INSTRUCTIONS_row_1_F3[loNibble]);
            } else if(p.prefix.repne) {
                /* F2 */
                p.instr.copy(INSTRUCTIONS_row_1_F2[loNibble]);
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_1_66[loNibble]);
            } else {
                /* no prefix */
                auto modrm = ModRM(p.peekByte());
                if(modrm.mod==0b11) {
                    /* Special cases if mod==0b11 */
                    if(loNibble==2) { p.instr.copy(Instruction("movhlps", ps_VoqUoq, IS.SSE)); return; }
                    else if(loNibble==6) { p.instr.copy(Instruction("movlhps", ps_VoqUoq, IS.SSE)); return; }
                }
                p.instr.copy(INSTRUCTIONS_row_1[loNibble]);
            }
            break;
        case 0x2:
            if(p.prefix.rep) {
                /* F3 */
                p.instr.copy(INSTRUCTIONS_row_2_F3[loNibble]);
            } else if(p.prefix.repne) {
                /* F2 */
                p.instr.copy(INSTRUCTIONS_row_2_F2[loNibble]);
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_2_66[loNibble]);
            } else {
                /* no prefix */
                p.instr.copy(INSTRUCTIONS_row_2[loNibble]);
            }
            break;
        case 0x3:
            p.instr.copy(INSTRUCTIONS_row_3[loNibble]);
            break;
        case 0x4:
            p.instr.copy(INSTRUCTIONS_row_4[loNibble]);
            break;
        case 0x5:
            if(p.prefix.rep) {
                /* F3 */
                p.instr.copy(INSTRUCTIONS_row_5_F3[loNibble]);
            } else if(p.prefix.repne) {
                /* F2 */
                p.instr.copy(INSTRUCTIONS_row_5_F2[loNibble]);
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_5_66[loNibble]);
            } else {
                /* no prefix */
                p.instr.copy(INSTRUCTIONS_row_5[loNibble]);
            }
            break;
        case 0x6:
            if(p.prefix.rep) {
                /* F3 */
                if(loNibble==0xF) p.instr.copy(Instruction("movdqu", ps_VoWo, IS.STD));
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_6_66[loNibble]);
            } else {
                /* no prefix */
                p.instr.copy(INSTRUCTIONS_row_6[loNibble]);
            }
            break;
        case 0x7:
            if(loNibble==1) group12(p);
            else if(loNibble==2) group13(p);
            else if(loNibble==3) group14(p);
            else if(p.prefix.rep) {
                /* F3 */
                p.instr.copy(INSTRUCTIONS_row_7_F3[loNibble]);
            } else if(p.prefix.repne) {
                /* F2 */
                p.instr.copy(INSTRUCTIONS_row_7_F2[loNibble]);
            } else if(p.prefix.opSize) {
                /* 66 */
                if(loNibble==0xE && p.prefix.rexW()) {
                    p.instr.copy(Instruction("movq", ps_EyVy, IS.SSE));
                }
                else if(loNibble==8) group17(p);
                else p.instr.copy(INSTRUCTIONS_row_7_66[loNibble]);
            } else {
                /* no prefix */
                if(loNibble==0xE && p.prefix.rexW()) {
                    p.instr.copy(Instruction("movq", ps_EyPy, IS.MMX));
                }
                else p.instr.copy(INSTRUCTIONS_row_7[loNibble]);
            }
            break;
        case 0x8:
            p.instr.copy(INSTRUCTIONS_row_8[loNibble]);
            break;
        case 0x9:
            p.instr.copy(INSTRUCTIONS_row_9[loNibble]);
            break;
        case 0xA:
            if(loNibble==0xE) {
                group15(p);
            } else {
                p.instr.copy(INSTRUCTIONS_row_A[loNibble]);
            }
            break;
        case 0xB:
            if(p.prefix.rep) {
                /* F3 */
                if(loNibble==0x8) p.instr.copy(Instruction("popcnt", ps_GvEv, IS.SSE4_2));
                else if(loNibble==0xC) p.instr.copy(Instruction("tzcnt", ps_GvEv, IS.STD));
                else if(loNibble==0xD) p.instr.copy(Instruction("lzcnt", ps_GvEv, IS.STD));
            } else if(loNibble==0x09) {
                group10(p);
            } else if(loNibble==0x0a) {
                group8(p);
            } else {
                p.instr.copy(INSTRUCTIONS_row_B[loNibble]);
            }
            break;
        case 0xC:
            if(loNibble==0x7) {
                group9(p);
            } else if(p.prefix.rep && loNibble==0x2) {
                /* F3 */
                p.instr.copy(Instruction("cmpss", ps_VssWssIb, IS.SSE));
            } else if(p.prefix.repne && loNibble==0x2) {
                /* F2 */
                p.instr.copy(Instruction("cmpsd", ps_VsdWsdIb, IS.SSE2));
            } else if(p.prefix.opSize && loNibble.isOneOf(2,4,5,6)) {
                /* 66 */
                switch(loNibble) {
                    case 2: p.instr.copy(Instruction("cmppd", ps_VpdWpdIb, IS.SSE2)); break;
                    case 4: p.instr.copy(Instruction("pinsrw", ps_VoEwIb, IS.STD)); break;
                    case 5: p.instr.copy(Instruction("pextrw", ps_GdUoIb, IS.STD)); break;
                    case 6: p.instr.copy(Instruction("shufpd", ps_VpdWpdIb, IS.STD)); break;
                    default: break;
                }
            } else {
                /* no prefix */
                p.instr.copy(INSTRUCTIONS_row_C[loNibble]);
            }
            break;
        case 0xD:
            if(p.prefix.rep) {
                /* F3 */
                if(loNibble==0x6) p.instr.copy(Instruction("movq2dq", ps_VoNq, IS.SSE2));
            } else if(p.prefix.repne) {
                /* F2 */
                if(loNibble==0x0) p.instr.copy(Instruction("addsubps", ps_VpsWps, IS.SSE3));
                else if(loNibble==0x6) p.instr.copy(Instruction("movdq2q", ps_PqUq, IS.MMX));

            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_D_66[loNibble]);
            } else {
                p.instr.copy(INSTRUCTIONS_row_D[loNibble]);
            }
            break;
        case 0xE:
            if(p.prefix.rep) {
                /* F3 */
                if(loNibble==0x6) p.instr.copy(Instruction("cvtdq2pd", ps_VpdWpj, IS.SSE2));
            } else if(p.prefix.repne) {
                /* F2 */
                if(loNibble==0x6) p.instr.copy(Instruction("cvtpd2dq", ps_VpjWpd, IS.SSE2));
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_E_66[loNibble]);
            } else {
                p.instr.copy(INSTRUCTIONS_row_E[loNibble]);
            }
            break;
        case 0xF:
            if(p.prefix.repne) {
                /* F2 */
                if(loNibble==0x0) p.instr.copy(Instruction("lddqu", ps_VoMo, IS.SSE3));
            } else if(p.prefix.opSize) {
                /* 66 */
                p.instr.copy(INSTRUCTIONS_row_F_66[loNibble]);
            } else {
                p.instr.copy(INSTRUCTIONS_row_F[loNibble]);
            }
            break;
        default: break;
    }
}

private:

/* row 0 */
__gshared Instruction[] INSTRUCTIONS_row_0 = [
    Instruction("", null, IS.STD),              /* lo=0 - group 6 */
    Instruction("", null, IS.STD),              /* lo=1 - group 7 */
    Instruction("lar", ps_GvEw, IS.STD),        /* lo=2 */
    Instruction("lsl", ps_GvEw, IS.STD),        /* lo=3 */
    Instruction("", null, IS.STD),              /* lo=4 - invalid */
    Instruction("syscall", ps_none, IS.STD),    /* lo=5 */
    Instruction("clts", ps_none, IS.STD),       /* lo=6 */
    Instruction("sysret", ps_none, IS.STD),     /* lo=7 */
    Instruction("invd", ps_none, IS.STD),       /* lo=8 */
    Instruction("", null, IS.STD),              /* lo=9 - handled in code */
    Instruction("", null, IS.STD),              /* lo=A - invalid */
    Instruction("ud2", ps_none, IS.STD),        /* lo=B */
    Instruction("", null, IS.STD),              /* lo=C - invalid */
    Instruction("", null, IS.STD),              /* lo=D - group p */
    Instruction("femms", ps_none, IS.STD),      /* lo=E */
    Instruction("", null, IS.STD),              /* lo=F - 3DNow! escape */
];
/* row 1 */
__gshared Instruction[] INSTRUCTIONS_row_1 = [
    Instruction("movups", ps_VpsWps, IS.SSE),       /* lo=0 */
    Instruction("movups", ps_WpsVps, IS.SSE),       /* lo=1 */
    Instruction("movlps", ps_VqMq, IS.SSE),         /* lo=2 */
    Instruction("movlps", ps_MqVq, IS.SSE),         /* lo=3 */
    Instruction("unpcklps", ps_VpsWps, IS.SSE),     /* lo=4 */
    Instruction("unpckhps", ps_VpsWps, IS.SSE),     /* lo=5 */
    Instruction("movhps", ps_VoqMq, IS.SSE),        /* lo=6 */
    Instruction("movhps", ps_MqVoq, IS.SSE),        /* lo=7 */
    Instruction("", null, IS.STD),                  /* lo=8 - group 16 */
    Instruction("", null, IS.STD),                  /* lo=9 - nop */
    Instruction("", null, IS.STD),                  /* lo=A - nop */
    Instruction("", null, IS.STD),                  /* lo=B - nop */
    Instruction("", null, IS.STD),                  /* lo=C - nop */
    Instruction("", null, IS.STD),                  /* lo=D - nop */
    Instruction("", null, IS.STD),                  /* lo=E - nop */
    Instruction("", null, IS.STD),                  /* lo=F - nop */
];
__gshared Instruction[] INSTRUCTIONS_row_1_F3 = [
    Instruction("movss", ps_VssWss, IS.SSE),        /* lo=0 */
    Instruction("movss", ps_WssVss, IS.SSE),        /* lo=1 */
    Instruction("movsldup", ps_VpsWps, IS.SSE3),    /* lo=2 */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("movshdup", ps_VpsWps, IS.SSE3),    /* lo=6 */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("", null, IS.STD),                  /* lo=A - invalid */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("", null, IS.STD),                  /* lo=C - invalid */
    Instruction("", null, IS.STD),                  /* lo=D - invalid */
    Instruction("", null, IS.STD),                  /* lo=E - invalid */
    Instruction("", null, IS.STD),                  /* lo=F - invalid */
];
__gshared Instruction[] INSTRUCTIONS_row_1_66 = [
    Instruction("movupd", ps_VpdWpd, IS.SSE2),      /* lo=0 */
    Instruction("movupd", ps_WpdVpd, IS.SSE2),      /* lo=1 */
    Instruction("movlpd", ps_VoqMq, IS.SSE2),       /* lo=2 */
    Instruction("movlpd", ps_MqVoq, IS.SSE2),       /* lo=3 */
    Instruction("unpcklpd", ps_VoqWoq, IS.SSE2),    /* lo=4 */
    Instruction("unpckhpd", ps_VoqWoq, IS.SSE2),    /* lo=5 */
    Instruction("movhpd", ps_VoqMq, IS.SSE2),       /* lo=6 */
    Instruction("movhpd", ps_MqVoq, IS.SSE2),       /* lo=7 */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("", null, IS.STD),                  /* lo=A - invalid */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("", null, IS.STD),                  /* lo=C - invalid */
    Instruction("", null, IS.STD),                  /* lo=D - invalid */
    Instruction("", null, IS.STD),                  /* lo=E - invalid */
    Instruction("", null, IS.STD),                  /* lo=F - invalid */
];
__gshared Instruction[] INSTRUCTIONS_row_1_F2 = [
    Instruction("movsd", ps_VsdWsd, IS.SSE2),           /* lo=0 */
    Instruction("movsd", ps_WsdVsd, IS.SSE2),           /* lo=1 */
    Instruction("movddup", ps_VoWsd, IS.SSE3),          /* lo=2 */
    Instruction("", null, IS.STD),                      /* lo=3 - invalid */
    Instruction("", null, IS.STD),                      /* lo=4 - invalid */
    Instruction("", null, IS.STD),                      /* lo=5 - invalid */
    Instruction("", null, IS.STD),                      /* lo=6 - invalid */
    Instruction("", null, IS.STD),                      /* lo=7 - invalid */
    Instruction("", null, IS.STD),                      /* lo=8 - invalid */
    Instruction("", null, IS.STD),                      /* lo=9 - invalid */
    Instruction("", null, IS.STD),                      /* lo=A - invalid */
    Instruction("", null, IS.STD),                      /* lo=B - invalid */
    Instruction("", null, IS.STD),                      /* lo=C - invalid */
    Instruction("", null, IS.STD),                      /* lo=D - invalid */
    Instruction("", null, IS.STD),                      /* lo=E - invalid */
    Instruction("", null, IS.STD),                      /* lo=F - invalid */
];
/* row 2 */
__gshared Instruction[] INSTRUCTIONS_row_2 = [
    Instruction("mov", ps_RdqCdq, IS.STD),          /* lo=0 */
    Instruction("mov", ps_RdqDdq, IS.STD),          /* lo=1 */
    Instruction("mov", ps_CdqRdq, IS.STD),          /* lo=2 */
    Instruction("mov", ps_DdqRdq, IS.STD),          /* lo=3 */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("movaps", ps_VpsWps, IS.SSE),       /* lo=8 */
    Instruction("movaps", ps_WpsVps, IS.SSE),       /* lo=9 */
    Instruction("cvtpi2ps", ps_VpsQpj, IS.SSE),     /* lo=A */
    Instruction("movntps", ps_MoVps, IS.SSE),       /* lo=B */
    Instruction("cvttps2pi", ps_PpjWps, IS.SSE),    /* lo=C */
    Instruction("cvtps2pi", ps_PpjWps, IS.SSE),     /* lo=D */
    Instruction("ucomiss", ps_VssWss, IS.SSE),      /* lo=E */
    Instruction("comiss", ps_VssWss, IS.SSE),       /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_2_66 = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("", null, IS.STD),                  /* lo=1 - invalid */
    Instruction("", null, IS.STD),                  /* lo=2 - invalid */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("movapd", ps_VpdWpd, IS.SSE2),      /* lo=8 */
    Instruction("movapd", ps_WpdVpd, IS.SSE2),      /* lo=9 */
    Instruction("cvtpi2pd", ps_VpdQpj, IS.SSE2),    /* lo=A */
    Instruction("movntpd", ps_MoVpd, IS.SSE2),      /* lo=B */
    Instruction("cvttpd2pi", ps_PpjWpd, IS.SSE2),   /* lo=C */
    Instruction("cvtpd2pi", ps_PpjWpd, IS.SSE2),    /* lo=D */
    Instruction("ucomisd", ps_VsdWsd, IS.SSE2),     /* lo=E */
    Instruction("comisd", ps_VsdWsd, IS.SSE2),      /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_2_F2 = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("", null, IS.STD),                  /* lo=1 - invalid */
    Instruction("", null, IS.STD),                  /* lo=2 - invalid */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("cvtsi2sd", ps_VsdEy, IS.SSE2),     /* lo=A */
    Instruction("movntsd", ps_MqVsd, IS.STD),       /* lo=B */
    Instruction("cvttsd2si", ps_GyWsd, IS.SSE2),    /* lo=C */
    Instruction("cvtsd2si", ps_GyWsd, IS.SSE2),     /* lo=D */
    Instruction("", null, IS.STD),                  /* lo=E - invalid **/
    Instruction("", null, IS.STD),                  /* lo=F - invalid **/
];
__gshared Instruction[] INSTRUCTIONS_row_2_F3 = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("", null, IS.STD),                  /* lo=1 - invalid */
    Instruction("", null, IS.STD),                  /* lo=2 - invalid */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("cvtsi2ss", ps_VssEy, IS.SSE),      /* lo=A */
    Instruction("movntss", ps_MdVss, IS.STD),       /* lo=B */
    Instruction("cvttss2si", ps_GyWss, IS.SSE),     /* lo=C */
    Instruction("cvtss2si", ps_GyWss, IS.SSE),      /* lo=D */
    Instruction("", null, IS.STD),                  /* lo=E - invalid **/
    Instruction("", null, IS.STD),                  /* lo=F - invalid **/
];
/* row 3 */
__gshared Instruction[] INSTRUCTIONS_row_3 = [ // SSE
    Instruction("wrmsr", ps_none, IS.STD),      /* lo=0 */
    Instruction("rdtsc", ps_none, IS.STD),      /* lo=1 */
    Instruction("rdmsr", ps_none, IS.STD),      /* lo=2 */
    Instruction("rdpmc", ps_none, IS.STD),      /* lo=3 */
    Instruction("sysenter", ps_none, IS.STD),   /* lo=4 */
    Instruction("sysexit", ps_none, IS.STD),    /* lo=5 */
    Instruction("", null, IS.STD),              /* lo=6 */
    Instruction("", null, IS.STD),              /* lo=7 */
    Instruction("", null, IS.STD),              /* lo=8 - three byte opcode escape */
    Instruction("", null, IS.STD),              /* lo=9 */
    Instruction("", null, IS.STD),              /* lo=A - three byte opcode escape */
    Instruction("", null, IS.STD),              /* lo=B */
    Instruction("", null, IS.STD),              /* lo=C */
    Instruction("", null, IS.STD),              /* lo=D */
    Instruction("", null, IS.STD),              /* lo=E */
    Instruction("", null, IS.STD),              /* lo=F */
];
/* row 4 */
__gshared Instruction[] INSTRUCTIONS_row_4 = [
    Instruction("cmovo",  ps_GvEv, IS.STD),     /* lo=0 */
    Instruction("cmovno", ps_GvEv, IS.STD),     /* lo=1 */
    Instruction("cmovb",  ps_GvEv, IS.STD),     /* lo=2 */
    Instruction("cmovnb", ps_GvEv, IS.STD),     /* lo=3 */
    Instruction("cmove",  ps_GvEv, IS.STD),     /* lo=4 */
    Instruction("cmovne", ps_GvEv, IS.STD),     /* lo=5 */
    Instruction("cmovbe", ps_GvEv, IS.STD),     /* lo=6 */
    Instruction("cmova",  ps_GvEv, IS.STD),     /* lo=7 */
    Instruction("cmovs",  ps_GvEv, IS.STD),     /* lo=8 */
    Instruction("cmovns", ps_GvEv, IS.STD),     /* lo=9 */
    Instruction("cmovp",  ps_GvEv, IS.STD),     /* lo=A */
    Instruction("cmovnp", ps_GvEv, IS.STD),     /* lo=B */
    Instruction("cmovl",  ps_GvEv, IS.STD),     /* lo=C */
    Instruction("cmovge", ps_GvEv, IS.STD),     /* lo=D */
    Instruction("cmovle", ps_GvEv, IS.STD),     /* lo=E */
    Instruction("cmovg",  ps_GvEv, IS.STD),     /* lo=F */
];
/* row 5 */
__gshared Instruction[] INSTRUCTIONS_row_5 = [
    Instruction("movmskps", ps_GdUps, IS.SSE),      /* lo=0 */
    Instruction("sqrtps", ps_VpsWps, IS.SSE),       /* lo=1 */
    Instruction("rsqrtps", ps_VpsWps, IS.SSE),      /* lo=2 */
    Instruction("rcpps", ps_VpsWps, IS.SSE),        /* lo=3 */
    Instruction("andps", ps_VpsWps, IS.SSE),        /* lo=4 */
    Instruction("andnps", ps_VpsWps, IS.SSE),       /* lo=5 */
    Instruction("orps", ps_VpsWps, IS.SSE),         /* lo=6 */
    Instruction("xorps", ps_VpsWps, IS.SSE),        /* lo=7 */
    Instruction("addps", ps_VpsWps, IS.SSE),        /* lo=8 */
    Instruction("mulps", ps_VpsWps, IS.SSE),        /* lo=9 */
    Instruction("cvtps2pd", ps_VpsWps, IS.SSE2),    /* lo=A */
    Instruction("cvtdq2ps", ps_VpsWps, IS.SSE2),    /* lo=B */
    Instruction("subps", ps_VpsWps, IS.SSE),        /* lo=C */
    Instruction("minps", ps_VpsWps, IS.SSE),        /* lo=D */
    Instruction("divps", ps_VpsWps, IS.SSE),        /* lo=E */
    Instruction("maxps", ps_VpsWps, IS.STD),        /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_66 = [
    Instruction("movmskpd", ps_GdUpd, IS.STD),      /* lo=0 */
    Instruction("sqrtpd", ps_VpdWpd, IS.SSE2),      /* lo=1 */
    Instruction("", null, IS.STD),                  /* lo=2 - invalid */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("andpd", ps_VpdWpd, IS.SSE2),       /* lo=4 */
    Instruction("andnpd", ps_VpdWpd, IS.SSE2),      /* lo=5 */
    Instruction("orpd", ps_VpdWpd, IS.SSE2),        /* lo=6 */
    Instruction("xorpd", ps_VpdWpd, IS.SSE2),       /* lo=7 */
    Instruction("addpd", ps_VpdWpd, IS.SSE2),       /* lo=8 */
    Instruction("mulpd", ps_VpdWpd, IS.SSE2),       /* lo=9 */
    Instruction("cvtpd2ps", ps_VpdWpd, IS.SSE2),    /* lo=A */
    Instruction("cvtps2dq", ps_VoWps, IS.SSE2),     /* lo=B - invalid */
    Instruction("subpd", ps_VpdWpd, IS.SSE2),       /* lo=C */
    Instruction("minpd", ps_VpdWpd, IS.SSE2),       /* lo=D */
    Instruction("divpd", ps_VpdWpd, IS.SSE2),       /* lo=E */
    Instruction("maxpd", ps_VpdWpd, IS.SSE2),       /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_F2 = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("sqrtsd", ps_VsdWsd, IS.SSE2),      /* lo=1 */
    Instruction("", null, IS.STD),                  /* lo=2 - invalid */
    Instruction("", null, IS.STD),                  /* lo=3 - invalid */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("addsd", ps_VsdWsd, IS.SSE2),       /* lo=8 */
    Instruction("mulsd", ps_VsdWsd, IS.SSE2),       /* lo=9 */
    Instruction("cvtsd2ss", ps_VsdWsd, IS.SSE2),    /* lo=A */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("subsd", ps_VsdWsd, IS.SSE2),       /* lo=C */
    Instruction("minsd", ps_VsdWsd, IS.SSE2),       /* lo=D */
    Instruction("divsd", ps_VsdWsd, IS.SSE2),       /* lo=E */
    Instruction("maxsd", ps_VsdWsd, IS.SSE2),       /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_F3 = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("sqrtss", ps_VssWss, IS.SSE),       /* lo=1 */
    Instruction("rsqrtss", ps_VssWss, IS.SSE),      /* lo=2 */
    Instruction("rcpss", ps_VssWss, IS.SSE),        /* lo=3 */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("addss", ps_VssWss, IS.SSE),        /* lo=8 */
    Instruction("mulss", ps_VssWss, IS.SSE),        /* lo=9 */
    Instruction("cvtss2sd", ps_VssWss, IS.SSE2),    /* lo=A */
    Instruction("cvttps2dq", ps_VoWps, IS.SSE2),    /* lo=B */
    Instruction("subss", ps_VssWss, IS.SSE),        /* lo=C */
    Instruction("minss", ps_VssWss, IS.SSE),        /* lo=D */
    Instruction("divss", ps_VssWss, IS.SSE),        /* lo=E */
    Instruction("maxss", ps_VssWss, IS.SSE),        /* lo=F */
];
/* row 6 */
__gshared Instruction[] INSTRUCTIONS_row_6 = [
    Instruction("punpcklbw", ps_PqQd, IS.MMX),      /* lo=0 */
    Instruction("punpcklwd", ps_PqQd, IS.MMX),      /* lo=1 */
    Instruction("punpckldq", ps_PqQd, IS.MMX),      /* lo=2 */
    Instruction("packsswb", ps_PpiQpi, IS.MMX),     /* lo=3 */
    Instruction("pcmpgtb", ps_PpkQpk, IS.MMX),      /* lo=4 */
    Instruction("pcmpgtw", ps_PpiQpi, IS.MMX),      /* lo=5 */
    Instruction("pcmpgtd", ps_PpjQpj, IS.MMX),      /* lo=6 */
    Instruction("packuswb", ps_PpiQpi, IS.MMX),     /* lo=7 */
    Instruction("punpckhbw", ps_PqDq, IS.MMX),      /* lo=8 */
    Instruction("punpckhwd", ps_PqDq, IS.MMX),      /* lo=9 */
    Instruction("punpckhdq", ps_PqDq, IS.MMX),      /* lo=A */
    Instruction("packssdw", ps_PqDq, IS.MMX),       /* lo=B */
    Instruction("", null, IS.STD),                  /* lo=C - invalid */
    Instruction("", null, IS.STD),                  /* lo=D - invalid */
    Instruction("movd", ps_PyEy, IS.MMX),           /* lo=E */
    Instruction("movq", ps_PqQq, IS.MMX),           /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_6_66 = [
    Instruction("punpcklbw", ps_VoqWoq, IS.SSE2),   /* lo=0 */
    Instruction("punpcklwd", ps_VoqWoq, IS.SSE2),   /* lo=1 */
    Instruction("punpckldq", ps_VoqWoq, IS.SSE2),   /* lo=2 */
    Instruction("packsswb", ps_VpiWpi, IS.SSE2),    /* lo=3 */
    Instruction("pcmpgtb", ps_VpkWpk, IS.SSE2),     /* lo=4 */
    Instruction("pcmpgtw", ps_VpiWpi, IS.SSE2),     /* lo=5 */
    Instruction("pcmpgtd", ps_VpjWpj, IS.SSE2),     /* lo=6 */
    Instruction("packuswb", ps_VpiWpi, IS.SSE2),    /* lo=7 */
    Instruction("punpckhbw", ps_VoWq, IS.SSE2),     /* lo=8 */
    Instruction("punpckhwd", ps_VoWq, IS.SSE2),     /* lo=9 */
    Instruction("punpckhdq", ps_VoWq, IS.SSE2),     /* lo=A */
    Instruction("packssdw", ps_VoWo, IS.SSE2),      /* lo=B */
    Instruction("punpcklqdq", ps_VoWq, IS.SSE2),    /* lo=C */
    Instruction("punpckhqdq", ps_VoWq, IS.SSE2),    /* lo=D */
    Instruction("movd", ps_VyEy, IS.SSE2),          /* lo=E */
    Instruction("movdqa", ps_VoWo, IS.SSE2),        /* lo=F */
];
/* row 7 */
__gshared Instruction[] INSTRUCTIONS_row_7 = [
    Instruction("pshufw", ps_PqQqIb, IS.MMX),       /* lo=0 */
    Instruction("", null, IS.STD),                  /* lo=1 - group 12 */
    Instruction("", null, IS.STD),                  /* lo=2 - group 13 */
    Instruction("", null, IS.STD),                  /* lo=3 - group 14 */
    Instruction("pcmpeqb", ps_PpkQpk, IS.MMX),      /* lo=4 */
    Instruction("pcmpeqw", ps_PpiQpi, IS.MMX),      /* lo=5 */
    Instruction("pcmpeqd", ps_PpjQpj, IS.MMX),      /* lo=6 */
    Instruction("emms",  ps_none, IS.MMX),          /* lo=7 */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("", null, IS.STD),                  /* lo=A - invalid */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("", null, IS.STD),                  /* lo=C - invalid */
    Instruction("", null, IS.STD),                  /* lo=D - invalid */
    Instruction("movd", ps_EyPy, IS.MMX),           /* lo=E */
    Instruction("movq", ps_QqPq, IS.MMX),           /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_66 = [
    Instruction("pshufd", ps_VoWoIb, IS.SSE2),      /* lo=0 */
    Instruction("", null, IS.STD),                  /* lo=1 - group 12 */
    Instruction("", null, IS.STD),                  /* lo=2 - group 13 */
    Instruction("", null, IS.STD),                  /* lo=3 - group 14 */
    Instruction("pcmpeqb", ps_VpkWpk, IS.SSE2),     /* lo=4 */
    Instruction("pcmpeqw", ps_VpiWpi, IS.SSE2),     /* lo=5 */
    Instruction("pcmpeqd", ps_VpjWpj, IS.SSE2),     /* lo=6 */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("", null, IS.STD),                  /* lo=8 - group 17 */
    Instruction("extrq", ps_VoqUo, IS.STD),         /* lo=9 */
    Instruction("", null, IS.STD),                  /* lo=A - invalid */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("haddpd", ps_VpdWpd, IS.SSE3),      /* lo=C */
    Instruction("hsubpd", ps_VpdWpd, IS.SSE3),      /* lo=D */
    Instruction("movd", ps_EyVy, IS.STD),           /* lo=E */
    Instruction("movdqa", ps_WoVo, IS.STD),         /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_F2 = [
    Instruction("pshuflw", ps_VqWqIb, IS.SSE2),         /* lo=0 */
    Instruction("", null, IS.STD),                      /* lo=1 - group 12 */
    Instruction("", null, IS.STD),                      /* lo=2 - group 13 */
    Instruction("", null, IS.STD),                      /* lo=3 - group 14 */
    Instruction("", null, IS.STD),                      /* lo=4 - invalid */
    Instruction("", null, IS.STD),                      /* lo=5 - invalid */
    Instruction("", null, IS.STD),                      /* lo=6 - invalid */
    Instruction("", null, IS.STD),                      /* lo=7 - invalid */
    Instruction("insertq", ps_VoqUoqIbIb, IS.STD),      /* lo=8 - SSE4A */
    Instruction("insertq", ps_VoqUo, IS.STD),           /* lo=9 - SSE4A*/
    Instruction("", null, IS.STD),                      /* lo=A - invalid */
    Instruction("", null, IS.STD),                      /* lo=B - invalid */
    Instruction("haddps", ps_VpdWpd, IS.SSE3),          /* lo=C */
    Instruction("hsubps", ps_VpdWpd, IS.SSE3),          /* lo=D */
    Instruction("", null, IS.STD),                      /* lo=E */
    Instruction("", null, IS.STD),                      /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_F3 = [
    Instruction("pshufhw", ps_VqWqIb, IS.SSE2),     /* lo=0 */
    Instruction("", null, IS.STD),                  /* lo=1 - group 12 */
    Instruction("", null, IS.STD),                  /* lo=2 - group 13 */
    Instruction("", null, IS.STD),                  /* lo=3 - group 14 */
    Instruction("", null, IS.STD),                  /* lo=4 - invalid */
    Instruction("", null, IS.STD),                  /* lo=5 - invalid */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("", null, IS.STD),                  /* lo=7 - invalid */
    Instruction("", null, IS.STD),                  /* lo=8 - invalid */
    Instruction("", null, IS.STD),                  /* lo=9 - invalid */
    Instruction("", null, IS.STD),                  /* lo=A - invalid */
    Instruction("", null, IS.STD),                  /* lo=B - invalid */
    Instruction("", null, IS.STD),                  /* lo=C */
    Instruction("", null, IS.STD),                  /* lo=D */
    Instruction("movq", ps_VqWq, IS.STD),           /* lo=E */
    Instruction("movdqu", ps_WoVo, IS.STD),         /* lo=F */
];
/* row 8 */
__gshared Instruction[] INSTRUCTIONS_row_8 = [
    Instruction("jo",  ps_Jz, IS.STD),       /* lo=0 */
    Instruction("jno", ps_Jz, IS.STD),       /* lo=1 */
    Instruction("jb",  ps_Jz, IS.STD),       /* lo=2 */
    Instruction("jae", ps_Jz, IS.STD),       /* lo=3 */
    Instruction("je",  ps_Jz, IS.STD),       /* lo=4 */
    Instruction("jne", ps_Jz, IS.STD),       /* lo=5 */
    Instruction("jbe", ps_Jz, IS.STD),       /* lo=6 */
    Instruction("ja",  ps_Jz, IS.STD),       /* lo=7 */
    Instruction("js",  ps_Jz, IS.STD),       /* lo=8 */
    Instruction("jns", ps_Jz, IS.STD),       /* lo=9 */
    Instruction("jp",  ps_Jz, IS.STD),       /* lo=A */
    Instruction("jnp", ps_Jz, IS.STD),       /* lo=B */
    Instruction("jl",  ps_Jz, IS.STD),       /* lo=C */
    Instruction("jge", ps_Jz, IS.STD),       /* lo=D */
    Instruction("jle", ps_Jz, IS.STD),       /* lo=E */
    Instruction("jg",  ps_Jz, IS.STD),       /* lo=F */
];
/* row 9 */
__gshared Instruction[] INSTRUCTIONS_row_9 = [
    Instruction("seto",  ps_Eb, IS.STD),       /* lo=0 */
    Instruction("setno", ps_Eb, IS.STD),       /* lo=1 */
    Instruction("setb",  ps_Eb, IS.STD),       /* lo=2 */
    Instruction("setae", ps_Eb, IS.STD),       /* lo=3 */
    Instruction("sete",  ps_Eb, IS.STD),       /* lo=4 */
    Instruction("setne", ps_Eb, IS.STD),       /* lo=5 */
    Instruction("setbe", ps_Eb, IS.STD),       /* lo=6 */
    Instruction("seta",  ps_Eb, IS.STD),       /* lo=7 */
    Instruction("sets",  ps_Eb, IS.STD),       /* lo=8 */
    Instruction("setns", ps_Eb, IS.STD),       /* lo=9 */
    Instruction("setp",  ps_Eb, IS.STD),       /* lo=A */
    Instruction("setnp", ps_Eb, IS.STD),       /* lo=B */
    Instruction("setl",  ps_Eb, IS.STD),       /* lo=C */
    Instruction("setge", ps_Eb, IS.STD),       /* lo=D */
    Instruction("setle", ps_Eb, IS.STD),       /* lo=E */
    Instruction("setg",  ps_Eb, IS.STD),       /* lo=F */
];
/* row A */
__gshared Instruction[] INSTRUCTIONS_row_A = [
    Instruction("push FS",  ps_none, IS.STD, [Hint.SIZE_64]),   /* lo=0 */
    Instruction("pop FS", ps_none, IS.STD, [Hint.SIZE_64]),     /* lo=1 */
    Instruction("cpuid",  ps_none, IS.STD),                     /* lo=2 */
    Instruction("bt", ps_EvGv, IS.STD),                         /* lo=3 */
    Instruction("shld",  ps_EvGvIb, IS.STD),                    /* lo=4 */
    Instruction("shld", ps_EvGvCL, IS.STD),                     /* lo=5 */
    Instruction("", null, IS.STD),                              /* lo=6 - invalid */
    Instruction("", null, IS.STD),                              /* lo=7 - invalid */
    Instruction("push GS", ps_none, IS.STD, [Hint.SIZE_64]),    /* lo=8 */
    Instruction("pop GS", ps_none,IS.STD, [Hint.SIZE_64]),      /* lo=9 */
    Instruction("rsm",  ps_none, IS.STD),                       /* lo=A */
    Instruction("bts", ps_EvGv, IS.STD),                        /* lo=B */
    Instruction("shrd",  ps_EvGvIb, IS.STD),                    /* lo=C */
    Instruction("shrd", ps_EvGvCL, IS.STD),                     /* lo=D */
    Instruction("", null, IS.STD),                              /* lo=E - group 15 */
    Instruction("imul", ps_GvEv, IS.STD),                       /* lo=F */
];
/* row B without prefix bytes */
__gshared Instruction[] INSTRUCTIONS_row_B = [
    Instruction("cmpxchg",  ps_EbGb, IS.STD),   /* lo=0 */
    Instruction("cmpxchg", ps_EvGv, IS.STD),    /* lo=1 */
    Instruction("lss",  ps_GzMp, IS.STD),       /* lo=2 */
    Instruction("btr", ps_EvGv, IS.STD),        /* lo=3 */
    Instruction("lfs",  ps_GzMp, IS.STD),       /* lo=4 */
    Instruction("lgs", ps_GzMp, IS.STD),        /* lo=5 */
    Instruction("movzx", ps_GvEb, IS.STD),      /* lo=6 */
    Instruction("movzx",  ps_GvEw, IS.STD),     /* lo=7 */
    Instruction("", null, IS.STD),              /* lo=8 - invalid */
    Instruction("", null, IS.STD),              /* lo=9 - group 10 */
    Instruction("", null, IS.STD),              /* lo=A - group 8 */
    Instruction("btc", ps_EvGv, IS.STD),        /* lo=B */
    Instruction("bsf",  ps_GvEv, IS.STD),       /* lo=C */
    Instruction("bsr", ps_GvEv, IS.STD),        /* lo=D */
    Instruction("movsx", ps_GvEb, IS.STD),      /* lo=E */
    Instruction("movsx",  ps_GvEw, IS.STD),     /* lo=F */
];
/* row C */
__gshared Instruction[] INSTRUCTIONS_row_C = [
    Instruction("xadd", ps_EbGb, IS.STD),           /* lo=0 */
    Instruction("xadd", ps_EvGv, IS.STD),           /* lo=1 */
    Instruction("cmpps", ps_VpsWpsIb, IS.SSE),      /* lo=2 */
    Instruction("movnti", ps_MyGy, IS.SSE2),        /* lo=3 */
    Instruction("pinsrw", ps_PqEwIb, IS.SSE),       /* lo=4 */
    Instruction("pextrw", ps_GdNqIb, IS.SSE),       /* lo=5 */
    Instruction("shufps", ps_VpsWpsIb, IS.SSE),     /* lo=6 */
    Instruction("", null, IS.STD),                  /* lo=7 - group 9 */
    Instruction("bswap", ps_rAX, IS.STD),           /* lo=8 */
    Instruction("bswap", ps_rCX, IS.STD),           /* lo=9 */
    Instruction("bswap", ps_rDX, IS.STD),           /* lo=A */
    Instruction("bswap", ps_rBX, IS.STD),           /* lo=B */
    Instruction("bswap", ps_rSP, IS.STD),           /* lo=C */
    Instruction("bswap", ps_rBP, IS.STD),           /* lo=D */
    Instruction("bswap", ps_rSI, IS.STD),           /* lo=E */
    Instruction("bswap", ps_rDI, IS.STD),           /* lo=F */
];
/* row D */
__gshared Instruction[] INSTRUCTIONS_row_D = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("psrlw", ps_PqQq, IS.MMX),          /* lo=1 */
    Instruction("psrld", ps_PqQq, IS.MMX),          /* lo=2 */
    Instruction("psrlq", ps_PqQq, IS.MMX),          /* lo=3 */
    Instruction("paddq", ps_PqQq, IS.SSE2),         /* lo=4 */
    Instruction("pmullw", ps_PqQq, IS.MMX),         /* lo=5 */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("pmovmskb", ps_GdNq, IS.SSE),       /* lo=7 */
    Instruction("psubusb", ps_PqQq, IS.MMX),        /* lo=8 */
    Instruction("psubusw", ps_PqQq, IS.MMX),        /* lo=9 */
    Instruction("pminub", ps_PqQq, IS.SSE),         /* lo=A */
    Instruction("pand", ps_PqQq, IS.MMX),           /* lo=B */
    Instruction("paddusb", ps_PqQq, IS.MMX),        /* lo=C */
    Instruction("paddusw", ps_PqQq, IS.MMX),        /* lo=D */
    Instruction("pmaxub", ps_PqQq, IS.SSE),         /* lo=E */
    Instruction("pandn", ps_PqQq, IS.MMX),          /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_D_66 = [
    Instruction("addsubpd", ps_VpdWpd, IS.SSE3),    /* lo=0 */
    Instruction("psrlw", ps_VoWo, IS.SSE2),         /* lo=1 */
    Instruction("psrld", ps_VoWo, IS.SSE2),         /* lo=2 */
    Instruction("psrlq", ps_VoWo, IS.SSE2),         /* lo=3 */
    Instruction("paddq", ps_VoWo, IS.STD),          /* lo=4 */
    Instruction("pmullw", ps_VoWo, IS.SSE2),        /* lo=5 */
    Instruction("movq", ps_WqVq, IS.STD),           /* lo=6 */
    Instruction("pmovmskb", ps_GdUo, IS.SSE),       /* lo=7 */
    Instruction("psubusb", ps_VoWo, IS.SSE2),       /* lo=8 */
    Instruction("psubusw", ps_VoWo, IS.SSE2),       /* lo=9 */
    Instruction("pminub", ps_VoWo, IS.SSE),         /* lo=A */
    Instruction("pand", ps_VoWo, IS.SSE2),          /* lo=B */
    Instruction("paddusb", ps_VoWo, IS.SSE2),       /* lo=C */
    Instruction("paddusw", ps_VoWo, IS.SSE2),       /* lo=D */
    Instruction("pmaxub", ps_VoWo, IS.SSE),         /* lo=E */
    Instruction("pandn", ps_VoWo, IS.SSE2),         /* lo=F */
];
/* row E */
__gshared Instruction[] INSTRUCTIONS_row_E = [
    Instruction("pavgb", ps_PqQq, IS.SSE),          /* lo=0 */
    Instruction("psraw", ps_PqQq, IS.MMX),          /* lo=1 */
    Instruction("psrad", ps_PqQq, IS.MMX),          /* lo=2 */
    Instruction("pavgw", ps_PqQq, IS.SSE),          /* lo=3 */
    Instruction("pmulhuw", ps_PqQq, IS.SSE),        /* lo=4 */
    Instruction("pmulhw", ps_PqQq, IS.MMX),         /* lo=5 */
    Instruction("", null, IS.STD),                  /* lo=6 - invalid */
    Instruction("movntq", ps_MqPq, IS.SSE),         /* lo=7 */
    Instruction("psubsb", ps_PqQq, IS.MMX),         /* lo=8 */
    Instruction("psubsw", ps_PqQq, IS.MMX),         /* lo=9 */
    Instruction("pminsw", ps_PqQq, IS.SSE),         /* lo=A */
    Instruction("por", ps_PqQq, IS.MMX),            /* lo=B */
    Instruction("paddsb", ps_PqQq, IS.MMX),         /* lo=C */
    Instruction("paddsw", ps_PqQq, IS.MMX),         /* lo=D */
    Instruction("pmaxsw", ps_PqQq, IS.SSE),         /* lo=E */
    Instruction("pxor", ps_PqQq, IS.MMX),           /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_E_66 = [
    Instruction("pavgb", ps_VoWo, IS.SSE),          /* lo=0 */
    Instruction("psraw", ps_VoWo, IS.SSE2),         /* lo=1 */
    Instruction("psrad", ps_VoWo, IS.SSE2),         /* lo=2 */
    Instruction("pavgw", ps_VoWo, IS.SSE),          /* lo=3 */
    Instruction("pmulhuw", ps_VoWo, IS.SSE),        /* lo=4 */
    Instruction("pmulhw", ps_VoWo, IS.SSE2),        /* lo=5 */
    Instruction("cvttpd2dq", ps_VpjWpd, IS.SSE2),   /* lo=6 */
    Instruction("movntdq", ps_MoVo, IS.SSE2),       /* lo=7 */
    Instruction("psubsb", ps_VoWo, IS.SSE2),        /* lo=8 */
    Instruction("psubsw", ps_VoWo, IS.SSE2),        /* lo=9 */
    Instruction("pminsw", ps_VoWo, IS.SSE),         /* lo=A */
    Instruction("por", ps_VoWo, IS.SSE2),           /* lo=B */
    Instruction("paddsb", ps_VoWo, IS.SSE2),        /* lo=C */
    Instruction("paddsw", ps_VoWo, IS.SSE2),        /* lo=D */
    Instruction("pmaxsw", ps_VoWo, IS.SSE),         /* lo=E */
    Instruction("pxor", ps_VoWo, IS.SSE2),          /* lo=F */
];
/* row F */
__gshared Instruction[] INSTRUCTIONS_row_F = [
    Instruction("", null, IS.STD),                  /* lo=0 - invalid */
    Instruction("psllw", ps_PqQq, IS.MMX),          /* lo=1 */
    Instruction("pslld", ps_PqQq, IS.MMX),          /* lo=2 */
    Instruction("psllq", ps_PqQq, IS.MMX),          /* lo=3 */
    Instruction("pmuludq", ps_PqQq, IS.SSE2),       /* lo=4 */
    Instruction("pmaddwd", ps_PqQq, IS.MMX),        /* lo=5 */
    Instruction("psadbw", ps_PqQq, IS.SSE),         /* lo=6 */
    Instruction("maskmovq", ps_PqNq, IS.SSE),       /* lo=7 */
    Instruction("psubb", ps_PqQq, IS.MMX),          /* lo=8 */
    Instruction("psubw", ps_PqQq, IS.MMX),          /* lo=9 */
    Instruction("psubd", ps_PqQq, IS.MMX),          /* lo=A */
    Instruction("psubq", ps_PqQq, IS.SSE2),         /* lo=B */
    Instruction("paddb", ps_PqQq, IS.MMX),          /* lo=C */
    Instruction("paddw", ps_PqQq, IS.MMX),          /* lo=D */
    Instruction("paddd", ps_PqQq, IS.MMX),          /* lo=E */
    Instruction("", null, IS.STD),                  /* lo=F - UD0 */
];
__gshared Instruction[] INSTRUCTIONS_row_F_66 = [
    Instruction("", null, IS.STD),                      /* lo=0 - invalid */
    Instruction("psllw", ps_VpwWoq, IS.SSE2),           /* lo=1 */
    Instruction("pslld", ps_VpdwWoq, IS.SSE2),          /* lo=2 */
    Instruction("psllq", ps_VpqwWoq, IS.SSE2),          /* lo=3 */
    Instruction("pmuludq", ps_VpjWpj, IS.SSE2),         /* lo=4 */
    Instruction("pmaddwd", ps_VpiWpi, IS.SSE2),         /* lo=5 */
    Instruction("psadbw", ps_VpkWpk, IS.SSE),           /* lo=6 */
    Instruction("maskmovdqu", ps_VpbUpb, IS.SSE2),      /* lo=7 */
    Instruction("psubb", ps_VoWo, IS.SSE2),             /* lo=8 */
    Instruction("psubw", ps_VoWo, IS.SSE2),             /* lo=9 */
    Instruction("psubd", ps_VoWo, IS.SSE2),             /* lo=A */
    Instruction("psubq", ps_VoWo, IS.SSE2),             /* lo=B */
    Instruction("paddb", ps_VoWo, IS.SSE2),             /* lo=C */
    Instruction("paddw", ps_VoWo, IS.SSE2),             /* lo=D */
    Instruction("paddd", ps_VoWo, IS.SSE2),             /* lo=E */
    Instruction("", null, IS.STD),                      /* lo=F - UD0 */
];

