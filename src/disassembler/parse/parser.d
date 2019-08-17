module disassembler.parse.parser;

import disassembler.all;

final class Parser {
private:
    ByteReader bytes;
    uint codeBase;
    uint fromOffset;
    ubyte[] code;
    string[uint] labels;
public:
    Prefix prefix;
    Instruction instr;

    this(ubyte[] code, uint fromOffset, uint codeBase) {
        this.code        = code;
        this.codeBase    = codeBase;
        this.bytes       = new ByteReader(code);

        this.bytes.skip(fromOffset);
    }
    Instruction parse() {

        auto offset = cast(uint)bytes.position;

        parsePrefix(this);
        parseInstruction(this);

        instr.offset = offset + codeBase;
        instr.prefix = prefix;

        if(!instr.parseStrategy) assert(false, "Unable to decode - no ParseStrategy");

        instr.parseStrategy.parse(this);

        instr.bytes = code[offset..bytes.position].dup;

        return instr;
    }
    bool eof() {
        return bytes.eof();
    }
    ubyte readByte() {
        return bytes.read!ubyte;
    }
    ushort readWord() {
        return bytes.read!ushort;
    }
    uint readDword() {
        return bytes.read!uint;
    }
    ulong readQword() {
        return bytes.read!ulong;
    }
    /* Read 8,16,32 or 64 */
    ulong read(uint numBits) {
        switch(numBits) {
            case 8: return readByte();
            case 16: return readWord();
            case 32: return readDword();
            case 64: return readQword();
            default: assert(false);
        }
    }
    ubyte peekByte(int offset = 0) {
        return bytes.peek!ubyte(offset);
    }
    bool isAVX() {
        return prefix.hasVexBits;
    }
    void addJumpTarget(int ripOffset) {
        auto currentOffset = cast(int)(bytes.position+codeBase);

        auto targetOffset = cast(uint)(currentOffset + ripOffset);

        string label;
        auto labelPtr = targetOffset in labels;
        if(labelPtr) {
            label = *labelPtr;
        } else {
            label = "@%s".format(labels.length);
            labels[targetOffset] = label;
        }

        instr.targetLabel = label;
    }
    string[uint] getLabels() {
        return labels;
    }
private:
    char getSizePostfix() {
        switch(instr.getOperandSize()) {
            case 8: return 'b';
            case 16: return 'w';
            case 32: return 'd';
            case 64: return 'q';
            default: assert(false);
        }
    }
}