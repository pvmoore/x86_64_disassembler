module unittests;

import disassembler;
import disassembler.util;
import disassembler.operand;
import test_suite;
import std.stdio;

unittest {
    doTests();
}

void doTests() {
    writefln("Unit testing ...");

    auto dis = new Disassembler();

    foreach(i, t; TESTS) {

        if(t.code.length==0) continue;

        auto inst = dis.processOne(cast(ubyte[])t.code, 0);

        auto actual = inst.getMnemonicAndOperandsString(Operand.Fmt.CANONICAL);

        if(t.expected != actual) {
            writefln("FAIL - Test %s: expected '%s' got '%s'", i, t.expected, actual);
            writefln("code: %s", formatHexBytes(t.code));
            throw new Error("FAIL");
        }

        writefln("[%s] %s %s", i, formatHexBytes(t.code), actual);
    }

    writefln("\nAll unit tests passed OK");
}