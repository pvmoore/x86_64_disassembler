module disassembler.parse.parse_avx_page3;

import disassembler.all;

void parseAVXPage3(Parser p, ref AVX avx) {
    // page 529

    uint op     = p.readByte();
    auto hi     = cast(Nibble)((op >>> 4) & 0b1111);
    auto lo     = cast(Nibble)(op & 0b1111);
    auto modrm  = ModRM(p.peekByte());

    //chat("PAGE3 %s pp=%s vvvv=%s hi=%s lo=%s", modrm, avx.pp, avx.vvvv, hi, lo);

    final switch(hi) with(Nibble) {
        case _00:
            if(avx.pp==1) {
                p.instr.copy(INSTRUCTIONS_page3_row0_pp1[lo]);
            }
            break;
        case _01:
        case _02:
        case _03:
        case _04:
        case _05:
        case _06:
        case _07:
        case _08:
        case _09:
        case _0A:
        case _0B:
        case _0C:
        case _0D:
        case _0E:
        case _0F:
            break;
    }
    p.instr.avx = avx;
}

private:

__gshared {
/* row 0 */
Instruction[] INSTRUCTIONS_page3_row0_pp1 = [
    Instruction("vpermq", ps_VqWqIb, IS.AVX2, Hint.PTR_SIZE_W), /* lo=0 */
    Instruction("vpermpd", ps_VpdWpdIb, IS.AVX),                /* lo=1 */
    Instruction("vpblendd", ps_VpdwxHpdwxWpdwxIb, IS.AVX),      /* lo=2 */
    Instruction("", null, IS.AVX),                              /* lo=3 - invalid */
    Instruction("vpermilps", ps_VpsxWpsxIb, IS.AVX),            /* lo=4 */
    Instruction("vpermilpd", ps_VpdxWpdxIb, IS.AVX),            /* lo=5 */
    Instruction("vperm2f128", ps_VdoHoWoIb, IS.AVX),            /* lo=6 */
    Instruction("", null, IS.AVX),                              /* lo=7 - invalid */

    Instruction("vroundps", ps_VpsxWpsxIb, IS.AVX),             /* lo=8 */
    Instruction("vroundpd", ps_VpdxWpdxIb, IS.AVX),             /* lo=9 */
    Instruction("vroundss", ps_VssHssWssIb, IS.AVX),            /* lo=A */
    Instruction("vroundsd", ps_VsdHsdWsdIb, IS.AVX),            /* lo=B */
    Instruction("vblendps", ps_VpsxHpsxWpsxIb, IS.AVX),         /* lo=C */
    Instruction("vblendpd", ps_VpdxHpdxWpdxIb, IS.AVX),         /* lo=D */
    Instruction("vpblendw", ps_VpwxHpwxWpwxIb, IS.AVX),         /* lo=E */
    Instruction("vpalignr", ps_VpbxHpbxWpbxIb, IS.AVX),         /* lo=F */
];

    // Instruction("", null, 0, IS.AVX),                       /* lo=0 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=1 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=2 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=3 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=4 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=5 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=6 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=7 */

    // Instruction("", null, 0, IS.AVX),                       /* lo=8 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=9 */
    // Instruction("", null, 0, IS.AVX),                       /* lo=A */
    // Instruction("", null, 0, IS.AVX),                       /* lo=B */
    // Instruction("", null, 0, IS.AVX),                       /* lo=C */
    // Instruction("", null, 0, IS.AVX),                       /* lo=D */
    // Instruction("", null, 0, IS.AVX),                       /* lo=E */
    // Instruction("", null, 0, IS.AVX),                       /* lo=F */

}   // __gshared