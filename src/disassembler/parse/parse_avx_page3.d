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
                            p.instr.copy(Instruction("vpextrb", ps_RyVpbIb));
                        } else {
                            p.instr.copy(Instruction("vpextrb", ps_MbVpbIb));
                        }
                        break;
                    case _05:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpextrw", ps_RyVpwIb));
                        } else {
                            p.instr.copy(Instruction("vpextrw", ps_MwVpwIb));
                        }
                        break;
                    case _06:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vpextrq", ps_EqVpqwIb));
                        } else {
                            p.instr.copy(Instruction("vpextrd", ps_EdVpdwIb));
                        }
                        break;
                    case _07:
                        if(modrm.mod==0b11) {
                            p.instr.copy(Instruction("vextractps", ps_RssVpsIb));
                        } else {
                            p.instr.copy(Instruction("vextractps", ps_MssVpsIb));
                        }
                        break;
                    case _08: p.instr.copy(Instruction("vinsertf128", ps_VdoHdoWoIb)); break;
                    case _09: p.instr.copy(Instruction("vextractf128", ps_WoVdoIb)); break;
                    case _0D: p.instr.copy(Instruction("vcvtps2ph", ps_WphVpsIb, [Hint.PTR_SIZE_L128_64])); break;
                    default: break;
                }
            }
            break;
        case _02:
            if(avx.pp==1) {
                switch(lo) {
                    case _00: p.instr.copy(Instruction("vinsrb", ps_VpbHpbWbIb)); break;
                    case _01: p.instr.copy(Instruction("vinsertps", ps_VpsHpsUpsIb, [Hint.PTR_SIZE_32])); break;
                    case _02:
                        if(avx.W) {
                            p.instr.copy(Instruction("vinsrq", ps_VpdwHpqwEqIb));
                        } else {
                            p.instr.copy(Instruction("vinsrd", ps_VpdwHpdwEdIb));
                        }
                        break;
                    default: break;
                }
            }
            break;
        case _03:
            if(avx.pp==1) {
                switch(lo) {
                    case _08: p.instr.copy(Instruction("vinserti128", ps_VdoHdoWoIb)); break;
                    case _09: p.instr.copy(Instruction("vextracti128", ps_WoVdoIb)); break;
                    default: break;
                }
            }
            break;
        case _04:
            if(avx.pp==1) {
                switch(lo) {
                    case _00: p.instr.copy(Instruction("vdpps", ps_VpsxHpsxWpsxIb)); break;
                    case _01: p.instr.copy(Instruction("vdppd", ps_VpdHpdWpdIb)); break;
                    case _02: p.instr.copy(Instruction("vmpsadbw", ps_VpixHpkxWpkxIb)); break;
                    case _04: p.instr.copy(Instruction("vpclmulqdq", ps_VoHpqWpqIb, [Hint.PTR_SIZE_128])); break;
                    case _06: p.instr.copy(Instruction("vperm2i128", ps_VoHoWoIb, [Hint.PTR_SIZE_256])); break;
                    case _08:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpermil2ps", ps_VpsxHpsxLpsxWpsxIb));
                        } else {
                            p.instr.copy(Instruction("vpermil2ps", ps_VpsxHpsxWpsxLpsxIb));
                        }
                        break;
                    case _09:
                        if(avx.W) {
                            p.instr.copy(Instruction("vpermil2pd", ps_VpdxHpdxLpdxWpdxIb));
                        } else {
                            p.instr.copy(Instruction("vpermil2pd", ps_VpdxHpdxWpdxLpdxIb));
                        }
                        break;
                    case _0A: p.instr.copy(Instruction("vblendvps", ps_VpsxHpsxWpsxLpdx)); break;
                    case _0B: p.instr.copy(Instruction("vblendvpd", ps_VpdxHpdxWpdxLpdx)); break;
                    case _0C: p.instr.copy(Instruction("vblenddvb", ps_VpbxHpbxWpbxLx)); break;
                    default: break;
                }
            }
            break;
        case _05:
            if(avx.pp==1) {
                if(avx.W) {
                    switch(lo) {
                        case _0C: p.instr.copy(Instruction("vfmaddsubps", ps_VpsxLpsxHpsxWpsx)); break;
                        case _0D: p.instr.copy(Instruction("vfmaddsubpd", ps_VpdxLpdxHpdxWpdx)); break;
                        case _0E: p.instr.copy(Instruction("vfmsubaddps", ps_VpsxLpsxHpsxWpsx)); break;
                        case _0F: p.instr.copy(Instruction("vfmsubaddpd", ps_VpdxLpdxHpdxWpdx)); break;
                        default: break;
                    }
                } else {
                    switch(lo) {
                        case _0C: p.instr.copy(Instruction("vfmaddsubps", ps_VpsxLpsxWpsxHpsx)); break;
                        case _0D: p.instr.copy(Instruction("vfmaddsubpd", ps_VpdxLpdxWpdxHpdx)); break;
                        case _0E: p.instr.copy(Instruction("vfmsubaddps", ps_VpsxLpsxWpsxHpsx)); break;
                        case _0F: p.instr.copy(Instruction("vfmsubaddpd", ps_VpdxLpdxWpdxHpdx)); break;
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
                if(lo==_0F) p.instr.copy(Instruction("vaeskeygenassist", ps_VoWoIb));
            }
            break;
        case _0E: /* Nothing here */ break;
        case _0F:
            if(avx.pp==3) {
                if(lo==_00) p.instr.copy(Instruction("rorx", ps_GyEyIb));
            }
            break;
    }
    p.instr.avx = avx;
}

private:

__gshared {
/* row 0 */
Instruction[] INSTRUCTIONS_page3_row0_pp1 = [
    Instruction("vpermq", ps_VqWqIb, [Hint.PTR_SIZE_L256_128]),         /* lo=0 */
    Instruction("vpermpd", ps_VpdWpdIb),                                /* lo=1 */
    Instruction("vpblendd", ps_VpdwxHpdwxWpdwxIb),                      /* lo=2 */
    Instruction("", null),                                              /* lo=3 - invalid */
    Instruction("vpermilps", ps_VpsxWpsxIb),                            /* lo=4 */
    Instruction("vpermilpd", ps_VpdxWpdxIb),                            /* lo=5 */
    Instruction("vperm2f128", ps_VdoHoWoIb, [Hint.PTR_SIZE_L256_128]),  /* lo=6 */
    Instruction("", null),                                              /* lo=7 - invalid */

    Instruction("vroundps", ps_VpsxWpsxIb),                             /* lo=8 */
    Instruction("vroundpd", ps_VpdxWpdxIb),                             /* lo=9 */
    Instruction("vroundss", ps_VssHssWssIb),                            /* lo=A */
    Instruction("vroundsd", ps_VsdHsdWsdIb),                            /* lo=B */
    Instruction("vblendps", ps_VpsxHpsxWpsxIb),                         /* lo=C */
    Instruction("vblendpd", ps_VpdxHpdxWpdxIb),                         /* lo=D */
    Instruction("vpblendw", ps_VpwxHpwxWpwxIb),                         /* lo=E */
    Instruction("vpalignr", ps_VpbxHpbxWpbxIb),                         /* lo=F */
];
/* row 6 */
Instruction[] INSTRUCTIONS_page3_row6_pp1_w0 = [
    Instruction("vpcmpestrm", ps_VoWoIb),           /* lo=0 */
    Instruction("vpcmpestri", ps_VoWoIb),           /* lo=1 */
    Instruction("vpcmpistrm", ps_VoWoIb),           /* lo=2 */
    Instruction("vpcmpistri", ps_VoWoIb),           /* lo=3 */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */

    Instruction("vfmaddps", ps_VpsxLpsxWpsxHpsx),                   /* lo=8 */
    Instruction("vfmaddpd", ps_VpdxLpdxWpdxHpdx),                   /* lo=9 */
    Instruction("vfmaddss", ps_VssLssWssHss, [Hint.PTR_SIZE_128]),  /* lo=A */
    Instruction("vfmaddsd", ps_VsdLsdWsdHsd, [Hint.PTR_SIZE_128]),  /* lo=B */
    Instruction("vfmsubps", ps_VpsxLpsxWpsxHpsx),                   /* lo=C */
    Instruction("vfmsubpd", ps_VpdxLpdxWpdxHpdx),                   /* lo=D */
    Instruction("vfmsubss", ps_VssLssWssHss, [Hint.PTR_SIZE_128]),  /* lo=E */
    Instruction("vfmsubsd", ps_VsdLsdWsdHsd, [Hint.PTR_SIZE_128]),  /* lo=F */
];
Instruction[] INSTRUCTIONS_page3_row6_pp1_w1 = [
    Instruction("vpcmpestrm", ps_VoWoIb),           /* lo=0 */
    Instruction("vpcmpestri", ps_VoWoIb),           /* lo=1 */
    Instruction("vpcmpistrm", ps_VoWoIb),           /* lo=2 */
    Instruction("vpcmpistri", ps_VoWoIb),           /* lo=3 */
    Instruction("", null),                          /* lo=4 - invalid */
    Instruction("", null),                          /* lo=5 - invalid */
    Instruction("", null),                          /* lo=6 - invalid */
    Instruction("", null),                          /* lo=7 - invalid */

    Instruction("vfmaddps", ps_VpsxLpsxHpsxWpsx),                   /* lo=8 */
    Instruction("vfmaddpd", ps_VpdxLpdxHpdxWpdx),                   /* lo=9 */
    Instruction("vfmaddss", ps_VssLssHssWss, [Hint.PTR_SIZE_128]),  /* lo=A */
    Instruction("vfmaddsd", ps_VsdLsdHsdWsd, [Hint.PTR_SIZE_128]),  /* lo=B */
    Instruction("vfmsubps", ps_VpsxLpsxHpsxWpsx),                   /* lo=C */
    Instruction("vfmsubpd", ps_VpdxLpdxHpdxWpdx),                   /* lo=D */
    Instruction("vfmsubss", ps_VssLssHssWss, [Hint.PTR_SIZE_128]),  /* lo=E */
    Instruction("vfmsubsd", ps_VsdLsdHsdWsd, [Hint.PTR_SIZE_128]),  /* lo=F */
];
/* row 7 */
Instruction[] INSTRUCTIONS_page3_row7_pp1_w0 = [
    Instruction("", null),                       /* lo=0 - invalid */
    Instruction("", null),                       /* lo=1 - invalid */
    Instruction("", null),                       /* lo=2 - invalid */
    Instruction("", null),                       /* lo=3 - invalid */
    Instruction("", null),                       /* lo=4 - invalid */
    Instruction("", null),                       /* lo=5 - invalid */
    Instruction("", null),                       /* lo=6 - invalid */
    Instruction("", null),                       /* lo=7 - invalid */

    Instruction("vfnmaddps", ps_VpsxLpsxWpsxHpsx),                       /* lo=8 */
    Instruction("vfnmaddpd", ps_VpdxLpdxWpdxHpdx),                       /* lo=9 */
    Instruction("vfnmaddss", ps_VssLssWssHss, [Hint.PTR_SIZE_128]),      /* lo=A */
    Instruction("vfnmaddsd", ps_VsdLsdWsdHsd, [Hint.PTR_SIZE_128]),      /* lo=B */
    Instruction("vfnmsubps", ps_VpsxLpsxWpsxHpsx),                       /* lo=C */
    Instruction("vfnmsubpd", ps_VpdxLpdxWpdxHpdx),                       /* lo=D */
    Instruction("vfnmsubss", ps_VssLssWssHss, [Hint.PTR_SIZE_128]),      /* lo=E */
    Instruction("vfnmsubsd", ps_VsdLsdWsdHsd, [Hint.PTR_SIZE_128]),      /* lo=F */
];
Instruction[] INSTRUCTIONS_page3_row7_pp1_w1 = [
    Instruction("", null),                       /* lo=0 - invalid */
    Instruction("", null),                       /* lo=1 - invalid */
    Instruction("", null),                       /* lo=2 - invalid */
    Instruction("", null),                       /* lo=3 - invalid */
    Instruction("", null),                       /* lo=4 - invalid */
    Instruction("", null),                       /* lo=5 - invalid */
    Instruction("", null),                       /* lo=6 - invalid */
    Instruction("", null),                       /* lo=7 - invalid */

    Instruction("vfnmaddps", ps_VpsxLpsxHpsxWpsx),                  /* lo=8 */
    Instruction("vfnmaddpd", ps_VpdxLpdxHpdxWpdx),                  /* lo=9 */
    Instruction("vfnmaddss", ps_VssLssHssWss, [Hint.PTR_SIZE_128]), /* lo=A */
    Instruction("vfnmaddsd", ps_VsdLsdHsdWsd, [Hint.PTR_SIZE_128]), /* lo=B */
    Instruction("vfnmsubps", ps_VpsxLpsxHpsxWpsx),                  /* lo=C */
    Instruction("vfnmsubpd", ps_VpdxLpdxHpdxWpdx),                  /* lo=D */
    Instruction("vfnmsubss", ps_VssLssHssWss, [Hint.PTR_SIZE_128]), /* lo=E */
    Instruction("vfnmsubsd", ps_VsdLsdHsdWsd, [Hint.PTR_SIZE_128]), /* lo=F */
];
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

}   // __gshared