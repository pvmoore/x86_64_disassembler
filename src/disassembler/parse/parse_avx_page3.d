module disassembler.parse.parse_avx_page3;

import disassembler.all;

void parseAVXPage3(Parser p, ref AVX avx) {
    // page 529

    uint op     = p.readByte();
    auto hi     = cast(Nibble)((op >>> 4) & 0b1111);
    auto lo     = cast(Nibble)(op & 0b1111);
    auto modrm  = ModRM(p.peekByte());

    //chat("PAGE3 %s pp=%s vvvv=%s hi=%s lo=%s", modrm, avx.pp, avx.vvvv, hi, lo);

    final switch(hi) with(Nibble) {
        case _00:
            if(avx.pp==1) {
                p.instr.copy(INSTRUCTIONS_page3_row0_pp1[lo]);
            }
            break;
        case _01:
            if(avx.pp==1) {
                switch(lo) {
                    case _04:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpextrb", ps_RyVpbIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpextrb", ps_MbVpbIb, IS.AVX));
                        }
                        break;
                    case _05:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpextrw", ps_RyVpwIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpextrw", ps_MwVpwIb, IS.AVX));
                        }
                        break;
                    case _06:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpextrq", ps_EqVpqwIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpextrd", ps_EdVpdwIb, IS.AVX));
                        }
                        break;
                    case _07:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vextractps", ps_RssVpsIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vextractps", ps_MssVpsIb, IS.AVX));
                        }
                        break;
                    case _08: p.instr.copy(Instruction("vinsertf128", ps_VdoHdoWoIb, IS.AVX)); break;
                    case _09: p.instr.copy(Instruction("vextractf128", ps_WoVdoIb, IS.AVX)); break;
                    case _0D: p.instr.copy(Instruction("vcvtps2ph", ps_WphVpsIb, IS.AVX, [Hint.PTR_SIZE_L128_64])); break;
                    default: break;
                }
            }
            break;
        case _02:
            if(avx.pp==1) {
                switch(lo) {
                    case _00: p.instr.copy(Instruction("vinsrb", ps_VpbHpbWbIb, IS.AVX)); break;
                    case _01: p.instr.copy(Instruction("vinsertps", ps_VpsHpsUpsIb, IS.AVX, [Hint.PTR_SIZE_32])); break;
                    case _02:
                        if(avx.W) {
                            p.instr.copy(Instruction("vinsrq", ps_VpdwHpqwEqIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vinsrd", ps_VpdwHpdwEdIb, IS.AVX));
                        }
                        break;
                    default: break;
                }
            }
            break;
        case _03:
            if(avx.pp==1) {
                switch(lo) {
                    case _08: p.instr.copy(Instruction("vinserti128", ps_VdoHdoWoIb, IS.AVX)); break;
                    case _09: p.instr.copy(Instruction("vextracti128", ps_WoVdoIb, IS.AVX)); break;
                    default: break;
                }
            }
            break;
        case _04:
            if(avx.pp==1) {
                switch(lo) {
                    case _00: p.instr.copy(Instruction("vdpps", ps_VpsxHpsxWpsxIb, IS.AVX)); break;
                    case _01: p.instr.copy(Instruction("vdppd", ps_VpdHpdWpdIb, IS.AVX)); break;
                    case _02: p.instr.copy(Instruction("vmpsadbw", ps_VpixHpkxWpkxIb, IS.AVX)); break;
                    case _04: p.instr.copy(Instruction("vpclmulqdq", ps_VoHpqWpqIb, IS.AVX, [Hint.PTR_SIZE_128])); break;
                    case _06: p.instr.copy(Instruction("vperm2i128", ps_VoHoWoIb, IS.AVX, [Hint.PTR_SIZE_256])); break;
                    case _08:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpermil2ps", ps_VpsxHpsxLpsxWpsxIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpermil2ps", ps_VpsxHpsxWpsxLpsxIb, IS.AVX));
                        }
                        break;
                    case _09:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpermil2pd", ps_VpdxHpdxLpdxWpdxIb, IS.AVX));
                        } else {
                            p.instr.copy(Instruction("vpermil2pd", ps_VpdxHpdxWpdxLpdxIb, IS.AVX));
                        }
                        break;
                    case _0A: p.instr.copy(Instruction("vblendvps", ps_VpsxHpsxWpsxLpdx, IS.AVX)); break;
                    case _0B: p.instr.copy(Instruction("vblendvpd", ps_VpdxHpdxWpdxLpdx, IS.AVX)); break;
                    case _0C: p.instr.copy(Instruction("vblenddvb", ps_VpbxHpbxWpbxLx, IS.AVX)); break;
                    default: break;
                }
            }
            break;
        case _05:
            if(avx.pp==1) {
                if(avx.W) {
                    switch(lo) {
                        case _0C: p.instr.copy(Instruction("vfmaddsubps", ps_VpsxLpsxHpsxWpsx, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vfmaddsubpd", ps_VpdxLpdxHpdxWpdx, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vfmsubaddps", ps_VpsxLpsxHpsxWpsx, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vfmsubaddpd", ps_VpdxLpdxHpdxWpdx, IS.AVX)); break;
                        default: break;
                    }
                } else {
                    switch(lo) {
                        case _0C: p.instr.copy(Instruction("vfmaddsubps", ps_VpsxLpsxWpsxHpsx, IS.AVX)); break;
                        case _0D: p.instr.copy(Instruction("vfmaddsubpd", ps_VpdxLpdxWpdxHpdx, IS.AVX)); break;
                        case _0E: p.instr.copy(Instruction("vfmsubaddps", ps_VpsxLpsxWpsxHpsx, IS.AVX)); break;
                        case _0F: p.instr.copy(Instruction("vfmsubaddpd", ps_VpdxLpdxWpdxHpdx, IS.AVX)); break;
                        default: break;
                    }
                }
            }
            break;
        case _06:
            if(avx.pp==1) {
                if(avx.W) {
                    p.instr.copy(INSTRUCTIONS_page3_row6_pp1_w1[lo]);
                } else {
                    p.instr.copy(INSTRUCTIONS_page3_row6_pp1_w0[lo]);
                }
            }
            break;
        case _07:
            if(avx.pp==1) {
                if(avx.W) {
                    p.instr.copy(INSTRUCTIONS_page3_row7_pp1_w1[lo]);
                } else {
                    p.instr.copy(INSTRUCTIONS_page3_row7_pp1_w0[lo]);
                }
            }
            break;
        case _08: /* Nothing here */ break;
        case _09: /* Nothing here */ break;
        case _0A: /* Nothing here */ break;
        case _0B: /* Nothing here */ break;
        case _0C: /* Nothing here */ break;
        case _0D:
            if(avx.pp==1) {
                if(lo==_0F) p.instr.copy(Instruction("vaeskeygenassist", ps_VoWoIb, IS.AVX));
            }
            break;
        case _0E: /* Nothing here */ break;
        case _0F:
            if(avx.pp==3) {
                if(lo==_00) p.instr.copy(Instruction("rorx", ps_GyEyIb, IS.AVX));
            }
            break;
    }
    p.instr.avx = avx;
}

private:

__gshared {
/* row 0 */
Instruction[] INSTRUCTIONS_page3_row0_pp1 = [
    Instruction("vpermq", ps_VqWqIb, IS.AVX2, [Hint.PTR_SIZE_L256_128]),            /* lo=0 */
    Instruction("vpermpd", ps_VpdWpdIb, IS.AVX),                                    /* lo=1 */
    Instruction("vpblendd", ps_VpdwxHpdwxWpdwxIb, IS.AVX),                          /* lo=2 */
    Instruction("", null, IS.AVX),                                                  /* lo=3 - invalid */
    Instruction("vpermilps", ps_VpsxWpsxIb, IS.AVX),                                /* lo=4 */
    Instruction("vpermilpd", ps_VpdxWpdxIb, IS.AVX),                                /* lo=5 */
    Instruction("vperm2f128", ps_VdoHoWoIb, IS.AVX, [Hint.PTR_SIZE_L256_128]),      /* lo=6 */
    Instruction("", null, IS.AVX),                                                  /* lo=7 - invalid */

    Instruction("vroundps", ps_VpsxWpsxIb, IS.AVX),                             /* lo=8 */
    Instruction("vroundpd", ps_VpdxWpdxIb, IS.AVX),                             /* lo=9 */
    Instruction("vroundss", ps_VssHssWssIb, IS.AVX),                            /* lo=A */
    Instruction("vroundsd", ps_VsdHsdWsdIb, IS.AVX),                            /* lo=B */
    Instruction("vblendps", ps_VpsxHpsxWpsxIb, IS.AVX),                         /* lo=C */
    Instruction("vblendpd", ps_VpdxHpdxWpdxIb, IS.AVX),                         /* lo=D */
    Instruction("vpblendw", ps_VpwxHpwxWpwxIb, IS.AVX),                         /* lo=E */
    Instruction("vpalignr", ps_VpbxHpbxWpbxIb, IS.AVX),                         /* lo=F */
];
/* row 6 */
Instruction[] INSTRUCTIONS_page3_row6_pp1_w0 = [
    Instruction("vpcmpestrm", ps_VoWoIb, IS.AVX),           /* lo=0 */
    Instruction("vpcmpestri", ps_VoWoIb, IS.AVX),           /* lo=1 */
    Instruction("vpcmpistrm", ps_VoWoIb, IS.AVX),           /* lo=2 */
    Instruction("vpcmpistri", ps_VoWoIb, IS.AVX),           /* lo=3 */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=6 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=7 - invalid */

    Instruction("vfmaddps", ps_VpsxLpsxWpsxHpsx, IS.AVX),                   /* lo=8 */
    Instruction("vfmaddpd", ps_VpdxLpdxWpdxHpdx, IS.AVX),                   /* lo=9 */
    Instruction("vfmaddss", ps_VssLssWssHss, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=A */
    Instruction("vfmaddsd", ps_VsdLsdWsdHsd, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=B */
    Instruction("vfmsubps", ps_VpsxLpsxWpsxHpsx, IS.AVX),                   /* lo=C */
    Instruction("vfmsubpd", ps_VpdxLpdxWpdxHpdx, IS.AVX),                   /* lo=D */
    Instruction("vfmsubss", ps_VssLssWssHss, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=E */
    Instruction("vfmsubsd", ps_VsdLsdWsdHsd, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=F */
];
Instruction[] INSTRUCTIONS_page3_row6_pp1_w1 = [
    Instruction("vpcmpestrm", ps_VoWoIb, IS.AVX),           /* lo=0 */
    Instruction("vpcmpestri", ps_VoWoIb, IS.AVX),           /* lo=1 */
    Instruction("vpcmpistrm", ps_VoWoIb, IS.AVX),           /* lo=2 */
    Instruction("vpcmpistri", ps_VoWoIb, IS.AVX),           /* lo=3 */
    Instruction("", null, IS.AVX),                          /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=5 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=6 - invalid */
    Instruction("", null, IS.AVX),                          /* lo=7 - invalid */

    Instruction("vfmaddps", ps_VpsxLpsxHpsxWpsx, IS.AVX),                   /* lo=8 */
    Instruction("vfmaddpd", ps_VpdxLpdxHpdxWpdx, IS.AVX),                   /* lo=9 */
    Instruction("vfmaddss", ps_VssLssHssWss, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=A */
    Instruction("vfmaddsd", ps_VsdLsdHsdWsd, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=B */
    Instruction("vfmsubps", ps_VpsxLpsxHpsxWpsx, IS.AVX),                   /* lo=C */
    Instruction("vfmsubpd", ps_VpdxLpdxHpdxWpdx, IS.AVX),                   /* lo=D */
    Instruction("vfmsubss", ps_VssLssHssWss, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=E */
    Instruction("vfmsubsd", ps_VsdLsdHsdWsd, IS.AVX, [Hint.PTR_SIZE_128]),  /* lo=F */
];
/* row 7 */
Instruction[] INSTRUCTIONS_page3_row7_pp1_w0 = [
    Instruction("", null, IS.AVX),                       /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=5 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=6 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=7 - invalid */

    Instruction("vfnmaddps", ps_VpsxLpsxWpsxHpsx, IS.AVX),                       /* lo=8 */
    Instruction("vfnmaddpd", ps_VpdxLpdxWpdxHpdx, IS.AVX),                       /* lo=9 */
    Instruction("vfnmaddss", ps_VssLssWssHss, IS.AVX, [Hint.PTR_SIZE_128]),      /* lo=A */
    Instruction("vfnmaddsd", ps_VsdLsdWsdHsd, IS.AVX, [Hint.PTR_SIZE_128]),      /* lo=B */
    Instruction("vfnmsubps", ps_VpsxLpsxWpsxHpsx, IS.AVX),                       /* lo=C */
    Instruction("vfnmsubpd", ps_VpdxLpdxWpdxHpdx, IS.AVX),                       /* lo=D */
    Instruction("vfnmsubss", ps_VssLssWssHss, IS.AVX, [Hint.PTR_SIZE_128]),      /* lo=E */
    Instruction("vfnmsubsd", ps_VsdLsdWsdHsd, IS.AVX, [Hint.PTR_SIZE_128]),      /* lo=F */
];
Instruction[] INSTRUCTIONS_page3_row7_pp1_w1 = [
    Instruction("", null, IS.AVX),                       /* lo=0 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=1 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=2 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=3 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=4 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=5 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=6 - invalid */
    Instruction("", null, IS.AVX),                       /* lo=7 - invalid */

    Instruction("vfnmaddps", ps_VpsxLpsxHpsxWpsx, IS.AVX),                  /* lo=8 */
    Instruction("vfnmaddpd", ps_VpdxLpdxHpdxWpdx, IS.AVX),                  /* lo=9 */
    Instruction("vfnmaddss", ps_VssLssHssWss, IS.AVX, [Hint.PTR_SIZE_128]), /* lo=A */
    Instruction("vfnmaddsd", ps_VsdLsdHsdWsd, IS.AVX, [Hint.PTR_SIZE_128]), /* lo=B */
    Instruction("vfnmsubps", ps_VpsxLpsxHpsxWpsx, IS.AVX),                  /* lo=C */
    Instruction("vfnmsubpd", ps_VpdxLpdxHpdxWpdx, IS.AVX),                  /* lo=D */
    Instruction("vfnmsubss", ps_VssLssHssWss, IS.AVX, [Hint.PTR_SIZE_128]), /* lo=E */
    Instruction("vfnmsubsd", ps_VsdLsdHsdWsd, IS.AVX, [Hint.PTR_SIZE_128]), /* lo=F */
];
    // Instruction("", null, IS.AVX),                       /* lo=0 */
    // Instruction("", null, IS.AVX),                       /* lo=1 */
    // Instruction("", null, IS.AVX),                       /* lo=2 */
    // Instruction("", null, IS.AVX),                       /* lo=3 */
    // Instruction("", null, IS.AVX),                       /* lo=4 */
    // Instruction("", null, IS.AVX),                       /* lo=5 */
    // Instruction("", null, IS.AVX),                       /* lo=6 */
    // Instruction("", null, IS.AVX),                       /* lo=7 */

    // Instruction("", null, IS.AVX),                       /* lo=8 */
    // Instruction("", null, IS.AVX),                       /* lo=9 */
    // Instruction("", null, IS.AVX),                       /* lo=A */
    // Instruction("", null, IS.AVX),                       /* lo=B */
    // Instruction("", null, IS.AVX),                       /* lo=C */
    // Instruction("", null, IS.AVX),                       /* lo=D */
    // Instruction("", null, IS.AVX),                       /* lo=E */
    // Instruction("", null, IS.AVX),                       /* lo=F */

}   // __gshared