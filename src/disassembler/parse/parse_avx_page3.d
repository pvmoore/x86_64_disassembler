module disassembler.parse.parse_avx_page3;

import disassembler.all;

void parseAVXPage3(Parser p, ref AVX avx) {
    // page 529

    p.instr.avx = avx;
}

private:

__gshared {
/* row 1 */
Instruction[] INSTRUCTIONS_page3_row1_pp0 = [
    // Instruction("", null),                       /* lo=0 */
    // Instruction("", null),                       /* lo=1 */
    // Instruction("", null),                       /* lo=2 */
    // Instruction("", null),                       /* lo=3 */
    // Instruction("", null),                       /* lo=4 */
    // Instruction("", null),                       /* lo=5 */
    // Instruction("", null),                       /* lo=6 */
    // Instruction("", null),                       /* lo=7 */

    // Instruction("", null),                       /* lo=8 */
    // Instruction("", null),                       /* lo=9 */
    // Instruction("", null),                       /* lo=A */
    // Instruction("", null),                       /* lo=B */
    // Instruction("", null),                       /* lo=C */
    // Instruction("", null),                       /* lo=D */
    // Instruction("", null),                       /* lo=E */
    // Instruction("", null),                       /* lo=F */
];

}   // __gshared