module disassembler.parse.parse_avx_page2;

import disassembler.all;

void parseAVXPage2(Parser p, ref AVX avx) {
    // page 527

    uint op     = p.readByte();
    auto hi     = cast(Nibble)((op >>> 4) & 0b1111);
    auto lo     = cast(Nibble)(op & 0b1111);
    auto modrm  = ModRM(p.peekByte());

    //chat("PAGE2 %s pp=%s vvvv=%s hi=%s lo=%s", modrm, avx.pp, avx.vvvv, hi, lo);

    final switch(hi) with(Nibble) {
        case _00: if(avx.pp==1) p.instr.copy(INSTRUCTIONS_page2_row0_pp1[lo]); break;
        case _01: if(avx.pp==1) p.instr.copy(INSTRUCTIONS_page2_row1_pp1[lo]); break;
        case _02: if(avx.pp==1) p.instr.copy(INSTRUCTIONS_page2_row2_pp1[lo]); break;
        case _03: if(avx.pp==1) p.instr.copy(INSTRUCTIONS_page2_row3_pp1[lo]); break;
        case _04:
            if(avx.pp==1) {
                switch(lo) {
                    case _00: p.instr.copy(Instruction("vpmulld", ps_VpjxHpjxWpjx, IS.AVX)); break;
                    case _01: p.instr.copy(Instruction("vphminposuw", ps_VoWpi, IS.AVX)); break;
                    case _05:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpsrlvq", ps_VxHxWx, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpsrlvd", ps_VxHxWx, IS.AVX));
                        }
                        break;
                    case _06: p.instr.copy(Instruction("vpsravd", ps_VpdwxHpdwxWpdwx, IS.AVX)); break;
                    case _07:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpsllvq", ps_VxHxWx, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpsllvd", ps_VxHxWx, IS.AVX));
                        }
                        break;
                    default: break;
                }
            }
            break;
        case _05:
            if(avx.pp==1) {
                switch(lo) {
                    case _08: p.instr.copy(Instruction("vpbroadcastd", ps_VxWd, IS.AVX)); break;
                    case _09: p.instr.copy(Instruction("vpbroadcastq", ps_VxWq, IS.AVX)); break;
                    case _0A: p.instr.copy(Instruction("vpbroadcasti128", ps_VdoMo, IS.AVX)); break;
                    default: break;
                }
            }
            break;
        case _06: /* Nothing here */ break;
        case _07:
            if(avx.pp==1) {
                switch(lo) {
                    case _08: p.instr.copy(Instruction("vpbroadcastb", ps_VxWb, IS.AVX)); break;
                    case _09:p.instr.copy(Instruction("vpbroadcastw", ps_VxWw, IS.AVX)); break;
                    default: break;
                }
            }
            break;
        case _08:
            if(avx.pp==1) {
                switch(lo) {
                    case _0C:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpmaskmovq", ps_VxHxMx, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpmaskmovd", ps_VxHxMx, IS.AVX));
                        }
                        break;
                    case _0E:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpmaskmovq", ps_MxHxVx, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpmaskmovd", ps_MxHxVx, IS.AVX));
                        }
                        break;
                    default: break;
                }
            }
            break;
        case _09:
            if(avx.pp==1) {
                if(avx.W) {
                    p.instr.copy(INSTRUCTIONS_page2_row9_pp1_w1[lo]);
                } else {
                    p.instr.copy(INSTRUCTIONS_page2_row9_pp1_w0[lo]);
                }
            }
            break;
        case _0A:
            if(avx.pp==1) {
                if(avx.W) {
                    p.instr.copy(INSTRUCTIONS_page2_rowA_pp1_w1[lo]);
                } else {
                    p.instr.copy(INSTRUCTIONS_page2_rowA_pp1_w0[lo]);
                }
            }
            break;
        case _0B:
            if(avx.pp==1) {
                if(avx.W) {
                    p.instr.copy(INSTRUCTIONS_page2_rowB_pp1_w1[lo]);
                } else {
                    p.instr.copy(INSTRUCTIONS_page2_rowB_pp1_w0[lo]);
                }
            }
            break;
        case _0C: /* Nothing here */ break;
        case _0D:
            if(avx.pp==1) {
                switch(lo) {
                    case _0B: p.instr.copy(Instruction("vaesimc", ps_VoWo, IS.AES)); break;
                    case _0C: p.instr.copy(Instruction("vaesenc", ps_VoHoWo, IS.AES)); break;
                    case _0D: p.instr.copy(Instruction("vaesenclast", ps_VoHoWo, IS.AES)); break;
                    case _0E: p.instr.copy(Instruction("vaesdec", ps_VoHoWo, IS.AES)); break;
                    case _0F: p.instr.copy(Instruction("vaesdeclast", ps_VoHoWo, IS.AES)); break;
                    default: break;
                }
            }
            break;
        case _0E: /* Nothing here */ break;
        case _0F:
            if(lo==_03) {
                avxGroup17(p, avx);
            } else {
                final switch(avx.pp) with(AVX.PP) {
                    case _0:
                        switch(lo) {
                            case _02: p.instr.copy(Instruction("andn", ps_GyByEy, IS.AVX)); break;
                            case _05: p.instr.copy(Instruction("bzhi", ps_GyEyBy, IS.AVX)); break;
                            case _07: p.instr.copy(Instruction("bextr", ps_GyEyBy, IS.AVX)); break;
                            default: break;
                        }
                        break;
                    case _1:
                        if(lo==_07) p.instr.copy(Instruction("shlx", ps_GyEyBy, IS.AVX));
                        break;
                    case _2:
                        switch(lo) {
                            /* NOTE: This one is incorrectly shown as pp=1 in the AMD docs */
                            case _05: p.instr.copy(Instruction("pext", ps_GyByEy, IS.AVX)); break;
                            case _07: p.instr.copy(Instruction("sarx", ps_GyEyBy, IS.AVX)); break;
                            default: break;
                        }
                        break;
                    case _3:
                        switch(lo) {
                            case _05: p.instr.copy(Instruction("pdep", ps_GyByEy, IS.AVX)); break;
                            case _06: p.instr.copy(Instruction("mulx", ps_GyByEy, IS.AVX)); break;
                            case _07: p.instr.copy(Instruction("shrx", ps_GyEyBy, IS.AVX)); break;
                            default: break;
                        }
                        break;
                }
            }
            break;
    }
    p.instr.avx = avx;
}

private:

__gshared {
/* row 0 */
Instruction[] INSTRUCTIONS_page2_row0_pp1 = [
    Instruction("vpshufb", ps_VpbxHpbxWpbx, IS.AVX),        /* lo=0 */
    Instruction("vphaddw", ps_VpixHpixWpix, IS.AVX),        /* lo=1 */
    Instruction("vphaddd", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=2 */
    Instruction("vphaddsw", ps_VpixHpixWpix, IS.AVX),       /* lo=3 */
    Instruction("vpmaddubsw", ps_VpixHpkxWpkx, IS.AVX),     /* lo=4 */
    Instruction("vphsubw", ps_VpixHpixWpix, IS.AVX),        /* lo=5 */
    Instruction("vphsubd", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=6 */
    Instruction("vphsubsw", ps_VpixHpixWpix, IS.AVX),       /* lo=7 */

    Instruction("vpsignb", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=8 */
    Instruction("vpsignw", ps_VpiHpiWpi, IS.AVX),           /* lo=9 */
    Instruction("vpsignd", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=A */
    Instruction("vpmulhrsw", ps_VpixHpixWpix, IS.AVX),      /* lo=B */
    Instruction("vpermilps", ps_VpsxHpsxWpdwx, IS.AVX),     /* lo=C */
    Instruction("vpermilpd", ps_VpdxHpdxWpqwx, IS.AVX),     /* lo=D */
    Instruction("vtestps", ps_VpsxWpsx, IS.AVX),            /* lo=E */
    Instruction("vtestpd", ps_VpdxWpdx, IS.AVX),            /* lo=F */
];
/* row 1 */
Instruction[] INSTRUCTIONS_page2_row1_pp1 = [
    Instruction("", null, IS.STD),                          /* lo=0 - invalid */
    Instruction("", null, IS.STD),                          /* lo=1 - invalid */
    Instruction("", null, IS.STD),                          /* lo=2 - invalid */
    Instruction("vcvtph2ps", ps_VpsxWphx, IS.AVX),          /* lo=3 */
    Instruction("", null, IS.STD),                          /* lo=4 - invalid */
    Instruction("", null, IS.STD),                          /* lo=5 - invalid */
    Instruction("vpermps", ps_VpsHdWps, IS.AVX),            /* lo=6 */
    Instruction("vptest", ps_VxWx, IS.AVX),                 /* lo=7 */

    Instruction("vbroadcastss", ps_VpsWss, IS.AVX),         /* lo=8 */
    Instruction("vbroadcastsd", ps_VpdWsd, IS.AVX),         /* lo=9 */
    Instruction("vbroadcastssf128", ps_VdoMo, IS.AVX),      /* lo=A */
    Instruction("", null, IS.STD),                          /* lo=B - invalid */
    Instruction("vpabsb", ps_VpkxWpkx, IS.AVX),             /* lo=C */
    Instruction("vpabsw", ps_VpixWpix, IS.AVX),             /* lo=D */
    Instruction("vpabsd", ps_VpjxWpjx, IS.AVX),             /* lo=E */
    Instruction("", null, IS.STD),                          /* lo=F - invalid */
];
/* row 2 */
Instruction[] INSTRUCTIONS_page2_row2_pp1 = [
    Instruction("vpmovsxbw", ps_VpixWpkx, IS.AVX),          /* lo=0 */
    Instruction("vpmovsxbd", ps_VpjxWpkx, IS.AVX),          /* lo=1 */
    Instruction("vpmovsxbq", ps_VpqxWpkx, IS.AVX),          /* lo=2 */
    Instruction("vpmovsxwd", ps_VpjxWpix, IS.AVX),          /* lo=3 */
    Instruction("vpmovsxwq", ps_VpqxWpix, IS.AVX),          /* lo=4 */
    Instruction("vpmovsxdq", ps_VpqxWpjx, IS.AVX),          /* lo=5 */
    Instruction("", null, IS.AVX),                          /* lo=6 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=7 - invalid */

    Instruction("vpmuldq", ps_VpqxHpjxWpjx, IS.AVX),        /* lo=8 */
    Instruction("vpcmpeqq", ps_VpqxHpqxWpqx, IS.AVX),       /* lo=9 */
    Instruction("vmovntdqa", ps_VxMx, IS.AVX),              /* lo=A */
    Instruction("vpackusdw", ps_VpixHpjxWpjx, IS.AVX),      /* lo=B */
    Instruction("vmaskmovps", ps_VpsxHxMpsx, IS.AVX),       /* lo=C */
    Instruction("vmaskmovpd", ps_VpdxHxMpdx, IS.AVX),       /* lo=D */
    Instruction("vmaskmovps", ps_MpsxHxVpsx, IS.AVX),       /* lo=E */
    Instruction("vmaskmovpd", ps_MpdxHxVpdx, IS.AVX),       /* lo=F */
];
/* row 3 */
Instruction[] INSTRUCTIONS_page2_row3_pp1 = [
    Instruction("vpmovzxbw", ps_VpixWpkx, IS.AVX),          /* lo=0 */
    Instruction("vpmovzxbd", ps_VpjxWpkx, IS.AVX),          /* lo=1 */
    Instruction("vpmovzxbq", ps_VpqxWpkx, IS.AVX),          /* lo=2 */
    Instruction("vpmovzxwd", ps_VpjxWpix, IS.AVX),          /* lo=3 */
    Instruction("vpmovzxwq", ps_VpqxWpix, IS.AVX),          /* lo=4 */
    Instruction("vpmovzxdq", ps_VpqxWpjx, IS.AVX),          /* lo=5 */
    Instruction("vpermd", ps_VdHdWd, IS.AVX),               /* lo=6 */
    Instruction("vpcmpgtq", ps_VpqxHpqxWpqx, IS.AVX),       /* lo=7 */

    Instruction("vpminsb", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=8 */
    Instruction("vpminsd", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=9 */
    Instruction("vpminuw", ps_VpixHpixWpix, IS.AVX),        /* lo=A */
    Instruction("vpminud", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=B */
    Instruction("vpmaxsb", ps_VpkxHpkxWpkx, IS.AVX),        /* lo=C */
    Instruction("vpmaxsd", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=D */
    Instruction("vpmaxuw", ps_VpixHpixWpix, IS.AVX),        /* lo=E */
    Instruction("vpmaxud", ps_VpjxHpjxWpjx, IS.AVX),        /* lo=F */
];
/* row 9 */
Instruction[] INSTRUCTIONS_page2_row9_pp1_w0 = [
    Instruction("vpgatherdd", ps_VxMSTARdHpdw, IS.AVX2),    /* lo=0 */
    Instruction("vpgatherqd", ps_VxMSTARdHpdw, IS.AVX2),    /* lo=1 */
    Instruction("vgatherdps", ps_VxMSTARpsHpsx, IS.AVX),    /* lo=2 */
    Instruction("vgatherqps", ps_VxMSTARpsHps, IS.AVX),     /* lo=3 */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub132ps", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd132ps", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd132ps", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd132ss", ps_VoHoWd, IS.AVX),          /* lo=9 */
    Instruction("vfmsub132ps", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub132ss", ps_VoHoWd, IS.AVX),          /* lo=B */
    Instruction("vfnmadd132ps", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd132ss", ps_VoHoWd, IS.AVX),         /* lo=D */
    Instruction("vfnmsub132ps", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub132ss", ps_VoHoWd, IS.AVX),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page2_row9_pp1_w1 = [
    Instruction("vpgatherdq", ps_VxMSTARqHpqwx, IS.AVX2),   /* lo=0 */
    Instruction("vpgatherqq", ps_VxMSTARqHpqw, IS.AVX2),    /* lo=1 */
    Instruction("vgatherdpd", ps_VxMSTARpdHpdx, IS.AVX),    /* lo=2 */
    Instruction("vgatherqpd", ps_VxMSTARpdHpdx, IS.AVX),    /* lo=3 */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub132pd", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd132pd", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd132pd", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd132sd", ps_VoHoWq, IS.AVX),          /* lo=9 */
    Instruction("vfmsub132pd", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub132sd", ps_VoHoWq, IS.AVX),          /* lo=B */
    Instruction("vfnmadd132pd", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd132sd", ps_VoHoWq, IS.AVX),         /* lo=D */
    Instruction("vfnmsub132pd", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub132sd", ps_VoHoWq, IS.AVX),         /* lo=F */
];
/* row A */
Instruction[] INSTRUCTIONS_page2_rowA_pp1_w0 = [
    Instruction("", null, IS.AVX),                          /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub213ps", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd213ps", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd213ps", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd213ss", ps_VoHoWd, IS.AVX),          /* lo=9 */
    Instruction("vfmsub213ps", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub213ss", ps_VoHoWd, IS.AVX),          /* lo=B */
    Instruction("vfnmadd213ps", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd213ss", ps_VoHoWd, IS.AVX),         /* lo=D */
    Instruction("vfnmsub213ps", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub213ss", ps_VoHoWd, IS.AVX),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page2_rowA_pp1_w1 = [
    Instruction("", null, IS.AVX),                          /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub213pd", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd213pd", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd213pd", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd213sd", ps_VoHoWq, IS.AVX),          /* lo=9 */
    Instruction("vfmsub213pd", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub213sd", ps_VoHoWq, IS.AVX),          /* lo=B */
    Instruction("vfnmadd213pd", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd213sd", ps_VoHoWq, IS.AVX),         /* lo=D */
    Instruction("vfnmsub213pd", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub213sd", ps_VoHoWq, IS.AVX),         /* lo=F */
];
/* row B */
Instruction[] INSTRUCTIONS_page2_rowB_pp1_w0 = [
    Instruction("", null, IS.AVX),                          /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub231ps", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd231ps", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd231ps", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd231ss", ps_VoHoWd, IS.AVX),          /* lo=9 */
    Instruction("vfmsub231ps", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub231ss", ps_VoHoWd, IS.AVX),          /* lo=B */
    Instruction("vfnmadd231ps", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd231ss", ps_VoHoWd, IS.AVX),         /* lo=D */
    Instruction("vfnmsub231ps", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub231ss", ps_VoHoWd, IS.AVX),         /* lo=F */
];
Instruction[] INSTRUCTIONS_page2_rowB_pp1_w1 = [
    Instruction("", null, IS.AVX),                          /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("vfmaddsub231pd", ps_VxHxWx, IS.AVX),       /* lo=6 */
    Instruction("vfmsubadd231pd", ps_VxHxWx, IS.AVX),       /* lo=7 */

    Instruction("vfmadd231pd", ps_VxHxWx, IS.AVX),          /* lo=8 */
    Instruction("vfmadd231sd", ps_VoHoWq, IS.AVX),          /* lo=9 */
    Instruction("vfmsub231pd", ps_VxHxWx, IS.AVX),          /* lo=A */
    Instruction("vfmsub231sd", ps_VoHoWq, IS.AVX),          /* lo=B */
    Instruction("vfnmadd231pd", ps_VxHxWx, IS.AVX),         /* lo=C */
    Instruction("vfnmadd231sd", ps_VoHoWq, IS.AVX),         /* lo=D */
    Instruction("vfnmsub231pd", ps_VxHxWx, IS.AVX),         /* lo=E */
    Instruction("vfnmsub231sd", ps_VoHoWq, IS.AVX),         /* lo=F */
];
}   // __gshared
