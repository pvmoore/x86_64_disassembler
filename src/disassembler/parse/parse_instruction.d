module disassembler.parse.parse_instruction;

import disassembler.all;

void parseInstruction(Parser p) {
    uint opcode = p.readByte();

    switch(opcode) {
        case 0x0F:
            uint opcode2 = p.readByte();
            if(opcode2==0x1F) {
                multibyteNop(p);
                break;
            }
            if(opcode2==0x38 || opcode2==0x3A) {
                threeByteOpcode(p, opcode, opcode2);
                break;
            }
            twoByteOpcode(p, opcode, opcode2);
            break;
        case 0x80:
        case 0x81:
        case 0x82:
        case 0x83:
            group1(p, opcode);
            break;
        case 0x8F:
            group1a(p);
            break;
        case 0xC0:
        case 0xC1:
            group2(p, opcode);
            break;
        case 0xC6:
        case 0xC7:
            group11(p, opcode);
            break;
        case 0xD0:
        case 0xD1:
        case 0xD2:
        case 0xD3:
            group2(p, opcode);
            break;
        case 0xD8:
        case 0xD9:
        case 0xDA:
        case 0xDB:
        case 0xDC:
        case 0xDD:
        case 0xDE:
        case 0xDF:
            fpuEsc(p, opcode);
            break;
        case 0xF6:
        case 0xF7:
            group3(p, opcode);
            break;
        case 0xFE:
            group4(p);
            break;
        case 0xFF:
            group5(p);
            break;
        default:
            oneByteOpcode(p, opcode);
            break;
    }
}
void oneByteOpcode(Parser p, uint byte1) {
    if(INSTRUCTIONS.length>byte1) {
        p.instr.copy(INSTRUCTIONS[byte1]);
    }
    else assert(false);
}
void twoByteOpcode(Parser p, uint byte1, uint byte2) {

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
                    _3dnow(p, loNibble);
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
                p.instr.copy(Instruction("cmpss", ps_VssWssIb));
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
void threeByteOpcode(Parser p, uint byte1, uint byte2) {
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
                        case 0x0: p.instr.copy(Instruction("pblendvb", ps_VpbWpb, 0, IS.SSE4_1)); break;
                        case 0x4: p.instr.copy(Instruction("blendvps", ps_VpsWps, 0, IS.SSE4_1)); break;
                        case 0x5: p.instr.copy(Instruction("blendvpd", ps_VpbWpb, 0, IS.SSE4_1)); break;
                        case 0x7: p.instr.copy(Instruction("ptest", ps_VoWo, 0, IS.SSE4_1)); break;
                        case 0xC: p.instr.copy(Instruction("pabsb", ps_VpkWpk, 0, IS.SSSE3)); break;
                        case 0xD: p.instr.copy(Instruction("pabsw", ps_VpiWpi, 0, IS.SSSE3)); break;
                        case 0xE: p.instr.copy(Instruction("pabsd", ps_VpjWpj, 0, IS.SSSE3)); break;
                        default: break;
                    }
                } else {
                    switch(loNibble) {
                        case 0xC: p.instr.copy(Instruction("pabsb", ps_PpkQpk, 0, IS.SSSE3)); break;
                        case 0xD: p.instr.copy(Instruction("pabsw", ps_PpiQpi, 0, IS.SSSE3)); break;
                        case 0xE: p.instr.copy(Instruction("pabsd", ps_PpjQpj, 0, IS.SSSE3)); break;
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
                    if(loNibble==0) p.instr.copy(Instruction("pmulld", ps_VpjWpj, 0, IS.SSE4_1));
                    else if(loNibble==1) p.instr.copy(Instruction("phminposuw", ps_VpiWpi, 0, IS.SSE4_1));
                }
                break;
            case 0xC:
                switch(loNibble) {
                    case 0x8: p.instr.copy(Instruction("sha1nexte", ps_VoWo, 0, IS.SHA)); break;
                    case 0x9: p.instr.copy(Instruction("sha1msg1", ps_VoWo, 0, IS.SHA)); break;
                    case 0xA: p.instr.copy(Instruction("sha1msg2", ps_VoWo, 0, IS.SHA)); break;
                    case 0xB: p.instr.copy(Instruction("sha256rnds2", ps_VoWo, 0, IS.SHA)); break;
                    case 0xC: p.instr.copy(Instruction("sha256msg1", ps_VoWo, 0, IS.SHA)); break;
                    case 0xD: p.instr.copy(Instruction("sha256msg2", ps_VoWo, 0, IS.SHA)); break;
                    default: break;
                }
                break;
            case 0xD:
                if(p.prefix.opSize) {
                    switch(loNibble) {
                        case 0xB: p.instr.copy(Instruction("aesimc", ps_VoWo, 0, IS.AES)); break;
                        case 0xC: p.instr.copy(Instruction("aesenc", ps_VoWo, 0, IS.AES)); break;
                        case 0xD: p.instr.copy(Instruction("aesenclast", ps_VoWo, 0, IS.AES)); break;
                        case 0xE: p.instr.copy(Instruction("aesdec", ps_VoWo, 0, IS.AES)); break;
                        case 0xF: p.instr.copy(Instruction("aesdeclast", ps_VoWo, 0, IS.AES)); break;
                        default: break;
                    }
                }
                break;
            case 0xF:
                if(p.prefix.repne) { /* F2 */
                    if(loNibble==0)
                        p.instr.copy(Instruction("crc32", ps_GyEb, 0, IS.SSE4_2));
                    else if(loNibble==1)
                        p.instr.copy(Instruction("crc32", ps_GyEv, 0, IS.SSE4_2));
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
                    if(loNibble==0xF) p.instr.copy(Instruction("palignr", ps_PpbQpbIb, 0, IS.SSSE3));
                }
                break;
            case 0x1:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        /**** NOTE: These have an alternative but I am not sure how they are encoded */
                        case 4: p.instr.copy(Instruction("pextrb", ps_MbVpkIb, 0, IS.SSE4_1)); break;
                        case 5: p.instr.copy(Instruction("pextrw", ps_MwVpwIb, 0, IS.SSE4_1)); break;
                        case 6:
                            if(p.prefix.rexW())
                                p.instr.copy(Instruction("pextrq", ps_EqVpqIb, 0, IS.SSE4_1));
                            else
                                p.instr.copy(Instruction("pextrd", ps_EdVpjIb, 0, IS.SSE4_1));
                            break;
                        case 7: p.instr.copy(Instruction("extractps", ps_MdVpsIb, 0, IS.SSE4_1)); break;

                        default: break;
                    }
                }
                break;
            case 0x2:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("pinsrb", ps_VpkMbIb, 0, IS.SSE4_1)); break;
                        case 1: p.instr.copy(Instruction("insertps", ps_VpsMdIb, 0, IS.SSE4_1)); break;
                        case 2:
                            if(p.prefix.rexW())
                                p.instr.copy(Instruction("pinsrq", ps_VpqEqIb, 0, IS.SSE4_1));
                            else
                                p.instr.copy(Instruction("pinsrd", ps_VpjEdIb, 0, IS.SSE4_1));
                            break;
                        default: break;
                    }
                }
                break;
            case 0x4:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("dpps", ps_VpsWpsIb, 0, IS.SSE4_1)); break;
                        case 1: p.instr.copy(Instruction("dppd", ps_VpdWpdIb, 0, IS.SSE4_1)); break;
                        case 2: p.instr.copy(Instruction("mpsadbw", ps_VpkWpkIb, 0, IS.SSE4_1)); break;
                        case 4: p.instr.copy(Instruction("pclmulqdq", ps_VpqWpqIb, 0, IS.CLMUL)); break;
                        default: break;
                    }
                }
                break;
            case 0x6:
                if(p.prefix.opSize) {/* 66 */
                    switch(loNibble) {
                        case 0: p.instr.copy(Instruction("pcmpestrm", ps_VoWoIb, 0, IS.SSE4_2)); break;
                        case 1: p.instr.copy(Instruction("pcmpestri", ps_VoWoIb, 0, IS.SSE4_2)); break;
                        case 2: p.instr.copy(Instruction("pcmpistrm", ps_VoWoIb, 0, IS.SSE4_2)); break;
                        case 3: p.instr.copy(Instruction("pcmpistri", ps_VoWoIb, 0, IS.SSE4_2)); break;
                        default: break;
                    }
                }
                break;
            case 0xC:
                if(loNibble==0xC) p.instr.copy(Instruction("sha1rnds4", ps_VoWoIb, 0, IS.SHA));
                break;
            case 0xD:
                if(p.prefix.opSize) {/* 66 */
                    if(loNibble==0xF) p.instr.copy(Instruction("aeskeygenassist", ps_VoWoIb, 0, IS.AES));
                }
                break;
            default: break;
        }
    }
}
void multibyteNop(Parser p) {
    /* If we get here, the last 2 bytes read must have been 0x0F, 0x1F */

    /* Recommended multibyte nops:
        1  - 0x90
        2  - 0x66, 0x90
        3  -                   0x0F, 0x1F, 0x00
        4  -                   0x0F, 0x1F, 0x40, 0x00
        5  -                   0x0F, 0x1F, 0x44, 0x00, 0x00
        6  -             0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00
        7  -                   0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00
        8  -                   0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
        9  -             0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
        10 -       0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
        11 - 0x66, 0x66, 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
    */

    auto num = 2 + p.prefix.bytes.length;

    switch(p.peekByte(0)) {
        case 0x00:
            p.readByte();
            num++;
            break;
        case 0x40:
            p.readWord();
            num+=2;
            break;
        case 0x44:
            p.readByte();
            p.readWord();
            num+=3;
            break;
        case 0x80:
            p.readByte();
            p.readDword();
            num += 5;
            break;
        case 0x84:
            p.readWord();
            p.readDword();
            num += 6;
            break;
        default:
            // shouldn't get here
            break;
    }

    auto instr = Instruction("nop (%s bytes)".format(num), ps_none);
    p.instr.copy(instr);
}
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
            case 2: p.instr.copy(Instruction("ldmxcsr", ps_Md)); break;
            case 3: p.instr.copy(Instruction("stmxcsr", ps_Md)); break;
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
                if(modrm.mod==0b11) p.instr.copy(Instruction("sfence", ps_none));
                else                p.instr.copy(Instruction("clflush", ps_Mb));
                break;
            default: break;
        }
    }
}
void group16(Parser p) {
    auto modrm = ModRM(p.peekByte());
    switch(modrm.reg) {
        case 0: p.instr.copy(Instruction("prefetchnta", ps_M)); break;
        case 1: p.instr.copy(Instruction("prefetcht0", ps_M)); break;
        case 2: p.instr.copy(Instruction("prefetcht1", ps_M)); break;
        case 3: p.instr.copy(Instruction("prefetcht2", ps_M)); break;
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
void _3dnow(Parser p, uint loNibble) {
    switch(loNibble) {
        case 0xD:
        case 0xE:
        case 0xF:
            break;
        default: break;
    }
    todo();
}
void fpuEsc(Parser p, uint byte1) {
    // fpu page 515
}