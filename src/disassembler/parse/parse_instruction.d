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
                parseThreeByteOpcode(p, opcode, opcode2);
                break;
            }
            parseTwoByteOpcode(p, opcode, opcode2);
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
            parseOneByteOpcode(p, opcode);
            break;
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

    auto instr = Instruction("nop (%s bytes)".format(num), ps_none, IS.STD);
    p.instr.copy(instr);
}


