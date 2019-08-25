module disassembler.parse.parse_avx_groups;

import disassembler.all;

void avxGroup12(Parser p, ref AVX avx, ModRM modrm) {
    if(avx.pp==1) {
        switch(modrm.reg) {
            case 0b010: p.instr.copy(Instruction("vpsrlw", ps_HpwxUpwxIb)); break;
            case 0b100: p.instr.copy(Instruction("vpsraw", ps_HpwxUpwxIb)); break;
            case 0b110: p.instr.copy(Instruction("vpsllw", ps_HpwxUpwxIb)); break;
            default: break;
        }
    }
}
void avxGroup13(Parser p, ref AVX avx, ModRM modrm) {
    if(avx.pp==1) {
        switch(modrm.reg) {
            case 0b010: p.instr.copy(Instruction("vpsrld", ps_HpdwxUpdwxIb)); break;
            case 0b100: p.instr.copy(Instruction("vpsrad", ps_HpdwxUpdwxIb)); break;
            case 0b110: p.instr.copy(Instruction("vpslld", ps_HpdwxUpdwxIb)); break;
            default: break;
        }
    }
}
void avxGroup14(Parser p, ref AVX avx, ModRM modrm) {
    if(avx.pp==1) {
        switch(modrm.reg) {
            case 0b010: p.instr.copy(Instruction("vpsrlq", ps_HpqwxUpqwxIb)); break;
            case 0b011: p.instr.copy(Instruction("vpsrldq", ps_HpbxUpbxIb)); break;
            case 0b110: p.instr.copy(Instruction("vpsllq", ps_HpqwxUpqwxIb)); break;
            case 0b111: p.instr.copy(Instruction("vpslldq", ps_HpbxUpbxIb)); break;
            default: break;
        }
    }
}
void avxGroup15(Parser p, ref AVX avx, ModRM modrm) {
    if(avx.pp==0) {
        switch(modrm.reg) {
            case 0b010: p.instr.copy(Instruction("vldmxcsr", ps_Md)); break;
            case 0b011: p.instr.copy(Instruction("vstmxcsr", ps_Md)); break;
            default: break;
        }
    }
}
void avxGroup17(Parser p, ref AVX avx, ModRM modrm) {
    if(avx.pp==0) {
        switch(modrm.reg) {
            case 0b001: p.instr.copy(Instruction("blsr", ps_ByEy)); break;
            case 0b010: p.instr.copy(Instruction("blsmsk", ps_ByEy)); break;
            case 0b011: p.instr.copy(Instruction("blsi", ps_ByEy)); break;
            default: break;
        }
    }
}

private:

__gshared {
/* row 1 */
Instruction[] INSTRUCTIONS_groupX_pp0 = [
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