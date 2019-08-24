module disassembler.parse.parse_1byte_opcodes;

import disassembler.all;

void parseOneByteOpcode(Parser p, uint byte1) {
    if(byte1==0x90 && p.prefix.rep) {
        p.instr.copy(Instruction("pause", ps_none, IS.STD));    /* spin lock hint */
        return;
    }

    if(INSTRUCTIONS.length>byte1) {
        p.instr.copy(INSTRUCTIONS[byte1]);
    }
    else assert(false);
}

private:

__gshared Instruction[] INSTRUCTIONS = [
    Instruction("add", ps_EbGb, IS.STD),        /* 00 */
    Instruction("add", ps_EvGv, IS.STD),        /* 01 */
    Instruction("add", ps_GbEb, IS.STD),        /* 02 */
    Instruction("add", ps_GvEv, IS.STD),        /* 03 */
    Instruction("add", ps_ALIb, IS.STD),        /* 04 */
    Instruction("add", ps_rAXIz, IS.STD),       /* 05 */
    Instruction("", null, IS.STD),              /* 06 - invalid in 64 bit mode */
    Instruction("", null, IS.STD),              /* 07 - invalid in 64 bit mode */
    Instruction("or", ps_EbGb, IS.STD),         /* 08 */
    Instruction("or", ps_EvGv, IS.STD),         /* 09 */
    Instruction("or", ps_GbEb, IS.STD),         /* 0A */
    Instruction("or", ps_GvEv, IS.STD),         /* 0B */
    Instruction("or", ps_ALIb, IS.STD),         /* 0C */
    Instruction("or", ps_rAXIz, IS.STD),        /* 0D */
    Instruction("", null, IS.STD),              /* 0E - invalid in 64 bit mode */

    Instruction("", null, IS.STD),              /* 0F - indicates 2 byte opcode */

    Instruction("adc", ps_EbGb, IS.STD),        /* 10 */
    Instruction("adc", ps_EvGv, IS.STD),        /* 11 */
    Instruction("adc", ps_GbEb, IS.STD),        /* 12 */
    Instruction("adc", ps_GvEv, IS.STD),        /* 13 */
    Instruction("adc", ps_ALIb, IS.STD),        /* 14 */
    Instruction("adc", ps_rAXIz, IS.STD),       /* 15 */
    Instruction("", null, IS.STD),              /* 16 - invalid in 64 bit mode */
    Instruction("", null, IS.STD),              /* 17 - invalid in 64 bit mode */
    Instruction("sbb", ps_EbGb, IS.STD),        /* 18 */
    Instruction("sbb", ps_EvGv, IS.STD),        /* 19 */
    Instruction("sbb", ps_GbEb, IS.STD),        /* 1A */
    Instruction("sbb", ps_GvEv, IS.STD),        /* 1B */
    Instruction("sbb", ps_ALIb, IS.STD),        /* 1C */
    Instruction("sbb", ps_rAXIz, IS.STD),       /* 1D */
    Instruction("", null, IS.STD),              /* 1E - invalid in 64 bit mode */
    Instruction("", null, IS.STD),              /* 1F - invalid in 64 bit mode */

    Instruction("and", ps_EbGb, IS.STD),        /* 20 */
    Instruction("and", ps_EvGv, IS.STD),        /* 21 */
    Instruction("and", ps_GbEb, IS.STD),        /* 22 */
    Instruction("and", ps_GvEv, IS.STD),        /* 23 */
    Instruction("and", ps_ALIb, IS.STD),        /* 24 */
    Instruction("and", ps_rAXIz, IS.STD),       /* 25 */
    Instruction("", null, IS.STD),              /* 26 - ES prefix */
    Instruction("", null, IS.STD),              /* 27 - invalid in 64 bit mode */
    Instruction("sub", ps_EbGb, IS.STD),        /* 28 */
    Instruction("sub", ps_EvGv, IS.STD),        /* 29 */
    Instruction("sub", ps_GbEb, IS.STD),        /* 2A */
    Instruction("sub", ps_GvEv, IS.STD),        /* 2B */
    Instruction("sub", ps_ALIb, IS.STD),        /* 2C */
    Instruction("sub", ps_rAXIz, IS.STD),       /* 2D */
    Instruction("", null, IS.STD),              /* 2E - CS prefix */
    Instruction("", null, IS.STD),              /* 2F - invalid in 64 bit mode */

    Instruction("xor", ps_EbGb, IS.STD),        /* 30 */
    Instruction("xor", ps_EvGv, IS.STD),        /* 31 */
    Instruction("xor", ps_GbEb, IS.STD),        /* 32 */
    Instruction("xor", ps_GvEv, IS.STD),        /* 33 */
    Instruction("xor", ps_ALIb, IS.STD),        /* 34 */
    Instruction("xor", ps_rAXIz, IS.STD),       /* 35 */
    Instruction("", null, IS.STD),              /* 36 - SS prefix */
    Instruction("", null, IS.STD),              /* 37 - invalid in 64 bit mode */
    Instruction("cmp", ps_EbGb, IS.STD),        /* 38 */
    Instruction("cmp", ps_EvGv, IS.STD),        /* 39 */
    Instruction("cmp", ps_GbEb, IS.STD),        /* 3A */
    Instruction("cmp", ps_GvEv, IS.STD),        /* 3B */
    Instruction("cmp", ps_ALIb, IS.STD),        /* 3C */
    Instruction("cmp", ps_rAXIz, IS.STD),       /* 3D */
    Instruction("", null, IS.STD),              /* 3E - DS prefix */
    Instruction("", null, IS.STD),              /* 3F - invalid in 64 bit mode */

    Instruction("nop", null, IS.STD),           /* 40 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 41 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 42 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 43 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 44 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 45 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 46 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 47 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 48 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 49 - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4A - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4B - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4C - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4D - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4E - not available in 64bit mode - will be read as prefix byte */
    Instruction("nop", null, IS.STD),           /* 4F - not available in 64bit mode - will be read as prefix byte */

    Instruction("push", ps_rAX, IS.STD, [Hint.SIZE_64]),  /* 50 */
    Instruction("push", ps_rCX, IS.STD, [Hint.SIZE_64]),  /* 51 */
    Instruction("push", ps_rDX, IS.STD, [Hint.SIZE_64]),  /* 52 */
    Instruction("push", ps_rBX, IS.STD, [Hint.SIZE_64]),  /* 53 */
    Instruction("push", ps_rSP, IS.STD, [Hint.SIZE_64]),  /* 54 */
    Instruction("push", ps_rBP, IS.STD, [Hint.SIZE_64]),  /* 55 */
    Instruction("push", ps_rSI, IS.STD, [Hint.SIZE_64]),  /* 56 */
    Instruction("push", ps_rDI, IS.STD, [Hint.SIZE_64]),  /* 57 */
    Instruction("pop", ps_rAX, IS.STD, [Hint.SIZE_64]),   /* 58 */
    Instruction("pop", ps_rCX, IS.STD, [Hint.SIZE_64]),   /* 59 */
    Instruction("pop", ps_rDX, IS.STD, [Hint.SIZE_64]),   /* 5A */
    Instruction("pop", ps_rBX, IS.STD, [Hint.SIZE_64]),   /* 5B */
    Instruction("pop", ps_rSP, IS.STD, [Hint.SIZE_64]),   /* 5C */
    Instruction("pop", ps_rBP, IS.STD, [Hint.SIZE_64]),   /* 5D */
    Instruction("pop", ps_rSI, IS.STD, [Hint.SIZE_64]),   /* 5E */
    Instruction("pop", ps_rDI, IS.STD, [Hint.SIZE_64]),   /* 5F */

    Instruction("", null, IS.STD),                      /* 60 - not valid in 64bit mode */
    Instruction("", null, IS.STD),                      /* 61 - not valid in 64bit mode */
    Instruction("", null, IS.STD),                      /* 62 - not valid in 64bit mode */
    Instruction("movsxd", ps_GvEd, IS.STD),             /* 63 */
    Instruction("", null, IS.STD),                      /* 64 - FS prefix */
    Instruction("", null, IS.STD),                      /* 65 - GS prefix */
    Instruction("", null, IS.STD),                      /* 66 - opsize prefix */
    Instruction("", null, IS.STD),                      /* 67 - addrsize prefix */
    Instruction("push", ps_Iz, IS.STD, [Hint.SIZE_64]), /* 68 */
    Instruction("imul", ps_GvEvIz, IS.STD),             /* 69 */
    Instruction("push", ps_Ib, IS.STD),                 /* 6A */
    Instruction("imul", ps_GvEvIb, IS.STD),             /* 6B */
    Instruction("ins", ps_b, IS.STD),                   /* 6C */
    Instruction("ins", ps_z, IS.STD),                   /* 6D */
    Instruction("outs", ps_b, IS.STD),                  /* 6E */
    Instruction("outs", ps_z, IS.STD),                  /* 6F */

    Instruction("jo", ps_Jb, IS.STD),                   /* 70 */
    Instruction("jno", ps_Jb, IS.STD),                  /* 71 */
    Instruction("jb", ps_Jb, IS.STD),                   /* 72 */
    Instruction("jnb", ps_Jb, IS.STD),                  /* 73 */
    Instruction("je", ps_Jb, IS.STD),                   /* 74 */
    Instruction("jne", ps_Jb, IS.STD),                  /* 75 */
    Instruction("jbe", ps_Jb, IS.STD),                  /* 76 */
    Instruction("ja", ps_Jb, IS.STD),                   /* 77 */
    Instruction("js", ps_Jb, IS.STD),                   /* 78 */
    Instruction("jns", ps_Jb, IS.STD),                  /* 79 */
    Instruction("jp", ps_Jb, IS.STD),                   /* 7A */
    Instruction("jnp", ps_Jb, IS.STD),                  /* 7B */
    Instruction("jl", ps_Jb, IS.STD),                   /* 7C */
    Instruction("jge", ps_Jb, IS.STD),                  /* 7D */
    Instruction("jle", ps_Jb, IS.STD),                  /* 7E */
    Instruction("jg", ps_Jb, IS.STD),                   /* 7F */

    Instruction("80", null, IS.STD),                    /* 80 - group 1 - INSTRUCTIONS_80 */
    Instruction("81", null, IS.STD),                    /* 81 - group 1 - INSTRUCTIONS_81 */
    Instruction("82", null, IS.STD),                    /* 82 - group 1 - INSTRUCTIONS_82 */
    Instruction("83", null, IS.STD),                    /* 83 - group 1 - INSTRUCTIONS_83 */

    Instruction("test", ps_EbGb, IS.STD),       /* 84 */
    Instruction("test", ps_EvGv, IS.STD),       /* 85 */
    Instruction("xchg", ps_EbGb, IS.STD),       /* 86 */
    Instruction("xchg", ps_EvGv, IS.STD),       /* 87 */

    Instruction("mov", ps_EbGb, IS.STD),        /* 88 */
    Instruction("mov", ps_EvGv, IS.STD),        /* 89 */
    Instruction("mov", ps_GbEb, IS.STD),        /* 8A */
    Instruction("mov", ps_GvEv, IS.STD),        /* 8B */
    Instruction("mov", ps_MwSw, IS.STD),        /* 8C */
    Instruction("lea", ps_GvM, IS.STD),         /* 8D */
    Instruction("mov", ps_SwMw, IS.STD),        /* 8E */

    Instruction("8F", null, IS.STD),            /* 8F - group 1a */

    Instruction("nop", ps_none, IS.STD),                /* 90 */
    Instruction("xchg", ps_rCXrAX, IS.STD),             /* 91 */
    Instruction("xchg", ps_rDXrAX, IS.STD),             /* 92 */
    Instruction("xchg", ps_rBXrAX, IS.STD),             /* 93 */
    Instruction("xchg", ps_rSPrAX, IS.STD),             /* 94 */
    Instruction("xchg", ps_rBPrAX, IS.STD),             /* 95 */
    Instruction("xchg", ps_rSIrAX, IS.STD),             /* 96 */
    Instruction("xchg", ps_rDIrAX, IS.STD),             /* 97 */
    Instruction("cdqe", ps_none, IS.STD),               /* 98 */
    Instruction("cqo", ps_none, IS.STD),                /* 99 */
    Instruction("", null, IS.STD),                      /* 9A - invalid in 64 bit mode */
    Instruction("wait", ps_none, IS.STD),               /* 9B */
    Instruction("pushf", ps_Fv, IS.STD, [Hint.SIZE_64]),/* 9C */
    Instruction("popf", ps_Fv, IS.STD, [Hint.SIZE_64]), /* 9D */
    Instruction("sahf", ps_none, IS.STD),               /* 9E */
    Instruction("lahf", ps_none, IS.STD),               /* 9F */

    Instruction("mov", ps_ALOv, IS.STD),                /* A0 */
    Instruction("mov", ps_rAXOv, IS.STD),               /* A1 */
    Instruction("mov", ps_OvAL, IS.STD),                /* A2 */
    Instruction("mov", ps_OvrAX, IS.STD),               /* A3 */
    Instruction("movs", ps_b, IS.STD, [Hint.SIZE_8]),   /* A4 */
    Instruction("movs", ps_v, IS.STD),                  /* A5 */
    Instruction("cmps", ps_b, IS.STD, [Hint.SIZE_8]),   /* A6 */
    Instruction("cmps", ps_v, IS.STD),                  /* A7 */
    Instruction("test", ps_ALIb, IS.STD),               /* A8 */
    Instruction("test", ps_rAXIz, IS.STD),              /* A9 */
    Instruction("stob", ps_b, IS.STD, [Hint.SIZE_8]),   /* AA */
    Instruction("stos", ps_v, IS.STD),                  /* AB */
    Instruction("lods", ps_b, IS.STD, [Hint.SIZE_8]),   /* AC */
    Instruction("lods", ps_v, IS.STD),                  /* AD */
    Instruction("scas", ps_b, IS.STD, [Hint.SIZE_8]),   /* AE */
    Instruction("scas", ps_v, IS.STD),                  /* AF */

    Instruction("mov", ps_ALIb, IS.STD),        /* B0 */
    Instruction("mov", ps_CLIb, IS.STD),        /* B1 */
    Instruction("mov", ps_DLIb, IS.STD),        /* B2 */
    Instruction("mov", ps_BLIb, IS.STD),        /* B3 */
    Instruction("mov", ps_AHIb, IS.STD),        /* B4 */
    Instruction("mov", ps_CHIb, IS.STD),        /* B5 */
    Instruction("mov", ps_DHIb, IS.STD),        /* B6 */
    Instruction("mov", ps_BHIb, IS.STD),        /* B7 */
    Instruction("mov", ps_rAXIv, IS.STD),       /* B8 */
    Instruction("mov", ps_rCXIv, IS.STD),       /* B9 */
    Instruction("mov", ps_rDXIv, IS.STD),       /* BA */
    Instruction("mov", ps_rBXIv, IS.STD),       /* BB */
    Instruction("mov", ps_rSPIv, IS.STD),       /* BC */
    Instruction("mov", ps_rBPIv, IS.STD),       /* BD */
    Instruction("mov", ps_rSIIv, IS.STD),       /* BE */
    Instruction("mov", ps_rDIIv, IS.STD),       /* BF */

    Instruction("", null, IS.STD),              /* C0 - group 2 - INSTRUCTIONS_C0 */
    Instruction("", null, IS.STD),              /* C1 - group 2 - INSTRUCTIONS_C1 */
    Instruction("ret", ps_Iw, IS.STD),          /* C2 */
    Instruction("ret", ps_none, IS.STD),        /* C3 */
    Instruction("", null, IS.STD),              /* C4 - vex prefix */
    Instruction("", null, IS.STD),              /* C5 - vex prefix */
    Instruction("", null, IS.STD),              /* C6 - group 11 - INSTRUCTIONS_C6 */
    Instruction("", null, IS.STD),              /* C7 - group 11 - INSTRUCTIONS_C7 */
    Instruction("enter", ps_IwIb, IS.STD),      /* C8 */
    Instruction("leave", ps_none, IS.STD),      /* C9 */
    Instruction("retf", ps_Iw, IS.STD),         /* CA */
    Instruction("retf", ps_none, IS.STD),       /* CB */
    Instruction("int 3", ps_none, IS.STD),      /* CC */
    Instruction("int", ps_Ib, IS.STD),          /* CD */
    Instruction("", null, IS.STD),              /* CE - invalid in 64 bit mode */
    Instruction("iret", ps_none, IS.STD),       /* CF */

    Instruction("", null, IS.STD),              /* D0 - group 2 - INSTRUCTIONS_D0 */
    Instruction("", null, IS.STD),              /* D1 - group 2 - INSTRUCTIONS_D1 */
    Instruction("", null, IS.STD),              /* D2 - group 2 - INSTRUCTIONS_D2 */
    Instruction("", null, IS.STD),              /* D3 - group 2 - INSTRUCTIONS_D3 */
    Instruction("", null, IS.STD),              /* D4 - invalid in 64 bit mode */
    Instruction("", null, IS.STD),              /* D5 - invalid in 64 bit mode */
    Instruction("", null, IS.STD),              /* D6 - invalid in 64 bit mode */
    Instruction("xlat", ps_none, IS.STD),       /* D7 */
    Instruction("", null, IS.STD),              /* D8 - FPU ESC 0 */
    Instruction("", null, IS.STD),              /* D9 - FPU ESC 1 */
    Instruction("", null, IS.STD),              /* DA - FPU ESC 2 */
    Instruction("", null, IS.STD),              /* DB - FPU ESC 3 */
    Instruction("", null, IS.STD),              /* DC - FPU ESC 4 */
    Instruction("", null, IS.STD),              /* DD - FPU ESC 5 */
    Instruction("", null, IS.STD),              /* DE - FPU ESC 6 */
    Instruction("", null, IS.STD),              /* DF - FPU ESC 7 */

    Instruction("loopne", ps_Jb, IS.STD),       /* E0 */
    Instruction("loope", ps_Jb, IS.STD),        /* E1 */
    Instruction("loop", ps_Jb, IS.STD),         /* E2 */
    Instruction("jcxz", ps_Jb, IS.STD),         /* E3 */
    Instruction("in", ps_ALIb, IS.STD),         /* E4 */
    Instruction("in", ps_eAXIb, IS.STD),        /* E5 */
    Instruction("out", ps_IbAL, IS.STD),        /* E6 */
    Instruction("out", ps_IbeAX, IS.STD),       /* E7 */
    Instruction("call", ps_Jz, IS.STD),         /* E8 */
    Instruction("jmp", ps_Jz, IS.STD),          /* E9 */
    Instruction("", null, IS.STD),              /* EA - invalid in 64 bit mode */
    Instruction("jmp", ps_Jb, IS.STD),          /* EB */
    Instruction("in", ps_ALDX, IS.STD),         /* EC */
    Instruction("in", ps_eAXDX, IS.STD),        /* ED */
    Instruction("out", ps_DXAL, IS.STD),        /* EE */
    Instruction("out", ps_DXeAX, IS.STD),       /* EF */

    Instruction("", null, IS.STD),              /* F0 - lock prefix */
    Instruction("int 1", ps_none, IS.STD),      /* F1 */
    Instruction("", null, IS.STD),              /* F2 - repne prefix */
    Instruction("", null, IS.STD),              /* F3 - rep prefix */
    Instruction("hlt", ps_none, IS.STD),        /* F4 */
    Instruction("cmc", ps_none, IS.STD),        /* F5 */
    Instruction("", null, IS.STD),              /* F6 - group 3 - INSTRUCTIONS_F6 */
    Instruction("", null, IS.STD),              /* F7 - group 3 - INSTRUCTIONS_F7 */
    Instruction("clc", ps_none, IS.STD),        /* F8 */
    Instruction("stc", ps_none, IS.STD),        /* F9 */
    Instruction("cli", ps_none, IS.STD),        /* FA */
    Instruction("sti", ps_none, IS.STD),        /* FB */
    Instruction("cld", ps_none, IS.STD),        /* FC */
    Instruction("std", ps_none, IS.STD),        /* FD */
    Instruction("", null, IS.STD),              /* FE - group 4 - INSTRUCTIONS_FE */
    Instruction("", null, IS.STD),              /* FF - group 5 - INSTRUCTIONS_FF */

];
