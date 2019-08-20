module disassembler.parse.parse_prefix;

import disassembler.all;

/**
 *  Up to 4 prefix bytes are possible.
 */
void parsePrefix(Parser p) {

    p.prefix = Prefix.init;

    while(true) {
        auto b = p.peekByte();

        switch(b) {
            /* Segment overrides - ignored in 64 bit mode */
            case 0x26 : p.prefix.segreg = Reg.ES; break;
            case 0x2E : p.prefix.segreg = Reg.CS; p.prefix.branch = Prefix.Branch.DONTTAKE; break;
            case 0x36 : p.prefix.segreg = Reg.SS; break;
            case 0x3E : p.prefix.segreg = Reg.DS; p.prefix.branch = Prefix.Branch.TAKE; break;

            /* REX */
            case 0x40:..case 0x4F:
                p.prefix.hasRexBits = true;
                p.prefix.rexBits    = b-0x40;
                break;

            case 0x64:
                p.prefix.segreg = Reg.FS;
                break;
            case 0x65:
                p.prefix.segreg = Reg.GS;
                break;

            case 0x66:
                // switch to 16 bit mode
                p.prefix.opSize = true;
                break;
            case 0x67:
                // switch to 32 bit addressing in x64 mode
                p.prefix.addrSize = true;
                break;

            /* XOP */
            case 0x8E:
                p.prefix.hasXopBits = true;
                break;

            /* VEX */
            case 0xC4:  // 3 byte vex escape prefix
            case 0xC5:  // 2 byte vex escape prefix
                p.prefix.hasVexBits = true;
                p.prefix.vexBits    = b-0xc4;
                break;

            case 0xF0:
                p.prefix.lock = true;
                break;
            case 0xF2:
                p.prefix.repne = true;
                break;
            case 0xF3:
                p.prefix.rep = true;
                break;

            default:
                return;
        }

        /* Consume the byte */
        p.prefix.bytes ~= p.readByte();

        /* Stop after we find a VEX prefix */
        if(p.prefix.hasVexBits) return;
    }
    assert(false);
}