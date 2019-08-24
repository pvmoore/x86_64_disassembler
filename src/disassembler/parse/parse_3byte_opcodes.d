module disassembler.parse.parse_3byte_opcodes;

import disassembler.all;

void parseThreeByteOpcode(Parser p, uint byte1, uint byte2) {
    assert(byte1 == 0x0F);
    assert(byte2 == 0x38 || byte2 == 0x3A);

    uint opcode3 = p.readByte();
    uint hiNibble = (opcode3 >>> 4) & 0b1111;
    uint loNibble = opcode3 & 0b1111;

    if(byte2==0x38) {

        switch(hiNibble) {
            case 0x0:
                if(p.prefix.opSize)
                    p.instr.copy(INSTRUCTIONS_0F_38_0_66[loNibble]);
                else
                    p.instr.copy(INSTRUCTIONS_0F_38_0[loNibble]);
                break;
            case 0x1:
                if(p.prefix.opSize) {
                    switch(loNibble) {
                        case 0x0: p.instr.copy(Instruction("pblendvb", ps_VpbWpb)); break;
                        case 0x4: p.instr.copy(Instruction("blendvps", ps_VpsWps)); break;
                        case 0x5: p.instr.copy(Instruction("blendvpd", ps_VpbWpb)); break;
                        case 0x7: p.instr.copy(Instruction("ptest", ps_VoWo)); break;
                        case 0xC: p.instr.copy(Instruction("pabsb", ps_VpkWpk)); break;
                        case 0xD: p.instr.copy(Instruction("pabsw", ps_VpiWpi)); break;
                        case 0xE: p.instr.copy(Instruction("pabsd", ps_VpjWpj)); break;
                        default: break;
                    }
                } else {
                    switch(loNibble) {
                        case 0xC: p.instr.copy(Instruction("pabsb", ps_PpkQpk)); break;
                        case 0xD: p.instr.copy(Instruction("pabsw", ps_PpiQpi)); break;
                        case 0xE: p.instr.copy(Instruction("pabsd", ps_PpjQpj)); break;
                        default: break;
                    }
                }
                break;
            case 0x2:
                if(p.prefix.opSize) {
                    p.instr.copy(INSTRUCTIONS_0F_38_2_66[loNibble]);
                }
                break;
            case 0x3:
                if(p.prefix.opSize) {
                    p.instr.copy(INSTRUCTIONS_0F_38_3_66[loNibble]);
                }
                break;
            case 0x4:
                if(p.prefix.opSize) {
                    if(loNibble==0) p.instr.copy(Instruction("pmulld", ps_VpjWpj));
                    else if(loNibble==1) p.instr.copy(Instruction("phminposuw", ps_VpiWpi));
                }
                break;
            case 0xC:
                switch(loNibble) {
                    case 0x8: p.instr.copy(Instruction("sha1nexte", ps_VoWo)); break;
                    case 0x9: p.instr.copy(Instruction("sha1msg1", ps_VoWo)); break;
                    case 0xA: p.instr.copy(Instruction("sha1msg2", ps_VoWo)); break;
                    case 0xB: p.instr.copy(Instruction("sha256rnds2", ps_VoWo)); break;
                    case 0xC: p.instr.copy(Instruction("sha256msg1", ps_VoWo)); break;
                    case 0xD: p.instr.copy(Instruction("sha256msg2", ps_VoWo)); break;
                    default: break;
                }
                break;
            case 0xD:
                if(p.prefix.opSize) {
                    switch(loNibble) {
                        case 0xB: p.instr.copy(Instruction("aesimc", ps_VoWo)); break;
                        case 0xC: p.instr.copy(Instruction("aesenc", ps_VoWo)); break;
                        case 0xD: p.instr.copy(Instruction("aesenclast", ps_VoWo)); break;
                        case 0xE: p.instr.copy(Instruction("aesdec", ps_VoWo)); break;
                        case 0xF: p.instr.copy(Instruction("aesdeclast", ps_VoWo)); break;
                        default: break;
                    }
                }
                break;
            case 0xF:
                if(p.prefix.repne) { /* F2 */
                    if(loNibble==0)
                        p.instr.copy(Instruction("crc32", ps_GyEb));
                    else if(loNibble==1)
                        p.instr.copy(Instruction("crc32", ps_GyEv));
                } else {
                    if(loNibble==0)
                        p.instr.copy(Instruction("movbe", ps_GvMv));
                    else if(loNibble==1)
                        p.instr.copy(Instruction("movbe", ps_MvGv));
                }
                break;
            default: break;
        }
    } else { /* byte2==0x3A */

        switch(hiNibble) {
            case 0x0:
                if(p.prefix.opSize) {/* 66 */
                    p.instr.copy(INSTRUCTIONS_0F_3A_0_66[loNibble]);
                } else {
                    if(loNibble==0xF) p.instr.copy(Instruction("palignr", ps_PpbQpbIb));
                }
                break;
            case 0x1:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        /**** NOTE: These have an alternative but I am not sure how they are encoded */
                        case 4: p.instr.copy(Instruction("pextrb", ps_MbVpkIb)); break;
                        case 5: p.instr.copy(Instruction("pextrw", ps_MwVpwIb)); break;
                        case 6:
                            if(p.prefix.rexW())
                                p.instr.copy(Instruction("pextrq", ps_EqVpqIb));
                            else
                                p.instr.copy(Instruction("pextrd", ps_EdVpjIb));
                            break;
                        case 7: p.instr.copy(Instruction("extractps", ps_MdVpsIb)); break;

                        default: break;
                    }
                }
                break;
            case 0x2:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("pinsrb", ps_VpkMbIb)); break;
                        case 1: p.instr.copy(Instruction("insertps", ps_VpsMdIb)); break;
                        case 2:
                            if(p.prefix.rexW())
                                p.instr.copy(Instruction("pinsrq", ps_VpqEqIb));
                            else
                                p.instr.copy(Instruction("pinsrd", ps_VpjEdIb));
                            break;
                        default: break;
                    }
                }
                break;
            case 0x4:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("dpps", ps_VpsWpsIb)); break;
                        case 1: p.instr.copy(Instruction("dppd", ps_VpdWpdIb)); break;
                        case 2: p.instr.copy(Instruction("mpsadbw", ps_VpkWpkIb)); break;
                        case 4: p.instr.copy(Instruction("pclmulqdq", ps_VpqWpqIb)); break;
                        default: break;
                    }
                }
                break;
            case 0x6:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("pcmpestrm", ps_VoWoIb)); break;
                        case 1: p.instr.copy(Instruction("pcmpestri", ps_VoWoIb)); break;
                        case 2: p.instr.copy(Instruction("pcmpistrm", ps_VoWoIb)); break;
                        case 3: p.instr.copy(Instruction("pcmpistri", ps_VoWoIb)); break;
                        default: break;
                    }
                }
                break;
            case 0xC:
                if(loNibble==0xC) p.instr.copy(Instruction("sha1rnds4", ps_VoWoIb));
                break;
            case 0xD:
                if(p.prefix.opSize) {/* 66 */
                    if(loNibble==0xF) p.instr.copy(Instruction("aeskeygenassist", ps_VoWoIb));
                }
                break;
            default: break;
        }
    }
}

private:

/* 0F, 38, hi nibble = 0, no prefix */
__gshared Instruction[] INSTRUCTIONS_0F_38_0 = [
    Instruction("pshufb", ps_PpbQpb),         /* lo=0 */
    Instruction("phaddw", ps_PpiQpi),         /* lo=1 */
    Instruction("phaddd", ps_PpjQpj),         /* lo=2 */
    Instruction("phaddsw", ps_PpiQpi),        /* lo=3 */
    Instruction("pmaddubsw", ps_PpkQpk),      /* lo=4 */
    Instruction("phsubw", ps_PpiQpi),         /* lo=5 */
    Instruction("phsubd", ps_PpjQpj),         /* lo=6 */
    Instruction("phsubsw", ps_PpiQpi),        /* lo=7 */
    Instruction("psignb", ps_PpkQpk),         /* lo=8 */
    Instruction("psignw", ps_PpiQpi),         /* lo=9 */
    Instruction("psignd", ps_PpjQpj),         /* lo=A */
    Instruction("pmulhrsw", ps_PpiQpi),       /* lo=B */
    Instruction("", null),                      /* lo=C - invalid */
    Instruction("", null),                      /* lo=D - invalid */
    Instruction("", null),                      /* lo=E - invalid */
    Instruction("", null),                      /* lo=F - invalid */
];
/* 0F, 38, hi nibble = 0, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_0_66 = [
    Instruction("pshufb", ps_VpbWpb),         /* lo=0 */
    Instruction("phaddw", ps_VpiWpi),         /* lo=1 */
    Instruction("phaddd", ps_VpjWpj),         /* lo=2 */
    Instruction("phaddsw", ps_VpiWpi),        /* lo=3 */
    Instruction("pmaddubsw", ps_VpkWpk),      /* lo=4 */
    Instruction("phsubw", ps_VpiWpi),         /* lo=5 */
    Instruction("phsubd", ps_VpjWpj),         /* lo=6 */
    Instruction("phsubsw", ps_VpiWpi),        /* lo=7 */
    Instruction("psignb", ps_VpkWpk),         /* lo=8 */
    Instruction("psignw", ps_VpiWpi),         /* lo=9 */
    Instruction("psignd", ps_VpjWpj),         /* lo=A */
    Instruction("pmulhrsw", ps_VpiWpi),       /* lo=B */
    Instruction("", null),                      /* lo=C - invalid */
    Instruction("", null),                      /* lo=D - invalid */
    Instruction("", null),                      /* lo=E - invalid */
    Instruction("", null),                      /* lo=F - invalid */

];
/* 0F, 38, hi nibble = 2, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_2_66 = [
    Instruction("pmovsxbw", ps_VpiWpk),      /* lo=0 */
    Instruction("pmovsxbd", ps_VpjWpk),      /* lo=1 */
    Instruction("pmovsxbq", ps_VpqWpk),      /* lo=2 */
    Instruction("pmovsxwd", ps_VpjWpi),      /* lo=3 */
    Instruction("pmovsxwq", ps_VpqWpi),      /* lo=4 */
    Instruction("pmovsxdq", ps_VpqWpj),      /* lo=5 */
    Instruction("", null),                      /* lo=6 - invalid */
    Instruction("", null),                      /* lo=7 - invalid */
    Instruction("pmuldq", ps_VpqWpj),        /* lo=8 */
    Instruction("pcmpeqq", ps_VpqWpq),       /* lo=9 */
    Instruction("movntdqa", ps_VoMo),        /* lo=A */
    Instruction("packusdw", ps_VpiWpj),      /* lo=B */
    Instruction("", null),                      /* lo=C - invalid */
    Instruction("", null),                      /* lo=D - invalid */
    Instruction("", null),                      /* lo=E - invalid */
    Instruction("", null),                      /* lo=F - invalid */
];
/* 0F, 38, hi nibble = 3, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_3_66 = [
    Instruction("pmovzxbw", ps_VpiWpk),      /* lo=0 */
    Instruction("pmovzxbd", ps_VpjWpk),      /* lo=1 */
    Instruction("pmovzxbq", ps_VpqWpk),      /* lo=2 */
    Instruction("pmovzxwd", ps_VpjWpi),      /* lo=3 */
    Instruction("pmovzxwq", ps_VpqWpi),      /* lo=4 */
    Instruction("pmovzxdq", ps_VpqWpj),      /* lo=5 */
    Instruction("", null),                      /* lo=6 - invalid */
    Instruction("pcmpgtq", ps_VpqWpq),       /* lo=7 */
    Instruction("pminsb", ps_VpkWpk),        /* lo=8 */
    Instruction("pminsd", ps_VpjWpj),        /* lo=9 */
    Instruction("pminuw", ps_VpiWpi),        /* lo=A */
    Instruction("pminud", ps_VpjWpj),        /* lo=B */
    Instruction("pmaxsb", ps_VpkWpk),        /* lo=C */
    Instruction("pmaxsd", ps_VpjWpj),        /* lo=D */
    Instruction("pmaxuw", ps_VpiWpi),        /* lo=E */
    Instruction("pmaxud", ps_VpjWpj),        /* lo=F */
];
/* 0F, 3A, hi nibble = 0, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_3A_0_66 = [
    Instruction("", null),                      /* lo=0 - invalid */
    Instruction("", null),                      /* lo=1 - invalid */
    Instruction("", null),                      /* lo=2 - invalid */
    Instruction("", null),                      /* lo=3 - invalid */
    Instruction("", null),                      /* lo=4 - invalid */
    Instruction("", null),                      /* lo=5 - invalid */
    Instruction("", null),                      /* lo=6 - invalid */
    Instruction("", null),                      /* lo=7 - invalid */
    Instruction("roundps", ps_VpsWpsIb),     /* lo=8 */
    Instruction("roundpd", ps_VpdWpdIb),     /* lo=9 */
    Instruction("roundss", ps_VssWssIb),     /* lo=A */
    Instruction("roundsd", ps_VsdWsdIb),     /* lo=B */
    Instruction("blendps", ps_VpsWpsIb),     /* lo=C */
    Instruction("blendpd", ps_VpdWpdIb),     /* lo=D */
    Instruction("blenddw", ps_VpwWpwIb),     /* lo=E */
    Instruction("palignr", ps_VpbWpbIb),      /* lo=F */
];
