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
                        p.instr.copy(Instruction("vmovhlps", ps_VpsHpsUps));
                    } else if(lo==_06 && modrm.mod==0b11) {
                        p.instr.copy(Instruction("vmovlhps", ps_VpsHpsUps));
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row1_pp0[lo]);
                    }
                    break;
                case _1: p.instr.copy(INSTRUCTIONS_page1_row1_pp1[lo]); break;
                case _2:
                    switch(lo) {
                        case _00:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_VssHssUss));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_VssMd));
                            }
                            break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovss", ps_UssHssVss));
                            } else {
                                p.instr.copy(Instruction("vmovss", ps_MdVss));
                            }
                            break;
                        case _02: p.instr.copy(Instruction("vmovsldup", ps_VpsxWpsx)); break;
                        case _06: p.instr.copy(Instruction("vmovshdup", ps_VpsxWpsx)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00:
                           if(modrm.mod==0b11) {
                               p.instr.copy(Instruction("vmovsd", ps_VsdHsdUsd));
                           } else {
                               p.instr.copy(Instruction("vmovsd", ps_VsdMq));
                           }
                           break;
                        case _01:
                            if(modrm.mod==0b11) {
                                p.instr.copy(Instruction("vmovsd", ps_UsdHsdVsd));
                            } else {
                                p.instr.copy(Instruction("vmovsd", ps_MqVsd));
                            }
                            break;
                        case _02:
                            if(avx.L) {
                                p.instr.copy(Instruction("vmovddup", ps_VdoWdo));
                            } else {
                                p.instr.copy(Instruction("vmovddup", ps_VoWq));
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
                        case _08: p.instr.copy(Instruction("vmovaps", ps_VpsxWpsx)); break;
                        case _09: p.instr.copy(Instruction("vmovaps", ps_WpsxVpsx)); break;
                        case _0B: p.instr.copy(Instruction("vmovntps", ps_MpsxVpsx)); break;
                        case _0E: p.instr.copy(Instruction("vucomiss", ps_VssWss)); break;
                        case _0F: p.instr.copy(Instruction("vcomiss", ps_VssWss)); break;
                        default: break;
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _08: p.instr.copy(Instruction("vmovapd", ps_VpdxWpdx)); break;
                        case _09: p.instr.copy(Instruction("vmovapd", ps_WpdxVpdx)); break;
                        case _0B: p.instr.copy(Instruction("vmovntpd", ps_MpdxVpdx)); break;
                        case _0E: p.instr.copy(Instruction("vucomisd", ps_VsdWsd)); break;
                        case _0F: p.instr.copy(Instruction("vcomisd", ps_VsdWsd)); break;
                        default: break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2ss", ps_VoHoEy)); break;
                        case _0C: p.instr.copy(Instruction("vcvttss2si", ps_GyWss)); break;
                        case _0D: p.instr.copy(Instruction("vcvtss2si", ps_GyWss)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _0A: p.instr.copy(Instruction("vcvtsi2sd", ps_VoHoEy)); break;
                        case _0C: p.instr.copy(Instruction("vcvttsd2si", ps_GyWsd)); break;
                        case _0D: p.instr.copy(Instruction("vcvtsd2si", ps_GyWsd)); break;
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
                            p.instr.copy(Instruction("movq", ps_VoEy));
                        } else {
                            p.instr.copy(Instruction("movd", ps_VoEy));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_row6_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==0xF) p.instr.copy(Instruction("vmovdqu", ps_VpqwxWpqwx));
                    break;
                case _3: break;
            }
            break;
        case _07:
            final switch(avx.pp) with(AVX.PP) {
                case _0:
                    if(avx.L) {
                        p.instr.copy(Instruction("vzeroall", ps_none));
                    } else {
                        p.instr.copy(Instruction("vzeroupper", ps_none));
                    }
                    break;
                case _1:
                    switch(lo) {
                        case _01: avxGroup12(p, avx, modrm); break;
                        case _02: avxGroup13(p, avx, modrm); break;
                        case _03: avxGroup14(p, avx, modrm); break;
                        case _0E:
                            if(avx.W) {
                                p.instr.copy(Instruction("movq", ps_EyVo));
                            } else {
                                p.instr.copy(Instruction("movd", ps_EyVo));
                            }
                            break;
                        default: p.instr.copy(INSTRUCTIONS_page1_row7_pp1[lo]); break;
                    }
                    break;
                case _2:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshufhw", ps_VpwxWpwxIb)); break;
                        case _0E: p.instr.copy(Instruction("vmovq", ps_VqWq)); break;
                        case _0F: p.instr.copy(Instruction("vmovdqu", ps_WpqwxVpqwx)); break;
                        default: break;
                    }
                    break;
                case _3:
                    switch(lo) {
                        case _00: p.instr.copy(Instruction("vpshuflw", ps_VpwxWpwxIb)); break;
                        case _0C: p.instr.copy(Instruction("vhaddps", ps_VpsxHpsxWpsx)); break;
                        case _0D: p.instr.copy(Instruction("vhsubps", ps_VpsxHpsxWpsx)); break;
                        default: break;
                    }
                    break;
            }
            break;
        case _08: /* Nothing here */
        case _09: /* Nothing here */
            break;
        case _0A:
            if(lo==_0E) avxGroup15(p, avx, modrm);
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
                p.instr.copy(Instruction(mnemonic, strategy));
            } else {
                if(avx.pp==AVX.PP._0 && lo==_06) {
                    p.instr.copy(Instruction("vshufps", ps_VpsxHpsxWpsxIb));
                } else if(avx.pp==AVX.PP._1) {
                    if(lo==_04) {
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwRdIb));
                        } else {
                            p.instr.copy(Instruction("vpinsrw", ps_VpwHpwMwIb));
                        }
                    } else if(lo==_05) {
                        p.instr.copy(Instruction("vpextrw", ps_GwUpwIb));
                    } else if(lo==_06) {
                        p.instr.copy(Instruction("vshufpd", ps_VpdxHpdxWpdxIb));
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
                        p.instr.copy(Instruction("vaddsubps", ps_VpsxHpsxWpsx));
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
                            p.instr.copy(Instruction("vmovntdq", ps_MdoVdo));
                        } else {
                            p.instr.copy(Instruction("vmovntdq", ps_MoVo));
                        }
                    } else {
                        p.instr.copy(INSTRUCTIONS_page1_rowE_pp1[lo]);
                    }
                    break;
                case _2:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtdq2pd", ps_VpdxWpjx));
                    }
                    break;
                case _3:
                    if(lo==_06) {
                        p.instr.copy(Instruction("vcvtpd2dq", ps_VpjxWpdx));
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
                            p.instr.copy(Instruction("vlddqu", ps_VdoMdo));
                        } else {
                            p.instr.copy(Instruction("vlddqu", ps_VoMo));
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
    Instruction("vmovups",  ps_VpsxWpsx),               /* lo=0 */
    Instruction("vmovups", ps_WpsxVpsx),                /* lo=1 */
    Instruction("vmovlps",  ps_VpsHpsMq),               /* lo=2 */
    Instruction("vmovlps", ps_MqVps),                   /* lo=3 */
    Instruction("vunpcklps",  ps_VpsxHpsxWpsx),         /* lo=4 */
    Instruction("vunpckhps", ps_VpsxHpsxWpsx),          /* lo=5 */
    Instruction("vmovhps", ps_VpsHpsMq),                /* lo=6 */
    Instruction("vmovhps",  ps_MqVps),                  /* lo=7 */
    Instruction("", null),                              /* lo=8 - invalid */
    Instruction("", null),                              /* lo=9 - invalid */
    Instruction("", null),                              /* lo=A - invalid */
    Instruction("", null),                              /* lo=B - invalid */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */
];
Instruction[] INSTRUCTIONS_page1_row1_pp1 = [
    Instruction("vmovupd", ps_VpdxWpdx),                /* lo=0 */
    Instruction("vmodupd", ps_WpdxVpdx),                /* lo=1 */
    Instruction("vmovlpd", ps_VoHoMq),                  /* lo=2 */
    Instruction("vmovlpd", ps_MqVo),                    /* lo=3 */
    Instruction("vunpcklpd", ps_VpdxHpdxWpdx),          /* lo=4 */
    Instruction("vunpckhpd", ps_VpdxHpdxWpdx),          /* lo=5 */
    Instruction("vmovhpd", ps_VpdHpdMq),                /* lo=6 */
    Instruction("vmovhpd", ps_MqVpd),                   /* lo=7 */
    Instruction("", null),                              /* lo=8 - invalid */
    Instruction("", null),                              /* lo=9 - invalid */
    Instruction("", null),                              /* lo=A - invalid */
    Instruction("", null),                              /* lo=B - invalid */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */
];
/* row 5 */
Instruction[] INSTRUCTIONS_page1_row5_pp0 = [
    Instruction("vmovmskps", ps_GyUpsx),            /* lo=0 */
    Instruction("vsqrtps", ps_VpsxWpsx),            /* lo=1 */
    Instruction("vrsqrtps", ps_VpsxWpsx),           /* lo=2 */
    Instruction("vrcpps", ps_VpsxWpsx),             /* lo=3 */
    Instruction("vandps", ps_VpsxHpsxWpsx),         /* lo=4 */
    Instruction("vandnps", ps_VpsxHpsxWpsx),        /* lo=5 */
    Instruction("vorps", ps_VpsxHpsxWpsx),          /* lo=6 */
    Instruction("vxorps", ps_VpsxHpsxWpsx),         /* lo=7 */

    Instruction("vaddps", ps_VpsxHpsxWpsx),         /* lo=8 */
    Instruction("vmulps", ps_VpsxHpsxWpsx),         /* lo=9 */
    Instruction("vcvtps2pd", ps_VpdxWpsx),          /* lo=A */
    Instruction("vcvtdq2ps", ps_VpsxWpjx),          /* lo=B */
    Instruction("vsubps", ps_VpsxHpsxWpsx),         /* lo=C */
    Instruction("vminps", ps_VpsxHpsxWpsx),         /* lo=D */
    Instruction("vdivps", ps_VpsxHpsxWpsx),         /* lo=E */
    Instruction("vmaxps", ps_VpsxHpsxWpsx),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp1 = [
    Instruction("vmovmskpd", ps_GyUpdx),            /* lo=0 */
    Instruction("vsqrtpd", ps_VpdxWpdx),            /* lo=1 */
    Instruction("", null),                          /* lo=2 - invalid */
    Instruction("", null),                          /* lo=3 - invalid */
    Instruction("vandpd", ps_VpdxHpdxWpdx),         /* lo=4 */
    Instruction("vandnpd", ps_VpdxHpdxWpdx),        /* lo=5 */
    Instruction("vorpd", ps_VpdxHpdxWpdx),          /* lo=6 */
    Instruction("vxorpd", ps_VpdxHpdxWpdx),         /* lo=7 */

    Instruction("vaddpd", ps_VpdxHpdxWpdx),         /* lo=8 */
    Instruction("vmulpd", ps_VpdxHpdxWpdx),         /* lo=9 */
    Instruction("vcvtpd2ps", ps_VpsxWpdx),          /* lo=A */
    Instruction("vcvtps2dq", ps_VpjxWpsx),          /* lo=B */
    Instruction("vsubpd", ps_VpdxHpdxWpdx),         /* lo=C */
    Instruction("vminpd", ps_VpdxHpdxWpdx),         /* lo=D */
    Instruction("vdivpd", ps_VpdxHpdxWpdx),         /* lo=E */
    Instruction("vmaxpd", ps_VpdxHpdxWpdx),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp2 = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("vsqrtss", ps_VoHoWss),             /* lo=1 */
    Instruction("vrsqrtss", ps_VoHoWss),            /* lo=2 */
    Instruction("vrcpss", ps_VoHoWss),              /* lo=3 */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */

    Instruction("vaddss", ps_VssHssWss),            /* lo=8 */
    Instruction("vmulss", ps_VssHssWss),            /* lo=9 */
    Instruction("vcvtss2sd", ps_VoHoWss),           /* lo=A */
    Instruction("vcvttps2dq", ps_VpjxWpsx),         /* lo=B */
    Instruction("vsubss", ps_VssHssWss),            /* lo=C */
    Instruction("vminss", ps_VssHssWss),            /* lo=D */
    Instruction("vdivss", ps_VssHssWss),            /* lo=E */
    Instruction("vmaxss", ps_VssHssWss),            /* lo=F */
];
Instruction[] INSTRUCTIONS_page1_row5_pp3 = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("vsqrtsd", ps_VoHoWsd),             /* lo=1 */
    Instruction("", null),                          /* lo=2 - invalid */
    Instruction("", null),                          /* lo=3 - invalid */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */

    Instruction("vaddsd", ps_VsdHsdWsd),            /* lo=8 */
    Instruction("vmulsd", ps_VsdHsdWsd),            /* lo=9 */
    Instruction("vcvtsd2ss", ps_VoHoWsd),           /* lo=A */
    Instruction("", null),                          /* lo=B - invalid */
    Instruction("vsubsd", ps_VsdHsdWsd),            /* lo=C */
    Instruction("vminsd", ps_VsdHsdWsd),            /* lo=D */
    Instruction("vdivsd", ps_VsdHsdWsd),            /* lo=E */
    Instruction("vmaxsd", ps_VsdHsdWsd),            /* lo=F */
];
/* row 6 */
Instruction[] INSTRUCTIONS_page1_row6_pp1 = [
    Instruction("vpunpcklbw", ps_VpbxHpbxWpbx),         /* lo=0 */
    Instruction("vpunpcklwd", ps_VpwxHpwxWpwx),         /* lo=1 */
    Instruction("vpunpckldq", ps_VpdwxHpdwxWpdwx),      /* lo=2 */
    Instruction("vpacksswb", ps_VpkxHpixWpix),          /* lo=3 */
    Instruction("vpcmpgtb", ps_VpbxHpkxWpkx),           /* lo=4 */
    Instruction("vpcmpgtw", ps_VpwxHpixWpix),           /* lo=5 */
    Instruction("vpcmpgtd", ps_VpdwxHpjxWpjx),          /* lo=6 */
    Instruction("vpackuswb", ps_VpkxHpixWpix),          /* lo=7 */

    Instruction("vpunpckhbw", ps_VpbxHpbxWpbx),         /* lo=8 */
    Instruction("vpunpckhwd", ps_VpwxHpwxWpwx),         /* lo=9 */
    Instruction("vpunpckhdq", ps_VpdwxHpdwxWpdwx),      /* lo=A */
    Instruction("vpackssdw", ps_VpixHpjxWpjx),          /* lo=B */
    Instruction("vpunpcklqdq", ps_VpqwxHpqwxWpqwx),     /* lo=C */
    Instruction("vpunpckhqdq", ps_VpqwxHpqwxWpqwx),     /* lo=D */
    Instruction("", null),                              /* lo=E - handled in code */
    Instruction("vmovdqa", ps_VpqwxWpqwx),              /* lo=F */
];
/* row 7 */
Instruction[] INSTRUCTIONS_page1_row7_pp1 = [
    Instruction("vpshufd", ps_VpdwxWpdwxIb),            /* lo=0 */
    Instruction("", null),                              /* lo=1 - VEX group 12 */
    Instruction("", null),                              /* lo=2 - VEX group 13 */
    Instruction("", null),                              /* lo=3 - VEX group 14 */
    Instruction("vpcmpeqb", ps_VpbxHpkxWpkx),           /* lo=4 */
    Instruction("vpcmpeqw", ps_VpwxHpixWpix),           /* lo=5 */
    Instruction("vpcmpeqd", ps_VpdwxHpjxWpjx),          /* lo=6 */
    Instruction("", null),                              /* lo=7 - invalid */

    Instruction("", null),                              /* lo=8 - invalid */
    Instruction("", null),                              /* lo=9 - invalid */
    Instruction("", null),                              /* lo=A - invalid */
    Instruction("", null),                              /* lo=B - invalid */
    Instruction("vhaddpd", ps_VpdxHpdxWpdx),            /* lo=C */
    Instruction("vhsubpd", ps_VpdxHpdxWpdx),            /* lo=D */
    Instruction("", null),                              /* lo=E 0 handled in code */
    Instruction("vmovdqa", ps_WpqwxVpqwx),              /* lo=F */
];
/* row D */
Instruction[] INSTRUCTIONS_page1_rowD_pp1 = [
    Instruction("vaddsubpd", ps_VpdxHpdxWpdx),      /* lo=0 */
    Instruction("vpsrlw", ps_VpwxHpwxWx),           /* lo=1 */
    Instruction("vpsrld", ps_VpdwxHpdwxWx),         /* lo=2 */
    Instruction("vpsrlq", ps_VpqwxHpqwxWx),         /* lo=3 */
    Instruction("vpaddq", ps_VpqHpqWpq),            /* lo=4 */
    Instruction("vpmullw", ps_VpixHpixWpix),        /* lo=5 */
    Instruction("vmovq", ps_WqVq),                  /* lo=6 */
    Instruction("vpmovmskb", ps_GyUpbx),            /* lo=7 */
    Instruction("vpsubusb", ps_VpkxHpkxWpkx),       /* lo=8 */
    Instruction("vpsubusw", px_VpixHpixWpix),       /* lo=9 */
    Instruction("vpminub", px_VpkxHpkxWpkx),        /* lo=A */
    Instruction("vpand", ps_VxHxWx),                /* lo=B */
    Instruction("vpaddusb", px_VpkxHpkxWpkx),       /* lo=C */
    Instruction("vpaddusw", px_VpixHpixWpix),       /* lo=D */
    Instruction("vpmaxub", ps_VpkxHpkxWpkx),        /* lo=E */
    Instruction("vpandn", ps_VxHxWx),               /* lo=F */
];
/* row E */
Instruction[] INSTRUCTIONS_page1_rowE_pp1 = [
    Instruction("vpavgb", ps_VpkxHpkxWpkx),         /* lo=0 */
    Instruction("vpsraw", ps_VpwxHpwxWx),           /* lo=1 */
    Instruction("vpsrad", ps_VpdwxHpdwxWx),         /* lo=2 */
    Instruction("vpavgw", ps_VpixHpixWpix),         /* lo=3 */
    Instruction("vpmulhuw", ps_VpiHpiWpi),          /* lo=4 */
    Instruction("vpmulhw", ps_VpiHpiWpi),           /* lo=5 */
    Instruction("vcvttpd2dq", ps_VpjxWpdx),         /* lo=6 */
    Instruction("", null),                          /* lo=7 - handled in code */

    Instruction("vpsubsb", ps_VpkxHpkxWpkx),        /* lo=8 */
    Instruction("vpsubsw", ps_VpixHpixWpix),        /* lo=9 */
    Instruction("vpminsw", ps_VpixHpixWpix),        /* lo=A */
    Instruction("vpor", ps_VxHxWx),                 /* lo=B */
    Instruction("vpaddsb", ps_VpkxHpkxWpkx),        /* lo=C */
    Instruction("vpaddsw", ps_VpixHpixWpix),        /* lo=D */
    Instruction("vpmaxsw", ps_VpixHpixWpix),        /* lo=E */
    Instruction("vpxor", ps_VxHxWx),                /* lo=F */
];
/* row F */
Instruction[] INSTRUCTIONS_page1_rowF_pp1 = [
    Instruction("", null),                          /* lo=0 - invalid */
    Instruction("vpsllw", ps_VpwxHpwxWoqx),         /* lo=1 */
    Instruction("vpslld", ps_VpdwxHpdwxWoqx),       /* lo=2 */
    Instruction("vpsllq", ps_VpqwxHpqwxWoqx),       /* lo=3 */
    Instruction("vpmuludq", ps_VpqxHpjxWpjx),       /* lo=4 */
    Instruction("vpmaddwd", ps_VpjxHpixWpix),       /* lo=5 */
    Instruction("vpsadbw", ps_VpixHpkxWpkx),        /* lo=6 */
    Instruction("vmaskmovdqu", ps_VpbUpb),          /* lo=7 */

    Instruction("vpsubb", ps_VpkxHpkxWpkx),         /* lo=8 */
    Instruction("vpsubw", ps_VpixHpixWpix),         /* lo=9 */
    Instruction("vpsubd", ps_VpjxHpjxWpjx),         /* lo=A */
    Instruction("vpsubq", ps_VpqxHpqxWpqx),         /* lo=B */
    Instruction("vpaddb", ps_VpkxHpkxWpkx),         /* lo=C */
    Instruction("vpaddw", ps_VpixHpixWpix),         /* lo=D */
    Instruction("vpaddd", ps_VpjxHpjxWpjx),         /* lo=E */
    Instruction("", null),                          /* lo=F - invalid */
];

} // __gshared