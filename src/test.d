module test;

import test_suite;
import std.stdio;
import resources;

import disassembler;
import disassembler.util;

void main(string[] args) {
    writefln("Testing...");

    auto filename = "test/test.exe";

    auto pe = new PE(filename);

    auto code = pe.getCode();
    writefln("code = %s", code.length);

    auto dis = new Disassembler();

    //auto instructions = dis.processAll(code[76880..$]);
    auto instructions = dis.processAll(code, 4096, pe.getCodeBase());

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

        movhlps XMM1, XMM2;



        pop RAX;
    }
}