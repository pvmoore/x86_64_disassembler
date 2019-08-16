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

        // loop here

        int count = 0;
        //chat("################################################");

        while(!parser.eof()) {

            Instruction instr = parser.parse();
            instructions ~= instr;

            count++;

            //chat("################################################");
            if(count==169) break;
        }

        return instructions;
    }
}