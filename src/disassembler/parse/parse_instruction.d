module disassembler.parse.parse_instruction;

import disassembler.all;

void parseInstruction(Parser p) {
    uint opcode = p.readByte();

    if(p.prefix.vex2Byte()) {
        parseVex2Byte(p, opcode);
        return;
    } else if(p.prefix.vex3Byte()) {
        parseVex3Byte(p, opcode);
        return;
    }

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
