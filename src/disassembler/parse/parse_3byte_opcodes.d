module disassembler.parse.parse_3byte_opcodes;

import disassembler.all;

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