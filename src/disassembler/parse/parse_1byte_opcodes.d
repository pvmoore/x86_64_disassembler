module disassembler.parse.parse_1byte_opcodes;

import disassembler.all;

void parseOneByteOpcode(Parser p, uint byte1) {
    if(INSTRUCTIONS.length>byte1) {
        p.instr.copy(INSTRUCTIONS[byte1]);
    }
    else assert(false);
}

__gshared Instruction[] INSTRUCTIONS = [
    Instruction("add", ps_EbGb),        /* 00 */
    Instruction("add", ps_EvGv),        /* 01 */
    Instruction("add", ps_GbEb),        /* 02 */
    Instruction("add", ps_GvEv),        /* 03 */
    Instruction("add", ps_ALIb),        /* 04 */
    Instruction("add", ps_rAXIz),       /* 05 */
    Instruction("", null),              /* 06 - invalid in 64 bit mode */
    Instruction("", null),              /* 07 - invalid in 64 bit mode */
    Instruction("or", ps_EbGb),         /* 08 */
    Instruction("or", ps_EvGv),         /* 09 */
    Instruction("or", ps_GbEb),         /* 0A */
    Instruction("or", ps_GvEv),         /* 0B */
    Instruction("or", ps_ALIb),         /* 0C */
    Instruction("or", ps_rAXIz),        /* 0D */
    Instruction("", null),              /* 0E - invalid in 64 bit mode */

    Instruction("", null),              /* 0F - indicates 2 byte opcode */

    Instruction("adc", ps_EbGb),        /* 10 */
    Instruction("adc", ps_EvGv),        /* 11 */
    Instruction("adc", ps_GbEb),        /* 12 */
    Instruction("adc", ps_GvEv),        /* 13 */
    Instruction("adc", ps_ALIb),        /* 14 */
    Instruction("adc", ps_rAXIz),       /* 15 */
    Instruction("", null),              /* 16 - invalid in 64 bit mode */
    Instruction("", null),              /* 17 - invalid in 64 bit mode */
    Instruction("sbb", ps_EbGb),        /* 18 */
    Instruction("sbb", ps_EvGv),        /* 19 */
    Instruction("sbb", ps_GbEb),        /* 1A */
    Instruction("sbb", ps_GvEv),        /* 1B */
    Instruction("sbb", ps_ALIb),        /* 1C */
    Instruction("sbb", ps_rAXIz),       /* 1D */
    Instruction("", null),              /* 1E - invalid in 64 bit mode */
    Instruction("", null),              /* 1F - invalid in 64 bit mode */

    Instruction("and", ps_EbGb),        /* 20 */
    Instruction("and", ps_EvGv),        /* 21 */
    Instruction("and", ps_GbEb),        /* 22 */
    Instruction("and", ps_GvEv),        /* 23 */
    Instruction("and", ps_ALIb),        /* 24 */
    Instruction("and", ps_rAXIz),       /* 25 */
    Instruction("", null),              /* 26 - ES prefix */
    Instruction("", null),              /* 27 - invalid in 64 bit mode */
    Instruction("sub", ps_EbGb),        /* 28 */
    Instruction("sub", ps_EvGv),        /* 29 */
    Instruction("sub", ps_GbEb),        /* 2A */
    Instruction("sub", ps_GvEv),        /* 2B */
    Instruction("sub", ps_ALIb),        /* 2C */
    Instruction("sub", ps_rAXIz),       /* 2D */
    Instruction("", null),              /* 2E - CS prefix */
    Instruction("", null),              /* 2F - invalid in 64 bit mode */

    Instruction("xor", ps_EbGb),        /* 30 */
    Instruction("xor", ps_EvGv),        /* 31 */
    Instruction("xor", ps_GbEb),        /* 32 */
    Instruction("xor", ps_GvEv),        /* 33 */
    Instruction("xor", ps_ALIb),        /* 34 */
    Instruction("xor", ps_rAXIz),       /* 35 */
    Instruction("", null),              /* 36 - SS prefix */
    Instruction("", null),              /* 37 - invalid in 64 bit mode */
    Instruction("cmp", ps_EbGb),        /* 38 */
    Instruction("cmp", ps_EvGv),        /* 39 */
    Instruction("cmp", ps_GbEb),        /* 3A */
    Instruction("cmp", ps_GvEv),        /* 3B */
    Instruction("cmp", ps_ALIb),        /* 3C */
    Instruction("cmp", ps_rAXIz),       /* 3D */
    Instruction("", null),              /* 3E - DS prefix */
    Instruction("", null),              /* 3F - invalid in 64 bit mode */

    Instruction("nop", null),           /* 40 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 41 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 42 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 43 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 44 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 45 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 46 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 47 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 48 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 49 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4A - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4B - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4C - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4D - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4E - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null),           /* 4F - not available in 64bit mode - will be read as prefix byte */

    Instruction("push", ps_rAX, 64),    /* 50 */
    Instruction("push", ps_rCX, 64),    /* 51 */
    Instruction("push", ps_rDX, 64),    /* 52 */
    Instruction("push", ps_rBX, 64),    /* 53 */
    Instruction("push", ps_rSP, 64),    /* 54 */
    Instruction("push", ps_rBP, 64),    /* 55 */
    Instruction("push", ps_rSI, 64),    /* 56 */
    Instruction("push", ps_rDI, 64),    /* 57 */
    Instruction("pop", ps_rAX, 64),     /* 58 */
    Instruction("pop", ps_rCX, 64),     /* 59 */
    Instruction("pop", ps_rDX, 64),     /* 5A */
    Instruction("pop", ps_rBX, 64),     /* 5B */
    Instruction("pop", ps_rSP, 64),     /* 5C */
    Instruction("pop", ps_rBP, 64),     /* 5D */
    Instruction("pop", ps_rSI, 64),     /* 5E */
    Instruction("pop", ps_rDI, 64),   /* 5F */

    Instruction("", null),              /* 60 - not valid in 64bit mode */
    Instruction("", null),              /* 61 - not valid in 64bit mode */
    Instruction("", null),              /* 62 - not valid in 64bit mode */
    Instruction("movsxd", ps_GvEd),     /* 63 */
    Instruction("", null),              /* 64 - FS prefix */
    Instruction("", null),              /* 65 - GS prefix */
    Instruction("", null),              /* 66 - opsize prefix */
    Instruction("", null),              /* 67 - addrsize prefix */
    Instruction("push", ps_Iz, 64),     /* 68 */
    Instruction("imul", ps_GvEvIz),     /* 69 */
    Instruction("push", ps_Ib),         /* 6A */
    Instruction("imul", ps_GvEvIb),     /* 6B */
    Instruction("ins", ps_b),           /* 6C */
    Instruction("ins", ps_z),           /* 6D */
    Instruction("outs", ps_b),          /* 6E */
    Instruction("outs", ps_z),          /* 6F */

    Instruction("jo", ps_Jb),           /* 70 */
    Instruction("jno", ps_Jb),          /* 71 */
    Instruction("jb", ps_Jb),           /* 72 */
    Instruction("jnb", ps_Jb),          /* 73 */
    Instruction("je", ps_Jb),           /* 74 */
    Instruction("jne", ps_Jb),          /* 75 */
    Instruction("jbe", ps_Jb),          /* 76 */
    Instruction("ja", ps_Jb),           /* 77 */
    Instruction("js", ps_Jb),           /* 78 */
    Instruction("jns", ps_Jb),          /* 79 */
    Instruction("jp", ps_Jb),           /* 7A */
    Instruction("jnp", ps_Jb),          /* 7B */
    Instruction("jl", ps_Jb),           /* 7C */
    Instruction("jge", ps_Jb),          /* 7D */
    Instruction("jle", ps_Jb),          /* 7E */
    Instruction("jg", ps_Jb),           /* 7F */

    Instruction("80", null),            /* 80 - group 1 - INSTRUCTIONS_80 */
    Instruction("81", null),            /* 81 - group 1 - INSTRUCTIONS_81 */
    Instruction("82", null),            /* 82 - group 1 - INSTRUCTIONS_82 */
    Instruction("83", null),            /* 83 - group 1 - INSTRUCTIONS_83 */

    Instruction("test", ps_EbGb),       /* 84 */
    Instruction("test", ps_EvGv),       /* 85 */
    Instruction("xchg", ps_EbGb),       /* 86 */
    Instruction("xchg", ps_EvGv),       /* 87 */

    Instruction("mov", ps_EbGb),        /* 88 */
    Instruction("mov", ps_EvGv),        /* 89 */
    Instruction("mov", ps_GbEb),        /* 8A */
    Instruction("mov", ps_GvEv),        /* 8B */
    Instruction("mov", ps_MwSw),        /* 8C */
    Instruction("lea", ps_GvM),         /* 8D */
    Instruction("mov", ps_SwMw),        /* 8E */

    Instruction("8F", null),            /* 8F - group 1a */

    Instruction("nop", ps_none),        /* 90 */
    Instruction("xchg", ps_rCXrAX),     /* 91 */
    Instruction("xchg", ps_rDXrAX),     /* 92 */
    Instruction("xchg", ps_rBXrAX),     /* 93 */
    Instruction("xchg", ps_rSPrAX),     /* 94 */
    Instruction("xchg", ps_rBPrAX),     /* 95 */
    Instruction("xchg", ps_rSIrAX),     /* 96 */
    Instruction("xchg", ps_rDIrAX),     /* 97 */
    Instruction("cdqe", ps_none),       /* 98 */
    Instruction("cqo", ps_none),        /* 99 */
    Instruction("", null),              /* 9A - invalid in 64 bit mode */
    Instruction("wait", ps_none),       /* 9B */
    Instruction("pushf", ps_Fv, 64),    /* 9C */
    Instruction("popf", ps_Fv, 64),     /* 9D */
    Instruction("sahf", ps_none),       /* 9E */
    Instruction("lahf", ps_none),       /* 9F */

    Instruction("mov", ps_ALOv),        /* A0 */
    Instruction("mov", ps_rAXOv),       /* A1 */
    Instruction("mov", ps_OvAL),        /* A2 */
    Instruction("mov", ps_OvrAX),       /* A3 */
    Instruction("movs", ps_b, 8),       /* A4 */
    Instruction("movs", ps_v),          /* A5 */
    Instruction("cmps", ps_b, 8),       /* A6 */
    Instruction("cmps", ps_v),          /* A7 */
    Instruction("test", ps_ALIb),       /* A8 */
    Instruction("test", ps_rAXIz),      /* A9 */
    Instruction("stob", ps_b, 8),       /* AA */
    Instruction("stos", ps_v),          /* AB */
    Instruction("lods", ps_b, 8),       /* AC */
    Instruction("lods", ps_v),          /* AD */
    Instruction("scas", ps_b, 8),       /* AE */
    Instruction("scas", ps_v),          /* AF */

    Instruction("mov", ps_ALIb),        /* B0 */
    Instruction("mov", ps_CLIb),        /* B1 */
    Instruction("mov", ps_DLIb),        /* B2 */
    Instruction("mov", ps_BLIb),        /* B3 */
    Instruction("mov", ps_AHIb),        /* B4 */
    Instruction("mov", ps_CHIb),        /* B5 */
    Instruction("mov", ps_DHIb),        /* B6 */
    Instruction("mov", ps_BHIb),        /* B7 */
    Instruction("mov", ps_rAXIv),       /* B8 */
    Instruction("mov", ps_rCXIv),       /* B9 */
    Instruction("mov", ps_rDXIv),       /* BA */
    Instruction("mov", ps_rBXIv),       /* BB */
    Instruction("mov", ps_rSPIv),       /* BC */
    Instruction("mov", ps_rBPIv),       /* BD */
    Instruction("mov", ps_rSIIv),       /* BE */
    Instruction("mov", ps_rDIIv),       /* BF */

    Instruction("", null),              /* C0 - group 2 - INSTRUCTIONS_C0 */
    Instruction("", null),              /* C1 - group 2 - INSTRUCTIONS_C1 */
    Instruction("ret", ps_Iw),          /* C2 */
    Instruction("ret", ps_none),        /* C3 */
    Instruction("", null),              /* C4 - vex prefix */
    Instruction("", null),              /* C5 - vex prefix */
    Instruction("", null),              /* C6 - group 11 - INSTRUCTIONS_C6 */
    Instruction("", null),              /* C7 - group 11 - INSTRUCTIONS_C7 */
    Instruction("enter", ps_IwIb),      /* C8 */
    Instruction("leave", ps_none),      /* C9 */
    Instruction("retf", ps_Iw),         /* CA */
    Instruction("retf", ps_none),       /* CB */
    Instruction("int 3", ps_none),      /* CC */
    Instruction("int", ps_Ib),          /* CD */
    Instruction("", null),              /* CE - invalid in 64 bit mode */
    Instruction("iret", ps_none),       /* CF */

    Instruction("", null),              /* D0 - group 2 - INSTRUCTIONS_D0 */
    Instruction("", null),              /* D1 - group 2 - INSTRUCTIONS_D1 */
    Instruction("", null),              /* D2 - group 2 - INSTRUCTIONS_D2 */
    Instruction("", null),              /* D3 - group 2 - INSTRUCTIONS_D3 */
    Instruction("", null),              /* D4 - invalid in 64 bit mode */
    Instruction("", null),              /* D5 - invalid in 64 bit mode */
    Instruction("", null),              /* D6 - invalid in 64 bit mode */
    Instruction("xlat", ps_none),       /* D7 */
    Instruction("", null),              /* D8 - FPU ESC 0 */
    Instruction("", null),              /* D9 - FPU ESC 1 */
    Instruction("", null),              /* DA - FPU ESC 2 */
    Instruction("", null),              /* DB - FPU ESC 3 */
    Instruction("", null),              /* DC - FPU ESC 4 */
    Instruction("", null),              /* DD - FPU ESC 5 */
    Instruction("", null),              /* DE - FPU ESC 6 */
    Instruction("", null),              /* DF - FPU ESC 7 */

    Instruction("loopne", ps_Jb),       /* E0 */
    Instruction("loope", ps_Jb),        /* E1 */
    Instruction("loop", ps_Jb),         /* E2 */
    Instruction("jcxz", ps_Jb),         /* E3 */
    Instruction("in", ps_ALIb),         /* E4 */
    Instruction("in", ps_eAXIb),        /* E5 */
    Instruction("out", ps_IbAL),        /* E6 */
    Instruction("out", ps_IbeAX),       /* E7 */
    Instruction("call", ps_Jz),         /* E8 */
    Instruction("jmp", ps_Jz),          /* E9 */
    Instruction("", null),              /* EA - invalid in 64 bit mode */
    Instruction("jmp", ps_Jb),          /* EB */
    Instruction("in", ps_ALDX),         /* EC */
    Instruction("in", ps_eAXDX),        /* ED */
    Instruction("out", ps_DXAL),        /* EE */
    Instruction("out", ps_DXeAX),       /* EF */

    Instruction("", null),              /* F0 - lock prefix */
    Instruction("int 1", ps_none),      /* F1 */
    Instruction("", null),              /* F2 - repne prefix */
    Instruction("", null),              /* F3 - rep prefix */
    Instruction("hlt", ps_none),        /* F4 */
    Instruction("cmc", ps_none),        /* F5 */
    Instruction("", null),              /* F6 - group 3 - INSTRUCTIONS_F6 */
    Instruction("", null),              /* F7 - group 3 - INSTRUCTIONS_F7 */
    Instruction("clc", ps_none),        /* F8 */
    Instruction("stc", ps_none),        /* F9 */
    Instruction("cli", ps_none),        /* FA */
    Instruction("sti", ps_none),        /* FB */
    Instruction("cld", ps_none),        /* FC */
    Instruction("std", ps_none),        /* FD */
    Instruction("", null),              /* FE - group 4 - INSTRUCTIONS_FE */
    Instruction("", null),              /* FF - group 5 - INSTRUCTIONS_FF */

];
