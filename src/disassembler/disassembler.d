module disassembler.disassembler;

import disassembler.all;

final class Disassembler {
private:
    Instruction[] instructions;
public:
    this() {

    }
    Instruction processOne(ubyte[] bytes, uint codeBase) {
        auto parser = new Parser(bytes, 0, codeBase);
        return parser.parse();
    }
    Instruction[] processAll(ubyte[] bytes, uint fromOffset, uint codeBase) {

        auto parser = new Parser(bytes, fromOffset, codeBase);

        int count = 0;

        while(!parser.eof()) {

            Instruction instr = parser.parse();
            instructions ~= instr;

            count++;

            chat("%s", instr);

            if(count==440) break;
        }

        /* Set labels */
        auto labels = parser.getLabels();
        foreach(ref i; instructions) {
            auto offset = i.offset;

            if(labels.containsKey(offset)) {
                i.label = labels[offset];
            }
        }

        return instructions;
    }
}