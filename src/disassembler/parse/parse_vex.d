module disassembler.parse.parse_vex;

import disassembler.all;
/*
    R: Inverted one-bit extension of ModRM reg field
    X: Inverted one-bit extension of SIB index field
    B: Inverted one-bit extension, r/m field or SIB base field
    W: Default operand size override for a general purpose register to 64-bit size in 64-bit mode;
       operand configuration specifier for certain YMM/XMM-based operations.

    mapSelect: Opcode map select

        map 1 - Same as used by 2-byte vex
        map 2 - 0f_38 3-byte map
        map 3 - 0F 3A 3-byte opcode map

    vvvv: Source or destination register selector, in ones’ complement format
          Typically used to encode the 1st src operand, but dest for VPSLLDQ,
          VPSRLDQ, VPSRLW, VPSRLD, VPSRLQ, VPSRAW, VPSRAD, VPSLLW, VPSLLD, and VPSLLQ

        0: XMM15/YMM15      8: XMM7/YMM7
        1: XMM14/YMM14      9: XMM6/YMM6
        2: XMM13/YMM13     10: XMM5/YMM5
        3: XMM12/YMM12     11: XMM4/YMM4
        4: XMM11/YMM11     12: XMM3/YMM3
        5: XMM10/YMM10     13: XMM2/YMM2
        6: XMM9/YMM9       14: XMM1/YMM1
        7: XMM8/YMM8       15: XMM0/YMM0

    L: Vector length specifier

        0 = 128-bit, 1 = 256-bit (ignored for scalar operands)

    pp: Implied 66, F2, or F3 opcode extension

        0=none, 1=66, 2=F3, 3=F2
*/
private struct AVX {
    const uint R;
    const uint X;
    const uint B;
    const uint W;
    const uint L;
    const uint pp;
    const uint vvvv;
    const uint map;

    this(uint byte1) {
        R    = (byte1 >>> 7) & 1;
        X    = 1;
        B    = 1;
        map  = 1;
        W    = 0;
        vvvv = (byte1 >>> 3) & 0b1111;
        L    = (byte1 >>> 2) & 1;
        pp   = byte1 & 0b11;
    }
    this(uint byte1, uint byte2) {
        R    = (byte1 >>> 7) & 1;
        X    = (byte1 >>> 6) & 1;
        B    = (byte1 >>> 5) & 1;
        map  = byte1 & 0b11111;
        W    = (byte2 >>> 7) & 1;
        vvvv = (byte2 >>> 3) & 0b1111;
        L    = (byte2 >>> 2) & 1;
        pp   = byte2 & 0b11;

        assert(map.isOneOf(1, 2, 3));   // all other maps are reserved
    }
}
void parseVex2Byte(Parser p, uint byte1) {

    auto v = AVX(byte1);



    todo();
}
void parseVex3Byte(Parser p, uint byte1) {
    uint byte2 = p.readByte();

    auto v = AVX(byte1, byte2);



    todo();
}
void page1(Parser p, ref AVX avx) {

}
void page2(Parser p, ref AVX avx) {

}
void page3(Parser p, ref AVX avx) {

}