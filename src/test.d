module test;

import test_suite;
import std.stdio;
import resources;

import disassembler;
import disassembler.util;

void main(string[] args) {
    writefln("Testing...");

    //auto filename = "test/test.exe";
    auto filename = "test/test1.exe";

    auto pe = new PE(filename);

    auto code = pe.getCode();
    writefln("code = %s", code.length);

    auto dis = new Disassembler();


    auto entry = pe.getEntryPoint() - pe.getCodeBase();
    auto instructions = dis.processAll(code, 0, pe.getCodeBase());

    writefln("Instructions:");
    foreach(i; instructions) {
        //writefln("%s", i);
    }
    writefln("Add to the test suite:\n");
    foreach(i; instructions) {
        checkTestSuite(i);
    }

    auto page = new HTMLOutput(filename, "out.html");
    page.add(instructions);
    page.render();

    writefln("Finished");



    testing();
}

align(16)
__gshared ulong mem, mem2;

void testing() {
    asm {
        push RAX;

        lea RAX, mem;
        vmovups XMM3, [RAX];
        vmovups YMM3, [RAX];

        pop RAX;
    }
}