module disassembler.parse.parse_avx_page1;

import disassembler.all;

void parseAVXPage1(Parser p, ref AVX avx) {

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
                        p.instr.copy(Instruction("vmovhlps", ps_VpsHpsUps, IS.AVX));
                    } else if(lo==_06 && modrm.mod==0b11) {
                        p.instr.copy(Instruction("vmovlhps", ps_VpsHpsUps, IS.AVX));
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row1_pp0[lo]);
                    }
                    break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_row1_pp1[lo]); break;
                case _2:
                    switch(lo) {
                        case _00:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_VssHssUss, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_VssMd, IS.AVX));
                            }
                            break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_UssHssVss, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_MdVss, IS.AVX));
                            }
                            break;
                        case _02: p.instr.copy(Instruction("vmovsldup", ps_VpsxWpsx, IS.AVX)); break;
                        case _06: p.instr.copy(Instruction("vmovshdup", ps_VpsxWpsx, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00:
                           if(modrm.mod==0b11) {
                               p.instr.copy(Instruction("vmovsd", ps_VsdHsdUsd, IS.AVX));
                           } else {
                               p.instr.copy(Instruction("vmovsd", ps_VsdMq, IS.AVX));
                           }
                           break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovsd", ps_UsdHsdVsd, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovsd", ps_MqVsd, IS.AVX));
                            }
                            break;
                        case _02:
                            if(avx.L) {
                                p.instr.copy(Instruction("vmovddup", ps_VdoWdo, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("vmovddup", ps_VoWq, IS.AVX));
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
                        case _08: p.instr.copy(Instruction("vmovaps", ps_VpsxWpsx, IS.AVX)); break;
                        case _09: p.instr.copy(Instruction("vmovaps", ps_WpsxVpsx, IS.AVX)); break;
                        case _0B: p.instr.copy(Instruction("vmovntps", ps_MpsxVpsx, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vucomiss", ps_VssWss, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vcomiss", ps_VssWss, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _08: p.instr.copy(Instruction("vmovapd", ps_VpdxWpdx, IS.AVX)); break;
                        case _09: p.instr.copy(Instruction("vmovapd", ps_WpdxVpdx, IS.AVX)); break;
                        case _0B: p.instr.copy(Instruction("vmovntpd", ps_MpdxVpdx, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vucomisd", ps_VsdWsd, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vcomisd", ps_VsdWsd, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2ss", ps_VoHoEy, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vcvttss2si", ps_GyWss, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vcvtss2si", ps_GyWss, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2sd", ps_VoHoEy, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vcvttsd2si", ps_GyWsd, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vcvtsd2si", ps_GyWsd, IS.AVX)); break;
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
                            p.instr.copy(Instruction("movq", ps_VoEy, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("movd", ps_VoEy, IS.AVX));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row6_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==0xF) p.instr.copy(Instruction("vmovdqu", ps_VpqwxWpqwx, IS.AVX));
                    break;
                case _3: break;
            }
            break;
        case _07:
            final switch(avx.pp) with(AVX.PP) {
                case _0:
                    if(avx.L) {
                        p.instr.copy(Instruction("vzeroall", ps_none, IS.AVX));
                    } else {
                        p.instr.copy(Instruction("vzeroupper", ps_none, IS.AVX));
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _01: avxGroup12(p, avx); break;
                        case _02: avxGroup13(p, avx); break;
                        case _03: avxGroup14(p, avx); break;
                        case _0E:
                            if(avx.W) {
                                p.instr.copy(Instruction("movq", ps_EyVo, IS.AVX));
                            } else {
                                p.instr.copy(Instruction("movd", ps_EyVo, IS.AVX));
                            }
                            break;
                        default: p.instr.copy(INSTRUCTIONS_page1_row7_pp1[lo]); break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshufhw", ps_VpwxWpwxIb, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vmovq", ps_VqWq, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vmovdqu", ps_WpqwxVpqwx, IS.AVX)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshuflw", ps_VpwxWpwxIb, IS.AVX)); break;
                        case _0C: p.instr.copy(Instruction("vhaddps", ps_VpsxHpsxWpsx, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vhsubps", ps_VpsxHpsxWpsx, IS.AVX)); break;
                        default: break;
                    }
                    break;
            }
            break;
        case _08: /* Nothing here */
        case _09: /* Nothing here */
            break;
        case _0A:
            if(lo==_0E) avxGroup15(p, avx);
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
                p.instr.copy(Instruction(mnemonic, strategy, IS.AVX));
            } else {
                if(avx.pp==AVX.PP._0 && lo==_06) {
                    p.instr.copy(Instruction("vshufps", ps_VpsxHpsxWpsxIb, IS.AVX));
                } else if(avx.pp==AVX.PP._1) {
                    if(lo==_04) {
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwRdIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwMwIb, IS.AVX));
                        }
                    } else if(lo==_05) {
                        p.instr.copy(Instruction("vpextrw", ps_GwUpwIb, IS.AVX));
                    } else if(lo==_06) {
                        p.instr.copy(Instruction("vshufpd", ps_VpdxHpdxWpdxIb, IS.AVX));
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
                        p.instr.copy(Instruction("vaddsubps", ps_VpsxHpsxWpsx, IS.AVX));
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
                            p.instr.copy(Instruction("vmovntdq", ps_MdoVdo, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vmovntdq", ps_MoVo, IS.AVX));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_rowE_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtdq2pd", ps_VpdxWpjx, IS.AVX));
                    }
                    break;
                case _3:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtpd2dq", ps_VpjxWpdx, IS.AVX));
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
                            p.instr.copy(Instruction("vlddqu", ps_VdoMdo, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vlddqu", ps_VoMo, IS.AVX));
                        }
                    }
                    break;
            }
            break;
    }
    p.instr.avx = avx;
}

private:

__gshared {
/* row 1 */
Instruction[] INSTRUCTIONS_page1_row1_pp0 = [
    Instruction("vmovups",  ps_VpsxWpsx, IS.AVX),               /* lo=0 */
    Instruction("vmovups", ps_WpsxVpsx, IS.AVX),                /* lo=1 */
    Instruction("vmovlps",  ps_VpsHpsMq, IS.AVX),               /* lo=2 */
    Instruction("vmovlps", ps_MqVps, IS.AVX),                   /* lo=3 */
    Instruction("vunpcklps",  ps_VpsxHpsxWpsx, IS.AVX),         /* lo=4 */
    Instruction("vunpckhps", ps_VpsxHpsxWpsx, IS.AVX),          /* lo=5 */
    Instruction("vmovhps", ps_VpsHpsMq, IS.AVX),                /* lo=6 */
    Instruction("vmovhps",  ps_MqVps, IS.AVX),                  /* lo=7 */
    Instruction("", null, IS.STD),                              /* lo=8 - invalid */
    Instruction("", null, IS.STD),                              /* lo=9 - invalid */
    Instruction("", null, IS.STD),                              /* lo=A - invalid */
    Instruction("", null, IS.STD),                              /* lo=B - invalid */
    Instruction("", null, IS.STD),                              /* lo=C - invalid */
    Instruction("", null, IS.STD),                              /* lo=D - invalid */
    Instruction("", null, IS.STD),                              /* lo=E - invalid */
    Instruction("", null, IS.STD),                              /* lo=F - invalid */
];
Instruction[] INSTRUCTIONS_page1_row1_pp1 = [
    Instruction("vmovupd", ps_VpdxWpdx, IS.AVX),                /* lo=0 */
    Instruction("vmodupd", ps_WpdxVpdx, IS.AVX),                /* lo=1 */
    Instruction("vmovlpd", ps_VoHoMq, IS.AVX),                  /* lo=2 */
    Instruction("vmovlpd", ps_MqVo, IS.AVX),                    /* lo=3 */
    Instruction("vunpcklpd", ps_VpdxHpdxWpdx, IS.AVX),          /* lo=4 */
    Instruction("vunpckhpd", ps_VpdxHpdxWpdx, IS.AVX),          /* lo=5 */
    Instruction("vmovhpd", ps_VpdHpdMq, IS.AVX),                /* lo=6 */
    Instruction("vmovhpd", ps_MqVpd, IS.AVX),                   /* lo=7 */
    Instruction("", null, IS.STD),                              /* lo=8 - invalid */
    Instruction("", null, IS.STD),                              /* lo=9 - invalid */
    Instruction("", null, IS.STD),                              /* lo=A - invalid */
    Instruction("", null, IS.STD),                              /* lo=B - invalid */
    Instruction("", null, IS.STD),                              /* lo=C - invalid */
    Instruction("", null, IS.STD),                              /* lo=D - invalid */
    Instruction("", null, IS.STD),                              /* lo=E - invalid */
    Instruction("", null, IS.STD),                              /* lo=F - invalid */
];
/* row 5 */
Instruction[] INSTRUCTIONS_page1_row5_pp0 = [
    Instruction("vmovmskps", ps_GyUpsx, IS.AVX),            /* lo=0 */
    Instruction("vsqrtps", ps_VpsxWpsx, IS.AVX),            /* lo=1 */
    Instruction("vrsqrtps", ps_VpsxWpsx, IS.AVX),           /* lo=2 */
    Instruction("vrcpps", ps_VpsxWpsx, IS.AVX),             /* lo=3 */
    Instruction("vandps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=4 */
    Instruction("vandnps", ps_VpsxHpsxWpsx, IS.AVX),        /* lo=5 */
    Instruction("vorps", ps_VpsxHpsxWpsx, IS.AVX),          /* lo=6 */
    Instruction("vxorps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=7 */

    Instruction("vaddps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=8 */
    Instruction("vmulps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=9 */
    Instruction("vcvtps2pd", ps_VpdxWpsx, IS.AVX),          /* lo=A */
    Instruction("vcvtdq2ps", ps_VpsxWpjx, IS.AVX),          /* lo=B */
    Instruction("vsubps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=C */
    Instruction("vminps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=D */
    Instruction("vdivps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=E */
    Instruction("vmaxps", ps_VpsxHpsxWpsx, IS.AVX),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp1 = [
    Instruction("vmovmskpd", ps_GyUpdx, IS.AVX),            /* lo=0 */
    Instruction("vsqrtpd", ps_VpdxWpdx, IS.AVX),            /* lo=1 */
    Instruction("", null, IS.STD),                          /* lo=2 - invalid */
    Instruction("", null, IS.STD),                          /* lo=3 - invalid */
    Instruction("vandpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=4 */
    Instruction("vandnpd", ps_VpdxHpdxWpdx, IS.AVX),        /* lo=5 */
    Instruction("vorpd", ps_VpdxHpdxWpdx, IS.AVX),          /* lo=6 */
    Instruction("vxorpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=7 */

    Instruction("vaddpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=8 */
    Instruction("vmulpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=9 */
    Instruction("vcvtpd2ps", ps_VpsxWpdx, IS.AVX),          /* lo=A */
    Instruction("vcvtps2dq", ps_VpjxWpsx, IS.AVX),          /* lo=B */
    Instruction("vsubpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=C */
    Instruction("vminpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=D */
    Instruction("vdivpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=E */
    Instruction("vmaxpd", ps_VpdxHpdxWpdx, IS.AVX),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp2 = [
    Instruction("", null, IS.STD),                          /* lo=0 - invalid */
    Instruction("vsqrtss", ps_VoHoWss, IS.AVX),             /* lo=1 */
    Instruction("vrsqrtss", ps_VoHoWss, IS.AVX),            /* lo=2 */
    Instruction("vrcpss", ps_VoHoWss, IS.AVX),              /* lo=3 */
    Instruction("", null, IS.STD),                          /* lo=4 - invalid */
    Instruction("", null, IS.STD),                          /* lo=5 - invalid */
    Instruction("", null, IS.STD),                          /* lo=6 - invalid */
    Instruction("", null, IS.STD),                          /* lo=7 - invalid */

    Instruction("vaddss", ps_VssHssWss, IS.AVX),            /* lo=8 */
    Instruction("vmulss", ps_VssHssWss, IS.AVX),            /* lo=9 */
    Instruction("vcvtss2sd", ps_VoHoWss, IS.AVX),           /* lo=A */
    Instruction("vcvttps2dq", ps_VpjxWpsx, IS.AVX),         /* lo=B */
    Instruction("vsubss", ps_VssHssWss, IS.AVX),            /* lo=C */
    Instruction("vminss", ps_VssHssWss, IS.AVX),            /* lo=D */
    Instruction("vdivss", ps_VssHssWss, IS.AVX),            /* lo=E */
    Instruction("vmaxss", ps_VssHssWss, IS.AVX),            /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp3 = [
    Instruction("", null, IS.STD),                          /* lo=0 - invalid */
    Instruction("vsqrtsd", ps_VoHoWsd, IS.AVX),             /* lo=1 */
    Instruction("", null, IS.STD),                          /* lo=2 - invalid */
    Instruction("", null, IS.STD),                          /* lo=3 - invalid */
    Instruction("", null, IS.STD),                          /* lo=4 - invalid */
    Instruction("", null, IS.STD),                          /* lo=5 - invalid */
    Instruction("", null, IS.STD),                          /* lo=6 - invalid */
    Instruction("", null, IS.STD),                          /* lo=7 - invalid */

    Instruction("vaddsd", ps_VsdHsdWsd, IS.AVX),            /* lo=8 */
    Instruction("vmulsd", ps_VsdHsdWsd, IS.AVX),            /* lo=9 */
    Instruction("vcvtsd2ss", ps_VoHoWsd, IS.AVX),           /* lo=A */
    Instruction("", null, IS.STD),                          /* lo=B - invalid */
    Instruction("vsubsd", ps_VsdHsdWsd, IS.AVX),            /* lo=C */
    Instruction("vminsd", ps_VsdHsdWsd, IS.AVX),            /* lo=D */
    Instruction("vdivsd", ps_VsdHsdWsd, IS.AVX),            /* lo=E */
    Instruction("vmaxsd", ps_VsdHsdWsd, IS.AVX),            /* lo=F */
];
/* row 6 */
Instruction[] INSTRUCTIONS_page1_row6_pp1 = [
    Instruction("vpunpcklbw", ps_VpbxHpbxWpbx, IS.AVX),         /* lo=0 */
    Instruction("vpunpcklwd", ps_VpwxHpwxWpwx, IS.AVX),         /* lo=1 */
    Instruction("vpunpckldq", ps_VpdwxHpdwxWpdwx, IS.AVX),      /* lo=2 */
    Instruction("vpacksswb", ps_VpkxHpixWpix, IS.AVX),          /* lo=3 */
    Instruction("vpcmpgtb", ps_VpbxHpkxWpkx, IS.AVX),           /* lo=4 */
    Instruction("vpcmpgtw", ps_VpwxHpixWpix, IS.AVX),           /* lo=5 */
    Instruction("vpcmpgtd", ps_VpdwxHpjxWpjx, IS.AVX),          /* lo=6 */
    Instruction("vpackuswb", ps_VpkxHpixWpix, IS.AVX),          /* lo=7 */

    Instruction("vpunpckhbw", ps_VpbxHpbxWpbx, IS.AVX),         /* lo=8 */
    Instruction("vpunpckhwd", ps_VpwxHpwxWpwx, IS.AVX),         /* lo=9 */
    Instruction("vpunpckhdq", ps_VpdwxHpdwxWpdwx, IS.AVX),      /* lo=A */
    Instruction("vpackssdw", ps_VpixHpjxWpjx, IS.AVX),          /* lo=B */
    Instruction("vpunpcklqdq", ps_VpqwxHpqwxWpqwx, IS.AVX),     /* lo=C */
    Instruction("vpunpckhqdq", ps_VpqwxHpqwxWpqwx, IS.AVX),     /* lo=D */
    Instruction("", null, IS.STD),                              /* lo=E - handled in code */
    Instruction("vmovdqa", ps_VpqwxWpqwx, IS.AVX),              /* lo=F */
];
/* row 7 */
Instruction[] INSTRUCTIONS_page1_row7_pp1 = [
    Instruction("vpshufd", ps_VpdwxWpdwxIb, IS.AVX),            /* lo=0 */
    Instruction("", null, IS.STD),                              /* lo=1 - VEX group 12 */
    Instruction("", null, IS.STD),                              /* lo=2 - VEX group 13 */
    Instruction("", null, IS.STD),                              /* lo=3 - VEX group 14 */
    Instruction("vpcmpeqb", ps_VpbxHpkxWpkx, IS.AVX),           /* lo=4 */
    Instruction("vpcmpeqw", ps_VpwxHpixWpix, IS.AVX),           /* lo=5 */
    Instruction("vpcmpeqd", ps_VpdwxHpjxWpjx, IS.AVX),          /* lo=6 */
    Instruction("", null, IS.STD),                              /* lo=7 - invalid */

    Instruction("", null, IS.STD),                              /* lo=8 - invalid */
    Instruction("", null, IS.STD),                              /* lo=9 - invalid */
    Instruction("", null, IS.STD),                              /* lo=A - invalid */
    Instruction("", null, IS.STD),                              /* lo=B - invalid */
    Instruction("vhaddpd", ps_VpdxHpdxWpdx, IS.AVX),            /* lo=C */
    Instruction("vhsubpd", ps_VpdxHpdxWpdx, IS.AVX),            /* lo=D */
    Instruction("", null, IS.STD),                              /* lo=E 0 handled in code */
    Instruction("vmovdqa", ps_WpqwxVpqwx, IS.AVX),              /* lo=F */
];
/* row D */
Instruction[] INSTRUCTIONS_page1_rowD_pp1 = [
    Instruction("vaddsubpd", ps_VpdxHpdxWpdx, IS.AVX),      /* lo=0 */
    Instruction("vpsrlw", ps_VpwxHpwxWx, IS.AVX),           /* lo=1 */
    Instruction("vpsrld", ps_VpdwxHpdwxWx, IS.AVX),         /* lo=2 */
    Instruction("vpsrlq", ps_VpqwxHpqwxWx, IS.AVX),         /* lo=3 */
    Instruction("vpaddq", ps_VpqHpqWpq, IS.AVX),            /* lo=4 */
    Instruction("vpmullw", ps_VpixHpixWpix, IS.AVX),        /* lo=5 */
    Instruction("vmovq", ps_WqVq, IS.AVX),                  /* lo=6 */
    Instruction("vpmovmskb", ps_GyUpbx, IS.AVX),            /* lo=7 */
    Instruction("vpsubusb", ps_VpkxHpkxWpkx, IS.AVX),       /* lo=8 */
    Instruction("vpsubusw", px_VpixHpixWpix, IS.AVX),       /* lo=9 */
    Instruction("vpminub", px_VpkxHpkxWpkx, IS.AVX),        /* lo=A */
    Instruction("vpand", ps_VxHxWx, IS.AVX),                /* lo=B */
    Instruction("vpaddusb", px_VpkxHpkxWpkx, IS.AVX),       /* lo=C */
    Instruction("vpaddusw", px_VpixHpixWpix, IS.AVX),       /* lo=D */
    Instruction("vpmaxub", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=E */
    Instruction("vpandn", ps_VxHxWx, IS.AVX),               /* lo=F */
];
/* row E */
Instruction[] INSTRUCTIONS_page1_rowE_pp1 = [
    Instruction("vpavgb", ps_VpkxHpkxWpkx, IS.AVX),         /* lo=0 */
    Instruction("vpsraw", ps_VpwxHpwxWx, IS.AVX),           /* lo=1 */
    Instruction("vpsrad", ps_VpdwxHpdwxWx, IS.AVX),         /* lo=2 */
    Instruction("vpavgw", ps_VpixHpixWpix, IS.AVX),         /* lo=3 */
    Instruction("vpmulhuw", ps_VpiHpiWpi, IS.AVX),          /* lo=4 */
    Instruction("vpmulhw", ps_VpiHpiWpi, IS.AVX),           /* lo=5 */
    Instruction("vcvttpd2dq", ps_VpjxWpdx, IS.AVX),         /* lo=6 */
    Instruction("", null, IS.STD),                          /* lo=7 - handled in code */

    Instruction("vpsubsb", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=8 */
    Instruction("vpsubsw", ps_VpixHpixWpix, IS.AVX),        /* lo=9 */
    Instruction("vpminsw", ps_VpixHpixWpix, IS.AVX),        /* lo=A */
    Instruction("vpor", ps_VxHxWx, IS.AVX),                 /* lo=B */
    Instruction("vpaddsb", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=C */
    Instruction("vpaddsw", ps_VpixHpixWpix, IS.AVX),        /* lo=D */
    Instruction("vpmaxsw", ps_VpixHpixWpix, IS.AVX),        /* lo=E */
    Instruction("vpxor", ps_VxHxWx, IS.AVX),                /* lo=F */
];
/* row F */
Instruction[] INSTRUCTIONS_page1_rowF_pp1 = [
    Instruction("", null, IS.STD),                          /* lo=0 - invalid */
    Instruction("vpsllw", ps_VpwxHpwxWoqx, IS.AVX),         /* lo=1 */
    Instruction("vpslld", ps_VpdwxHpdwxWoqx, IS.AVX),       /* lo=2 */
    Instruction("vpsllq", ps_VpqwxHpqwxWoqx, IS.AVX),       /* lo=3 */
    Instruction("vpmuludq", ps_VpqxHpjxWpjx, IS.AVX),       /* lo=4 */
    Instruction("vpmaddwd", ps_VpjxHpixWpix, IS.AVX),       /* lo=5 */
    Instruction("vpsadbw", ps_VpixHpkxWpkx, IS.AVX),        /* lo=6 */
    Instruction("vmaskmovdqu", ps_VpbUpb, IS.AVX),          /* lo=7 */

    Instruction("vpsubb", ps_VpkxHpkxWpkx, IS.AVX),         /* lo=8 */
    Instruction("vpsubw", ps_VpixHpixWpix, IS.AVX),         /* lo=9 */
    Instruction("vpsubd", ps_VpjxHpjxWpjx, IS.AVX),         /* lo=A */
    Instruction("vpsubq", ps_VpqxHpqxWpqx, IS.AVX),         /* lo=B */
    Instruction("vpaddb", ps_VpkxHpkxWpkx, IS.AVX),         /* lo=C */
    Instruction("vpaddw", ps_VpixHpixWpix, IS.AVX),         /* lo=D */
    Instruction("vpaddd", ps_VpjxHpjxWpjx, IS.AVX),         /* lo=E */
    Instruction("", null, IS.STD),                          /* lo=F - invalid */
];

} // __gshared