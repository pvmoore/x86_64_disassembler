module disassembler.instructions.threebytes;

import disassembler.all;

/* 0F, 38, hi nibble = 0, no prefix */
__gshared Instruction[] INSTRUCTIONS_0F_38_0 = [
    Instruction("pshufb", ps_PpbQpb, 0, IS.SSSE3),      /* lo=0 */
    Instruction("phaddw", ps_PpiQpi, 0, IS.SSSE3),      /* lo=1 */
    Instruction("phaddd", ps_PpjQpj, 0, IS.SSSE3),      /* lo=2 */
    Instruction("phaddsw", ps_PpiQpi, 0, IS.SSSE3),     /* lo=3 */
    Instruction("pmaddubsw", ps_PpkQpk, 0, IS.SSSE3),   /* lo=4 */
    Instruction("phsubw", ps_PpiQpi, 0, IS.SSSE3),      /* lo=5 */
    Instruction("phsubd", ps_PpjQpj, 0, IS.SSSE3),      /* lo=6 */
    Instruction("phsubsw", ps_PpiQpi, 0, IS.SSSE3),     /* lo=7 */
    Instruction("psignb", ps_PpkQpk, 0, IS.SSSE3),      /* lo=8 */
    Instruction("psignw", ps_PpiQpi, 0, IS.SSSE3),      /* lo=9 */
    Instruction("psignd", ps_PpjQpj, 0, IS.SSSE3),      /* lo=A */
    Instruction("pmulhrsw", ps_PpiQpi, 0, IS.SSSE3),    /* lo=B */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */
];
/* 0F, 38, hi nibble = 0, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_0_66 = [
    Instruction("pshufb", ps_VpbWpb, 0, IS.SSSE3),      /* lo=0 */
    Instruction("phaddw", ps_VpiWpi, 0, IS.SSSE3),      /* lo=1 */
    Instruction("phaddd", ps_VpjWpj, 0, IS.SSSE3),      /* lo=2 */
    Instruction("phaddsw", ps_VpiWpi, 0, IS.SSSE3),     /* lo=3 */
    Instruction("pmaddubsw", ps_VpkWpk, 0, IS.SSSE3),   /* lo=4 */
    Instruction("phsubw", ps_VpiWpi, 0, IS.SSSE3),      /* lo=5 */
    Instruction("phsubd", ps_VpjWpj, 0, IS.SSSE3),      /* lo=6 */
    Instruction("phsubsw", ps_VpiWpi, 0, IS.SSSE3),     /* lo=7 */
    Instruction("psignb", ps_VpkWpk, 0, IS.SSSE3),      /* lo=8 */
    Instruction("psignw", ps_VpiWpi, 0, IS.SSSE3),      /* lo=9 */
    Instruction("psignd", ps_VpjWpj, 0, IS.SSSE3),      /* lo=A */
    Instruction("pmulhrsw", ps_VpiWpi, 0, IS.SSSE3),    /* lo=B */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */

];
/* 0F, 38, hi nibble = 2, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_2_66 = [
    Instruction("pmovsxbw", ps_VpiWpk, 0, IS.SSE4_1),   /* lo=0 */
    Instruction("pmovsxbd", ps_VpjWpk, 0, IS.SSE4_1),   /* lo=1 */
    Instruction("pmovsxbq", ps_VpqWpk, 0, IS.SSE4_1),   /* lo=2 */
    Instruction("pmovsxwd", ps_VpjWpi, 0, IS.SSE4_1),   /* lo=3 */
    Instruction("pmovsxwq", ps_VpqWpi, 0, IS.SSE4_1),   /* lo=4 */
    Instruction("pmovsxdq", ps_VpqWpj, 0, IS.SSE4_1),   /* lo=5 */
    Instruction("", null),                              /* lo=6 - invalid */
    Instruction("", null),                              /* lo=7 - invalid */
    Instruction("pmuldq", ps_VpqWpj, 0, IS.SSE4_1),     /* lo=8 */
    Instruction("pcmpeqq", ps_VpqWpq, 0, IS.SSE4_1),    /* lo=9 */
    Instruction("movntdqa", ps_VoMo, 0, IS.SSE4_1),     /* lo=A */
    Instruction("packusdw", ps_VpiWpj, 0, IS.SSE4_1),   /* lo=B */
    Instruction("", null),                              /* lo=C - invalid */
    Instruction("", null),                              /* lo=D - invalid */
    Instruction("", null),                              /* lo=E - invalid */
    Instruction("", null),                              /* lo=F - invalid */
];
/* 0F, 38, hi nibble = 3, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_38_3_66 = [
    Instruction("pmovzxbw", ps_VpiWpk, 0, IS.SSE4_1),   /* lo=0 */
    Instruction("pmovzxbd", ps_VpjWpk, 0, IS.SSE4_1),   /* lo=1 */
    Instruction("pmovzxbq", ps_VpqWpk, 0, IS.SSE4_1),   /* lo=2 */
    Instruction("pmovzxwd", ps_VpjWpi, 0, IS.SSE4_1),   /* lo=3 */
    Instruction("pmovzxwq", ps_VpqWpi, 0, IS.SSE4_1),   /* lo=4 */
    Instruction("pmovzxdq", ps_VpqWpj, 0, IS.SSE4_1),   /* lo=5 */
    Instruction("", null),                              /* lo=6 - invalid */
    Instruction("pcmpgtq", ps_VpqWpq, 0, IS.SSE4_2),    /* lo=7 */
    Instruction("pminsb", ps_VpkWpk, 0, IS.SSE4_1),     /* lo=8 */
    Instruction("pminsd", ps_VpjWpj, 0, IS.SSE4_1),     /* lo=9 */
    Instruction("pminuw", ps_VpiWpi, 0, IS.SSE4_1),     /* lo=A */
    Instruction("pminud", ps_VpjWpj, 0, IS.SSE4_1),     /* lo=B */
    Instruction("pmaxsb", ps_VpkWpk, 0, IS.SSE4_1),     /* lo=C */
    Instruction("pmaxsd", ps_VpjWpj, 0, IS.SSE4_1),     /* lo=D */
    Instruction("pmaxuw", ps_VpiWpi, 0, IS.SSE4_1),     /* lo=E */
    Instruction("pmaxud", ps_VpjWpj, 0, IS.SSE4_1),     /* lo=F */
];
/* 0F, 3A, hi nibble = 0, prefix = 0x66 */
__gshared Instruction[] INSTRUCTIONS_0F_3A_0_66 = [
    Instruction("", null),                              /* lo=0 - invalid */
    Instruction("", null),                              /* lo=1 - invalid */
    Instruction("", null),                              /* lo=2 - invalid */
    Instruction("", null),                              /* lo=3 - invalid */
    Instruction("", null),                              /* lo=4 - invalid */
    Instruction("", null),                              /* lo=5 - invalid */
    Instruction("", null),                              /* lo=6 - invalid */
    Instruction("", null),                              /* lo=7 - invalid */
    Instruction("roundps", ps_VpsWpsIb, 0, IS.SSE4_1),  /* lo=8 */
    Instruction("roundpd", ps_VpdWpdIb, 0, IS.SSE4_1),  /* lo=9 */
    Instruction("roundss", ps_VssWssIb, 0, IS.SSE4_1),  /* lo=A */
    Instruction("roundsd", ps_VsdWsdIb, 0, IS.SSE4_1),  /* lo=B */
    Instruction("blendps", ps_VpsWpsIb, 0, IS.SSE4_1),  /* lo=C */
    Instruction("blendpd", ps_VpdWpdIb, 0, IS.SSE4_1),  /* lo=D */
    Instruction("blenddw", ps_VpwWpwIb, 0, IS.SSE4_1),  /* lo=E */
    Instruction("palignr", ps_VpbWpbIb, 0, IS.SSSE3),   /* lo=F */
];
    // Instruction("", null),                          /* lo=0 */
    // Instruction("", null),                          /* lo=1 */
    // Instruction("", null),                          /* lo=2 */
    // Instruction("", null),                          /* lo=3 */
    // Instruction("", null),                          /* lo=4 */
    // Instruction("", null),                          /* lo=5 */
    // Instruction("", null),                          /* lo=6 */
    // Instruction("", null),                          /* lo=7 */
    // Instruction("", null),                          /* lo=8 */
    // Instruction("", null),                          /* lo=9 */
    // Instruction("", null),                          /* lo=A */
    // Instruction("", null),                          /* lo=B */
    // Instruction("", null),                          /* lo=C */
    // Instruction("", null),                          /* lo=D */
    // Instruction("", null),                          /* lo=E */
    // Instruction("", null),                          /* lo=F */