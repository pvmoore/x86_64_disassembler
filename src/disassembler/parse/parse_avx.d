module disassembler.parse.parse_avx;

import disassembler.all;
/*
    R: Inverted one-bit extension of ModRM reg field
    X: Inverted one-bit extension of SIB index field
    B: Inverted one-bit extension, r/m field or SIB base field
    W: Default operand size override for a general purpose register to 64-bit size in 64-bit mode;
       operand configuration specifier for certain YMM/XMM-based operations.

    mapSelect: Opcode map select

        map 1 - Same as used by 2-byte vex
        map 2 - 0f_38 3-byte map
        map 3 - 0F 3A 3-byte opcode map

    vvvv: Source or destination register selector, in ones’ complement format

        0: XMM15/YMM15      8: XMM7/YMM7
        1: XMM14/YMM14      9: XMM6/YMM6
        2: XMM13/YMM13     10: XMM5/YMM5
        3: XMM12/YMM12     11: XMM4/YMM4
        4: XMM11/YMM11     12: XMM3/YMM3
        5: XMM10/YMM10     13: XMM2/YMM2
        6: XMM9/YMM9       14: XMM1/YMM1
        7: XMM8/YMM8       15: XMM0/YMM0

    L: Vector length specifier

        0 = 128-bit, 1 = 256-bit (ignored for scalar operands)

    pp: Implied 66, F2, or F3 opcode extension

        0=none, 1=66, 2=F3, 3=F2
*/
// page 67
private struct AVX {
    enum PP : uint { _0, _1, _2, _3 }
    uint R;
    uint X;
    uint B;
    uint W;
    uint L;
    uint pp;
    uint vvvv;
    uint map;

    string toString() { return "AVX(R=%s X=%s B=%s W=%s L=%s)".format(R,X,B,W,L); }

    this(uint byte1) {
        R    = (byte1 >>> 7) & 1;
        X    = 1;
        B    = 1;
        map  = 1;
        W    = 0;
        vvvv = (byte1 >>> 3) & 0b1111;
        L    = (byte1 >>> 2) & 1;
        pp   = cast(PP)(byte1 & 0b11);
    }
    this(uint byte1, uint byte2) {
        R    = (byte1 >>> 7) & 1;
        X    = (byte1 >>> 6) & 1;
        B    = (byte1 >>> 5) & 1;
        map  = byte1 & 0b11111;
        W    = (byte2 >>> 7) & 1;
        vvvv = (byte2 >>> 3) & 0b1111;
        L    = (byte2 >>> 2) & 1;
        pp   = cast(PP)(byte2 & 0b11);

        assert(map.isOneOf(1, 2, 3), "map=%s".format(map));   // all other maps are reserved
    }
}
void parseVex2Byte(Parser p, uint byte1) {

    auto v = AVX(byte1);
    //chat("2byte avx=%s", v);

    page1(p, v);
}
void parseVex3Byte(Parser p, uint byte1) {
    uint byte2 = p.readByte();

    //chat("byte1=%x, byte2=%x", byte1, byte2);

    auto v = AVX(byte1, byte2);
    //chat("3byte avx=%s", v);

    page1(p, v);
}
void page1(Parser p, ref AVX avx) {
    // page 524

    uint op     = p.readByte();
    auto hi     = cast(Nibble)((op >>> 4) & 0b1111);
    auto lo     = cast(Nibble)(op & 0b1111);
    auto modrm  = ModRM(p.peekByte());

    final switch(hi) with(Nibble) {
        case _00:
            /* nothing here */
            break;
        case _01:
            final switch(avx.pp) with(AVX.PP) {
                case _0:
                    if(lo==_02 && modrm.mod==0b11) {
                        p.instr.copy(Instruction("vmovhlps", ps_VpsHpsUps, 0, IS.AVX));
                    } else if(lo==_06 && modrm.mod==0b11) {
                        p.instr.copy(Instruction("vmovlhps", ps_VpsHpsUps, 0, IS.AVX));
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row1_pp0[lo]);
                    }
                    break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_row1_pp1[lo]); break;
                case _2:
                    switch(lo) {
                        case _00:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_VssHssUss, 0, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_VssMd, 0, IS.AVX));
                            }
                            break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_UssHssVss, 0, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_MdVss, 0, IS.AVX));
                            }
                            break;
                        case _02: p.instr.copy(Instruction("vmovsldup", ps_VpsxWpsx, 0, IS.AVX)); break;
                        case _06: p.instr.copy(Instruction("vmovshdup", ps_VpsxWpsx, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00:
                           if(modrm.mod==0b11) {
                               p.instr.copy(Instruction("vmovsd", ps_VsdHsdUsd, 0, IS.AVX));
                           } else {
                               p.instr.copy(Instruction("vmovsd", ps_VsdMq, 0, IS.AVX));
                           }
                           break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovsd", ps_UsdHsdVsd, 0, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovsd", ps_MqVsd, 0, IS.AVX));
                            }
                            break;
                        case _02:
                            if(avx.L) {
                                p.instr.copy(Instruction("vmovddup", ps_VdoWdo, 0, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovddup", ps_VoWq, 0, IS.AVX));
                            }
                            break;
                        default: break;
                    }
                    break;
            }
            break;
        case _02:
            final switch(avx.pp) with(AVX.PP) {
                case _0:
                    switch(lo) {
                        case _08: p.instr.copy(Instruction("vmovaps", ps_VpsxWpsx, 0, IS.AVX)); break;
                        case _09: p.instr.copy(Instruction("vmovaps", ps_WpsxVpsx, 0, IS.AVX)); break;
                        case _0B: p.instr.copy(Instruction("vmovntps", ps_MpsxVpsx, 0, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vucomiss", ps_VssWss, 0, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vcomiss", ps_VssWss, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _08: p.instr.copy(Instruction("vmovapd", ps_VpdxWpdx, 0, IS.AVX)); break;
                        case _09: p.instr.copy(Instruction("vmovapd", ps_WpdxVpdx, 0, IS.AVX)); break;
                        case _0B: p.instr.copy(Instruction("vmovntpd", ps_MpdxVpdx, 0, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vucomisd", ps_VsdWsd, 0, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vcomisd", ps_VsdWsd, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2ss", ps_VoHoEy, 0, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vcvttss2si", ps_GyWss, 0, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vcvtss2si", ps_GyWss, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2sd", ps_VoHoEy, 0, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vcvttsd2si", ps_GyWsd, 0, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vcvtsd2si", ps_GyWsd, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
            }
            break;
        case _03:
            /* Nothing here */
            break;
        case _04:
            /* Nothing here */
            break;
        case _05:
            final switch(avx.pp) with(AVX.PP) {
                case _0: p.instr.copy(INSTRUCTIONS_page1_row5_pp0[lo]); break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_row5_pp1[lo]); break;
                case _2: p.instr.copy(INSTRUCTIONS_page1_row5_pp2[lo]); break;
                case _3: p.instr.copy(INSTRUCTIONS_page1_row5_pp3[lo]); break;
            }
            break;
        case _06:
            final switch(avx.pp) with(AVX.PP) {
                case _0: break;
                case _1:
                    if(lo == 0xE) {
                        if(avx.W) {
                            p.instr.copy(Instruction("movq", ps_VoEy, 0, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("movd", ps_VoEy, 0, IS.AVX));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row6_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==0xF) p.instr.copy(Instruction("vmovdqu", ps_VpqwxWpqwx, 0, IS.AVX));
                    break;
                case _3: break;
            }
            break;
        case _07:
            final switch(avx.pp) with(AVX.PP) {
                case _0:
                    if(avx.L) {
                        p.instr.copy(Instruction("vzeroall", ps_none, 0, IS.AVX));
                    } else {
                        p.instr.copy(Instruction("vzeroupper", ps_none, 0, IS.AVX));
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _01: vexGroup12(p, avx); break;
                        case _02: vexGroup13(p, avx); break;
                        case _03: vexGroup14(p, avx); break;
                        case _0E:
                            if(avx.W) {
                                p.instr.copy(Instruction("movq", ps_EyVo, 0, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("movd", ps_EyVo, 0, IS.AVX));
                            }
                            break;
                        default: p.instr.copy(INSTRUCTIONS_page1_row7_pp1[lo]); break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshufhw", ps_VpwxWpwxIb, 0, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vmovq", ps_VqWq, 0, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vmovdqu", ps_WpqwxVpqwx, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshuflw", ps_VpwxWpwxIb, 0, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vhaddps", ps_VpsxHpsxWpsx, 0, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vhsubps", ps_VpsxHpsxWpsx, 0, IS.AVX)); break;
                        default: break;
                    }
                    break;
            }
            break;
        case _08: /* Nothing here */
        case _09: /* Nothing here */
            break;
        case _0A:
            if(lo==_0E) vexGroup15(p, avx);
            break;
        case _0B: /* Nothing here */
            break;
        case _0C:
            if(lo==_02) {
                /* Handle VCMPccXX */
                ParseStrategy strategy;
                string mnemonic;
                final switch(avx.pp) with(AVX.PP) {
                    case _0: strategy = cast(ParseStrategy)ps_VpdwHpsWpsIb; mnemonic = "vcmp%sps"; break;
                    case _1: strategy = cast(ParseStrategy)ps_VpqwHpdWpdIb; mnemonic = "vcmp%spd"; break;
                    case _2: strategy = cast(ParseStrategy)ps_VdHssWssIb; mnemonic = "vcmp%sss"; break;
                    case _3: strategy = cast(ParseStrategy)ps_VqHsdWsdIb; mnemonic = "vcmp%ssd"; break;
                }
                p.instr.copy(Instruction(mnemonic, strategy, 0, IS.AVX));
            } else {
                if(avx.pp==AVX.PP._0 && lo==_06) {
                    p.instr.copy(Instruction("vshufps", ps_VpsxHpsxWpsxIb, 0, IS.AVX));
                } else if(avx.pp==AVX.PP._1) {
                    if(lo==_04) {
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwRdIb, 0, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwMwIb, 0, IS.AVX));
                        }
                    } else if(lo==_05) {
                        p.instr.copy(Instruction("vpextrw", ps_GwUpwIb, 0, IS.AVX));
                    } else if(lo==_06) {
                        p.instr.copy(Instruction("vshufpd", ps_VpdxHpdxWpdxIb, 0, IS.AVX));
                    }
                }
            }
            break;
        case _0D:
            final switch(avx.pp) with(AVX.PP) {
                case _0: /* Nothing here */ break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_rowD_pp1[lo]); break;
                case _2: /* Nothing here */ break;
                case _3:
                    if(lo==_00) {
                        p.instr.copy(Instruction("vaddsubps", ps_VpsxHpsxWpsx, 0, IS.AVX));
                    }
                    break;
            }
            break;
        case _0E:
            final switch(avx.pp) with(AVX.PP) {
                case _0: /* Nothing here */ break;
                case _1:
                    if(lo==_07) {
                        if(avx.L) {
                            p.instr.copy(Instruction("vmovntdq", ps_MdoVdo, 0, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vmovntdq", ps_MoVo, 0, IS.AVX));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_rowE_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtdq2pd", ps_VpdxWpjx, 0, IS.AVX));
                    }
                    break;
                case _3:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtpd2dq", ps_VpjxWpdx, 0, IS.AVX));
                    }
                    break;
            }
            break;
        case _0F:
            final switch(avx.pp) with(AVX.PP) {
                case _0: /* Nothing here */ break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_rowF_pp1[lo]); break;
                case _2: /* Nothing here */ break;
                case _3:
                    if(lo==_00) {
                        if(avx.L) {
                            p.instr.copy(Instruction("vlddqu", ps_VdoMdo, 0, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vlddqu", ps_VoMo, 0, IS.AVX));
                        }
                    }
                    break;
            }
            break;
    }
    p.instr.avx = avx;
}
void page2(Parser p, ref AVX avx) {
    // page 527
}
void page3(Parser p, ref AVX avx) {
    // page 529
}
void vexGroup12(Parser p, ref AVX avx) {
    todo();
}
void vexGroup13(Parser p, ref AVX avx) {
    todo();
}
void vexGroup14(Parser p, ref AVX avx) {
    todo();
}
void vexGroup15(Parser p, ref AVX avx) {
    todo();
}
void vexGroup17(Parser p, ref AVX avx) {
    todo();
}

private:

__gshared {
/* page 1, row 1 */
Instruction[] INSTRUCTIONS_page1_row1_pp0 = [
    Instruction("vmovups",  ps_VpsxWpsx, 0, IS.AVX),            /* lo=0 */
    Instruction("vmovups", ps_WpsxVpsx, 0, IS.AVX),             /* lo=1 */
    Instruction("vmovlps",  ps_VpsHpsMq, 0, IS.AVX),            /* lo=2 */
    Instruction("vmovlps", ps_MqVps, 0, IS.AVX),                /* lo=3 */
    Instruction("vunpcklps",  ps_VpsxHpsxWpsx, 0, IS.AVX),      /* lo=4 */
    Instruction("vunpckhps", ps_VpsxHpsxWpsx, 0, IS.AVX),       /* lo=5 */
    Instruction("vmovhps", ps_VpsHpsMq, 0, IS.AVX),             /* lo=6 */
    Instruction("vmovhps",  ps_MqVps, 0, IS.AVX),               /* lo=7 */
    Instruction("", null),                                      /* lo=8 - invalid */
    Instruction("", null),                                      /* lo=9 - invalid */
    Instruction("", null),                                      /* lo=A - invalid */
    Instruction("", null),                                      /* lo=B - invalid */
    Instruction("", null),                                      /* lo=C - invalid */
    Instruction("", null),                                      /* lo=D - invalid */
    Instruction("", null),                                      /* lo=E - invalid */
    Instruction("", null),                                      /* lo=F - invalid */
];
Instruction[] INSTRUCTIONS_page1_row1_pp1 = [
    Instruction("vmovupd", ps_VpdxWpdx, 0, IS.AVX),             /* lo=0 */
    Instruction("vmodupd", ps_WpdxVpdx, 0, IS.AVX),             /* lo=1 */
    Instruction("vmovlpd", ps_VoHoMq, 0, IS.AVX),               /* lo=2 */
    Instruction("vmovlpd", ps_MqVo, 0, IS.AVX),                 /* lo=3 */
    Instruction("vunpcklpd", ps_VpdxHpdxWpdx, 0, IS.AVX),       /* lo=4 */
    Instruction("vunpckhpd", ps_VpdxHpdxWpdx, 0, IS.AVX),       /* lo=5 */
    Instruction("vmovhpd", ps_VpdHpdMq, 0, IS.AVX),             /* lo=6 */
    Instruction("vmovhpd", ps_MqVpd, 0, IS.AVX),                /* lo=7 */
    Instruction("", null),                                      /* lo=8 - invalid */
    Instruction("", null),                                      /* lo=9 - invalid */
    Instruction("", null),                                      /* lo=A - invalid */
    Instruction("", null),                                      /* lo=B - invalid */
    Instruction("", null),                                      /* lo=C - invalid */
    Instruction("", null),                                      /* lo=D - invalid */
    Instruction("", null),                                      /* lo=E - invalid */
    Instruction("", null),                                      /* lo=F - invalid */
];
/* page 1, row 5 */
Instruction[] INSTRUCTIONS_page1_row5_pp0 = [
    Instruction("vmovmskps", ps_GyUpsx),        /* lo=0 */
    Instruction("vsqrtps", ps_VpsxWpsx),        /* lo=1 */
    Instruction("vrsqrtps", ps_VpsxWpsx),       /* lo=2 */
    Instruction("vrcpps", ps_VpsxWpsx),         /* lo=3 */
    Instruction("vandps", ps_VpsxHpsxWpsx),     /* lo=4 */
    Instruction("vandnps", ps_VpsxHpsxWpsx),    /* lo=5 */
    Instruction("vorps", ps_VpsxHpsxWpsx),      /* lo=6 */
    Instruction("vxorps", ps_VpsxHpsxWpsx),     /* lo=7 */

    Instruction("vaddps", ps_VpsxHpsxWpsx),     /* lo=8 */
    Instruction("vmulps", ps_VpsxHpsxWpsx),     /* lo=9 */
    Instruction("vcvtps2pd", ps_VpdxWpsx),      /* lo=A */
    Instruction("vcvtdq2ps", ps_VpsxWpjx),      /* lo=B */
    Instruction("vsubps", ps_VpsxHpsxWpsx),     /* lo=C */
    Instruction("vminps", ps_VpsxHpsxWpsx),     /* lo=D */
    Instruction("vdivps", ps_VpsxHpsxWpsx),     /* lo=E */
    Instruction("vmaxps", ps_VpsxHpsxWpsx),     /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp1 = [
    Instruction("vmovmskpd", ps_GyUpdx),        /* lo=0 */
    Instruction("vsqrtpd", ps_VpdxWpdx),        /* lo=1 */
    Instruction("", null),                      /* lo=2 - invalid */
    Instruction("", null),                      /* lo=3 - invalid */
    Instruction("vandpd", ps_VpdxHpdxWpdx),     /* lo=4 */
    Instruction("vandnpd", ps_VpdxHpdxWpdx),    /* lo=5 */
    Instruction("vorpd", ps_VpdxHpdxWpdx),      /* lo=6 */
    Instruction("vxorpd", ps_VpdxHpdxWpdx),     /* lo=7 */

    Instruction("vaddpd", ps_VpdxHpdxWpdx),     /* lo=8 */
    Instruction("vmulpd", ps_VpdxHpdxWpdx),     /* lo=9 */
    Instruction("vcvtpd2ps", ps_VpsxWpdx),      /* lo=A */
    Instruction("vcvtps2dq", ps_VpjxWpsx),      /* lo=B */
    Instruction("vsubpd", ps_VpdxHpdxWpdx),     /* lo=C */
    Instruction("vminpd", ps_VpdxHpdxWpdx),     /* lo=D */
    Instruction("vdivpd", ps_VpdxHpdxWpdx),     /* lo=E */
    Instruction("vmaxpd", ps_VpdxHpdxWpdx),     /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp2 = [
    Instruction("", null),                      /* lo=0 - invalid */
    Instruction("vsqrtss", ps_VoHoWss),         /* lo=1 */
    Instruction("vrsqrtss", ps_VoHoWss),        /* lo=2 */
    Instruction("vrcpss", ps_VoHoWss),          /* lo=3 */
    Instruction("", null),                      /* lo=4 - invalid */
    Instruction("", null),                      /* lo=5 - invalid */
    Instruction("", null),                      /* lo=6 - invalid */
    Instruction("", null),                      /* lo=7 - invalid */

    Instruction("vaddss", ps_VssHssWss),        /* lo=8 */
    Instruction("vmulss", ps_VssHssWss),        /* lo=9 */
    Instruction("vcvtss2sd", ps_VoHoWss),       /* lo=A */
    Instruction("vcvttps2dq", ps_VpjxWpsx),     /* lo=B */
    Instruction("vsubss", ps_VssHssWss),        /* lo=C */
    Instruction("vminss", ps_VssHssWss),        /* lo=D */
    Instruction("vdivss", ps_VssHssWss),        /* lo=E */
    Instruction("vmaxss", ps_VssHssWss),        /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp3 = [
    Instruction("", null),                      /* lo=0 - invalid */
    Instruction("vsqrtsd", ps_VoHoWsd),         /* lo=1 */
    Instruction("", null),                      /* lo=2 - invalid */
    Instruction("", null),                      /* lo=3 - invalid */
    Instruction("", null),                      /* lo=4 - invalid */
    Instruction("", null),                      /* lo=5 - invalid */
    Instruction("", null),                      /* lo=6 - invalid */
    Instruction("", null),                      /* lo=7 - invalid */

    Instruction("vaddsd", ps_VsdHsdWsd),        /* lo=8 */
    Instruction("vmulsd", ps_VsdHsdWsd),        /* lo=9 */
    Instruction("vcvtsd2ss", ps_VoHoWsd),       /* lo=A */
    Instruction("", null),                      /* lo=B - invalid */
    Instruction("vsubsd", ps_VsdHsdWsd),        /* lo=C */
    Instruction("vminsd", ps_VsdHsdWsd),        /* lo=D */
    Instruction("vdivsd", ps_VsdHsdWsd),        /* lo=E */
    Instruction("vmaxsd", ps_VsdHsdWsd),        /* lo=F */
];
/* page 1, row 6 */
Instruction[] INSTRUCTIONS_page1_row6_pp1 = [
    Instruction("vpunpcklbw", ps_VpbxHpbxWpbx),     /* lo=0 */
    Instruction("vpunpcklwd", ps_VpwxHpwxWpwx),     /* lo=1 */
    Instruction("vpunpckldq", ps_VpdwxHpdwxWpdwx),  /* lo=2 */
    Instruction("vpacksswb", ps_VpkxHpixWpix),      /* lo=3 */
    Instruction("vpcmpgtb", ps_VpbxHpkxWpkx),       /* lo=4 */
    Instruction("vpcmpgtw", ps_VpwxHpixWpix),       /* lo=5 */
    Instruction("vpcmpgtd", ps_VpdwxHpjxWpjx),      /* lo=6 */
    Instruction("vpackuswb", ps_VpkxHpixWpix),      /* lo=7 */

    Instruction("vpunpckhbw", ps_VpbxHpbxWpbx),     /* lo=8 */
    Instruction("vpunpckhwd", ps_VpwxHpwxWpwx),     /* lo=9 */
    Instruction("vpunpckhdq", ps_VpdwxHpdwxWpdwx),  /* lo=A */
    Instruction("vpackssdw", ps_VpixHpjxWpjx),      /* lo=B */
    Instruction("vpunpcklqdq", ps_VpqwxHpqwxWpqwx), /* lo=C */
    Instruction("vpunpckhqdq", ps_VpqwxHpqwxWpqwx), /* lo=D */
    Instruction("", null),                          /* lo=E - handled in code */
    Instruction("vmovdqa", ps_VpqwxWpqwx),          /* lo=F */
];
/* page 1, row 7 */
Instruction[] INSTRUCTIONS_page1_row7_pp1 = [
    Instruction("vpshufd", ps_VpdwxWpdwxIb),        /* lo=0 */
    Instruction("", null),                          /* lo=1 - VEX group 12 */
    Instruction("", null),                          /* lo=2 - VEX group 13 */
    Instruction("", null),                          /* lo=3 - VEX group 14 */
    Instruction("vpcmpeqb", ps_VpbxHpkxWpkx),       /* lo=4 */
    Instruction("vpcmpeqw", ps_VpwxHpixWpix),       /* lo=5 */
    Instruction("vpcmpeqd", ps_VpdwxHpjxWpjx),      /* lo=6 */
    Instruction("", null),                          /* lo=7 - invalid */

    Instruction("", null),                          /* lo=8 - invalid */
    Instruction("", null),                          /* lo=9 - invalid */
    Instruction("", null),                          /* lo=A - invalid */
    Instruction("", null),                          /* lo=B - invalid */
    Instruction("vhaddpd", ps_VpdxHpdxWpdx),        /* lo=C */
    Instruction("vhsubpd", ps_VpdxHpdxWpdx),        /* lo=D */
    Instruction("", null),                          /* lo=E 0 handled in code */
    Instruction("vmovdqa", ps_WpqwxVpqwx),          /* lo=F */
];
/* page 1, row D */
Instruction[] INSTRUCTIONS_page1_rowD_pp1 = [
    Instruction("vaddsubpd", ps_VpdxHpdxWpdx),   /* lo=0 */
    Instruction("vpsrlw", ps_VpwxHpwxWx),        /* lo=1 */
    Instruction("vpsrld", ps_VpdwxHpdwxWx),      /* lo=2 */
    Instruction("vpsrlq", ps_VpqwxHpqwxWx),      /* lo=3 */
    Instruction("vpaddq", ps_VpqHpqWpq),         /* lo=4 */
    Instruction("vpmullw", ps_VpixHpixWpix),     /* lo=5 */
    Instruction("vmovq", ps_WqVq),               /* lo=6 */
    Instruction("vpmovmskb", ps_GyUpbx),         /* lo=7 */
    Instruction("vpsubusb", ps_VpkxHpkxWpkx),    /* lo=8 */
    Instruction("vpsubusw", px_VpixHpixWpix),    /* lo=9 */
    Instruction("vpminub", px_VpkxHpkxWpkx),     /* lo=A */
    Instruction("vpand", ps_VxHxWx),             /* lo=B */
    Instruction("vpaddusb", px_VpkxHpkxWpkx),    /* lo=C */
    Instruction("vpaddusw", px_VpixHpixWpix),    /* lo=D */
    Instruction("vpmaxub", ps_VpkxHpkxWpkx),     /* lo=E */
    Instruction("vpandn", ps_VxHxWx),            /* lo=F */
];
/* page 1, row E */
Instruction[] INSTRUCTIONS_page1_rowE_pp1 = [
    Instruction("vpavgb", ps_VpkxHpkxWpkx),     /* lo=0 */
    Instruction("vpsraw", ps_VpwxHpwxWx),       /* lo=1 */
    Instruction("vpsrad", ps_VpdwxHpdwxWx),     /* lo=2 */
    Instruction("vpavgw", ps_VpixHpixWpix),     /* lo=3 */
    Instruction("vpmulhuw", ps_VpiHpiWpi),      /* lo=4 */
    Instruction("vpmulhw", ps_VpiHpiWpi),       /* lo=5 */
    Instruction("vcvttpd2dq", ps_VpjxWpdx),     /* lo=6 */
    Instruction("", null),                      /* lo=7 - handled in code */

    Instruction("vpsubsb", ps_VpkxHpkxWpkx),    /* lo=8 */
    Instruction("vpsubsw", ps_VpixHpixWpix),    /* lo=9 */
    Instruction("vpminsw", ps_VpixHpixWpix),    /* lo=A */
    Instruction("vpor", ps_VxHxWx),             /* lo=B */
    Instruction("vpaddsb", ps_VpkxHpkxWpkx),    /* lo=C */
    Instruction("vpaddsw", ps_VpixHpixWpix),    /* lo=D */
    Instruction("vpmaxsw", ps_VpixHpixWpix),    /* lo=E */
    Instruction("vpxor", ps_VxHxWx),            /* lo=F */
];
/* page 1, row F */
Instruction[] INSTRUCTIONS_page1_rowF_pp1 = [
    Instruction("", null),                      /* lo=0 - invalid */
    Instruction("vpsllw", ps_VpwxHpwxWoqx),     /* lo=1 */
    Instruction("vpslld", ps_VpdwxHpdwxWoqx),   /* lo=2 */
    Instruction("vpsllq", ps_VpqwxHpqwxWoqx),   /* lo=3 */
    Instruction("vpmuludq", ps_VpqxHpjxWpjx),   /* lo=4 */
    Instruction("vpmaddwd", ps_VpjxHpixWpix),   /* lo=5 */
    Instruction("vpsadbw", ps_VpixHpkxWpkx),    /* lo=6 */
    Instruction("vmaskmovdqu", ps_VpbUpb),      /* lo=7 */

    Instruction("vpsubb", ps_VpkxHpkxWpkx),     /* lo=8 */
    Instruction("vpsubw", ps_VpixHpixWpix),     /* lo=9 */
    Instruction("vpsubd", ps_VpjxHpjxWpjx),     /* lo=A */
    Instruction("vpsubq", ps_VpqxHpqxWpqx),     /* lo=B */
    Instruction("vpaddb", ps_VpkxHpkxWpkx),     /* lo=C */
    Instruction("vpaddw", ps_VpixHpixWpix),     /* lo=D */
    Instruction("vpaddd", ps_VpjxHpjxWpjx),     /* lo=E */
    Instruction("", null),                      /* lo=F - invalid */
];
}


    // Instruction("", null),                       /* lo=0 */
    // Instruction("", null),                       /* lo=1 */
    // Instruction("", null),                       /* lo=2 */
    // Instruction("", null),                       /* lo=3 */
    // Instruction("", null),                       /* lo=4 */
    // Instruction("", null),                       /* lo=5 */
    // Instruction("", null),                       /* lo=6 */
    // Instruction("", null),                       /* lo=7 */

    // Instruction("", null),                       /* lo=8 */
    // Instruction("", null),                       /* lo=9 */
    // Instruction("", null),                       /* lo=A */
    // Instruction("", null),                       /* lo=B */
    // Instruction("", null),                       /* lo=C */
    // Instruction("", null),                       /* lo=D */
    // Instruction("", null),                       /* lo=E */
    // Instruction("", null),                       /* lo=F */