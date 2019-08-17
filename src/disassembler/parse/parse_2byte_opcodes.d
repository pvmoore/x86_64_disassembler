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
                if(loNibble==0xF) p.instr.copy(Instruction("movdqu", ps_VoWo));
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
                if(loNibble==8) group17(p);
                else p.instr.copy(INSTRUCTIONS_row_7_66[loNibble]);
            } else {
                /* no prefix */
                p.instr.copy(INSTRUCTIONS_row_7[loNibble]);
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
                if(loNibble==0x8) p.instr.copy(Instruction("popcnt", ps_GvEv, 0, IS.SSE4_2));
                else if(loNibble==0xC) p.instr.copy(Instruction("tzcnt", ps_GvEv));
                else if(loNibble==0xD) p.instr.copy(Instruction("lzcnt", ps_GvEv));
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
                p.instr.copy(Instruction("cmpss", ps_VssWssIb, 0, IS.SSE));
            } else if(p.prefix.repne && loNibble==0x2) {
                /* F2 */
                p.instr.copy(Instruction("cmpsd", ps_VsdWsdIb));
            } else if(p.prefix.opSize && loNibble.isOneOf(2,4,5,6)) {
                /* 66 */
                switch(loNibble) {
                    case 2: p.instr.copy(Instruction("cmppd", ps_VpdWpdIb)); break;
                    case 4: p.instr.copy(Instruction("pinsrw", ps_VoEwIb)); break;
                    case 5: p.instr.copy(Instruction("pextrw", ps_GdUoIb)); break;
                    case 6: p.instr.copy(Instruction("shufpd", ps_VpdWpdIb)); break;
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
                if(loNibble==0x6) p.instr.copy(Instruction("movq2dq", ps_VoNq));
            } else if(p.prefix.repne) {
                /* F2 */
                if(loNibble==0x0) p.instr.copy(Instruction("addsubps", ps_VpsWps, 0, IS.SSE3));
                else if(loNibble==0x6) p.instr.copy(Instruction("movqdq2q", ps_PqUq));
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
                if(loNibble==0x6) p.instr.copy(Instruction("cvtdq2pd", ps_VpdWpj));
            } else if(p.prefix.repne) {
                /* F2 */
                if(loNibble==0x6) p.instr.copy(Instruction("cvtpd2dq", ps_VpjWpd));
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
                if(loNibble==0x0) p.instr.copy(Instruction("lddqu", ps_VoMo, 0, IS.SSE3));
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

/* row 0 */
__gshared Instruction[] INSTRUCTIONS_row_0 = [
    Instruction("", null),              /* lo=0 - group 6 */
    Instruction("", null),              /* lo=1 - group 7 */
    Instruction("lar", ps_GvEw),        /* lo=2 */
    Instruction("lsl", ps_GvEw),        /* lo=3 */
    Instruction("", null),              /* lo=4 - invalid */
    Instruction("syscall", ps_none),    /* lo=5 */
    Instruction("clts", ps_none),       /* lo=6 */
    Instruction("sysret", ps_none),     /* lo=7 */
    Instruction("invd", ps_none),       /* lo=8 */
    Instruction("wbinvd", ps_none),     /* lo=9 - wbnoinvd id prefix F3 */
    Instruction("", null),              /* lo=A - invalid */
    Instruction("ud2", ps_none),        /* lo=B */
    Instruction("", null),              /* lo=C - invalid */
    Instruction("", null),              /* lo=D - group p */
    Instruction("femms", ps_none),      /* lo=E */
    Instruction("", null),              /* lo=F - 3DNow! escape */
];
/* row 1 */
__gshared Instruction[] INSTRUCTIONS_row_1 = [
    Instruction("movups", ps_VpsWps, 0, IS.SSE),    /* lo=0 */
    Instruction("movups", ps_WpsVps, 0, IS.SSE),    /* lo=1 */
    Instruction("movlps", ps_VqMq, 0, IS.SSE),      /* lo=2 */
    Instruction("movlps", ps_MqVq, 0, IS.SSE),      /* lo=3 */
    Instruction("unpcklps", ps_VpsWps, 0, IS.SSE),  /* lo=4 */
    Instruction("unpckhps", ps_VpsWps, 0, IS.SSE),  /* lo=5 */
    Instruction("movhps", ps_VoqMq, 0, IS.SSE),     /* lo=6 */
    Instruction("movhps", ps_MqVoq, 0, IS.SSE),     /* lo=7 */
    Instruction("", null),                          /* lo=8 - group 16 */
    Instruction("", null),                          /* lo=9 - nop */
    Instruction("", null),                          /* lo=A - nop */
    Instruction("", null),                          /* lo=B - nop */
    Instruction("", null),                          /* lo=C - nop */
    Instruction("", null),                          /* lo=D - nop */
    Instruction("", null),                          /* lo=E - nop */
    Instruction("", null),                          /* lo=F - nop */
];
__gshared Instruction[] INSTRUCTIONS_row_1_F3 = [
    Instruction("movss", ps_VssWss, 0, IS.SSE),     /* lo=0 */
    Instruction("movss", ps_WssVss, 0, IS.SSE),     /* lo=1 */
    Instruction("movsldup", ps_VpsWps, 0, IS.SSE3), /* lo=2 */
    Instruction("", null),                          /* lo=3 - invalid */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("movshdup", ps_VpsWps, 0, IS.SSE3), /* lo=6 */
    Instruction("", null),                          /* lo=7 - invalid */
    Instruction("", null),                          /* lo=8 - invalid */
    Instruction("", null),                          /* lo=9 - invalid */
    Instruction("", null),                          /* lo=A - invalid */
    Instruction("", null),                          /* lo=B - invalid */
    Instruction("", null),                          /* lo=C - invalid */
    Instruction("", null),                          /* lo=D - invalid */
    Instruction("", null),                          /* lo=E - invalid */
    Instruction("", null),                          /* lo=F - invalid */
];
__gshared Instruction[] INSTRUCTIONS_row_1_66 = [
    Instruction("movupd", ps_VpdWpd),   /* lo=0 */
    Instruction("movupd", ps_WpdVpd),   /* lo=1 */
    Instruction("movlpd", ps_VoqMq),    /* lo=2 */
    Instruction("movlpd", ps_MqVoq),    /* lo=3 */
    Instruction("unpcklpd", ps_VoqWoq), /* lo=4 */
    Instruction("unpckhpd", ps_VoqWoq), /* lo=5 */
    Instruction("movhpd", ps_VoqMq),    /* lo=6 */
    Instruction("movhpd", ps_MqVoq),    /* lo=7 */
    Instruction("", null),              /* lo=8 - invalid */
    Instruction("", null),              /* lo=9 - invalid */
    Instruction("", null),              /* lo=A - invalid */
    Instruction("", null),              /* lo=B - invalid */
    Instruction("", null),              /* lo=C - invalid */
    Instruction("", null),              /* lo=D - invalid */
    Instruction("", null),              /* lo=E - invalid */
    Instruction("", null),              /* lo=F - invalid */
];
__gshared Instruction[] INSTRUCTIONS_row_1_F2 = [
    Instruction("movsd", ps_VsdWsd),                    /* lo=0 */
    Instruction("movsd", ps_WsdVsd),                    /* lo=1 */
    Instruction("movddup", ps_VoWsd, 0, IS.SSE3),       /* lo=2 */
    Instruction("", null),                              /* lo=3 - invalid */
    Instruction("", null),                              /* lo=4 - invalid */
    Instruction("", null),                              /* lo=5 - invalid */
    Instruction("", null),                              /* lo=6 - invalid */
    Instruction("", null),                              /* lo=7 - invalid */
    Instruction("", null),                              /* lo=8 - invalid */
    Instruction("", null),                              /* lo=9 - invalid */
    Instruction("", null),                              /* lo=A - invalid */
    Instruction("", null),                              /* lo=B - invalid */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */
];
/* row 2 */
__gshared Instruction[] INSTRUCTIONS_row_2 = [
    Instruction("mov", ps_RdqCdq),                  /* lo=0 */
    Instruction("mov", ps_RdqDdq),                  /* lo=1 */
    Instruction("mov", ps_CdqRdq),                  /* lo=2 */
    Instruction("mov", ps_DdqRdq),                  /* lo=3 */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */
    Instruction("movaps", ps_VpsWps, 0, IS.SSE),    /* lo=8 */
    Instruction("movaps", ps_WpsVps, 0, IS.SSE),    /* lo=9 */
    Instruction("cvtpi2ps", ps_VpsQpj, 0, IS.SSE),  /* lo=A */
    Instruction("movntps", ps_MoVps, 0, IS.SSE),    /* lo=B */
    Instruction("cvttps2pi", ps_PpjWps, 0, IS.SSE), /* lo=C */
    Instruction("cvtps2pi", ps_PpjWps, 0, IS.SSE),  /* lo=D */
    Instruction("ucomiss", ps_VssWss, 0, IS.SSE),   /* lo=E */
    Instruction("comiss", ps_VssWss, 0, IS.SSE),    /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_2_66 = [
    Instruction("", null),              /* lo=0 - invalid */
    Instruction("", null),              /* lo=1 - invalid */
    Instruction("", null),              /* lo=2 - invalid */
    Instruction("", null),              /* lo=3 - invalid */
    Instruction("", null),              /* lo=4 - invalid */
    Instruction("", null),              /* lo=5 - invalid */
    Instruction("", null),              /* lo=6 - invalid */
    Instruction("", null),              /* lo=7 - invalid */
    Instruction("movapd", ps_VpdWpd),   /* lo=8 */
    Instruction("movapd", ps_WpdVpd),   /* lo=9 */
    Instruction("cvtpi2pd", ps_VpdQpj), /* lo=A */
    Instruction("movntpd", ps_MoVpd),   /* lo=B */
    Instruction("cvttpd2pi", ps_PpjWpd),/* lo=C */
    Instruction("cvtpd2pi", ps_PpjWpd), /* lo=D */
    Instruction("ucomisd", ps_VsdWsd),  /* lo=E */
    Instruction("comisd", ps_VsdWsd),   /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_2_F2 = [
    Instruction("", null),              /* lo=0 - invalid */
    Instruction("", null),              /* lo=1 - invalid */
    Instruction("", null),              /* lo=2 - invalid */
    Instruction("", null),              /* lo=3 - invalid */
    Instruction("", null),              /* lo=4 - invalid */
    Instruction("", null),              /* lo=5 - invalid */
    Instruction("", null),              /* lo=6 - invalid */
    Instruction("", null),              /* lo=7 - invalid */
    Instruction("", null),              /* lo=8 - invalid */
    Instruction("", null),              /* lo=9 - invalid */
    Instruction("cvtsi2sd", ps_VsdEy),  /* lo=A */
    Instruction("movntsd", ps_MqVsd),   /* lo=B */
    Instruction("cvttsd2si", ps_GyWsd), /* lo=C */
    Instruction("cvtsd2si", ps_GyWsd),  /* lo=D */
    Instruction("", null),              /* lo=E - invalid **/
    Instruction("", null),              /* lo=F - invalid **/
];
__gshared Instruction[] INSTRUCTIONS_row_2_F3 = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("", null),                          /* lo=1 - invalid */
    Instruction("", null),                          /* lo=2 - invalid */
    Instruction("", null),                          /* lo=3 - invalid */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */
    Instruction("", null),                          /* lo=8 - invalid */
    Instruction("", null),                          /* lo=9 - invalid */
    Instruction("cvtsi2ss", ps_VssEy, 0, IS.SSE),   /* lo=A */
    Instruction("movntss", ps_MdVss),               /* lo=B */
    Instruction("cvttss2si", ps_GyWss, 0, IS.SSE),  /* lo=C */
    Instruction("cvtss2si", ps_GyWss, 0, IS.SSE),   /* lo=D */
    Instruction("", null),                          /* lo=E - invalid **/
    Instruction("", null),                          /* lo=F - invalid **/
];
/* row 3 */
__gshared Instruction[] INSTRUCTIONS_row_3 = [ // SSE
    Instruction("wrmsr", ps_none),      /* lo=0 */
    Instruction("rdtsc", ps_none),      /* lo=1 */
    Instruction("rdmsr", ps_none),      /* lo=2 */
    Instruction("rdpmc", ps_none),      /* lo=3 */
    Instruction("sysenter", ps_none),   /* lo=4 */
    Instruction("sysexit", ps_none),    /* lo=5 */
    Instruction("", null),              /* lo=6 */
    Instruction("", null),              /* lo=7 */
    Instruction("", null),              /* lo=8 - three byte opcode escape */
    Instruction("", null),              /* lo=9 */
    Instruction("", null),              /* lo=A - three byte opcode escape */
    Instruction("", null),              /* lo=B */
    Instruction("", null),              /* lo=C */
    Instruction("", null),              /* lo=D */
    Instruction("", null),              /* lo=E */
    Instruction("", null),              /* lo=F */
];
/* row 4 */
__gshared Instruction[] INSTRUCTIONS_row_4 = [
    Instruction("cmovo",  ps_GvEv),     /* lo=0 */
    Instruction("cmovno", ps_GvEv),     /* lo=1 */
    Instruction("cmovb",  ps_GvEv),     /* lo=2 */
    Instruction("cmovnb", ps_GvEv),     /* lo=3 */
    Instruction("cmove",  ps_GvEv),     /* lo=4 */
    Instruction("cmovne", ps_GvEv),     /* lo=5 */
    Instruction("cmovbe", ps_GvEv),     /* lo=6 */
    Instruction("cmova",  ps_GvEv),     /* lo=7 */
    Instruction("cmovs",  ps_GvEv),     /* lo=8 */
    Instruction("cmovns", ps_GvEv),     /* lo=9 */
    Instruction("cmovp",  ps_GvEv),     /* lo=A */
    Instruction("cmovnp", ps_GvEv),     /* lo=B */
    Instruction("cmovl",  ps_GvEv),     /* lo=C */
    Instruction("cmovge", ps_GvEv),     /* lo=D */
    Instruction("cmovle", ps_GvEv),     /* lo=E */
    Instruction("cmovg",  ps_GvEv),     /* lo=F */
];
/* row 5 */
__gshared Instruction[] INSTRUCTIONS_row_5 = [
    Instruction("movmskps", ps_GdUps, 0, IS.SSE),   /* lo=0 */
    Instruction("sqrtps", ps_VpsWps, 0, IS.SSE),    /* lo=1 */
    Instruction("rsqrtps", ps_VpsWps, 0, IS.SSE),   /* lo=2 */
    Instruction("rcpps", ps_VpsWps, 0, IS.SSE),     /* lo=3 */
    Instruction("andps", ps_VpsWps, 0, IS.SSE),     /* lo=4 */
    Instruction("andnps", ps_VpsWps, 0, IS.SSE),    /* lo=5 */
    Instruction("orps", ps_VpsWps, 0, IS.SSE),      /* lo=6 */
    Instruction("xorps", ps_VpsWps, 0, IS.SSE),     /* lo=7 */
    Instruction("addps", ps_VpsWps, 0, IS.SSE),     /* lo=8 */
    Instruction("mulps", ps_VpsWps, 0, IS.SSE),     /* lo=9 */
    Instruction("cvtps2pd", ps_VpsWps),             /* lo=A */
    Instruction("cvtdq2ps", ps_VpsWps),             /* lo=B */
    Instruction("subps", ps_VpsWps, 0, IS.SSE),     /* lo=C */
    Instruction("minps", ps_VpsWps, 0, IS.SSE),     /* lo=D */
    Instruction("divps", ps_VpsWps, 0, IS.SSE),     /* lo=E */
    Instruction("maxps", ps_VpsWps),                /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_66 = [
    Instruction("movmskpd", ps_GdUpd),  /* lo=0 */
    Instruction("sqrtpd", ps_VpdWpd),   /* lo=1 */
    Instruction("", null),              /* lo=2 - invalid */
    Instruction("", null),              /* lo=3 - invalid */
    Instruction("andpd", ps_VpdWpd),    /* lo=4 */
    Instruction("andnpd", ps_VpdWpd),   /* lo=5 */
    Instruction("orpd", ps_VpdWpd),     /* lo=6 */
    Instruction("xorpd", ps_VpdWpd),    /* lo=7 */
    Instruction("addpd", ps_VpdWpd),    /* lo=8 */
    Instruction("mulpd", ps_VpdWpd),    /* lo=9 */
    Instruction("cvtpd2ps", ps_VpdWpd), /* lo=A */
    Instruction("cvtps2dq", ps_VoWps),  /* lo=B - invalid */
    Instruction("subpd", ps_VpdWpd),    /* lo=C */
    Instruction("minpd", ps_VpdWpd),    /* lo=D */
    Instruction("divpd", ps_VpdWpd),    /* lo=E */
    Instruction("maxpd", ps_VpdWpd),    /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_F2 = [
    Instruction("", null),              /* lo=0 - invalid */
    Instruction("sqrtsd", ps_VsdWsd),   /* lo=1 */
    Instruction("", null),              /* lo=2 - invalid */
    Instruction("", null),              /* lo=3 - invalid */
    Instruction("", null),              /* lo=4 - invalid */
    Instruction("", null),              /* lo=5 - invalid */
    Instruction("", null),              /* lo=6 - invalid */
    Instruction("", null),              /* lo=7 - invalid */
    Instruction("addsd", ps_VsdWsd),    /* lo=8 */
    Instruction("mulsd", ps_VsdWsd),    /* lo=9 */
    Instruction("cvtsd2ss", ps_VsdWsd), /* lo=A */
    Instruction("", null),              /* lo=B - invalid */
    Instruction("subsd", ps_VsdWsd),    /* lo=C */
    Instruction("minsd", ps_VsdWsd),    /* lo=D */
    Instruction("divsd", ps_VsdWsd),    /* lo=E */
    Instruction("maxsd", ps_VsdWsd),    /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_5_F3 = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("sqrtss", ps_VssWss, 0, IS.SSE),    /* lo=1 */
    Instruction("rsqrtss", ps_VssWss, 0, IS.SSE),   /* lo=2 */
    Instruction("rcpss", ps_VssWss, 0, IS.SSE),     /* lo=3 */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */
    Instruction("addss", ps_VssWss, 0, IS.SSE),     /* lo=8 */
    Instruction("mulss", ps_VssWss, 0, IS.SSE),     /* lo=9 */
    Instruction("cvtss2sd", ps_VssWss),             /* lo=A */
    Instruction("cvtps2dq", ps_VoWps),              /* lo=B */
    Instruction("subss", ps_VssWss, 0, IS.SSE),     /* lo=C */
    Instruction("minss", ps_VssWss, 0, IS.SSE),     /* lo=D */
    Instruction("divss", ps_VssWss, 0, IS.SSE),     /* lo=E */
    Instruction("maxss", ps_VssWss, 0, IS.SSE),     /* lo=F */
];
/* row 6 */
__gshared Instruction[] INSTRUCTIONS_row_6 = [
    Instruction("punpcklbw", ps_PqQd),   /* lo=0 */
    Instruction("punpcklwd", ps_PqQd),   /* lo=1 */
    Instruction("punpckldq", ps_PqQd),   /* lo=2 */
    Instruction("packsswb", ps_PpiQpi),  /* lo=3 */
    Instruction("pcmpgtb", ps_PpkQpk),   /* lo=4 */
    Instruction("pcmpgtw", ps_PpiQpi),   /* lo=5 */
    Instruction("pcmpgtd", ps_PpjQpj),   /* lo=6 */
    Instruction("packuswb", ps_PpiQpi),  /* lo=7 */
    Instruction("punpckhbw", ps_PqDq),   /* lo=8 */
    Instruction("punpckhwd", ps_PqDq),   /* lo=9 */
    Instruction("punpckhdq", ps_PqDq),   /* lo=A */
    Instruction("packssdw", ps_PqDq),    /* lo=B */
    Instruction("", null),               /* lo=C - invalid */
    Instruction("", null),               /* lo=D - invalid */
    Instruction("movd", ps_PyEy),        /* lo=E */
    Instruction("movq", ps_PqQq),        /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_6_66 = [
    Instruction("punpcklbw", ps_VoqWoq), /* lo=0 */
    Instruction("punpcklwd", ps_VoqWoq), /* lo=1 */
    Instruction("punpckldq", ps_VoqWoq), /* lo=2 */
    Instruction("packsswb", ps_VpiWpi),  /* lo=3 */
    Instruction("pcmpgtb", ps_VpkWpk),   /* lo=4 */
    Instruction("pcmpgtw", ps_VpiWpi),   /* lo=5 */
    Instruction("pcmpgtd", ps_VpjWpj),   /* lo=6 */
    Instruction("packuswb", ps_VpiWpi),  /* lo=7 */
    Instruction("punpckhbw", ps_VoWq),   /* lo=8 */
    Instruction("punpckhwd", ps_VoWq),   /* lo=9 */
    Instruction("punpckhdq", ps_VoWq),   /* lo=A */
    Instruction("packssdw", ps_VoWo),    /* lo=B */
    Instruction("punpcklqdq", ps_VoWq),  /* lo=C */
    Instruction("punpckhqdq", ps_VoWq),  /* lo=D */
    Instruction("movd", ps_VyEy),        /* lo=E */
    Instruction("movdqa", ps_VoWo),      /* lo=F */
];
/* row 7 */
__gshared Instruction[] INSTRUCTIONS_row_7 = [
    Instruction("pshufw", ps_PqQqIb, 0, IS.SSE),    /* lo=0 */
    Instruction("", null),                          /* lo=1 - group 12 */
    Instruction("", null),                          /* lo=2 - group 13 */
    Instruction("", null),                          /* lo=3 - group 14 */
    Instruction("pcmpeqb", ps_PpkQpk),              /* lo=4 */
    Instruction("pcmpeqw", ps_PpiQpi),              /* lo=5 */
    Instruction("pcmpeqd", ps_PpjQpj),              /* lo=6 */
    Instruction("emms",  ps_none),                  /* lo=7 */
    Instruction("", null),                          /* lo=8 - invalid */
    Instruction("", null),                          /* lo=9 - invalid */
    Instruction("", null),                          /* lo=A - invalid */
    Instruction("", null),                          /* lo=B - invalid */
    Instruction("", null),                          /* lo=C - invalid */
    Instruction("", null),                          /* lo=D - invalid */
    Instruction("movd", ps_EyPy),                   /* lo=E */
    Instruction("movq", ps_QqPq),                   /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_66 = [
    Instruction("pshufd", ps_VoWoIb),               /* lo=0 */
    Instruction("", null),                          /* lo=1 - group 12 */
    Instruction("", null),                          /* lo=2 - group 13 */
    Instruction("", null),                          /* lo=3 - group 14 */
    Instruction("pcmpeqb", ps_VpkWpk),              /* lo=4 */
    Instruction("pcmpeqw", ps_VpiWpi),              /* lo=5 */
    Instruction("pcmpeqd", ps_VpjWpj),              /* lo=6 */
    Instruction("", null),                          /* lo=7 - invalid */
    Instruction("", null),                          /* lo=8 - group 17 */
    Instruction("extrq", ps_VoqUo),                 /* lo=9 */
    Instruction("", null),                          /* lo=A - invalid */
    Instruction("", null),                          /* lo=B - invalid */
    Instruction("haddpd", ps_VpdWpd, 0, IS.SSE3),   /* lo=C */
    Instruction("hsubpd", ps_VpdWpd, 0, IS.SSE3),   /* lo=D */
    Instruction("movd", ps_EyVy),                   /* lo=E */
    Instruction("movdqa", ps_WoVo),                 /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_F2 = [
    Instruction("pshuflw", ps_VqWqIb),                  /* lo=0 */
    Instruction("", null),                              /* lo=1 - group 12 */
    Instruction("", null),                              /* lo=2 - group 13 */
    Instruction("", null),                              /* lo=3 - group 14 */
    Instruction("", null),                              /* lo=4 - invalid */
    Instruction("", null),                              /* lo=5 - invalid */
    Instruction("", null),                              /* lo=6 - invalid */
    Instruction("", null),                              /* lo=7 - invalid */
    Instruction("insertq", ps_VoqUoqIbIb),              /* lo=8 - SSE4A */
    Instruction("insertq", ps_VoqUo),                   /* lo=9 - SSE4A*/
    Instruction("", null),                              /* lo=A - invalid */
    Instruction("", null),                              /* lo=B - invalid */
    Instruction("haddps", ps_VpdWpd, 0, IS.SSE3),       /* lo=C */
    Instruction("hsubps", ps_VpdWpd, 0, IS.SSE3),       /* lo=D */
    Instruction("", null),                              /* lo=E */
    Instruction("", null),                              /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_7_F3 = [
    Instruction("pshufhw", ps_VqWqIb),  /* lo=0 */
    Instruction("", null),              /* lo=1 - group 12 */
    Instruction("", null),              /* lo=2 - group 13 */
    Instruction("", null),              /* lo=3 - group 14 */
    Instruction("", null),              /* lo=4 - invalid */
    Instruction("", null),              /* lo=5 - invalid */
    Instruction("", null),              /* lo=6 - invalid */
    Instruction("", null),              /* lo=7 - invalid */
    Instruction("", null),              /* lo=8 - invalid */
    Instruction("", null),              /* lo=9 - invalid */
    Instruction("", null),              /* lo=A - invalid */
    Instruction("", null),              /* lo=B - invalid */
    Instruction("", null),              /* lo=C */
    Instruction("", null),              /* lo=D */
    Instruction("movq", ps_VqWq),       /* lo=E */
    Instruction("movdqu", ps_WoVo),     /* lo=F */
];
/* row 8 */
__gshared Instruction[] INSTRUCTIONS_row_8 = [
    Instruction("jo",  ps_Jz),       /* lo=0 */
    Instruction("jno", ps_Jz),       /* lo=1 */
    Instruction("jb",  ps_Jz),       /* lo=2 */
    Instruction("jae", ps_Jz),       /* lo=3 */
    Instruction("je",  ps_Jz),       /* lo=4 */
    Instruction("jne", ps_Jz),       /* lo=5 */
    Instruction("jbe", ps_Jz),       /* lo=6 */
    Instruction("ja",  ps_Jz),       /* lo=7 */
    Instruction("js",  ps_Jz),       /* lo=8 */
    Instruction("jns", ps_Jz),       /* lo=9 */
    Instruction("jp",  ps_Jz),       /* lo=A */
    Instruction("jnp", ps_Jz),       /* lo=B */
    Instruction("jl",  ps_Jz),       /* lo=C */
    Instruction("jge", ps_Jz),       /* lo=D */
    Instruction("jle", ps_Jz),       /* lo=E */
    Instruction("jg",  ps_Jz),       /* lo=F */
];
/* row 9 */
__gshared Instruction[] INSTRUCTIONS_row_9 = [
    Instruction("seto",  ps_Eb),       /* lo=0 */
    Instruction("setno", ps_Eb),       /* lo=1 */
    Instruction("setb",  ps_Eb),       /* lo=2 */
    Instruction("setae", ps_Eb),       /* lo=3 */
    Instruction("sete",  ps_Eb),       /* lo=4 */
    Instruction("setne", ps_Eb),       /* lo=5 */
    Instruction("setbe", ps_Eb),       /* lo=6 */
    Instruction("seta",  ps_Eb),       /* lo=7 */
    Instruction("sets",  ps_Eb),       /* lo=8 */
    Instruction("setns", ps_Eb),       /* lo=9 */
    Instruction("setp",  ps_Eb),       /* lo=A */
    Instruction("setnp", ps_Eb),       /* lo=B */
    Instruction("setl",  ps_Eb),       /* lo=C */
    Instruction("setge", ps_Eb),       /* lo=D */
    Instruction("setle", ps_Eb),       /* lo=E */
    Instruction("setg",  ps_Eb),       /* lo=F */
];
/* row A */
__gshared Instruction[] INSTRUCTIONS_row_A = [
    Instruction("push FS",  ps_none, 64),   /* lo=0 */
    Instruction("pop FS", ps_none, 64),     /* lo=1 */
    Instruction("cpuid",  ps_none),         /* lo=2 */
    Instruction("bt", ps_EvGv),             /* lo=3 */
    Instruction("shld",  ps_EvGvIb),        /* lo=4 */
    Instruction("shld", ps_EvGvCL),         /* lo=5 */
    Instruction("", null),                  /* lo=6 - invalid */
    Instruction("", null),                  /* lo=7 - invalid */
    Instruction("push GS", ps_none, 64),    /* lo=8 */
    Instruction("pop GS", ps_none, 64),     /* lo=9 */
    Instruction("rsm",  ps_none),           /* lo=A */
    Instruction("bts", ps_EvGv),            /* lo=B */
    Instruction("shrd",  ps_EvGvIb),        /* lo=C */
    Instruction("shrd", ps_EvGvCL),         /* lo=D */
    Instruction("", null),                  /* lo=E - group 15 */
    Instruction("imul", ps_GvEv),           /* lo=F */
];
/* row B without prefix bytes */
__gshared Instruction[] INSTRUCTIONS_row_B = [
    Instruction("cmpxchg",  ps_EbGb),   /* lo=0 */
    Instruction("cmpxchg", ps_EvGv),    /* lo=1 */
    Instruction("lss",  ps_GzMp),       /* lo=2 */
    Instruction("btr", ps_EvGv),        /* lo=3 */
    Instruction("lfs",  ps_GzMp),       /* lo=4 */
    Instruction("lgs", ps_GzMp),        /* lo=5 */
    Instruction("movzx", ps_GvEb),      /* lo=6 */
    Instruction("movzx",  ps_GvEw),     /* lo=7 */
    Instruction("", null),              /* lo=8 - invalid */
    Instruction("", null),              /* lo=9 - group 10 */
    Instruction("", null),              /* lo=A - group 8 */
    Instruction("btc", ps_EvGv),        /* lo=B */
    Instruction("bsf",  ps_GvEv),       /* lo=C */
    Instruction("bsr", ps_GvEv),        /* lo=D */
    Instruction("movsx", ps_GvEb),      /* lo=E */
    Instruction("movsx",  ps_GvEw),     /* lo=F */
];
/* row C */
__gshared Instruction[] INSTRUCTIONS_row_C = [
    Instruction("xadd", ps_EbGb),                   /* lo=0 */
    Instruction("xadd", ps_EvGv),                   /* lo=1 */
    Instruction("cmpps", ps_VpsWpsIb, 0, IS.SSE),   /* lo=2 */
    Instruction("movnti", ps_MyGy),                 /* lo=3 */
    Instruction("pinsrw", ps_PqEwIb, 0, IS.SSE),    /* lo=4 */
    Instruction("pextrw", ps_GdNqIb, 0, IS.SSE),    /* lo=5 */
    Instruction("shufps", ps_VpsWpsIb, 0, IS.SSE),  /* lo=6 */
    Instruction("", null),                          /* lo=7 - group 9 */
    Instruction("bswap", ps_rAX),                   /* lo=8 */
    Instruction("bswap", ps_rCX),                   /* lo=9 */
    Instruction("bswap", ps_rDX),                   /* lo=A */
    Instruction("bswap", ps_rBX),                   /* lo=B */
    Instruction("bswap", ps_rSP),                   /* lo=C */
    Instruction("bswap", ps_rBP),                   /* lo=D */
    Instruction("bswap", ps_rSI),                   /* lo=E */
    Instruction("bswap", ps_rDI),                   /* lo=F */
];
/* row D */
__gshared Instruction[] INSTRUCTIONS_row_D = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("psrlw", ps_PqQq),                  /* lo=1 */
    Instruction("psrld", ps_PqQq),                  /* lo=2 */
    Instruction("psrlq", ps_PqQq),                  /* lo=3 */
    Instruction("paddq", ps_PqQq),                  /* lo=4 */
    Instruction("pmullw", ps_PqQq),                 /* lo=5 */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("pmovmskb", ps_GdNq, 0, IS.SSE),    /* lo=7 */
    Instruction("psubusb", ps_PqQq),                /* lo=8 */
    Instruction("psubusw", ps_PqQq),                /* lo=9 */
    Instruction("pminub", ps_PqQq, 0, IS.SSE),      /* lo=A */
    Instruction("pand", ps_PqQq),                   /* lo=B */
    Instruction("paddusb", ps_PqQq),                /* lo=C */
    Instruction("paddusw", ps_PqQq),                /* lo=D */
    Instruction("pmaxub", ps_PqQq, 0, IS.SSE),      /* lo=E */
    Instruction("pandn", ps_PqQq),                  /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_D_66 = [
    Instruction("addsubpd", ps_VpdWpd, 0, IS.SSE3), /* lo=0 */
    Instruction("psrlw", ps_VoWo),                  /* lo=1 */
    Instruction("psrld", ps_VoWo),                  /* lo=2 */
    Instruction("psrlq", ps_VoWo),                  /* lo=3 */
    Instruction("paddq", ps_VoWo),                  /* lo=4 */
    Instruction("pmullw", ps_VoWo),                 /* lo=5 */
    Instruction("movq", ps_WqVq),                   /* lo=6 */
    Instruction("pmovmskb", ps_GdUo, 0, IS.SSE),    /* lo=7 */
    Instruction("psubusb", ps_VoWo),                /* lo=8 */
    Instruction("psubusw", ps_VoWo),                /* lo=9 */
    Instruction("pminub", ps_VoWo, 0, IS.SSE),      /* lo=A */
    Instruction("pand", ps_VoWo),                   /* lo=B */
    Instruction("paddusb", ps_VoWo),                /* lo=C */
    Instruction("paddusw", ps_VoWo),                /* lo=D */
    Instruction("pmaxub", ps_VoWo, 0, IS.SSE),      /* lo=E */
    Instruction("pandn", ps_VoWo),                  /* lo=F */
];
/* row E */
__gshared Instruction[] INSTRUCTIONS_row_E = [
    Instruction("pavgb", ps_PqQq, 0, IS.SSE),       /* lo=0 */
    Instruction("psraw", ps_PqQq),                  /* lo=1 */
    Instruction("psrad", ps_PqQq),                  /* lo=2 */
    Instruction("pavgw", ps_PqQq, 0, IS.SSE),       /* lo=3 */
    Instruction("pmulhuw", ps_PqQq, 0, IS.SSE),     /* lo=4 */
    Instruction("pmulhw", ps_PqQq),                 /* lo=5 */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("movntq", ps_MqPq, 0, IS.SSE),      /* lo=7 */
    Instruction("psubsb", ps_PqQq),                 /* lo=8 */
    Instruction("psubsw", ps_PqQq),                 /* lo=9 */
    Instruction("pminsw", ps_PqQq, 0, IS.SSE),      /* lo=A */
    Instruction("por", ps_PqQq),                    /* lo=B */
    Instruction("paddsb", ps_PqQq),                 /* lo=C */
    Instruction("paddsw", ps_PqQq),                 /* lo=D */
    Instruction("pmaxsw", ps_PqQq, 0, IS.SSE),      /* lo=E */
    Instruction("pxor", ps_PqQq),                   /* lo=F */
];
__gshared Instruction[] INSTRUCTIONS_row_E_66 = [
    Instruction("pavgb", ps_VoWo, 0, IS.SSE),       /* lo=0 */
    Instruction("psraw", ps_VoWo),                  /* lo=1 */
    Instruction("psrad", ps_VoWo),                  /* lo=2 */
    Instruction("pavgw", ps_VoWo, 0, IS.SSE),       /* lo=3 */
    Instruction("pmulhuw", ps_VoWo, 0, IS.SSE),     /* lo=4 */
    Instruction("pmulhw", ps_VoWo),                 /* lo=5 */
    Instruction("cvttpd2dq", ps_VpjWpd),            /* lo=6 */
    Instruction("movntdq", ps_MoVo),                /* lo=7 */
    Instruction("psubsb", ps_VoWo),                 /* lo=8 */
    Instruction("psubsw", ps_VoWo),                 /* lo=9 */
    Instruction("pminsw", ps_VoWo, 0, IS.SSE),      /* lo=A */
    Instruction("por", ps_VoWo),                    /* lo=B */
    Instruction("paddsb", ps_VoWo),                 /* lo=C */
    Instruction("paddsw", ps_VoWo),                 /* lo=D */
    Instruction("pmaxsw", ps_VoWo, 0, IS.SSE),      /* lo=E */
    Instruction("pxor", ps_VoWo),                   /* lo=F */
];
/* row F */
__gshared Instruction[] INSTRUCTIONS_row_F = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("psllw", ps_PqQq),                  /* lo=1 */
    Instruction("pslld", ps_PqQq),                  /* lo=2 */
    Instruction("psllq", ps_PqQq),                  /* lo=3 */
    Instruction("pmuludq", ps_PqQq),                /* lo=4 */
    Instruction("pmaddwd", ps_PqQq),                /* lo=5 */
    Instruction("psadbw", ps_PqQq, 0, IS.SSE),      /* lo=6 */
    Instruction("maskmovq", ps_PqNq, 0, IS.SSE),    /* lo=7 */
    Instruction("psubb", ps_PqQq),                  /* lo=8 */
    Instruction("psubw", ps_PqQq),                  /* lo=9 */
    Instruction("psubd", ps_PqQq),                  /* lo=A */
    Instruction("psubq", ps_PqQq),                  /* lo=B */
    Instruction("paddb", ps_PqQq),                  /* lo=C */
    Instruction("paddw", ps_PqQq),                  /* lo=D */
    Instruction("paddd", ps_PqQq),                  /* lo=E */
    Instruction("", null),                          /* lo=F - UD0 */
];
__gshared Instruction[] INSTRUCTIONS_row_F_66 = [
    Instruction("", null),                              /* lo=0 - invalid */
    Instruction("psllw", ps_VpwWoq),                    /* lo=1 */
    Instruction("pslld", ps_VpdwWoq),                   /* lo=2 */
    Instruction("psllq", ps_VpqwWoq),                   /* lo=3 */
    Instruction("pmuludq", ps_VpjWpj),                  /* lo=4 */
    Instruction("pmaddwd", ps_VpiWpi),                  /* lo=5 */
    Instruction("psadbw", ps_VpkWpk, 0, IS.SSE),        /* lo=6 */
    Instruction("maskmovdqu", ps_VpbUpb),               /* lo=7 */
    Instruction("psubb", ps_VoWo),                      /* lo=8 */
    Instruction("psubw", ps_VoWo),                      /* lo=9 */
    Instruction("psubd", ps_VoWo),                      /* lo=A */
    Instruction("psubq", ps_VoWo),                      /* lo=B */
    Instruction("paddb", ps_VoWo),                      /* lo=C */
    Instruction("paddw", ps_VoWo),                      /* lo=D */
    Instruction("paddd", ps_VoWo),                      /* lo=E */
    Instruction("", null),                              /* lo=F - UD0 */
];
/* group 6 */
__gshared Instruction[] INSTRUCTIONS_0F_00_grp6 = [
    Instruction("sldt", ps_Mw_or_Rv),   /* reg=0 */
    Instruction("str", ps_Mw_or_Rv),    /* reg=1 */
    Instruction("lldt", ps_Ew),         /* reg=2 */
    Instruction("ltr", ps_Ew),          /* reg=3 */
    Instruction("verr", ps_Ew),         /* reg=4 */
    Instruction("verw", ps_Ew),         /* reg=5 */
    Instruction("", null),              /* reg=6 - invalid */
    Instruction("", null),              /* reg=7 - invalid */
];
/* group 7 */
__gshared Instruction[] INSTRUCTIONS_0F_01_grp7 = [
    Instruction("sgdt", ps_Ms),         /* reg=0 */
    Instruction("sidt", ps_Ms),         /* reg=1 */
    Instruction("lgdt", ps_Ms),         /* reg=2 */
    Instruction("lidt", ps_Ms),         /* reg=3 */
    Instruction("smsw", ps_Mw_or_Rv),   /* reg=4 */
    Instruction("", null),              /* reg=5 - invalid*/
    Instruction("lmsw", ps_Ew),         /* reg=6 */
    Instruction("invlpg", ps_Mb),       /* reg=7 */
];
/* group 8 */
__gshared Instruction[] INSTRUCTIONS_B_grp8 = [
    Instruction("", null),         /* reg=0 - invalid */
    Instruction("", null),         /* reg=1 - invalid */
    Instruction("", null),         /* reg=2 - invalid */
    Instruction("", null),         /* reg=3 - invalid */
    Instruction("bt", ps_EvIb),    /* reg=4 */
    Instruction("bts", ps_EvIb),   /* reg=5 */
    Instruction("btr", ps_EvIb),   /* reg=6 */
    Instruction("btc", ps_EvIb),   /* reg=7 */
];
