; Disassembly of file: Test.exe
; Fri Aug  9 13:14:28 2019
; Mode: 64 bits
; Syntax: MASM/ML64
; Instruction set: SSE4.2, x64
option dotname
assume gs:nothing

public Entry_point

extern __ImageBase: word
extern InitializeSListHead: near                        ; KERNEL32.dll
extern RtlLookupFunctionEntry: near                     ; KERNEL32.dll
extern RtlVirtualUnwind: near                           ; KERNEL32.dll
extern UnhandledExceptionFilter: near                   ; KERNEL32.dll
extern SetUnhandledExceptionFilter: near                ; KERNEL32.dll
extern GetCurrentProcess: near                          ; KERNEL32.dll
extern TerminateProcess: near                           ; KERNEL32.dll
extern IsProcessorFeaturePresent: near                  ; KERNEL32.dll
extern QueryPerformanceCounter: near                    ; KERNEL32.dll
extern GetModuleHandleW: near                           ; KERNEL32.dll
extern IsDebuggerPresent: near                          ; KERNEL32.dll
extern RtlCaptureContext: near                          ; KERNEL32.dll
extern GetSystemTimeAsFileTime: near                    ; KERNEL32.dll
extern GetCurrentThreadId: near                         ; KERNEL32.dll
extern GetCurrentProcessId: near                        ; KERNEL32.dll
extern _Query_perf_frequency: near                      ; MSVCP140.dll
extern _Query_perf_counter: near                        ; MSVCP140.dll
extern memset: near                                     ; VCRUNTIME140.dll
extern __C_specific_handler: near                       ; VCRUNTIME140.dll
extern realloc: near                                    ; api-ms-win-crt-heap-l1-1-0.dll
extern free: near                                       ; api-ms-win-crt-heap-l1-1-0.dll
extern _set_new_mode: near                              ; api-ms-win-crt-heap-l1-1-0.dll
extern _configthreadlocale: near                        ; api-ms-win-crt-locale-l1-1-0.dll
extern __setusermatherr: near                           ; api-ms-win-crt-math-l1-1-0.dll
extern _initialize_onexit_table: near                   ; api-ms-win-crt-runtime-l1-1-0.dll
extern _register_onexit_function: near                  ; api-ms-win-crt-runtime-l1-1-0.dll
extern _crt_atexit: near                                ; api-ms-win-crt-runtime-l1-1-0.dll
extern terminate: near                                  ; api-ms-win-crt-runtime-l1-1-0.dll
extern _register_thread_local_exe_atexit_callback: near ; api-ms-win-crt-runtime-l1-1-0.dll
extern _c_exit: near                                    ; api-ms-win-crt-runtime-l1-1-0.dll
extern _cexit: near                                     ; api-ms-win-crt-runtime-l1-1-0.dll
extern __p___argc: near                                 ; api-ms-win-crt-runtime-l1-1-0.dll
extern __p___wargv: near                                ; api-ms-win-crt-runtime-l1-1-0.dll
extern _exit: near                                      ; api-ms-win-crt-runtime-l1-1-0.dll
extern exit: near                                       ; api-ms-win-crt-runtime-l1-1-0.dll
extern _initterm_e: near                                ; api-ms-win-crt-runtime-l1-1-0.dll
extern _initterm: near                                  ; api-ms-win-crt-runtime-l1-1-0.dll
extern _get_initial_wide_environment: near              ; api-ms-win-crt-runtime-l1-1-0.dll
extern _initialize_wide_environment: near               ; api-ms-win-crt-runtime-l1-1-0.dll
extern _configure_wide_argv: near                       ; api-ms-win-crt-runtime-l1-1-0.dll
extern _set_app_type: near                              ; api-ms-win-crt-runtime-l1-1-0.dll
extern _seh_filter_exe: near                            ; api-ms-win-crt-runtime-l1-1-0.dll
extern __acrt_iob_func: near                            ; api-ms-win-crt-stdio-l1-1-0.dll
extern __stdio_common_vfprintf: near                    ; api-ms-win-crt-stdio-l1-1-0.dll
extern __p__commode: near                               ; api-ms-win-crt-stdio-l1-1-0.dll
extern _set_fmode: near                                 ; api-ms-win-crt-stdio-l1-1-0.dll
extern getchar: near                                    ; api-ms-win-crt-stdio-l1-1-0.dll


_text   SEGMENT BYTE 'CODE'                             ; section number 1

?_001   LABEL NEAR
        mov     qword ptr [rsp+8H], rcx                 ; 40001000 _ 48: 89. 4C 24, 08
        mov     qword ptr [rsp+10H], rdx                ; 40001005 _ 48: 89. 54 24, 10
        mov     qword ptr [rsp+18H], r8                 ; 4000100A _ 4C: 89. 44 24, 18
        mov     qword ptr [rsp+20H], r9                 ; 4000100F _ 4C: 89. 4C 24, 20
        push    rbx                                     ; 40001014 _ 53
        push    rsi                                     ; 40001015 _ 56
        push    rdi                                     ; 40001016 _ 57
        sub     rsp, 48                                 ; 40001017 _ 48: 83. EC, 30
        mov     rdi, rcx                                ; 4000101B _ 48: 8B. F9
        lea     rsi, ptr [rsp+58H]                      ; 4000101E _ 48: 8D. 74 24, 58
        mov     ecx, 1                                  ; 40001023 _ B9, 00000001
        call    qword ptr [imp___acrt_iob_func]         ; 40001028 _ FF. 15, 0000215A(rel)
        mov     rbx, rax                                ; 4000102E _ 48: 8B. D8
        call    ?_002                                   ; 40001031 _ E8, 0000002A
        xor     r9d, r9d                                ; 40001036 _ 45: 33. C9
        mov     qword ptr [rsp+20H], rsi                ; 40001039 _ 48: 89. 74 24, 20
        mov     r8, rdi                                 ; 4000103E _ 4C: 8B. C7
        mov     rdx, rbx                                ; 40001041 _ 48: 8B. D3
        mov     rcx, qword ptr [rax]                    ; 40001044 _ 48: 8B. 08
        call    qword ptr [imp___stdio_common_vfprintf] ; 40001047 _ FF. 15, 00002143(rel)
        add     rsp, 48                                 ; 4000104D _ 48: 83. C4, 30
        pop     rdi                                     ; 40001051 _ 5F
        pop     rsi                                     ; 40001052 _ 5E
        pop     rbx                                     ; 40001053 _ 5B
        ret                                             ; 40001054 _ C3

        int 3    ; breakpoint or filler                 ; 40001055 _ CC
        int 3    ; breakpoint or filler                 ; 40001056 _ CC
        int 3    ; breakpoint or filler                 ; 40001057 _ CC
        int 3    ; breakpoint or filler                 ; 40001058 _ CC
        int 3    ; breakpoint or filler                 ; 40001059 _ CC
        int 3    ; breakpoint or filler                 ; 4000105A _ CC
        int 3    ; breakpoint or filler                 ; 4000105B _ CC
        int 3    ; breakpoint or filler                 ; 4000105C _ CC
        int 3    ; breakpoint or filler                 ; 4000105D _ CC
        int 3    ; breakpoint or filler                 ; 4000105E _ CC
        int 3    ; breakpoint or filler                 ; 4000105F _ CC

?_002   LABEL NEAR
        lea     rax, ptr [?_165]                        ; 40001060 _ 48: 8D. 05, 000035B9(rel)
        ret                                             ; 40001067 _ C3

        int 3    ; breakpoint or filler                 ; 40001068 _ CC
        int 3    ; breakpoint or filler                 ; 40001069 _ CC
        int 3    ; breakpoint or filler                 ; 4000106A _ CC
        int 3    ; breakpoint or filler                 ; 4000106B _ CC
        int 3    ; breakpoint or filler                 ; 4000106C _ CC
        int 3    ; breakpoint or filler                 ; 4000106D _ CC
        int 3    ; breakpoint or filler                 ; 4000106E _ CC
        int 3    ; breakpoint or filler                 ; 4000106F _ CC
        int 3    ; breakpoint or filler                 ; 40001070 _ CC
        int 3    ; breakpoint or filler                 ; 40001071 _ CC
        int 3    ; breakpoint or filler                 ; 40001072 _ CC
        int 3    ; breakpoint or filler                 ; 40001073 _ CC
        int 3    ; breakpoint or filler                 ; 40001074 _ CC
        int 3    ; breakpoint or filler                 ; 40001075 _ CC
; Filling space: 0AH
; Filler type: Multi-byte NOP
;       db 66H, 66H, 0FH, 1FH, 84H, 00H, 00H, 00H
;       db 00H, 00H

ALIGN   16
        cmp     rcx, qword ptr [?_137]                  ; 40001080 _ 48: 3B. 0D, 00002F79(rel)
        DB      0F2H                                    ; BND prefix coded explicitly
        jnz     ?_004                                   ; 40001087 _ F2: 75, 12
        rol     rcx, 16                                 ; 4000108A _ 48: C1. C1, 10
; Note: Length-changing prefix causes delay on Intel processors
        test    cx, 0FFFFH                              ; 4000108E _ 66: F7. C1, FFFF
        DB      0F2H                                    ; BND prefix coded explicitly
        jnz     ?_003                                   ; 40001093 _ F2: 75, 02
        DB      0F2H                                    ; BND prefix coded explicitly
        ret                                             ; 40001096 _ F2: C3

?_003:  ror     rcx, 16                                 ; 40001098 _ 48: C1. C9, 10
?_004:  jmp     ?_022                                   ; 4000109C _ E9, 000002A3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4
; Note: Prefix bit or byte has no meaning in this context
; Note: No jump seems to point here
        push    rbx                                     ; 400010A4 _ 40: 53
        sub     rsp, 32                                 ; 400010A6 _ 48: 83. EC, 20
        mov     ecx, 1                                  ; 400010AA _ B9, 00000001
        call    _set_app_type                           ; 400010AF _ E8, 00000BEE
        call    ?_067                                   ; 400010B4 _ E8, 00000747
        mov     ecx, eax                                ; 400010B9 _ 8B. C8
        call    _set_fmode                              ; 400010BB _ E8, 00000C18
        call    __p__commode                            ; 400010C0 _ E8, 00000C43
        mov     rbx, rax                                ; 400010C5 _ 48: 8B. D8
        call    ?_065                                   ; 400010C8 _ E8, 00000727
        mov     ecx, 1                                  ; 400010CD _ B9, 00000001
        mov     dword ptr [rbx], eax                    ; 400010D2 _ 89. 03
        call    ?_038                                   ; 400010D4 _ E8, 0000043B
        test    al, al                                  ; 400010D9 _ 84. C0
        jz      ?_007                                   ; 400010DB _ 74, 6C
        call    ?_088                                   ; 400010DD _ E8, 0000096E
        lea     rcx, ptr [?_092]                        ; 400010E2 _ 48: 8D. 0D, 000009A3(rel)
        call    ?_062                                   ; 400010E9 _ E8, 0000063E
        call    ?_066                                   ; 400010EE _ E8, 00000705
        mov     ecx, eax                                ; 400010F3 _ 8B. C8
        call    _configure_wide_argv                    ; 400010F5 _ E8, 00000BB4
        test    eax, eax                                ; 400010FA _ 85. C0
        jnz     ?_007                                   ; 400010FC _ 75, 4B
        call    ?_068                                   ; 400010FE _ E8, 00000705
        call    ?_073                                   ; 40001103 _ E8, 0000073C
        test    eax, eax                                ; 40001108 _ 85. C0
        jz      ?_005                                   ; 4000110A _ 74, 0C
        lea     rcx, ptr [?_065]                        ; 4000110C _ 48: 8D. 0D, 000006E1(rel)
        call    __setusermatherr                        ; 40001113 _ E8, 00000B90
?_005:  call    ?_070                                   ; 40001118 _ E8, 000006FF
        call    ?_070                                   ; 4000111D _ E8, 000006FA
        call    ?_065                                   ; 40001122 _ E8, 000006CD
        mov     ecx, eax                                ; 40001127 _ 8B. C8
        call    _configthreadlocale                     ; 40001129 _ E8, 00000BCE
        call    ?_069                                   ; 4000112E _ E8, 000006E5
        test    al, al                                  ; 40001133 _ 84. C0
        jz      ?_006                                   ; 40001135 _ 74, 05
        call    _initialize_wide_environment            ; 40001137 _ E8, 00000B78
?_006:  call    ?_065                                   ; 4000113C _ E8, 000006B3
        xor     eax, eax                                ; 40001141 _ 33. C0
        add     rsp, 32                                 ; 40001143 _ 48: 83. C4, 20
        pop     rbx                                     ; 40001147 _ 5B
        ret                                             ; 40001148 _ C3

?_007:  mov     ecx, 7                                  ; 40001149 _ B9, 00000007
        call    ?_077                                   ; 4000114E _ E8, 00000715
        int 3    ; breakpoint or filler                 ; 40001153 _ CC
        sub     rsp, 40                                 ; 40001154 _ 48: 83. EC, 28
        call    ?_072                                   ; 40001158 _ E8, 000006CB
        xor     eax, eax                                ; 4000115D _ 33. C0
        add     rsp, 40                                 ; 4000115F _ 48: 83. C4, 28
        ret                                             ; 40001163 _ C3

; Note: No jump seems to point here
        sub     rsp, 40                                 ; 40001164 _ 48: 83. EC, 28
        call    ?_084                                   ; 40001168 _ E8, 0000089B
        call    ?_065                                   ; 4000116D _ E8, 00000682
        mov     ecx, eax                                ; 40001172 _ 8B. C8
        add     rsp, 40                                 ; 40001174 _ 48: 83. C4, 28
        jmp     _set_new_mode                           ; 40001178 _ E9, 00000B85

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   8
?_008:  mov     qword ptr [rsp+8H], rbx                 ; 40001180 _ 48: 89. 5C 24, 08
        mov     qword ptr [rsp+10H], rsi                ; 40001185 _ 48: 89. 74 24, 10
        push    rdi                                     ; 4000118A _ 57
        sub     rsp, 48                                 ; 4000118B _ 48: 83. EC, 30
        mov     ecx, 1                                  ; 4000118F _ B9, 00000001
        call    ?_033                                   ; 40001194 _ E8, 0000032F
        test    al, al                                  ; 40001199 _ 84. C0
        je      ?_017                                   ; 4000119B _ 0F 84, 00000136
        xor     sil, sil                                ; 400011A1 _ 40: 32. F6
        mov     byte ptr [rsp+20H], sil                 ; 400011A4 _ 40: 88. 74 24, 20
        call    ?_027                                   ; 400011A9 _ E8, 000002DE
        mov     bl, al                                  ; 400011AE _ 8A. D8
        mov     ecx, dword ptr [?_153]                  ; 400011B0 _ 8B. 0D, 000033FA(rel)
        cmp     ecx, 1                                  ; 400011B6 _ 83. F9, 01
        je      ?_018                                   ; 400011B9 _ 0F 84, 00000123
        test    ecx, ecx                                ; 400011BF _ 85. C9
        jnz     ?_010                                   ; 400011C1 _ 75, 4A
        mov     dword ptr [?_153], 1                    ; 400011C3 _ C7. 05, 000033E3(rel), 00000001
        lea     rdx, ptr [?_124]                        ; 400011CD _ 48: 8D. 15, 00002024(rel)
        lea     rcx, ptr [?_123]                        ; 400011D4 _ 48: 8D. 0D, 00002005(rel)
        call    _initterm_e                             ; 400011DB _ E8, 00000AE6
        test    eax, eax                                ; 400011E0 _ 85. C0
        jz      ?_009                                   ; 400011E2 _ 74, 0A
        mov     eax, 255                                ; 400011E4 _ B8, 000000FF
        jmp     ?_016                                   ; 400011E9 _ E9, 000000D9

?_009:  lea     rdx, ptr [?_122]                        ; 400011EE _ 48: 8D. 15, 00001FE3(rel)
        lea     rcx, ptr [?_121]                        ; 400011F5 _ 48: 8D. 0D, 00001FCC(rel)
        call    _initterm                               ; 400011FC _ E8, 00000ABF
        mov     dword ptr [?_153], 2                    ; 40001201 _ C7. 05, 000033A5(rel), 00000002
        jmp     ?_011                                   ; 4000120B _ EB, 08

?_010:  mov     sil, 1                                  ; 4000120D _ 40: B6, 01
        mov     byte ptr [rsp+20H], sil                 ; 40001210 _ 40: 88. 74 24, 20
?_011:  mov     cl, bl                                  ; 40001215 _ 8A. CB
        call    ?_054                                   ; 40001217 _ E8, 00000470
        call    ?_074                                   ; 4000121C _ E8, 0000062F
        mov     rbx, rax                                ; 40001221 _ 48: 8B. D8
        cmp     qword ptr [rax], 0                      ; 40001224 _ 48: 83. 38, 00
        jz      ?_012                                   ; 40001228 _ 74, 1E
        mov     rcx, rax                                ; 4000122A _ 48: 8B. C8
        call    ?_045                                   ; 4000122D _ E8, 000003BE
        test    al, al                                  ; 40001232 _ 84. C0
        jz      ?_012                                   ; 40001234 _ 74, 12
        xor     r8d, r8d                                ; 40001236 _ 45: 33. C0
        lea     edx, ptr [r8+2H]                        ; 40001239 _ 41: 8D. 50, 02
        xor     ecx, ecx                                ; 4000123D _ 33. C9
        mov     rax, qword ptr [rbx]                    ; 4000123F _ 48: 8B. 03
        call    qword ptr [?_120]                       ; 40001242 _ FF. 15, 00001F78(rel)
?_012:  call    ?_075                                   ; 40001248 _ E8, 0000060B
        mov     rbx, rax                                ; 4000124D _ 48: 8B. D8
        cmp     qword ptr [rax], 0                      ; 40001250 _ 48: 83. 38, 00
        jz      ?_013                                   ; 40001254 _ 74, 14
        mov     rcx, rax                                ; 40001256 _ 48: 8B. C8
        call    ?_045                                   ; 40001259 _ E8, 00000392
        test    al, al                                  ; 4000125E _ 84. C0
        jz      ?_013                                   ; 40001260 _ 74, 08
        mov     rcx, qword ptr [rbx]                    ; 40001262 _ 48: 8B. 0B
        call    _register_thread_local_exe_atexit_callback; 40001265 _ E8, 00000A8C
?_013:  call    __p___wargv                             ; 4000126A _ E8, 00000A75
        mov     rdi, qword ptr [rax]                    ; 4000126F _ 48: 8B. 38
        call    __p___argc                              ; 40001272 _ E8, 00000A67
        mov     rbx, rax                                ; 40001277 _ 48: 8B. D8
        call    _get_initial_wide_environment           ; 4000127A _ E8, 00000A3B
        mov     r8, rax                                 ; 4000127F _ 4C: 8B. C0
        mov     rdx, rdi                                ; 40001282 _ 48: 8B. D7
        mov     ecx, dword ptr [rbx]                    ; 40001285 _ 8B. 0B
        call    ?_114                                   ; 40001287 _ E8, 00000D74
        mov     ebx, eax                                ; 4000128C _ 8B. D8
        call    ?_081                                   ; 4000128E _ E8, 00000721
        test    al, al                                  ; 40001293 _ 84. C0
        jz      ?_019                                   ; 40001295 _ 74, 55
        test    sil, sil                                ; 40001297 _ 40: 84. F6
        jnz     ?_014                                   ; 4000129A _ 75, 05
        call    _cexit                                  ; 4000129C _ E8, 00000A49
?_014:  xor     edx, edx                                ; 400012A1 _ 33. D2
        mov     cl, 1                                   ; 400012A3 _ B1, 01
        call    ?_056                                   ; 400012A5 _ E8, 00000406
        mov     eax, ebx                                ; 400012AA _ 8B. C3
        jmp     ?_016                                   ; 400012AC _ EB, 19

; Note: No jump seems to point here
        mov     ebx, eax                                ; 400012AE _ 8B. D8
        call    ?_081                                   ; 400012B0 _ E8, 000006FF
        test    al, al                                  ; 400012B5 _ 84. C0
        jz      ?_020                                   ; 400012B7 _ 74, 3B
        cmp     byte ptr [rsp+20H], 0                   ; 400012B9 _ 80. 7C 24, 20, 00
        jnz     ?_015                                   ; 400012BE _ 75, 05
        call    _c_exit                                 ; 400012C0 _ E8, 00000A2B
?_015:  mov     eax, ebx                                ; 400012C5 _ 8B. C3
?_016:  mov     rbx, qword ptr [rsp+40H]                ; 400012C7 _ 48: 8B. 5C 24, 40
        mov     rsi, qword ptr [rsp+48H]                ; 400012CC _ 48: 8B. 74 24, 48
        add     rsp, 48                                 ; 400012D1 _ 48: 83. C4, 30
        pop     rdi                                     ; 400012D5 _ 5F
        ret                                             ; 400012D6 _ C3

?_017:  mov     ecx, 7                                  ; 400012D7 _ B9, 00000007
        call    ?_077                                   ; 400012DC _ E8, 00000587
        nop                                             ; 400012E1 _ 90
?_018:  mov     ecx, 7                                  ; 400012E2 _ B9, 00000007
        call    ?_077                                   ; 400012E7 _ E8, 0000057C
?_019:  mov     ecx, ebx                                ; 400012EC _ 8B. CB
        call    exit                                    ; 400012EE _ E8, 000009D9
        nop                                             ; 400012F3 _ 90
?_020:  mov     ecx, ebx                                ; 400012F4 _ 8B. CB
        call    _exit                                   ; 400012F6 _ E8, 000009D7
        nop                                             ; 400012FB _ 90

Entry_point LABEL NEAR
        sub     rsp, 40                                 ; 400012FC _ 48: 83. EC, 28
        call    ?_063                                   ; 40001300 _ E8, 0000043F
        add     rsp, 40                                 ; 40001305 _ 48: 83. C4, 28
        jmp     ?_008                                   ; 40001309 _ E9, FFFFFE72

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_021   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 40001310 _ 40: 53
        sub     rsp, 32                                 ; 40001312 _ 48: 83. EC, 20
        mov     rbx, rcx                                ; 40001316 _ 48: 8B. D9
        xor     ecx, ecx                                ; 40001319 _ 33. C9
        call    qword ptr [imp_SetUnhandledExceptionFilter]; 4000131B _ FF. 15, 00001CFF(rel)
        mov     rcx, rbx                                ; 40001321 _ 48: 8B. CB
        call    qword ptr [imp_UnhandledExceptionFilter]; 40001324 _ FF. 15, 00001CEE(rel)
        call    qword ptr [imp_GetCurrentProcess]       ; 4000132A _ FF. 15, 00001CF8(rel)
        mov     rcx, rax                                ; 40001330 _ 48: 8B. C8
        mov     edx, 3221226505                         ; 40001333 _ BA, C0000409
        add     rsp, 32                                 ; 40001338 _ 48: 83. C4, 20
        pop     rbx                                     ; 4000133C _ 5B
; Note: Prefix valid but unnecessary
; Note: Prefix bit or byte has no meaning in this context
        jmp     qword ptr [imp_TerminateProcess]        ; 4000133D _ 48: FF. 25, 00001CEC(rel)

?_022:  mov     qword ptr [rsp+8H], rcx                 ; 40001344 _ 48: 89. 4C 24, 08
        sub     rsp, 56                                 ; 40001349 _ 48: 83. EC, 38
        mov     ecx, 23                                 ; 4000134D _ B9, 00000017
        call    IsProcessorFeaturePresent               ; 40001352 _ E8, 000009CF
        test    eax, eax                                ; 40001357 _ 85. C0
        jz      ?_023                                   ; 40001359 _ 74, 07
        mov     ecx, 2                                  ; 4000135B _ B9, 00000002
        int     41                                      ; 40001360 _ CD, 29
?_023:  lea     rcx, ptr [?_149]                        ; 40001362 _ 48: 8D. 0D, 00002D77(rel)
        call    ?_024                                   ; 40001369 _ E8, 000000AA
        mov     rax, qword ptr [rsp+38H]                ; 4000136E _ 48: 8B. 44 24, 38
        mov     qword ptr [?_152], rax                  ; 40001373 _ 48: 89. 05, 00002E5E(rel)
        lea     rax, ptr [rsp+38H]                      ; 4000137A _ 48: 8D. 44 24, 38
        add     rax, 8                                  ; 4000137F _ 48: 83. C0, 08
        mov     qword ptr [?_151], rax                  ; 40001383 _ 48: 89. 05, 00002DEE(rel)
        mov     rax, qword ptr [?_152]                  ; 4000138A _ 48: 8B. 05, 00002E47(rel)
        mov     qword ptr [?_146], rax                  ; 40001391 _ 48: 89. 05, 00002CB8(rel)
        mov     rax, qword ptr [rsp+40H]                ; 40001398 _ 48: 8B. 44 24, 40
        mov     qword ptr [?_150], rax                  ; 4000139D _ 48: 89. 05, 00002DBC(rel)
        mov     dword ptr [?_144], -1073740791          ; 400013A4 _ C7. 05, 00002C92(rel), C0000409
        mov     dword ptr [?_145], 1                    ; 400013AE _ C7. 05, 00002C8C(rel), 00000001
        mov     dword ptr [?_147], 1                    ; 400013B8 _ C7. 05, 00002C96(rel), 00000001
        mov     eax, 8                                  ; 400013C2 _ B8, 00000008
        imul    rax, rax, 0                             ; 400013C7 _ 48: 6B. C0, 00
        lea     rcx, ptr [?_148]                        ; 400013CB _ 48: 8D. 0D, 00002C8E(rel)
        mov     qword ptr [rcx+rax], 2                  ; 400013D2 _ 48: C7. 04 01, 00000002
        mov     eax, 8                                  ; 400013DA _ B8, 00000008
        imul    rax, rax, 0                             ; 400013DF _ 48: 6B. C0, 00
        mov     rcx, qword ptr [?_137]                  ; 400013E3 _ 48: 8B. 0D, 00002C16(rel)
        mov     qword ptr [rsp+rax+20H], rcx            ; 400013EA _ 48: 89. 4C 04, 20
        mov     eax, 8                                  ; 400013EF _ B8, 00000008
        imul    rax, rax, 1                             ; 400013F4 _ 48: 6B. C0, 01
        mov     rcx, qword ptr [?_138]                  ; 400013F8 _ 48: 8B. 0D, 00002C09(rel)
        mov     qword ptr [rsp+rax+20H], rcx            ; 400013FF _ 48: 89. 4C 04, 20
        lea     rcx, ptr [?_125]                        ; 40001404 _ 48: 8D. 0D, 00001E15(rel)
        call    ?_021                                   ; 4000140B _ E8, FFFFFF00
        add     rsp, 56                                 ; 40001410 _ 48: 83. C4, 38
        ret                                             ; 40001414 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   8

?_024   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 40001418 _ 40: 53
        push    rsi                                     ; 4000141A _ 56
        push    rdi                                     ; 4000141B _ 57
        sub     rsp, 64                                 ; 4000141C _ 48: 83. EC, 40
        mov     rbx, rcx                                ; 40001420 _ 48: 8B. D9
        call    qword ptr [imp_RtlCaptureContext]       ; 40001423 _ FF. 15, 00001C2F(rel)
        mov     rsi, qword ptr [rbx+0F8H]               ; 40001429 _ 48: 8B. B3, 000000F8
        xor     edi, edi                                ; 40001430 _ 33. FF
?_025:  xor     r8d, r8d                                ; 40001432 _ 45: 33. C0
        lea     rdx, ptr [rsp+60H]                      ; 40001435 _ 48: 8D. 54 24, 60
        mov     rcx, rsi                                ; 4000143A _ 48: 8B. CE
        call    qword ptr [imp_RtlLookupFunctionEntry]  ; 4000143D _ FF. 15, 00001BC5(rel)
        test    rax, rax                                ; 40001443 _ 48: 85. C0
        jz      ?_026                                   ; 40001446 _ 74, 39
        and     qword ptr [rsp+38H], 00H                ; 40001448 _ 48: 83. 64 24, 38, 00
        lea     rcx, ptr [rsp+68H]                      ; 4000144E _ 48: 8D. 4C 24, 68
        mov     rdx, qword ptr [rsp+60H]                ; 40001453 _ 48: 8B. 54 24, 60
        mov     r9, rax                                 ; 40001458 _ 4C: 8B. C8
        mov     qword ptr [rsp+30H], rcx                ; 4000145B _ 48: 89. 4C 24, 30
        mov     r8, rsi                                 ; 40001460 _ 4C: 8B. C6
        lea     rcx, ptr [rsp+70H]                      ; 40001463 _ 48: 8D. 4C 24, 70
        mov     qword ptr [rsp+28H], rcx                ; 40001468 _ 48: 89. 4C 24, 28
        xor     ecx, ecx                                ; 4000146D _ 33. C9
        mov     qword ptr [rsp+20H], rbx                ; 4000146F _ 48: 89. 5C 24, 20
        call    qword ptr [imp_RtlVirtualUnwind]        ; 40001474 _ FF. 15, 00001B96(rel)
        inc     edi                                     ; 4000147A _ FF. C7
        cmp     edi, 2                                  ; 4000147C _ 83. FF, 02
        jl      ?_025                                   ; 4000147F _ 7C, B1
?_026:  add     rsp, 64                                 ; 40001481 _ 48: 83. C4, 40
        pop     rdi                                     ; 40001485 _ 5F
        pop     rsi                                     ; 40001486 _ 5E
        pop     rbx                                     ; 40001487 _ 5B
        ret                                             ; 40001488 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4

?_027   LABEL NEAR
        sub     rsp, 40                                 ; 4000148C _ 48: 83. EC, 28
        call    ?_103                                   ; 40001490 _ E8, 000007EF
        test    eax, eax                                ; 40001495 _ 85. C0
        jz      ?_030                                   ; 40001497 _ 74, 21
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
ASSUME  gs:NOTHING
        mov     rax, qword ptr gs:[30H]                 ; 40001499 _ 65 48: 8B. 04 25, 00000030
        mov     rcx, qword ptr [rax+8H]                 ; 400014A2 _ 48: 8B. 48, 08
        jmp     ?_029                                   ; 400014A6 _ EB, 05

?_028:  cmp     rcx, rax                                ; 400014A8 _ 48: 3B. C8
        jz      ?_032                                   ; 400014AB _ 74, 14
?_029:  xor     eax, eax                                ; 400014AD _ 33. C0
        lock cmpxchg qword ptr [?_155], rcx             ; 400014AF _ F0 48: 0F B1. 0D, 00003100(rel)
        jnz     ?_028                                   ; 400014B8 _ 75, EE
?_030:  xor     al, al                                  ; 400014BA _ 32. C0
?_031:  add     rsp, 40                                 ; 400014BC _ 48: 83. C4, 28
        ret                                             ; 400014C0 _ C3

?_032:  mov     al, 1                                   ; 400014C1 _ B0, 01
        jmp     ?_031                                   ; 400014C3 _ EB, F7

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   8

?_033   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 400014C8 _ 40: 53
        sub     rsp, 32                                 ; 400014CA _ 48: 83. EC, 20
        movzx   eax, byte ptr [?_160]                   ; 400014CE _ 0F B6. 05, 0000311B(rel)
        test    ecx, ecx                                ; 400014D5 _ 85. C9
        mov     ebx, 1                                  ; 400014D7 _ BB, 00000001
        cmove   eax, ebx                                ; 400014DC _ 0F 44. C3
        mov     byte ptr [?_160], al                    ; 400014DF _ 88. 05, 0000310B(rel)
        call    ?_096                                   ; 400014E5 _ E8, 000005DE
        call    ?_069                                   ; 400014EA _ E8, 00000329
        test    al, al                                  ; 400014EF _ 84. C0
        jnz     ?_035                                   ; 400014F1 _ 75, 04
?_034:  xor     al, al                                  ; 400014F3 _ 32. C0
        jmp     ?_037                                   ; 400014F5 _ EB, 14

?_035:  call    ?_069                                   ; 400014F7 _ E8, 0000031C
        test    al, al                                  ; 400014FC _ 84. C0
        jnz     ?_036                                   ; 400014FE _ 75, 09
        xor     ecx, ecx                                ; 40001500 _ 33. C9
        call    ?_069                                   ; 40001502 _ E8, 00000311
        jmp     ?_034                                   ; 40001507 _ EB, EA

?_036:  mov     al, bl                                  ; 40001509 _ 8A. C3
?_037:  add     rsp, 32                                 ; 4000150B _ 48: 83. C4, 20
        pop     rbx                                     ; 4000150F _ 5B
        ret                                             ; 40001510 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4

?_038   LABEL NEAR
        mov     qword ptr [rsp+8H], rbx                 ; 40001514 _ 48: 89. 5C 24, 08
        push    rbp                                     ; 40001519 _ 55
        mov     rbp, rsp                                ; 4000151A _ 48: 8B. EC
        sub     rsp, 64                                 ; 4000151D _ 48: 83. EC, 40
        cmp     byte ptr [?_154], 0                     ; 40001521 _ 80. 3D, 0000308C(rel), 00
        mov     ebx, ecx                                ; 40001528 _ 8B. D9
        jne     ?_042                                   ; 4000152A _ 0F 85, 000000A6
        cmp     ecx, 1                                  ; 40001530 _ 83. F9, 01
        ja      ?_044                                   ; 40001533 _ 0F 87, 000000AA
        call    ?_103                                   ; 40001539 _ E8, 00000746
        test    eax, eax                                ; 4000153E _ 85. C0
        jz      ?_040                                   ; 40001540 _ 74, 28
        test    ebx, ebx                                ; 40001542 _ 85. DB
        jnz     ?_040                                   ; 40001544 _ 75, 24
        lea     rcx, ptr [?_156]                        ; 40001546 _ 48: 8D. 0D, 00003073(rel)
        call    _initialize_onexit_table                ; 4000154D _ E8, 000007BC
        test    eax, eax                                ; 40001552 _ 85. C0
        jnz     ?_039                                   ; 40001554 _ 75, 10
        lea     rcx, ptr [?_158]                        ; 40001556 _ 48: 8D. 0D, 0000307B(rel)
        call    _initialize_onexit_table                ; 4000155D _ E8, 000007AC
        test    eax, eax                                ; 40001562 _ 85. C0
        jz      ?_041                                   ; 40001564 _ 74, 69
?_039:  xor     al, al                                  ; 40001566 _ 32. C0
        jmp     ?_043                                   ; 40001568 _ EB, 6E

?_040:  mov     rdx, qword ptr [?_137]                  ; 4000156A _ 48: 8B. 15, 00002A8F(rel)
        mov     ecx, 64                                 ; 40001571 _ B9, 00000040
        mov     eax, edx                                ; 40001576 _ 8B. C2
        and     eax, 3FH                                ; 40001578 _ 83. E0, 3F
        sub     ecx, eax                                ; 4000157B _ 2B. C8
        or      rax, 0FFFFFFFFFFFFFFFFH                 ; 4000157D _ 48: 83. C8, FF
        ror     rax, cl                                 ; 40001581 _ 48: D3. C8
        xor     rax, rdx                                ; 40001584 _ 48: 33. C2
        mov     qword ptr [rbp-20H], rax                ; 40001587 _ 48: 89. 45, E0
        mov     qword ptr [rbp-18H], rax                ; 4000158B _ 48: 89. 45, E8
        movups  xmm0, xmmword ptr [rbp-20H]             ; 4000158F _ 0F 10. 45, E0
        mov     qword ptr [rbp-10H], rax                ; 40001593 _ 48: 89. 45, F0
        movsd   xmm1, qword ptr [rbp-10H]               ; 40001597 _ F2: 0F 10. 4D, F0
        movups  xmmword ptr [?_156], xmm0               ; 4000159C _ 0F 11. 05, 0000301D(rel)
        mov     qword ptr [rbp-20H], rax                ; 400015A3 _ 48: 89. 45, E0
        mov     qword ptr [rbp-18H], rax                ; 400015A7 _ 48: 89. 45, E8
        movups  xmm0, xmmword ptr [rbp-20H]             ; 400015AB _ 0F 10. 45, E0
        mov     qword ptr [rbp-10H], rax                ; 400015AF _ 48: 89. 45, F0
        movsd   qword ptr [?_157], xmm1                 ; 400015B3 _ F2: 0F 11. 0D, 00003015(rel)
        movsd   xmm1, qword ptr [rbp-10H]               ; 400015BB _ F2: 0F 10. 4D, F0
; Note: Memory operand is misaligned. Performance penalty
        movups  xmmword ptr [?_158], xmm0               ; 400015C0 _ 0F 11. 05, 00003011(rel)
        movsd   qword ptr [?_159], xmm1                 ; 400015C7 _ F2: 0F 11. 0D, 00003019(rel)
?_041:  mov     byte ptr [?_154], 1                     ; 400015CF _ C6. 05, 00002FDE(rel), 01
?_042:  mov     al, 1                                   ; 400015D6 _ B0, 01
?_043:  mov     rbx, qword ptr [rsp+50H]                ; 400015D8 _ 48: 8B. 5C 24, 50
        add     rsp, 64                                 ; 400015DD _ 48: 83. C4, 40
        pop     rbp                                     ; 400015E1 _ 5D
        ret                                             ; 400015E2 _ C3

?_044:  mov     ecx, 5                                  ; 400015E3 _ B9, 00000005
        call    ?_077                                   ; 400015E8 _ E8, 0000027B
        int 3    ; breakpoint or filler                 ; 400015ED _ CC
        int 3    ; breakpoint or filler                 ; 400015EE _ CC
        int 3    ; breakpoint or filler                 ; 400015EF _ CC

?_045   LABEL NEAR
        sub     rsp, 24                                 ; 400015F0 _ 48: 83. EC, 18
        mov     r8, rcx                                 ; 400015F4 _ 4C: 8B. C1
        mov     eax, 23117                              ; 400015F7 _ B8, 00005A4D
        cmp     word ptr [__ImageBase], ax              ; 400015FC _ 66: 39. 05, FFFFE9FD(rel)
        jnz     ?_052                                   ; 40001603 _ 75, 79
; Note: Absolute memory address without relocation
        movsxd  rax, dword ptr DS:[14000003CH]          ; 40001605 _ 48: 63. 05, FFFFEA30
        lea     rdx, ptr [__ImageBase]                  ; 4000160C _ 48: 8D. 15, FFFFE9ED(rel)
        lea     rcx, ptr [rax+rdx]                      ; 40001613 _ 48: 8D. 0C 10
        cmp     dword ptr [rcx], 17744                  ; 40001617 _ 81. 39, 00004550
        jnz     ?_052                                   ; 4000161D _ 75, 5F
        mov     eax, 523                                ; 4000161F _ B8, 0000020B
        cmp     word ptr [rcx+18H], ax                  ; 40001624 _ 66: 39. 41, 18
        jnz     ?_052                                   ; 40001628 _ 75, 54
        sub     r8, rdx                                 ; 4000162A _ 4C: 2B. C2
        movzx   eax, word ptr [rcx+14H]                 ; 4000162D _ 0F B7. 41, 14
        lea     rdx, ptr [rcx+18H]                      ; 40001631 _ 48: 8D. 51, 18
        add     rdx, rax                                ; 40001635 _ 48: 03. D0
        movzx   eax, word ptr [rcx+6H]                  ; 40001638 _ 0F B7. 41, 06
        lea     rcx, ptr [rax+rax*4]                    ; 4000163C _ 48: 8D. 0C 80
        lea     r9, ptr [rdx+rcx*8]                     ; 40001640 _ 4C: 8D. 0C CA
?_046:  mov     qword ptr [rsp], rdx                    ; 40001644 _ 48: 89. 14 24
        cmp     rdx, r9                                 ; 40001648 _ 49: 3B. D1
        jz      ?_048                                   ; 4000164B _ 74, 18
        mov     ecx, dword ptr [rdx+0CH]                ; 4000164D _ 8B. 4A, 0C
        cmp     r8, rcx                                 ; 40001650 _ 4C: 3B. C1
        jc      ?_047                                   ; 40001653 _ 72, 0A
        mov     eax, dword ptr [rdx+8H]                 ; 40001655 _ 8B. 42, 08
        add     eax, ecx                                ; 40001658 _ 03. C1
        cmp     r8, rax                                 ; 4000165A _ 4C: 3B. C0
        jc      ?_049                                   ; 4000165D _ 72, 08
?_047:  add     rdx, 40                                 ; 4000165F _ 48: 83. C2, 28
        jmp     ?_046                                   ; 40001663 _ EB, DF

?_048:  xor     edx, edx                                ; 40001665 _ 33. D2
?_049:  test    rdx, rdx                                ; 40001667 _ 48: 85. D2
        jnz     ?_050                                   ; 4000166A _ 75, 04
        xor     al, al                                  ; 4000166C _ 32. C0
        jmp     ?_053                                   ; 4000166E _ EB, 14

?_050:  cmp     dword ptr [rdx+24H], 0                  ; 40001670 _ 83. 7A, 24, 00
        jge     ?_051                                   ; 40001674 _ 7D, 04
        xor     al, al                                  ; 40001676 _ 32. C0
        jmp     ?_053                                   ; 40001678 _ EB, 0A

?_051:  mov     al, 1                                   ; 4000167A _ B0, 01
        jmp     ?_053                                   ; 4000167C _ EB, 06

?_052:  xor     al, al                                  ; 4000167E _ 32. C0
        jmp     ?_053                                   ; 40001680 _ EB, 02

; Note: No jump seems to point here
        xor     al, al                                  ; 40001682 _ 32. C0
?_053:  add     rsp, 24                                 ; 40001684 _ 48: 83. C4, 18
        ret                                             ; 40001688 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4

?_054   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 4000168C _ 40: 53
        sub     rsp, 32                                 ; 4000168E _ 48: 83. EC, 20
        mov     bl, cl                                  ; 40001692 _ 8A. D9
        call    ?_103                                   ; 40001694 _ E8, 000005EB
        xor     edx, edx                                ; 40001699 _ 33. D2
        test    eax, eax                                ; 4000169B _ 85. C0
        jz      ?_055                                   ; 4000169D _ 74, 0B
        test    bl, bl                                  ; 4000169F _ 84. DB
        jnz     ?_055                                   ; 400016A1 _ 75, 07
        xchg    qword ptr [?_155], rdx                  ; 400016A3 _ 48: 87. 15, 00002F0E(rel)
?_055:  add     rsp, 32                                 ; 400016AA _ 48: 83. C4, 20
        pop     rbx                                     ; 400016AE _ 5B
        ret                                             ; 400016AF _ C3

?_056   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 400016B0 _ 40: 53
        sub     rsp, 32                                 ; 400016B2 _ 48: 83. EC, 20
        cmp     byte ptr [?_160], 0                     ; 400016B6 _ 80. 3D, 00002F33(rel), 00
        mov     bl, cl                                  ; 400016BD _ 8A. D9
        jz      ?_057                                   ; 400016BF _ 74, 04
        test    dl, dl                                  ; 400016C1 _ 84. D2
        jnz     ?_058                                   ; 400016C3 _ 75, 0E
?_057:  mov     cl, bl                                  ; 400016C5 _ 8A. CB
        call    ?_069                                   ; 400016C7 _ E8, 0000014C
        mov     cl, bl                                  ; 400016CC _ 8A. CB
        call    ?_069                                   ; 400016CE _ E8, 00000145
?_058:  mov     al, 1                                   ; 400016D3 _ B0, 01
        add     rsp, 32                                 ; 400016D5 _ 48: 83. C4, 20
        pop     rbx                                     ; 400016D9 _ 5B
        ret                                             ; 400016DA _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   4

?_059   LABEL NEAR
; Note: Prefix bit or byte has no meaning in this context
        push    rbx                                     ; 400016DC _ 40: 53
        sub     rsp, 32                                 ; 400016DE _ 48: 83. EC, 20
        mov     rdx, qword ptr [?_137]                  ; 400016E2 _ 48: 8B. 15, 00002917(rel)
        mov     rbx, rcx                                ; 400016E9 _ 48: 8B. D9
        mov     ecx, edx                                ; 400016EC _ 8B. CA
        xor     rdx, qword ptr [?_156]                  ; 400016EE _ 48: 33. 15, 00002ECB(rel)
        and     ecx, 3FH                                ; 400016F5 _ 83. E1, 3F
        ror     rdx, cl                                 ; 400016F8 _ 48: D3. CA
        cmp     rdx, -1                                 ; 400016FB _ 48: 83. FA, FF
        jnz     ?_060                                   ; 400016FF _ 75, 0A
        mov     rcx, rbx                                ; 40001701 _ 48: 8B. CB
        call    _crt_atexit                             ; 40001704 _ E8, 00000611
        jmp     ?_061                                   ; 40001709 _ EB, 0F

?_060:  mov     rdx, rbx                                ; 4000170B _ 48: 8B. D3
        lea     rcx, ptr [?_156]                        ; 4000170E _ 48: 8D. 0D, 00002EAB(rel)
        call    _register_onexit_function               ; 40001715 _ E8, 000005FA
?_061:  xor     ecx, ecx                                ; 4000171A _ 33. C9
        test    eax, eax                                ; 4000171C _ 85. C0
        cmove   rcx, rbx                                ; 4000171E _ 48: 0F 44. CB
        mov     rax, rcx                                ; 40001722 _ 48: 8B. C1
        add     rsp, 32                                 ; 40001725 _ 48: 83. C4, 20
        pop     rbx                                     ; 40001729 _ 5B
        ret                                             ; 4000172A _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   4

?_062   LABEL NEAR
        sub     rsp, 40                                 ; 4000172C _ 48: 83. EC, 28
        call    ?_059                                   ; 40001730 _ E8, FFFFFFA7
        neg     rax                                     ; 40001735 _ 48: F7. D8
        sbb     eax, eax                                ; 40001738 _ 1B. C0
        neg     eax                                     ; 4000173A _ F7. D8
        dec     eax                                     ; 4000173C _ FF. C8
        add     rsp, 40                                 ; 4000173E _ 48: 83. C4, 28
        ret                                             ; 40001742 _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   4

?_063   LABEL NEAR
        mov     qword ptr [rsp+20H], rbx                ; 40001744 _ 48: 89. 5C 24, 20
        push    rbp                                     ; 40001749 _ 55
        mov     rbp, rsp                                ; 4000174A _ 48: 8B. EC
        sub     rsp, 32                                 ; 4000174D _ 48: 83. EC, 20
        mov     rax, qword ptr [?_137]                  ; 40001751 _ 48: 8B. 05, 000028A8(rel)
        mov     rbx, 2B992DDFA232H                      ; 40001758 _ 48: BB, 00002B992DDFA232
        cmp     rax, rbx                                ; 40001762 _ 48: 3B. C3
        jnz     ?_064                                   ; 40001765 _ 75, 75
        xor     eax, eax                                ; 40001767 _ 33. C0
        lea     rcx, ptr [rbp+18H]                      ; 40001769 _ 48: 8D. 4D, 18
        mov     qword ptr [rbp+18H], rax                ; 4000176D _ 48: 89. 45, 18
        call    qword ptr [imp_GetSystemTimeAsFileTime] ; 40001771 _ FF. 15, 000018E9(rel)
        mov     rax, qword ptr [rbp+18H]                ; 40001777 _ 48: 8B. 45, 18
        mov     qword ptr [rbp+10H], rax                ; 4000177B _ 48: 89. 45, 10
        call    qword ptr [imp_GetCurrentThreadId]      ; 4000177F _ FF. 15, 000018E3(rel)
        mov     eax, eax                                ; 40001785 _ 8B. C0
        xor     qword ptr [rbp+10H], rax                ; 40001787 _ 48: 31. 45, 10
        call    qword ptr [imp_GetCurrentProcessId]     ; 4000178B _ FF. 15, 000018DF(rel)
        mov     eax, eax                                ; 40001791 _ 8B. C0
        lea     rcx, ptr [rbp+20H]                      ; 40001793 _ 48: 8D. 4D, 20
        xor     qword ptr [rbp+10H], rax                ; 40001797 _ 48: 31. 45, 10
        call    qword ptr [imp_QueryPerformanceCounter] ; 4000179B _ FF. 15, 0000189F(rel)
        mov     eax, dword ptr [rbp+20H]                ; 400017A1 _ 8B. 45, 20
        lea     rcx, ptr [rbp+10H]                      ; 400017A4 _ 48: 8D. 4D, 10
        shl     rax, 32                                 ; 400017A8 _ 48: C1. E0, 20
        xor     rax, qword ptr [rbp+20H]                ; 400017AC _ 48: 33. 45, 20
        xor     rax, qword ptr [rbp+10H]                ; 400017B0 _ 48: 33. 45, 10
        xor     rax, rcx                                ; 400017B4 _ 48: 33. C1
        mov     rcx, 0FFFFFFFFFFFFH                     ; 400017B7 _ 48: B9, 0000FFFFFFFFFFFF
        and     rax, rcx                                ; 400017C1 _ 48: 23. C1
        mov     rcx, 2B992DDFA233H                      ; 400017C4 _ 48: B9, 00002B992DDFA233
        cmp     rax, rbx                                ; 400017CE _ 48: 3B. C3
        cmove   rax, rcx                                ; 400017D1 _ 48: 0F 44. C1
        mov     qword ptr [?_137], rax                  ; 400017D5 _ 48: 89. 05, 00002824(rel)
?_064:  mov     rbx, qword ptr [rsp+48H]                ; 400017DC _ 48: 8B. 5C 24, 48
        not     rax                                     ; 400017E1 _ 48: F7. D0
        mov     qword ptr [?_138], rax                  ; 400017E4 _ 48: 89. 05, 0000281D(rel)
        add     rsp, 32                                 ; 400017EB _ 48: 83. C4, 20
        pop     rbp                                     ; 400017EF _ 5D
        ret                                             ; 400017F0 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4

?_065   LABEL NEAR
        xor     eax, eax                                ; 400017F4 _ 33. C0
        ret                                             ; 400017F6 _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   8

?_066   LABEL NEAR
        mov     eax, 1                                  ; 400017F8 _ B8, 00000001
        ret                                             ; 400017FD _ C3

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_067   LABEL NEAR
        mov     eax, 16384                              ; 40001800 _ B8, 00004000
        ret                                             ; 40001805 _ C3

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_068   LABEL NEAR
        lea     rcx, ptr [?_161]                        ; 40001808 _ 48: 8D. 0D, 00002DF1(rel)
; Note: Prefix valid but unnecessary
; Note: Prefix bit or byte has no meaning in this context
        jmp     qword ptr [imp_InitializeSListHead]     ; 4000180F _ 48: FF. 25, 000017EA(rel)

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_069   LABEL NEAR
        mov     al, 1                                   ; 40001818 _ B0, 01
        ret                                             ; 4000181A _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   4

?_070   LABEL NEAR
        ret     0                                       ; 4000181C _ C2, 0000

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   8

?_071   LABEL NEAR
        lea     rax, ptr [?_162]                        ; 40001820 _ 48: 8D. 05, 00002DE9(rel)
        ret                                             ; 40001827 _ C3

?_072   LABEL NEAR
        sub     rsp, 40                                 ; 40001828 _ 48: 83. EC, 28
        call    ?_002                                   ; 4000182C _ E8, FFFFF82F
        or      qword ptr [rax], 04H                    ; 40001831 _ 48: 83. 08, 04
        call    ?_071                                   ; 40001835 _ E8, FFFFFFE6
        or      qword ptr [rax], 02H                    ; 4000183A _ 48: 83. 08, 02
        add     rsp, 40                                 ; 4000183E _ 48: 83. C4, 28
        ret                                             ; 40001842 _ C3

; Filling space: 1H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH

ALIGN   4

?_073   LABEL NEAR
        xor     eax, eax                                ; 40001844 _ 33. C0
        cmp     dword ptr [?_139], eax                  ; 40001846 _ 39. 05, 000027C8(rel)
        sete    al                                      ; 4000184C _ 0F 94. C0
        ret                                             ; 4000184F _ C3

?_074   LABEL NEAR
        lea     rax, ptr [?_167]                        ; 40001850 _ 48: 8D. 05, 00002DE1(rel)
        ret                                             ; 40001857 _ C3

?_075   LABEL NEAR
        lea     rax, ptr [?_166]                        ; 40001858 _ 48: 8D. 05, 00002DD1(rel)
        ret                                             ; 4000185F _ C3

?_076   LABEL NEAR
        and     dword ptr [?_163], 00H                  ; 40001860 _ 83. 25, 00002DB1(rel), 00
        ret                                             ; 40001867 _ C3

?_077   LABEL NEAR
        mov     qword ptr [rsp+8H], rbx                 ; 40001868 _ 48: 89. 5C 24, 08
        push    rbp                                     ; 4000186D _ 55
        lea     rbp, ptr [rsp-4C0H]                     ; 4000186E _ 48: 8D. AC 24, FFFFFB40
        sub     rsp, 1472                               ; 40001876 _ 48: 81. EC, 000005C0
        mov     ebx, ecx                                ; 4000187D _ 8B. D9
        mov     ecx, 23                                 ; 4000187F _ B9, 00000017
        call    IsProcessorFeaturePresent               ; 40001884 _ E8, 0000049D
        test    eax, eax                                ; 40001889 _ 85. C0
        jz      ?_078                                   ; 4000188B _ 74, 04
        mov     ecx, ebx                                ; 4000188D _ 8B. CB
        int     41                                      ; 4000188F _ CD, 29
?_078:  mov     ecx, 3                                  ; 40001891 _ B9, 00000003
        call    ?_076                                   ; 40001896 _ E8, FFFFFFC5
        xor     edx, edx                                ; 4000189B _ 33. D2
        lea     rcx, ptr [rbp-10H]                      ; 4000189D _ 48: 8D. 4D, F0
        mov     r8d, 1232                               ; 400018A1 _ 41: B8, 000004D0
        call    memset                                  ; 400018A7 _ E8, 000003EA
        lea     rcx, ptr [rbp-10H]                      ; 400018AC _ 48: 8D. 4D, F0
        call    qword ptr [imp_RtlCaptureContext]       ; 400018B0 _ FF. 15, 000017A2(rel)
        mov     rbx, qword ptr [rbp+0E8H]               ; 400018B6 _ 48: 8B. 9D, 000000E8
        lea     rdx, ptr [rbp+4D8H]                     ; 400018BD _ 48: 8D. 95, 000004D8
        mov     rcx, rbx                                ; 400018C4 _ 48: 8B. CB
        xor     r8d, r8d                                ; 400018C7 _ 45: 33. C0
        call    qword ptr [imp_RtlLookupFunctionEntry]  ; 400018CA _ FF. 15, 00001738(rel)
        test    rax, rax                                ; 400018D0 _ 48: 85. C0
        jz      ?_079                                   ; 400018D3 _ 74, 3C
        and     qword ptr [rsp+38H], 00H                ; 400018D5 _ 48: 83. 64 24, 38, 00
        lea     rcx, ptr [rbp+4E0H]                     ; 400018DB _ 48: 8D. 8D, 000004E0
        mov     rdx, qword ptr [rbp+4D8H]               ; 400018E2 _ 48: 8B. 95, 000004D8
        mov     r9, rax                                 ; 400018E9 _ 4C: 8B. C8
        mov     qword ptr [rsp+30H], rcx                ; 400018EC _ 48: 89. 4C 24, 30
        mov     r8, rbx                                 ; 400018F1 _ 4C: 8B. C3
        lea     rcx, ptr [rbp+4E8H]                     ; 400018F4 _ 48: 8D. 8D, 000004E8
        mov     qword ptr [rsp+28H], rcx                ; 400018FB _ 48: 89. 4C 24, 28
        lea     rcx, ptr [rbp-10H]                      ; 40001900 _ 48: 8D. 4D, F0
        mov     qword ptr [rsp+20H], rcx                ; 40001904 _ 48: 89. 4C 24, 20
        xor     ecx, ecx                                ; 40001909 _ 33. C9
        call    qword ptr [imp_RtlVirtualUnwind]        ; 4000190B _ FF. 15, 000016FF(rel)
?_079:  mov     rax, qword ptr [rbp+4C8H]               ; 40001911 _ 48: 8B. 85, 000004C8
        lea     rcx, ptr [rsp+50H]                      ; 40001918 _ 48: 8D. 4C 24, 50
        mov     qword ptr [rbp+0E8H], rax               ; 4000191D _ 48: 89. 85, 000000E8
        xor     edx, edx                                ; 40001924 _ 33. D2
        lea     rax, ptr [rbp+4C8H]                     ; 40001926 _ 48: 8D. 85, 000004C8
        mov     r8d, 152                                ; 4000192D _ 41: B8, 00000098
        add     rax, 8                                  ; 40001933 _ 48: 83. C0, 08
        mov     qword ptr [rbp+88H], rax                ; 40001937 _ 48: 89. 85, 00000088
        call    memset                                  ; 4000193E _ E8, 00000353
        mov     rax, qword ptr [rbp+4C8H]               ; 40001943 _ 48: 8B. 85, 000004C8
        mov     qword ptr [rsp+60H], rax                ; 4000194A _ 48: 89. 44 24, 60
        mov     dword ptr [rsp+50H], 1073741845         ; 4000194F _ C7. 44 24, 50, 40000015
        mov     dword ptr [rsp+54H], 1                  ; 40001957 _ C7. 44 24, 54, 00000001
        call    qword ptr [imp_IsDebuggerPresent]       ; 4000195F _ FF. 15, 000016EB(rel)
        cmp     eax, 1                                  ; 40001965 _ 83. F8, 01
        lea     rax, ptr [rsp+50H]                      ; 40001968 _ 48: 8D. 44 24, 50
        mov     qword ptr [rsp+40H], rax                ; 4000196D _ 48: 89. 44 24, 40
        lea     rax, ptr [rbp-10H]                      ; 40001972 _ 48: 8D. 45, F0
        sete    bl                                      ; 40001976 _ 0F 94. C3
        mov     qword ptr [rsp+48H], rax                ; 40001979 _ 48: 89. 44 24, 48
        xor     ecx, ecx                                ; 4000197E _ 33. C9
        call    qword ptr [imp_SetUnhandledExceptionFilter]; 40001980 _ FF. 15, 0000169A(rel)
        lea     rcx, ptr [rsp+40H]                      ; 40001986 _ 48: 8D. 4C 24, 40
        call    qword ptr [imp_UnhandledExceptionFilter]; 4000198B _ FF. 15, 00001687(rel)
        test    eax, eax                                ; 40001991 _ 85. C0
        jnz     ?_080                                   ; 40001993 _ 75, 0C
        test    bl, bl                                  ; 40001995 _ 84. DB
        jnz     ?_080                                   ; 40001997 _ 75, 08
        lea     ecx, ptr [rax+3H]                       ; 40001999 _ 8D. 48, 03
        call    ?_076                                   ; 4000199C _ E8, FFFFFEBF
?_080:  mov     rbx, qword ptr [rsp+5D0H]               ; 400019A1 _ 48: 8B. 9C 24, 000005D0
        add     rsp, 1472                               ; 400019A9 _ 48: 81. C4, 000005C0
        pop     rbp                                     ; 400019B0 _ 5D
        ret                                             ; 400019B1 _ C3

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   4

?_081   LABEL NEAR
        sub     rsp, 40                                 ; 400019B4 _ 48: 83. EC, 28
        xor     ecx, ecx                                ; 400019B8 _ 33. C9
        call    qword ptr [imp_GetModuleHandleW]        ; 400019BA _ FF. 15, 00001688(rel)
        test    rax, rax                                ; 400019C0 _ 48: 85. C0
        jz      ?_082                                   ; 400019C3 _ 74, 3A
        mov     ecx, 23117                              ; 400019C5 _ B9, 00005A4D
        cmp     word ptr [rax], cx                      ; 400019CA _ 66: 39. 08
        jnz     ?_082                                   ; 400019CD _ 75, 30
        movsxd  rcx, dword ptr [rax+3CH]                ; 400019CF _ 48: 63. 48, 3C
        add     rcx, rax                                ; 400019D3 _ 48: 03. C8
        cmp     dword ptr [rcx], 17744                  ; 400019D6 _ 81. 39, 00004550
        jnz     ?_082                                   ; 400019DC _ 75, 21
        mov     eax, 523                                ; 400019DE _ B8, 0000020B
        cmp     word ptr [rcx+18H], ax                  ; 400019E3 _ 66: 39. 41, 18
        jnz     ?_082                                   ; 400019E7 _ 75, 16
        cmp     dword ptr [rcx+84H], 14                 ; 400019E9 _ 83. B9, 00000084, 0E
        jbe     ?_082                                   ; 400019F0 _ 76, 0D
        cmp     dword ptr [rcx+0F8H], 0                 ; 400019F2 _ 83. B9, 000000F8, 00
        jz      ?_082                                   ; 400019F9 _ 74, 04
        mov     al, 1                                   ; 400019FB _ B0, 01
        jmp     ?_083                                   ; 400019FD _ EB, 02

?_082:  xor     al, al                                  ; 400019FF _ 32. C0
?_083:  add     rsp, 40                                 ; 40001A01 _ 48: 83. C4, 28
        ret                                             ; 40001A05 _ C3

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_084   LABEL NEAR
        lea     rcx, ptr [?_085]                        ; 40001A08 _ 48: 8D. 0D, 00000009(rel)
; Note: Prefix valid but unnecessary
; Note: Prefix bit or byte has no meaning in this context
        jmp     qword ptr [imp_SetUnhandledExceptionFilter]; 40001A0F _ 48: FF. 25, 0000160A(rel)

; Filling space: 2H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH

ALIGN   8

?_085   LABEL NEAR
        sub     rsp, 40                                 ; 40001A18 _ 48: 83. EC, 28
        mov     rax, qword ptr [rcx]                    ; 40001A1C _ 48: 8B. 01
        cmp     dword ptr [rax], -529697949             ; 40001A1F _ 81. 38, E06D7363
        jnz     ?_086                                   ; 40001A25 _ 75, 1C
        cmp     dword ptr [rax+18H], 4                  ; 40001A27 _ 83. 78, 18, 04
        jnz     ?_086                                   ; 40001A2B _ 75, 16
        mov     ecx, dword ptr [rax+20H]                ; 40001A2D _ 8B. 48, 20
        lea     eax, ptr [rcx-19930520H]                ; 40001A30 _ 8D. 81, E66CFAE0
        cmp     eax, 2                                  ; 40001A36 _ 83. F8, 02
        jbe     ?_087                                   ; 40001A39 _ 76, 0F
        cmp     ecx, 26820608                           ; 40001A3B _ 81. F9, 01994000
        jz      ?_087                                   ; 40001A41 _ 74, 07
?_086:  xor     eax, eax                                ; 40001A43 _ 33. C0
        add     rsp, 40                                 ; 40001A45 _ 48: 83. C4, 28
        ret                                             ; 40001A49 _ C3

?_087:  call    terminate                               ; 40001A4A _ E8, 000002D1
        int 3    ; breakpoint or filler                 ; 40001A4F _ CC

?_088   LABEL NEAR
        mov     qword ptr [rsp+8H], rbx                 ; 40001A50 _ 48: 89. 5C 24, 08
        push    rdi                                     ; 40001A55 _ 57
        sub     rsp, 32                                 ; 40001A56 _ 48: 83. EC, 20
        lea     rbx, ptr [?_135]                        ; 40001A5A _ 48: 8D. 1D, 00001CAF(rel)
        lea     rdi, ptr [?_135]                        ; 40001A61 _ 48: 8D. 3D, 00001CA8(rel)
        jmp     ?_091                                   ; 40001A68 _ EB, 12

?_089:  mov     rax, qword ptr [rbx]                    ; 40001A6A _ 48: 8B. 03
        test    rax, rax                                ; 40001A6D _ 48: 85. C0
        jz      ?_090                                   ; 40001A70 _ 74, 06
        call    qword ptr [?_120]                       ; 40001A72 _ FF. 15, 00001748(rel)
?_090:  add     rbx, 8                                  ; 40001A78 _ 48: 83. C3, 08
?_091:  cmp     rbx, rdi                                ; 40001A7C _ 48: 3B. DF
        jc      ?_089                                   ; 40001A7F _ 72, E9
        mov     rbx, qword ptr [rsp+30H]                ; 40001A81 _ 48: 8B. 5C 24, 30
        add     rsp, 32                                 ; 40001A86 _ 48: 83. C4, 20
        pop     rdi                                     ; 40001A8A _ 5F
        ret                                             ; 40001A8B _ C3

?_092   LABEL NEAR
        mov     qword ptr [rsp+8H], rbx                 ; 40001A8C _ 48: 89. 5C 24, 08
        push    rdi                                     ; 40001A91 _ 57
        sub     rsp, 32                                 ; 40001A92 _ 48: 83. EC, 20
        lea     rbx, ptr [?_136]                        ; 40001A96 _ 48: 8D. 1D, 00001C83(rel)
        lea     rdi, ptr [?_136]                        ; 40001A9D _ 48: 8D. 3D, 00001C7C(rel)
        jmp     ?_095                                   ; 40001AA4 _ EB, 12

?_093:  mov     rax, qword ptr [rbx]                    ; 40001AA6 _ 48: 8B. 03
        test    rax, rax                                ; 40001AA9 _ 48: 85. C0
        jz      ?_094                                   ; 40001AAC _ 74, 06
        call    qword ptr [?_120]                       ; 40001AAE _ FF. 15, 0000170C(rel)
?_094:  add     rbx, 8                                  ; 40001AB4 _ 48: 83. C3, 08
?_095:  cmp     rbx, rdi                                ; 40001AB8 _ 48: 3B. DF
        jc      ?_093                                   ; 40001ABB _ 72, E9
        mov     rbx, qword ptr [rsp+30H]                ; 40001ABD _ 48: 8B. 5C 24, 30
        add     rsp, 32                                 ; 40001AC2 _ 48: 83. C4, 20
        pop     rdi                                     ; 40001AC6 _ 5F
        ret                                             ; 40001AC7 _ C3

?_096   LABEL NEAR
        mov     qword ptr [rsp+10H], rbx                ; 40001AC8 _ 48: 89. 5C 24, 10
        mov     qword ptr [rsp+18H], rbp                ; 40001ACD _ 48: 89. 6C 24, 18
        push    rsi                                     ; 40001AD2 _ 56
        push    rdi                                     ; 40001AD3 _ 57
        push    r14                                     ; 40001AD4 _ 41: 56
        sub     rsp, 16                                 ; 40001AD6 _ 48: 83. EC, 10
        xor     ecx, ecx                                ; 40001ADA _ 33. C9
        mov     dword ptr [?_141], 2                    ; 40001ADC _ C7. 05, 00002536(rel), 00000002
        xor     eax, eax                                ; 40001AE6 _ 33. C0
        mov     dword ptr [?_140], 1                    ; 40001AE8 _ C7. 05, 00002526(rel), 00000001
        cpuid                                           ; 40001AF2 _ 0F A2
        mov     r8d, ecx                                ; 40001AF4 _ 44: 8B. C1
        mov     r10d, edx                               ; 40001AF7 _ 44: 8B. D2
        xor     ecx, 444D4163H                          ; 40001AFA _ 81. F1, 444D4163
        xor     edx, 69746E65H                          ; 40001B00 _ 81. F2, 69746E65
        mov     ebp, ebx                                ; 40001B06 _ 8B. EB
        xor     r11d, r11d                              ; 40001B08 _ 45: 33. DB
        xor     ebp, 68747541H                          ; 40001B0B _ 81. F5, 68747541
        mov     r14d, eax                               ; 40001B11 _ 44: 8B. F0
        or      ebp, edx                                ; 40001B14 _ 0B. EA
        xor     r10d, 49656E69H                         ; 40001B16 _ 41: 81. F2, 49656E69
        or      ebp, ecx                                ; 40001B1D _ 0B. E9
        xor     r8d, 6C65746EH                          ; 40001B1F _ 41: 81. F0, 6C65746E
        mov     r9d, ebx                                ; 40001B26 _ 44: 8B. CB
        lea     eax, ptr [r11+1H]                       ; 40001B29 _ 41: 8D. 43, 01
        xor     ecx, ecx                                ; 40001B2D _ 33. C9
        xor     r9d, 756E6547H                          ; 40001B2F _ 41: 81. F1, 756E6547
        cpuid                                           ; 40001B36 _ 0F A2
        or      r10d, r8d                               ; 40001B38 _ 45: 0B. D0
        mov     dword ptr [rsp], eax                    ; 40001B3B _ 89. 04 24
        or      r10d, r9d                               ; 40001B3E _ 45: 0B. D1
        mov     dword ptr [rsp+4H], ebx                 ; 40001B41 _ 89. 5C 24, 04
        mov     esi, ecx                                ; 40001B45 _ 8B. F1
        mov     dword ptr [rsp+8H], ecx                 ; 40001B47 _ 89. 4C 24, 08
        mov     edi, eax                                ; 40001B4B _ 8B. F8
        mov     dword ptr [rsp+0CH], edx                ; 40001B4D _ 89. 54 24, 0C
        jnz     ?_098                                   ; 40001B51 _ 75, 50
        or      qword ptr [?_142], 0FFFFFFFFFFFFFFFFH   ; 40001B53 _ 48: 83. 0D, 000024C5(rel), FF
        and     eax, 0FFF3FF0H                          ; 40001B5B _ 25, 0FFF3FF0
        cmp     eax, 67264                              ; 40001B60 _ 3D, 000106C0
        jz      ?_097                                   ; 40001B65 _ 74, 28
        cmp     eax, 132704                             ; 40001B67 _ 3D, 00020660
        jz      ?_097                                   ; 40001B6C _ 74, 21
        cmp     eax, 132720                             ; 40001B6E _ 3D, 00020670
        jz      ?_097                                   ; 40001B73 _ 74, 1A
        add     eax, -198224                            ; 40001B75 _ 05, FFFCF9B0
        cmp     eax, 32                                 ; 40001B7A _ 83. F8, 20
        ja      ?_098                                   ; 40001B7D _ 77, 24
        mov     rcx, 100010001H                         ; 40001B7F _ 48: B9, 0000000100010001
        bt      rcx, rax                                ; 40001B89 _ 48: 0F A3. C1
        jnc     ?_098                                   ; 40001B8D _ 73, 14
?_097:  mov     r8d, dword ptr [?_164]                  ; 40001B8F _ 44: 8B. 05, 00002A86(rel)
        or      r8d, 01H                                ; 40001B96 _ 41: 83. C8, 01
        mov     dword ptr [?_164], r8d                  ; 40001B9A _ 44: 89. 05, 00002A7B(rel)
        jmp     ?_099                                   ; 40001BA1 _ EB, 07

?_098:  mov     r8d, dword ptr [?_164]                  ; 40001BA3 _ 44: 8B. 05, 00002A72(rel)
?_099:  test    ebp, ebp                                ; 40001BAA _ 85. ED
        jnz     ?_100                                   ; 40001BAC _ 75, 19
        and     edi, 0FF00F00H                          ; 40001BAE _ 81. E7, 0FF00F00
        cmp     edi, 6295808                            ; 40001BB4 _ 81. FF, 00601100
        jc      ?_100                                   ; 40001BBA _ 72, 0B
        or      r8d, 04H                                ; 40001BBC _ 41: 83. C8, 04
        mov     dword ptr [?_164], r8d                  ; 40001BC0 _ 44: 89. 05, 00002A55(rel)
?_100:  mov     eax, 7                                  ; 40001BC7 _ B8, 00000007
        cmp     r14d, eax                               ; 40001BCC _ 44: 3B. F0
        jl      ?_101                                   ; 40001BCF _ 7C, 27
        xor     ecx, ecx                                ; 40001BD1 _ 33. C9
        cpuid                                           ; 40001BD3 _ 0F A2
        mov     dword ptr [rsp], eax                    ; 40001BD5 _ 89. 04 24
        mov     r11d, ebx                               ; 40001BD8 _ 44: 8B. DB
        mov     dword ptr [rsp+4H], ebx                 ; 40001BDB _ 89. 5C 24, 04
        mov     dword ptr [rsp+8H], ecx                 ; 40001BDF _ 89. 4C 24, 08
        mov     dword ptr [rsp+0CH], edx                ; 40001BE3 _ 89. 54 24, 0C
        bt      ebx, 9                                  ; 40001BE7 _ 0F BA. E3, 09
        jnc     ?_101                                   ; 40001BEB _ 73, 0B
        or      r8d, 02H                                ; 40001BED _ 41: 83. C8, 02
        mov     dword ptr [?_164], r8d                  ; 40001BF1 _ 44: 89. 05, 00002A24(rel)
?_101:  bt      esi, 20                                 ; 40001BF8 _ 0F BA. E6, 14
        jnc     ?_102                                   ; 40001BFC _ 73, 6E
        mov     dword ptr [?_140], 2                    ; 40001BFE _ C7. 05, 00002410(rel), 00000002
        mov     dword ptr [?_141], 6                    ; 40001C08 _ C7. 05, 0000240A(rel), 00000006
        bt      esi, 27                                 ; 40001C12 _ 0F BA. E6, 1B
        jnc     ?_102                                   ; 40001C16 _ 73, 54
        bt      esi, 28                                 ; 40001C18 _ 0F BA. E6, 1C
        jnc     ?_102                                   ; 40001C1C _ 73, 4E
        xor     ecx, ecx                                ; 40001C1E _ 33. C9
        xgetbv                                          ; 40001C20 _ 0F 01. D0
        shl     rdx, 32                                 ; 40001C23 _ 48: C1. E2, 20
        or      rdx, rax                                ; 40001C27 _ 48: 0B. D0
        mov     qword ptr [rsp+30H], rdx                ; 40001C2A _ 48: 89. 54 24, 30
        mov     rax, qword ptr [rsp+30H]                ; 40001C2F _ 48: 8B. 44 24, 30
        and     al, 06H                                 ; 40001C34 _ 24, 06
        cmp     al, 6                                   ; 40001C36 _ 3C, 06
        jnz     ?_102                                   ; 40001C38 _ 75, 32
        mov     eax, dword ptr [?_141]                  ; 40001C3A _ 8B. 05, 000023DC(rel)
        or      eax, 08H                                ; 40001C40 _ 83. C8, 08
        mov     dword ptr [?_140], 3                    ; 40001C43 _ C7. 05, 000023CB(rel), 00000003
        mov     dword ptr [?_141], eax                  ; 40001C4D _ 89. 05, 000023C9(rel)
        test    r11b, 20H                               ; 40001C53 _ 41: F6. C3, 20
        jz      ?_102                                   ; 40001C57 _ 74, 13
        or      eax, 20H                                ; 40001C59 _ 83. C8, 20
        mov     dword ptr [?_140], 5                    ; 40001C5C _ C7. 05, 000023B2(rel), 00000005
        mov     dword ptr [?_141], eax                  ; 40001C66 _ 89. 05, 000023B0(rel)
?_102:  mov     rbx, qword ptr [rsp+38H]                ; 40001C6C _ 48: 8B. 5C 24, 38
        xor     eax, eax                                ; 40001C71 _ 33. C0
        mov     rbp, qword ptr [rsp+40H]                ; 40001C73 _ 48: 8B. 6C 24, 40
        add     rsp, 16                                 ; 40001C78 _ 48: 83. C4, 10
        pop     r14                                     ; 40001C7C _ 41: 5E
        pop     rdi                                     ; 40001C7E _ 5F
        pop     rsi                                     ; 40001C7F _ 5E
        ret                                             ; 40001C80 _ C3

; Filling space: 3H
; Filler type: INT 3 Debug breakpoint
;       db 0CCH, 0CCH, 0CCH

ALIGN   4

?_103   LABEL NEAR
        xor     eax, eax                                ; 40001C84 _ 33. C0
        cmp     dword ptr [?_143], eax                  ; 40001C86 _ 39. 05, 000023A4(rel)
        setne   al                                      ; 40001C8C _ 0F 95. C0
        ret                                             ; 40001C8F _ C3

; Note: No jump seems to point here
        jmp     qword ptr [imp___C_specific_handler]    ; 40001C90 _ FF. 25, 0000140A(rel)

memset  LABEL NEAR
        jmp     qword ptr [imp_memset]                  ; 40001C96 _ FF. 25, 000013FC(rel)

_seh_filter_exe LABEL NEAR
        jmp     qword ptr [imp__seh_filter_exe]         ; 40001C9C _ FF. 25, 000014D6(rel)

_set_app_type LABEL NEAR
        jmp     qword ptr [imp__set_app_type]           ; 40001CA2 _ FF. 25, 000014C8(rel)

__setusermatherr LABEL NEAR
        jmp     qword ptr [imp___setusermatherr]        ; 40001CA8 _ FF. 25, 00001432(rel)

_configure_wide_argv LABEL NEAR
        jmp     qword ptr [imp__configure_wide_argv]    ; 40001CAE _ FF. 25, 000014B4(rel)

_initialize_wide_environment LABEL NEAR
        jmp     qword ptr [imp__initialize_wide_environment]; 40001CB4 _ FF. 25, 000014A6(rel)

_get_initial_wide_environment LABEL NEAR
        jmp     qword ptr [imp__get_initial_wide_environment]; 40001CBA _ FF. 25, 00001498(rel)

_initterm LABEL NEAR
        jmp     qword ptr [imp__initterm]               ; 40001CC0 _ FF. 25, 0000148A(rel)

_initterm_e LABEL NEAR
        jmp     qword ptr [imp__initterm_e]             ; 40001CC6 _ FF. 25, 0000147C(rel)

exit    LABEL NEAR
        jmp     qword ptr [imp_exit]                    ; 40001CCC _ FF. 25, 0000146E(rel)

_exit   LABEL NEAR
        jmp     qword ptr [imp__exit]                   ; 40001CD2 _ FF. 25, 00001460(rel)

_set_fmode LABEL NEAR
        jmp     qword ptr [imp__set_fmode]              ; 40001CD8 _ FF. 25, 000014C2(rel)

__p___argc LABEL NEAR
        jmp     qword ptr [imp___p___argc]              ; 40001CDE _ FF. 25, 00001444(rel)

__p___wargv LABEL NEAR
        jmp     qword ptr [imp___p___wargv]             ; 40001CE4 _ FF. 25, 00001446(rel)

_cexit  LABEL NEAR
        jmp     qword ptr [imp__cexit]                  ; 40001CEA _ FF. 25, 00001430(rel)

_c_exit LABEL NEAR
        jmp     qword ptr [imp__c_exit]                 ; 40001CF0 _ FF. 25, 00001422(rel)

_register_thread_local_exe_atexit_callback LABEL NEAR
        jmp     qword ptr [imp__register_thread_local_exe_atexit_callback]; 40001CF6 _ FF. 25, 00001414(rel)

_configthreadlocale LABEL NEAR
        jmp     qword ptr [imp__configthreadlocale]     ; 40001CFC _ FF. 25, 000013CE(rel)

_set_new_mode LABEL NEAR
        jmp     qword ptr [imp__set_new_mode]           ; 40001D02 _ FF. 25, 000013B8(rel)

__p__commode LABEL NEAR
        jmp     qword ptr [imp___p__commode]            ; 40001D08 _ FF. 25, 0000148A(rel)

_initialize_onexit_table LABEL NEAR
        jmp     qword ptr [imp__initialize_onexit_table]; 40001D0E _ FF. 25, 000013DC(rel)

_register_onexit_function LABEL NEAR
        jmp     qword ptr [imp__register_onexit_function]; 40001D14 _ FF. 25, 000013DE(rel)

_crt_atexit LABEL NEAR
        jmp     qword ptr [imp__crt_atexit]             ; 40001D1A _ FF. 25, 000013E0(rel)

terminate LABEL NEAR
        jmp     qword ptr [imp_terminate]               ; 40001D20 _ FF. 25, 000013E2(rel)

IsProcessorFeaturePresent LABEL NEAR
        jmp     qword ptr [imp_IsProcessorFeaturePresent]; 40001D26 _ FF. 25, 0000130C(rel)

        int 3    ; breakpoint or filler                 ; 40001D2C _ CC
        int 3    ; breakpoint or filler                 ; 40001D2D _ CC
        int 3    ; breakpoint or filler                 ; 40001D2E _ CC
        int 3    ; breakpoint or filler                 ; 40001D2F _ CC
        mov     qword ptr [rsp+8H], rbx                 ; 40001D30 _ 48: 89. 5C 24, 08
        mov     qword ptr [rsp+10H], rbp                ; 40001D35 _ 48: 89. 6C 24, 10
        mov     qword ptr [rsp+18H], rsi                ; 40001D3A _ 48: 89. 74 24, 18
        push    rdi                                     ; 40001D3F _ 57
        push    r14                                     ; 40001D40 _ 41: 56
        push    r15                                     ; 40001D42 _ 41: 57
        sub     rsp, 32                                 ; 40001D44 _ 48: 83. EC, 20
        lea     rcx, ptr [?_128]                        ; 40001D48 _ 48: 8D. 0D, 00001511(rel)
        call    ?_001                                   ; 40001D4F _ E8, FFFFF2AC
        xor     r14d, r14d                              ; 40001D54 _ 45: 33. F6
        xor     edi, edi                                ; 40001D57 _ 33. FF
        call    qword ptr [imp__Query_perf_frequency]   ; 40001D59 _ FF. 15, 00001321(rel)
        mov     rbx, rax                                ; 40001D5F _ 48: 8B. D8
        call    qword ptr [imp__Query_perf_counter]     ; 40001D62 _ FF. 15, 00001320(rel)
        cqo                                             ; 40001D68 _ 48: 99
        mov     r15d, 1000                              ; 40001D6A _ 41: BF, 000003E8
        idiv    rbx                                     ; 40001D70 _ 48: F7. FB
        mov     rcx, rax                                ; 40001D73 _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40001D76 _ 48: 69. C2, 3B9ACA00
        cqo                                             ; 40001D7D _ 48: 99
        idiv    rbx                                     ; 40001D7F _ 48: F7. FB
        mov     rbx, rax                                ; 40001D82 _ 48: 8B. D8
        imul    rax, rcx, 1000000000                    ; 40001D85 _ 48: 69. C1, 3B9ACA00
        add     rbx, rax                                ; 40001D8C _ 48: 03. D8
        nop                                             ; 40001D8F _ 90
?_104:  test    r14, r14                                ; 40001D90 _ 4D: 85. F6
        jz      ?_105                                   ; 40001D93 _ 74, 04
        mov     byte ptr [r14], 0                       ; 40001D95 _ 41: C6. 06, 00
?_105:  xor     ebp, ebp                                ; 40001D99 _ 33. ED
        mov     esi, 100000                             ; 40001D9B _ BE, 000186A0
?_106:  lea     eax, ptr [rbp+6H]                       ; 40001DA0 _ 8D. 45, 06
        cmp     eax, edi                                ; 40001DA3 _ 3B. C7
        jbe     ?_107                                   ; 40001DA5 _ 76, 15
; Note: Displacement could be made smaller by sign extension
        lea     edi, ptr [rbp*2+0CH]                    ; 40001DA7 _ 8D. 3C 6D, 0000000C
        mov     rcx, r14                                ; 40001DAE _ 49: 8B. CE
        mov     edx, edi                                ; 40001DB1 _ 8B. D7
        call    qword ptr [imp_realloc]                 ; 40001DB3 _ FF. 15, 000012F7(rel)
        mov     r14, rax                                ; 40001DB9 _ 4C: 8B. F0
?_107:  mov     eax, dword ptr [?_129]                  ; 40001DBC _ 8B. 05, 000014B2(rel)
        mov     dword ptr [rbp+r14], eax                ; 40001DC2 _ 42: 89. 44 35, 00
        movzx   eax, byte ptr [?_130]                   ; 40001DC7 _ 0F B6. 05, 000014AA(rel)
        mov     byte ptr [rbp+r14+4H], al               ; 40001DCE _ 42: 88. 44 35, 04
        add     ebp, 5                                  ; 40001DD3 _ 83. C5, 05
        mov     byte ptr [rbp+r14], 0                   ; 40001DD6 _ 42: C6. 44 35, 00, 00
        sub     rsi, 1                                  ; 40001DDC _ 48: 83. EE, 01
        jnz     ?_106                                   ; 40001DE0 _ 75, BE
        sub     r15, 1                                  ; 40001DE2 _ 49: 83. EF, 01
        jnz     ?_104                                   ; 40001DE6 _ 75, A8
        call    qword ptr [imp__Query_perf_frequency]   ; 40001DE8 _ FF. 15, 00001292(rel)
        mov     rsi, rax                                ; 40001DEE _ 48: 8B. F0
        call    qword ptr [imp__Query_perf_counter]     ; 40001DF1 _ FF. 15, 00001291(rel)
        mov     edx, ebp                                ; 40001DF7 _ 8B. D5
        lea     rcx, ptr [?_131]                        ; 40001DF9 _ 48: 8D. 0D, 00001480(rel)
        mov     rdi, rax                                ; 40001E00 _ 48: 8B. F8
        call    ?_001                                   ; 40001E03 _ E8, FFFFF1F8
        xor     edx, edx                                ; 40001E08 _ 33. D2
        lea     rcx, ptr [?_132]                        ; 40001E0A _ 48: 8D. 0D, 00001487(rel)
        call    ?_001                                   ; 40001E11 _ E8, FFFFF1EA
        mov     rax, rdi                                ; 40001E16 _ 48: 8B. C7
        xorps   xmm1, xmm1                              ; 40001E19 _ 0F 57. C9
        cqo                                             ; 40001E1C _ 48: 99
        idiv    rsi                                     ; 40001E1E _ 48: F7. FE
        mov     rcx, rax                                ; 40001E21 _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40001E24 _ 48: 69. C2, 3B9ACA00
        imul    rcx, rcx, 1000000000                    ; 40001E2B _ 48: 69. C9, 3B9ACA00
        cqo                                             ; 40001E32 _ 48: 99
        idiv    rsi                                     ; 40001E34 _ 48: F7. FE
        add     rax, rcx                                ; 40001E37 _ 48: 03. C1
        lea     rcx, ptr [?_127]                        ; 40001E3A _ 48: 8D. 0D, 00001407(rel)
        sub     rax, rbx                                ; 40001E41 _ 48: 2B. C3
        cvtsi2sd xmm1, rax                              ; 40001E44 _ F2 48: 0F 2A. C8
        mulsd   xmm1, qword ptr [?_134]                 ; 40001E49 _ F2: 0F 59. 0D, 00001477(rel)
        movq    rdx, xmm1                               ; 40001E51 _ 66 48: 0F 7E. CA
        call    ?_001                                   ; 40001E56 _ E8, FFFFF1A5
        test    r14, r14                                ; 40001E5B _ 4D: 85. F6
        jz      ?_108                                   ; 40001E5E _ 74, 09
        mov     rcx, r14                                ; 40001E60 _ 49: 8B. CE
        call    qword ptr [imp_free]                    ; 40001E63 _ FF. 15, 0000124F(rel)
?_108:  mov     rbx, qword ptr [rsp+40H]                ; 40001E69 _ 48: 8B. 5C 24, 40
        mov     rbp, qword ptr [rsp+48H]                ; 40001E6E _ 48: 8B. 6C 24, 48
        mov     rsi, qword ptr [rsp+50H]                ; 40001E73 _ 48: 8B. 74 24, 50
        add     rsp, 32                                 ; 40001E78 _ 48: 83. C4, 20
        pop     r15                                     ; 40001E7C _ 41: 5F
        pop     r14                                     ; 40001E7E _ 41: 5E
        pop     rdi                                     ; 40001E80 _ 5F
        ret                                             ; 40001E81 _ C3

        int 3    ; breakpoint or filler                 ; 40001E82 _ CC
        int 3    ; breakpoint or filler                 ; 40001E83 _ CC
        int 3    ; breakpoint or filler                 ; 40001E84 _ CC
        int 3    ; breakpoint or filler                 ; 40001E85 _ CC
        int 3    ; breakpoint or filler                 ; 40001E86 _ CC
        int 3    ; breakpoint or filler                 ; 40001E87 _ CC
        int 3    ; breakpoint or filler                 ; 40001E88 _ CC
        int 3    ; breakpoint or filler                 ; 40001E89 _ CC
        int 3    ; breakpoint or filler                 ; 40001E8A _ CC
        int 3    ; breakpoint or filler                 ; 40001E8B _ CC
        int 3    ; breakpoint or filler                 ; 40001E8C _ CC
        int 3    ; breakpoint or filler                 ; 40001E8D _ CC
        int 3    ; breakpoint or filler                 ; 40001E8E _ CC
        int 3    ; breakpoint or filler                 ; 40001E8F _ CC
        mov     qword ptr [rsp+8H], rbx                 ; 40001E90 _ 48: 89. 5C 24, 08
        mov     qword ptr [rsp+10H], rbp                ; 40001E95 _ 48: 89. 6C 24, 10
        mov     qword ptr [rsp+18H], rsi                ; 40001E9A _ 48: 89. 74 24, 18
        push    rdi                                     ; 40001E9F _ 57
        push    r14                                     ; 40001EA0 _ 41: 56
        push    r15                                     ; 40001EA2 _ 41: 57
        sub     rsp, 32                                 ; 40001EA4 _ 48: 83. EC, 20
        lea     rcx, ptr [?_126]                        ; 40001EA8 _ 48: 8D. 0D, 00001381(rel)
        call    ?_001                                   ; 40001EAF _ E8, FFFFF14C
        lea     rcx, ptr [?_128]                        ; 40001EB4 _ 48: 8D. 0D, 000013A5(rel)
        call    ?_001                                   ; 40001EBB _ E8, FFFFF140
        xor     r14d, r14d                              ; 40001EC0 _ 45: 33. F6
        xor     edi, edi                                ; 40001EC3 _ 33. FF
        call    qword ptr [imp__Query_perf_frequency]   ; 40001EC5 _ FF. 15, 000011B5(rel)
        mov     rbx, rax                                ; 40001ECB _ 48: 8B. D8
        call    qword ptr [imp__Query_perf_counter]     ; 40001ECE _ FF. 15, 000011B4(rel)
        cqo                                             ; 40001ED4 _ 48: 99
        mov     r15d, 1000                              ; 40001ED6 _ 41: BF, 000003E8
        idiv    rbx                                     ; 40001EDC _ 48: F7. FB
        mov     rcx, rax                                ; 40001EDF _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40001EE2 _ 48: 69. C2, 3B9ACA00
        cqo                                             ; 40001EE9 _ 48: 99
        idiv    rbx                                     ; 40001EEB _ 48: F7. FB
        mov     rbx, rax                                ; 40001EEE _ 48: 8B. D8
        imul    rax, rcx, 1000000000                    ; 40001EF1 _ 48: 69. C1, 3B9ACA00
        add     rbx, rax                                ; 40001EF8 _ 48: 03. D8
; Filling space: 5H
; Filler type: Multi-byte NOP
;       db 0FH, 1FH, 44H, 00H, 00H

ALIGN   8
?_109:  test    r14, r14                                ; 40001F00 _ 4D: 85. F6
        jz      ?_110                                   ; 40001F03 _ 74, 04
        mov     byte ptr [r14], 0                       ; 40001F05 _ 41: C6. 06, 00
?_110:  xor     ebp, ebp                                ; 40001F09 _ 33. ED
        mov     esi, 100000                             ; 40001F0B _ BE, 000186A0
?_111:  lea     eax, ptr [rbp+6H]                       ; 40001F10 _ 8D. 45, 06
        cmp     eax, edi                                ; 40001F13 _ 3B. C7
        jbe     ?_112                                   ; 40001F15 _ 76, 15
; Note: Displacement could be made smaller by sign extension
        lea     edi, ptr [rbp*2+0CH]                    ; 40001F17 _ 8D. 3C 6D, 0000000C
        mov     rcx, r14                                ; 40001F1E _ 49: 8B. CE
        mov     edx, edi                                ; 40001F21 _ 8B. D7
        call    qword ptr [imp_realloc]                 ; 40001F23 _ FF. 15, 00001187(rel)
        mov     r14, rax                                ; 40001F29 _ 4C: 8B. F0
?_112:  mov     eax, dword ptr [?_129]                  ; 40001F2C _ 8B. 05, 00001342(rel)
        mov     dword ptr [rbp+r14], eax                ; 40001F32 _ 42: 89. 44 35, 00
        movzx   eax, byte ptr [?_130]                   ; 40001F37 _ 0F B6. 05, 0000133A(rel)
        mov     byte ptr [rbp+r14+4H], al               ; 40001F3E _ 42: 88. 44 35, 04
        add     ebp, 5                                  ; 40001F43 _ 83. C5, 05
        mov     byte ptr [rbp+r14], 0                   ; 40001F46 _ 42: C6. 44 35, 00, 00
        sub     rsi, 1                                  ; 40001F4C _ 48: 83. EE, 01
        jnz     ?_111                                   ; 40001F50 _ 75, BE
        sub     r15, 1                                  ; 40001F52 _ 49: 83. EF, 01
        jnz     ?_109                                   ; 40001F56 _ 75, A8
        call    qword ptr [imp__Query_perf_frequency]   ; 40001F58 _ FF. 15, 00001122(rel)
        mov     rsi, rax                                ; 40001F5E _ 48: 8B. F0
        call    qword ptr [imp__Query_perf_counter]     ; 40001F61 _ FF. 15, 00001121(rel)
        mov     edx, ebp                                ; 40001F67 _ 8B. D5
        lea     rcx, ptr [?_131]                        ; 40001F69 _ 48: 8D. 0D, 00001310(rel)
        mov     rdi, rax                                ; 40001F70 _ 48: 8B. F8
        call    ?_001                                   ; 40001F73 _ E8, FFFFF088
        xor     edx, edx                                ; 40001F78 _ 33. D2
        lea     rcx, ptr [?_132]                        ; 40001F7A _ 48: 8D. 0D, 00001317(rel)
        call    ?_001                                   ; 40001F81 _ E8, FFFFF07A
        mov     rax, rdi                                ; 40001F86 _ 48: 8B. C7
        xorps   xmm1, xmm1                              ; 40001F89 _ 0F 57. C9
        cqo                                             ; 40001F8C _ 48: 99
        idiv    rsi                                     ; 40001F8E _ 48: F7. FE
        mov     rcx, rax                                ; 40001F91 _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40001F94 _ 48: 69. C2, 3B9ACA00
        imul    rcx, rcx, 1000000000                    ; 40001F9B _ 48: 69. C9, 3B9ACA00
        cqo                                             ; 40001FA2 _ 48: 99
        idiv    rsi                                     ; 40001FA4 _ 48: F7. FE
        add     rax, rcx                                ; 40001FA7 _ 48: 03. C1
        lea     rcx, ptr [?_127]                        ; 40001FAA _ 48: 8D. 0D, 00001297(rel)
        sub     rax, rbx                                ; 40001FB1 _ 48: 2B. C3
        cvtsi2sd xmm1, rax                              ; 40001FB4 _ F2 48: 0F 2A. C8
        mulsd   xmm1, qword ptr [?_134]                 ; 40001FB9 _ F2: 0F 59. 0D, 00001307(rel)
        movq    rdx, xmm1                               ; 40001FC1 _ 66 48: 0F 7E. CA
        call    ?_001                                   ; 40001FC6 _ E8, FFFFF035
        test    r14, r14                                ; 40001FCB _ 4D: 85. F6
        jz      ?_113                                   ; 40001FCE _ 74, 09
        mov     rcx, r14                                ; 40001FD0 _ 49: 8B. CE
        call    qword ptr [imp_free]                    ; 40001FD3 _ FF. 15, 000010DF(rel)
?_113:  mov     rbx, qword ptr [rsp+40H]                ; 40001FD9 _ 48: 8B. 5C 24, 40
        mov     rbp, qword ptr [rsp+48H]                ; 40001FDE _ 48: 8B. 6C 24, 48
        mov     rsi, qword ptr [rsp+50H]                ; 40001FE3 _ 48: 8B. 74 24, 50
        add     rsp, 32                                 ; 40001FE8 _ 48: 83. C4, 20
        pop     r15                                     ; 40001FEC _ 41: 5F
        pop     r14                                     ; 40001FEE _ 41: 5E
        pop     rdi                                     ; 40001FF0 _ 5F
        ret                                             ; 40001FF1 _ C3

        int 3    ; breakpoint or filler                 ; 40001FF2 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF3 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF4 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF5 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF6 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF7 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF8 _ CC
        int 3    ; breakpoint or filler                 ; 40001FF9 _ CC
        int 3    ; breakpoint or filler                 ; 40001FFA _ CC
        int 3    ; breakpoint or filler                 ; 40001FFB _ CC
        int 3    ; breakpoint or filler                 ; 40001FFC _ CC
        int 3    ; breakpoint or filler                 ; 40001FFD _ CC
        int 3    ; breakpoint or filler                 ; 40001FFE _ CC
        int 3    ; breakpoint or filler                 ; 40001FFF _ CC

?_114   LABEL NEAR
        mov     qword ptr [rsp+8H], rbx                 ; 40002000 _ 48: 89. 5C 24, 08
        mov     qword ptr [rsp+10H], rbp                ; 40002005 _ 48: 89. 6C 24, 10
        mov     qword ptr [rsp+18H], rsi                ; 4000200A _ 48: 89. 74 24, 18
        push    rdi                                     ; 4000200F _ 57
        push    r14                                     ; 40002010 _ 41: 56
        push    r15                                     ; 40002012 _ 41: 57
        sub     rsp, 32                                 ; 40002014 _ 48: 83. EC, 20
        lea     rcx, ptr [?_126]                        ; 40002018 _ 48: 8D. 0D, 00001211(rel)
        call    ?_001                                   ; 4000201F _ E8, FFFFEFDC
        lea     rcx, ptr [?_128]                        ; 40002024 _ 48: 8D. 0D, 00001235(rel)
        call    ?_001                                   ; 4000202B _ E8, FFFFEFD0
        xor     r14d, r14d                              ; 40002030 _ 45: 33. F6
        xor     edi, edi                                ; 40002033 _ 33. FF
        call    qword ptr [imp__Query_perf_frequency]   ; 40002035 _ FF. 15, 00001045(rel)
        mov     rbx, rax                                ; 4000203B _ 48: 8B. D8
        call    qword ptr [imp__Query_perf_counter]     ; 4000203E _ FF. 15, 00001044(rel)
        cqo                                             ; 40002044 _ 48: 99
        mov     r15d, 1000                              ; 40002046 _ 41: BF, 000003E8
        idiv    rbx                                     ; 4000204C _ 48: F7. FB
        mov     rcx, rax                                ; 4000204F _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40002052 _ 48: 69. C2, 3B9ACA00
        cqo                                             ; 40002059 _ 48: 99
        idiv    rbx                                     ; 4000205B _ 48: F7. FB
        mov     rbx, rax                                ; 4000205E _ 48: 8B. D8
        imul    rax, rcx, 1000000000                    ; 40002061 _ 48: 69. C1, 3B9ACA00
        add     rbx, rax                                ; 40002068 _ 48: 03. D8
; Filling space: 5H
; Filler type: Multi-byte NOP
;       db 0FH, 1FH, 44H, 00H, 00H

ALIGN   8
?_115:  test    r14, r14                                ; 40002070 _ 4D: 85. F6
        jz      ?_116                                   ; 40002073 _ 74, 04
        mov     byte ptr [r14], 0                       ; 40002075 _ 41: C6. 06, 00
?_116:  xor     ebp, ebp                                ; 40002079 _ 33. ED
        mov     esi, 100000                             ; 4000207B _ BE, 000186A0
?_117:  lea     eax, ptr [rbp+6H]                       ; 40002080 _ 8D. 45, 06
        cmp     eax, edi                                ; 40002083 _ 3B. C7
        jbe     ?_118                                   ; 40002085 _ 76, 15
; Note: Displacement could be made smaller by sign extension
        lea     edi, ptr [rbp*2+0CH]                    ; 40002087 _ 8D. 3C 6D, 0000000C
        mov     rcx, r14                                ; 4000208E _ 49: 8B. CE
        mov     edx, edi                                ; 40002091 _ 8B. D7
        call    qword ptr [imp_realloc]                 ; 40002093 _ FF. 15, 00001017(rel)
        mov     r14, rax                                ; 40002099 _ 4C: 8B. F0
?_118:  mov     eax, dword ptr [?_129]                  ; 4000209C _ 8B. 05, 000011D2(rel)
        mov     dword ptr [rbp+r14], eax                ; 400020A2 _ 42: 89. 44 35, 00
        movzx   eax, byte ptr [?_130]                   ; 400020A7 _ 0F B6. 05, 000011CA(rel)
        mov     byte ptr [rbp+r14+4H], al               ; 400020AE _ 42: 88. 44 35, 04
        add     ebp, 5                                  ; 400020B3 _ 83. C5, 05
        mov     byte ptr [rbp+r14], 0                   ; 400020B6 _ 42: C6. 44 35, 00, 00
        sub     rsi, 1                                  ; 400020BC _ 48: 83. EE, 01
        jnz     ?_117                                   ; 400020C0 _ 75, BE
        sub     r15, 1                                  ; 400020C2 _ 49: 83. EF, 01
        jnz     ?_115                                   ; 400020C6 _ 75, A8
        call    qword ptr [imp__Query_perf_frequency]   ; 400020C8 _ FF. 15, 00000FB2(rel)
        mov     rsi, rax                                ; 400020CE _ 48: 8B. F0
        call    qword ptr [imp__Query_perf_counter]     ; 400020D1 _ FF. 15, 00000FB1(rel)
        mov     edx, ebp                                ; 400020D7 _ 8B. D5
        lea     rcx, ptr [?_131]                        ; 400020D9 _ 48: 8D. 0D, 000011A0(rel)
        mov     rdi, rax                                ; 400020E0 _ 48: 8B. F8
        call    ?_001                                   ; 400020E3 _ E8, FFFFEF18
        xor     edx, edx                                ; 400020E8 _ 33. D2
        lea     rcx, ptr [?_132]                        ; 400020EA _ 48: 8D. 0D, 000011A7(rel)
        call    ?_001                                   ; 400020F1 _ E8, FFFFEF0A
        mov     rax, rdi                                ; 400020F6 _ 48: 8B. C7
        xorps   xmm1, xmm1                              ; 400020F9 _ 0F 57. C9
        cqo                                             ; 400020FC _ 48: 99
        idiv    rsi                                     ; 400020FE _ 48: F7. FE
        mov     rcx, rax                                ; 40002101 _ 48: 8B. C8
        imul    rax, rdx, 1000000000                    ; 40002104 _ 48: 69. C2, 3B9ACA00
        imul    rcx, rcx, 1000000000                    ; 4000210B _ 48: 69. C9, 3B9ACA00
        cqo                                             ; 40002112 _ 48: 99
        idiv    rsi                                     ; 40002114 _ 48: F7. FE
        add     rax, rcx                                ; 40002117 _ 48: 03. C1
        lea     rcx, ptr [?_127]                        ; 4000211A _ 48: 8D. 0D, 00001127(rel)
        sub     rax, rbx                                ; 40002121 _ 48: 2B. C3
        cvtsi2sd xmm1, rax                              ; 40002124 _ F2 48: 0F 2A. C8
        mulsd   xmm1, qword ptr [?_134]                 ; 40002129 _ F2: 0F 59. 0D, 00001197(rel)
        movq    rdx, xmm1                               ; 40002131 _ 66 48: 0F 7E. CA
        call    ?_001                                   ; 40002136 _ E8, FFFFEEC5
        test    r14, r14                                ; 4000213B _ 4D: 85. F6
        jz      ?_119                                   ; 4000213E _ 74, 09
        mov     rcx, r14                                ; 40002140 _ 49: 8B. CE
        call    qword ptr [imp_free]                    ; 40002143 _ FF. 15, 00000F6F(rel)
?_119:  lea     rcx, ptr [?_133]                        ; 40002149 _ 48: 8D. 0D, 00001160(rel)
        call    ?_001                                   ; 40002150 _ E8, FFFFEEAB
        call    qword ptr [imp_getchar]                 ; 40002155 _ FF. 15, 0000104D(rel)
        mov     rbx, qword ptr [rsp+40H]                ; 4000215B _ 48: 8B. 5C 24, 40
        xor     eax, eax                                ; 40002160 _ 33. C0
        mov     rbp, qword ptr [rsp+48H]                ; 40002162 _ 48: 8B. 6C 24, 48
        mov     rsi, qword ptr [rsp+50H]                ; 40002167 _ 48: 8B. 74 24, 50
        add     rsp, 32                                 ; 4000216C _ 48: 83. C4, 20
        pop     r15                                     ; 40002170 _ 41: 5F
        pop     r14                                     ; 40002172 _ 41: 5E
        pop     rdi                                     ; 40002174 _ 5F
        ret                                             ; 40002175 _ C3

        int 3    ; breakpoint or filler                 ; 40002176 _ CC
        int 3    ; breakpoint or filler                 ; 40002177 _ CC
        int 3    ; breakpoint or filler                 ; 40002178 _ CC
        int 3    ; breakpoint or filler                 ; 40002179 _ CC
        int 3    ; breakpoint or filler                 ; 4000217A _ CC
        int 3    ; breakpoint or filler                 ; 4000217B _ CC
        int 3    ; breakpoint or filler                 ; 4000217C _ CC
        int 3    ; breakpoint or filler                 ; 4000217D _ CC
        int 3    ; breakpoint or filler                 ; 4000217E _ CC
        int 3    ; breakpoint or filler                 ; 4000217F _ CC
        int 3    ; breakpoint or filler                 ; 40002180 _ CC
        int 3    ; breakpoint or filler                 ; 40002181 _ CC
        int 3    ; breakpoint or filler                 ; 40002182 _ CC
        int 3    ; breakpoint or filler                 ; 40002183 _ CC
        int 3    ; breakpoint or filler                 ; 40002184 _ CC
        int 3    ; breakpoint or filler                 ; 40002185 _ CC
; Filling space: 0AH
; Filler type: Multi-byte NOP
;       db 66H, 66H, 0FH, 1FH, 84H, 00H, 00H, 00H
;       db 00H, 00H

ALIGN   16
        jmp     rax                                     ; 40002190 _ FF. E0

; Note: Prefix bit or byte has no meaning in this context
        push    rbp                                     ; 40002192 _ 40: 55
        sub     rsp, 32                                 ; 40002194 _ 48: 83. EC, 20
        mov     rbp, rdx                                ; 40002198 _ 48: 8B. EA
        mov     rax, qword ptr [rcx]                    ; 4000219B _ 48: 8B. 01
        mov     rdx, rcx                                ; 4000219E _ 48: 8B. D1
        mov     ecx, dword ptr [rax]                    ; 400021A1 _ 8B. 08
        call    _seh_filter_exe                         ; 400021A3 _ E8, FFFFFAF4
        nop                                             ; 400021A8 _ 90
        add     rsp, 32                                 ; 400021A9 _ 48: 83. C4, 20
        pop     rbp                                     ; 400021AD _ 5D
        ret                                             ; 400021AE _ C3

        int 3    ; breakpoint or filler                 ; 400021AF _ CC
; Note: Prefix bit or byte has no meaning in this context
        push    rbp                                     ; 400021B0 _ 40: 55
        mov     rbp, rdx                                ; 400021B2 _ 48: 8B. EA
        mov     rax, qword ptr [rcx]                    ; 400021B5 _ 48: 8B. 01
        xor     ecx, ecx                                ; 400021B8 _ 33. C9
        cmp     dword ptr [rax], -1073741819            ; 400021BA _ 81. 38, C0000005
        sete    cl                                      ; 400021C0 _ 0F 94. C1
        mov     eax, ecx                                ; 400021C3 _ 8B. C1
        pop     rbp                                     ; 400021C5 _ 5D
        ret                                             ; 400021C6 _ C3

        db 0CCH, 00H, 00H, 00H, 00H, 00H, 00H, 00H      ; 400021C7 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021CF _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021D7 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021DF _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021E7 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021EF _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400021F7 _ ........
        db 00H                                          ; 400021FF _ .

_text   ENDS

.rdata  SEGMENT BYTE 'CONST'                            ; section number 2

Import_address_table label dword
imp_InitializeSListHead label qword                     ; import from KERNEL32.dll
        dq 0000000000003EF0H                            ; 40003000 _ 0000000000003EF0

imp_RtlLookupFunctionEntry label qword                  ; import from KERNEL32.dll
        dq 0000000000003DE4H                            ; 40003008 _ 0000000000003DE4

imp_RtlVirtualUnwind label qword                        ; import from KERNEL32.dll
        dq 0000000000003DFEH                            ; 40003010 _ 0000000000003DFE

imp_UnhandledExceptionFilter label qword                ; import from KERNEL32.dll
        dq 0000000000003E12H                            ; 40003018 _ 0000000000003E12

imp_SetUnhandledExceptionFilter label qword             ; import from KERNEL32.dll
        dq 0000000000003E2EH                            ; 40003020 _ 0000000000003E2E

imp_GetCurrentProcess label qword                       ; import from KERNEL32.dll
        dq 0000000000003E4CH                            ; 40003028 _ 0000000000003E4C

imp_TerminateProcess label qword                        ; import from KERNEL32.dll
        dq 0000000000003E60H                            ; 40003030 _ 0000000000003E60

imp_IsProcessorFeaturePresent label qword               ; import from KERNEL32.dll
        dq 0000000000003E74H                            ; 40003038 _ 0000000000003E74

imp_QueryPerformanceCounter label qword                 ; import from KERNEL32.dll
        dq 0000000000003E90H                            ; 40003040 _ 0000000000003E90

imp_GetModuleHandleW label qword                        ; import from KERNEL32.dll
        dq 0000000000003F1AH                            ; 40003048 _ 0000000000003F1A

imp_IsDebuggerPresent label qword                       ; import from KERNEL32.dll
        dq 0000000000003F06H                            ; 40003050 _ 0000000000003F06

imp_RtlCaptureContext label qword                       ; import from KERNEL32.dll
        dq 0000000000003DD0H                            ; 40003058 _ 0000000000003DD0

imp_GetSystemTimeAsFileTime label qword                 ; import from KERNEL32.dll
        dq 0000000000003ED6H                            ; 40003060 _ 0000000000003ED6

imp_GetCurrentThreadId label qword                      ; import from KERNEL32.dll
        dq 0000000000003EC0H                            ; 40003068 _ 0000000000003EC0

imp_GetCurrentProcessId label qword                     ; import from KERNEL32.dll
        dq 0000000000003EAAH                            ; 40003070 _ 0000000000003EAA
        dq 0000000000000000H                            ; 40003078 _ 0000000000000000

imp__Query_perf_frequency label qword                   ; import from MSVCP140.dll
        dq 0000000000003ADEH                            ; 40003080 _ 0000000000003ADE

imp__Query_perf_counter label qword                     ; import from MSVCP140.dll
        dq 0000000000003AC8H                            ; 40003088 _ 0000000000003AC8
        dq 0000000000000000H                            ; 40003090 _ 0000000000000000

imp_memset label qword                                  ; import from VCRUNTIME140.dll
        dq 0000000000003B1CH                            ; 40003098 _ 0000000000003B1C

imp___C_specific_handler label qword                    ; import from VCRUNTIME140.dll
        dq 0000000000003B04H                            ; 400030A0 _ 0000000000003B04
        dq 0000000000000000H                            ; 400030A8 _ 0000000000000000

imp_realloc label qword                                 ; import from api-ms-win-crt-heap-l1-1-0.dll
        dq 0000000000003B40H                            ; 400030B0 _ 0000000000003B40

imp_free label qword                                    ; import from api-ms-win-crt-heap-l1-1-0.dll
        dq 0000000000003B38H                            ; 400030B8 _ 0000000000003B38

imp__set_new_mode label qword                           ; import from api-ms-win-crt-heap-l1-1-0.dll
        dq 0000000000003CBAH                            ; 400030C0 _ 0000000000003CBA
        dq 0000000000000000H                            ; 400030C8 _ 0000000000000000

imp__configthreadlocale label qword                     ; import from api-ms-win-crt-locale-l1-1-0.dll
        dq 0000000000003CA4H                            ; 400030D0 _ 0000000000003CA4
        dq 0000000000000000H                            ; 400030D8 _ 0000000000000000

imp___setusermatherr label qword                        ; import from api-ms-win-crt-math-l1-1-0.dll
        dq 0000000000003BA2H                            ; 400030E0 _ 0000000000003BA2
        dq 0000000000000000H                            ; 400030E8 _ 0000000000000000

imp__initialize_onexit_table label qword                ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003CDAH                            ; 400030F0 _ 0000000000003CDA

imp__register_onexit_function label qword               ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003CF6H                            ; 400030F8 _ 0000000000003CF6

imp__crt_atexit label qword                             ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003D12H                            ; 40003100 _ 0000000000003D12

imp_terminate label qword                               ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003D20H                            ; 40003108 _ 0000000000003D20

imp__register_thread_local_exe_atexit_callback label qword; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C76H                            ; 40003110 _ 0000000000003C76

imp__c_exit label qword                                 ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C6CH                            ; 40003118 _ 0000000000003C6C

imp__cexit label qword                                  ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C62H                            ; 40003120 _ 0000000000003C62

imp___p___argc label qword                              ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C46H                            ; 40003128 _ 0000000000003C46

imp___p___wargv label qword                             ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C54H                            ; 40003130 _ 0000000000003C54

imp__exit label qword                                   ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C30H                            ; 40003138 _ 0000000000003C30

imp_exit label qword                                    ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C28H                            ; 40003140 _ 0000000000003C28

imp__initterm_e label qword                             ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C1AH                            ; 40003148 _ 0000000000003C1A

imp__initterm label qword                               ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003C0EH                            ; 40003150 _ 0000000000003C0E

imp__get_initial_wide_environment label qword           ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003BEEH                            ; 40003158 _ 0000000000003BEE

imp__initialize_wide_environment label qword            ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003BCEH                            ; 40003160 _ 0000000000003BCE

imp__configure_wide_argv label qword                    ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003BB6H                            ; 40003168 _ 0000000000003BB6

imp__set_app_type label qword                           ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003B92H                            ; 40003170 _ 0000000000003B92

imp__seh_filter_exe label qword                         ; import from api-ms-win-crt-runtime-l1-1-0.dll
        dq 0000000000003B80H                            ; 40003178 _ 0000000000003B80
        dq 0000000000000000H                            ; 40003180 _ 0000000000000000

imp___acrt_iob_func label qword                         ; import from api-ms-win-crt-stdio-l1-1-0.dll
        dq 0000000000003B4AH                            ; 40003188 _ 0000000000003B4A

imp___stdio_common_vfprintf label qword                 ; import from api-ms-win-crt-stdio-l1-1-0.dll
        dq 0000000000003B5CH                            ; 40003190 _ 0000000000003B5C

imp___p__commode label qword                            ; import from api-ms-win-crt-stdio-l1-1-0.dll
        dq 0000000000003CCAH                            ; 40003198 _ 0000000000003CCA

imp__set_fmode label qword                              ; import from api-ms-win-crt-stdio-l1-1-0.dll
        dq 0000000000003C38H                            ; 400031A0 _ 0000000000003C38

imp_getchar label qword                                 ; import from api-ms-win-crt-stdio-l1-1-0.dll
        dq 0000000000003B76H                            ; 400031A8 _ 0000000000003B76
        dq 0000000000000000H                            ; 400031B0 _ 0000000000000000
        dq Unnamed_80000000_0                           ; 400031B8 _ 000000014000181C (d)

?_120   label qword                                     ; virtual table or function pointer
        dq Unnamed_80000000_0                           ; 400031C0 _ 0000000140002190 (d)

?_121   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400031C8 _ ........
        dq Unnamed_80000000_0                           ; 400031D0 _ 0000000140001164 (d)

?_122   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400031D8 _ ........

?_123   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400031E0 _ ........
        dq Unnamed_80000000_0                           ; 400031E8 _ 00000001400010A4 (d)
        dq Unnamed_80000000_0                           ; 400031F0 _ 0000000140001154 (d)

?_124   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400031F8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003200 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003208 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003210 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003218 _ ........

?_125   label byte
        dq Unnamed_80000000_0                           ; 40003220 _ 0000000140004040 (d)
        dq Unnamed_80000000_0                           ; 40003228 _ 00000001400040E0 (d)

?_126   label byte
        db 42H, 65H, 6EH, 63H, 68H, 6DH, 61H, 72H       ; 40003230 _ Benchmar
        db 6BH, 69H, 6EH, 67H, 2EH, 2EH, 2EH, 0AH       ; 40003238 _ king....
        db 0AH, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003240 _ ........

?_127   label byte
        db 45H, 6CH, 61H, 70H, 73H, 65H, 64H, 3AH       ; 40003248 _ Elapsed:
        db 20H, 25H, 2EH, 33H, 66H, 20H, 6DH, 73H       ; 40003250 _  %.3f ms
        db 0AH, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003258 _ ........

?_128   label byte
        db 42H, 65H, 6EH, 63H, 68H, 69H, 6EH, 67H       ; 40003260 _ Benching
        db 20H, 43H, 68H, 61H, 72H, 42H, 75H, 66H       ; 40003268 _  CharBuf
        db 0AH, 00H, 00H, 00H                           ; 40003270 _ ....

?_129   label dword
        dd 6C6C6568H                                    ; 40003274 _ 1819043176

?_130   label byte
        db 6FH, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003278 _ o.......

?_131   label byte
        db 43H, 42H, 20H, 20H, 52H, 65H, 73H, 75H       ; 40003280 _ CB  Resu
        db 6CH, 74H, 20H, 3DH, 20H, 25H, 75H, 0AH       ; 40003288 _ lt = %u.
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003290 _ ........

?_132   label byte
        db 53H, 54H, 52H, 20H, 52H, 65H, 73H, 75H       ; 40003298 _ STR Resu
        db 6CH, 74H, 20H, 3DH, 20H, 25H, 6CH, 6CH       ; 400032A0 _ lt = %ll
        db 75H, 0AH, 00H, 00H, 00H, 00H, 00H, 00H       ; 400032A8 _ u.......

?_133   label byte
        db 0AH, 46H, 69H, 6EH, 69H, 73H, 68H, 65H       ; 400032B0 _ .Finishe
        db 64H, 2EH, 20H, 50H, 72H, 65H, 73H, 73H       ; 400032B8 _ d. Press
        db 20H, 45H, 4EH, 54H, 45H, 52H, 00H, 00H       ; 400032C0 _  ENTER..

?_134   label qword
        dq 3EB0C6F7A0B5ED8DH                            ; 400032C8 _ 1E-06

Debug_table label dword
        db 00H, 00H, 00H, 00H, 1CH, 19H, 6BH, 5BH       ; 400032D0 _ ......k[
        db 00H, 00H, 00H, 00H, 02H, 00H, 00H, 00H       ; 400032D8 _ ........
        db 41H, 00H, 00H, 00H, 40H, 34H, 00H, 00H       ; 400032E0 _ A...@4..
        db 40H, 1AH, 00H, 00H, 00H, 00H, 00H, 00H       ; 400032E8 _ @.......
        db 1CH, 19H, 6BH, 5BH, 00H, 00H, 00H, 00H       ; 400032F0 _ ..k[....
        db 0CH, 00H, 00H, 00H, 14H, 00H, 00H, 00H       ; 400032F8 _ ........
        db 84H, 34H, 00H, 00H, 84H, 1AH, 00H, 00H       ; 40003300 _ .4......
        db 00H, 00H, 00H, 00H, 1CH, 19H, 6BH, 5BH       ; 40003308 _ ......k[
        db 00H, 00H, 00H, 00H, 0DH, 00H, 00H, 00H       ; 40003310 _ ........
        db 6CH, 02H, 00H, 00H, 98H, 34H, 00H, 00H       ; 40003318 _ l....4..
        db 98H, 1AH, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003320 _ ........
        db 1CH, 19H, 6BH, 5BH, 00H, 00H, 00H, 00H       ; 40003328 _ ..k[....
        db 0EH, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003330 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003338 _ ........

Load_configuration_table label dword
        db 00H, 01H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003340 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003348 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003350 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003358 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003360 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003368 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003370 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003378 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003380 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003388 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003390 _ ........
        dq Unnamed_80000000_0                           ; 40003398 _ 0000000140004000 (d)
        dq 0000000000000000H                            ; 400033A0 _ 0000000000000000
        dq 0000000000000000H                            ; 400033A8 _ 0000000000000000
        dq Unnamed_80000000_0                           ; 400033B0 _ 00000001400031B8 (d)
        dq Unnamed_80000000_0                           ; 400033B8 _ 00000001400031C0 (d)
        dq 0000000000000000H                            ; 400033C0 _ 0000000000000000
        dq 0000000000000000H                            ; 400033C8 _ 0000000000000000
        dq 0000000000000100H                            ; 400033D0 _ 0000000000000100
        dq 0000000000000000H                            ; 400033D8 _ 0000000000000000
        dq 0000000000000000H                            ; 400033E0 _ 0000000000000000
        dq 0000000000000000H                            ; 400033E8 _ 0000000000000000
        dq 0000000000000000H                            ; 400033F0 _ 0000000000000000
        dq 0000000000000000H                            ; 400033F8 _ 0000000000000000
        dq 0000000000000000H                            ; 40003400 _ 0000000000000000
        dq 0000000000000000H                            ; 40003408 _ 0000000000000000
        dq 0000000000000000H                            ; 40003410 _ 0000000000000000
        dq 0000000000000000H                            ; 40003418 _ 0000000000000000
        dq 0000000000000000H                            ; 40003420 _ 0000000000000000
        dq 0000000000000000H                            ; 40003428 _ 0000000000000000
        dq 0000000000000000H                            ; 40003430 _ 0000000000000000
        dq 0000000000000000H                            ; 40003438 _ 0000000000000000
        dq 0AC35237353445352H                           ; 40003440 _ AC35237353445352
        dq 0EFC3D9A7480AEC6DH                           ; 40003448 _ EFC3D9A7480AEC6D
        dq 00000001BC17BF2AH                            ; 40003450 _ 00000001BC17BF2A
        dq 6F6F6D76705C3A43H                            ; 40003458 _ 6F6F6D76705C3A43
        dq 435C7070635C6572H                            ; 40003460 _ 435C7070635C6572
        dq 5C3436785C65726FH                            ; 40003468 _ 5C3436785C65726F
        dq 5C657361656C6552H                            ; 40003470 _ 5C657361656C6552
        dq 6264702E74736554H                            ; 40003478 _ 6264702E74736554
        dq 0000000000000000H                            ; 40003480 _ 0000000000000000
        dq 0000002000000020H                            ; 40003488 _ 0000002000000020
        dq 0000001E00000000H                            ; 40003490 _ 0000001E00000000
        dq 000010004C544347H                            ; 40003498 _ 000010004C544347
        dq 7865742E00001180H                            ; 400034A0 _ 7865742E00001180
        dq 000000006E6D2474H                            ; 400034A8 _ 000000006E6D2474
        dq 0000001200002180H                            ; 400034B0 _ 0000001200002180
        dq 6E6D24747865742EH                            ; 400034B8 _ 6E6D24747865742E
        dq 0000219200303024H                            ; 400034C0 _ 0000219200303024
        dq 7865742E00000036H                            ; 400034C8 _ 7865742E00000036
        dq 0000300000782474H                            ; 400034D0 _ 0000300000782474
        dq 6164692E000001B8H                            ; 400034D8 _ 6164692E000001B8
        dq 0000000035246174H                            ; 400034E0 _ 0000000035246174
        dq 00000010000031B8H                            ; 400034E8 _ 00000010000031B8
        dq 000067666330302EH                            ; 400034F0 _ 000067666330302E
        dq 00000008000031C8H                            ; 400034F8 _ 00000008000031C8
        dq 414358245452432EH                            ; 40003500 _ 414358245452432E
        dq 000031D000000000H                            ; 40003508 _ 000031D000000000
        dq 5452432E00000008H                            ; 40003510 _ 5452432E00000008
        dq 0000004141435824H                            ; 40003518 _ 0000004141435824
        dq 00000008000031D8H                            ; 40003520 _ 00000008000031D8
        dq 5A4358245452432EH                            ; 40003528 _ 5A4358245452432E
        dq 000031E000000000H                            ; 40003530 _ 000031E000000000
        dq 5452432E00000008H                            ; 40003538 _ 5452432E00000008
        dq 0000000041495824H                            ; 40003540 _ 0000000041495824
        dq 00000008000031E8H                            ; 40003548 _ 00000008000031E8
        dq 414958245452432EH                            ; 40003550 _ 414958245452432E
        dq 000031F000000041H                            ; 40003558 _ 000031F000000041
        dq 5452432E00000008H                            ; 40003560 _ 5452432E00000008
        dq 0000004341495824H                            ; 40003568 _ 0000004341495824
        dq 00000008000031F8H                            ; 40003570 _ 00000008000031F8
        dq 5A4958245452432EH                            ; 40003578 _ 5A4958245452432E
        dq 0000320000000000H                            ; 40003580 _ 0000320000000000
        dq 5452432E00000008H                            ; 40003588 _ 5452432E00000008
        dq 0000000041505824H                            ; 40003590 _ 0000000041505824
        dq 0000000800003208H                            ; 40003598 _ 0000000800003208
        dq 5A5058245452432EH                            ; 400035A0 _ 5A5058245452432E
        dq 0000321000000000H                            ; 400035A8 _ 0000321000000000
        dq 5452432E00000008H                            ; 400035B0 _ 5452432E00000008
        dq 0000000041545824H                            ; 400035B8 _ 0000000041545824
        dq 0000000800003218H                            ; 400035C0 _ 0000000800003218
        dq 5A5458245452432EH                            ; 400035C8 _ 5A5458245452432E
        dq 0000322000000000H                            ; 400035D0 _ 0000322000000000
        dq 6164722E00000220H                            ; 400035D8 _ 6164722E00000220
        dq 0000344000006174H                            ; 400035E0 _ 0000344000006174
        dq 6164722E000002C8H                            ; 400035E8 _ 6164722E000002C8
        dq 62647A7A7A246174H                            ; 400035F0 _ 62647A7A7A246174
        dq 0000370800000067H                            ; 400035F8 _ 0000370800000067
        dq 6374722E00000008H                            ; 40003600 _ 6374722E00000008
        dq 0000000041414924H                            ; 40003608 _ 0000000041414924
        dq 0000000800003710H                            ; 40003610 _ 0000000800003710
        dq 5A5A49246374722EH                            ; 40003618 _ 5A5A49246374722E
        dq 0000371800000000H                            ; 40003620 _ 0000371800000000
        dq 6374722E00000008H                            ; 40003628 _ 6374722E00000008
        dq 0000000041415424H                            ; 40003630 _ 0000000041415424
        dq 0000000800003720H                            ; 40003638 _ 0000000800003720
        dq 5A5A54246374722EH                            ; 40003640 _ 5A5A54246374722E
        dq 0000372800000000H                            ; 40003648 _ 0000372800000000
        dq 6164782E00000134H                            ; 40003650 _ 6164782E00000134
        dq 0000385C00006174H                            ; 40003658 _ 0000385C00006174
        dq 6164692E000000A0H                            ; 40003660 _ 6164692E000000A0
        dq 0000000032246174H                            ; 40003668 _ 0000000032246174
        dq 00000014000038FCH                            ; 40003670 _ 00000014000038FC
        dq 332461746164692EH                            ; 40003678 _ 332461746164692E
        dq 0000391000000000H                            ; 40003680 _ 0000391000000000
        dq 6164692E000001B8H                            ; 40003688 _ 6164692E000001B8
        dq 0000000034246174H                            ; 40003690 _ 0000000034246174
        dq 0000047400003AC8H                            ; 40003698 _ 0000047400003AC8
        dq 362461746164692EH                            ; 400036A0 _ 362461746164692E
        dq 0000400000000000H                            ; 400036A8 _ 0000400000000000
        dq 7461642E00000040H                            ; 400036B0 _ 7461642E00000040
        dq 0000404000000061H                            ; 400036B8 _ 0000404000000061
        dq 7373622E00000600H                            ; 400036C0 _ 7373622E00000600
        dq 0000500000000000H                            ; 400036C8 _ 0000500000000000
        dq 6164702E00000180H                            ; 400036D0 _ 6164702E00000180
        dq 0000600000006174H                            ; 400036D8 _ 0000600000006174
        dq 7273722E00000060H                            ; 400036E0 _ 7273722E00000060
        dq 0000000031302463H                            ; 400036E8 _ 0000000031302463
        dq 0000018000006060H                            ; 400036F0 _ 0000018000006060
        dq 323024637273722EH                            ; 400036F8 _ 323024637273722E
        dq 0000000000000000H                            ; 40003700 _ 0000000000000000
        dq 0000000000000000H                            ; 40003708 _ 0000000000000000

?_135   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003710 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003718 _ ........

?_136   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003720 _ ........
        db 01H, 1BH, 04H, 00H, 1BH, 52H, 17H, 70H       ; 40003728 _ .....R.p
        db 16H, 60H, 15H, 30H, 00H, 00H, 00H, 00H       ; 40003730 _ .`.0....
        db 01H, 00H, 00H, 00H, 01H, 06H, 02H, 00H       ; 40003738 _ ........
        db 06H, 32H, 02H, 30H, 01H, 04H, 01H, 00H       ; 40003740 _ .2.0....
        db 04H, 42H, 00H, 00H, 09H, 0FH, 06H, 00H       ; 40003748 _ .B......
        db 0FH, 64H, 09H, 00H, 0FH, 34H, 08H, 00H       ; 40003750 _ .d...4..
        db 0FH, 52H, 0BH, 70H, 90H, 1CH, 00H, 00H       ; 40003758 _ .R.p....
        db 02H, 00H, 00H, 00H, 0A9H, 11H, 00H, 00H      ; 40003760 _ ........
        db 0AEH, 12H, 00H, 00H, 92H, 21H, 00H, 00H      ; 40003768 _ .....!..
        db 0AEH, 12H, 00H, 00H, 0E2H, 12H, 00H, 00H     ; 40003770 _ ........
        db 0F4H, 12H, 00H, 00H, 92H, 21H, 00H, 00H      ; 40003778 _ .....!..
        db 0AEH, 12H, 00H, 00H, 01H, 06H, 02H, 00H      ; 40003780 _ ........
        db 06H, 32H, 02H, 50H, 01H, 09H, 01H, 00H       ; 40003788 _ .2.P....
        db 09H, 62H, 00H, 00H, 01H, 08H, 04H, 00H       ; 40003790 _ .b......
        db 08H, 72H, 04H, 70H, 03H, 60H, 02H, 30H       ; 40003798 _ .r.p.`.0
        db 09H, 04H, 01H, 00H, 04H, 22H, 00H, 00H       ; 400037A0 _ ....."..
        db 90H, 1CH, 00H, 00H, 01H, 00H, 00H, 00H       ; 400037A8 _ ........
        db 0F7H, 15H, 00H, 00H, 82H, 16H, 00H, 00H      ; 400037B0 _ ........
        db 0B0H, 21H, 00H, 00H, 82H, 16H, 00H, 00H      ; 400037B8 _ .!......
        db 01H, 02H, 01H, 00H, 02H, 50H, 00H, 00H       ; 400037C0 _ .....P..
        db 01H, 0DH, 04H, 00H, 0DH, 34H, 0AH, 00H       ; 400037C8 _ .....4..
        db 0DH, 72H, 06H, 50H, 01H, 0DH, 04H, 00H       ; 400037D0 _ .r.P....
        db 0DH, 34H, 09H, 00H, 0DH, 32H, 06H, 50H       ; 400037D8 _ .4...2.P
        db 01H, 15H, 05H, 00H, 15H, 34H, 0BAH, 00H      ; 400037E0 _ .....4..
        db 15H, 01H, 0B8H, 00H, 06H, 50H, 00H, 00H      ; 400037E8 _ .....P..
        db 01H, 0AH, 04H, 00H, 0AH, 34H, 06H, 00H       ; 400037F0 _ .....4..
        db 0AH, 32H, 06H, 70H, 01H, 12H, 08H, 00H       ; 400037F8 _ .2.p....
        db 12H, 54H, 08H, 00H, 12H, 34H, 07H, 00H       ; 40003800 _ .T...4..
        db 12H, 12H, 0EH, 0E0H, 0CH, 70H, 0BH, 60H      ; 40003808 _ .....p.`
        db 01H, 00H, 00H, 00H, 01H, 18H, 0AH, 00H       ; 40003810 _ ........
        db 18H, 64H, 0AH, 00H, 18H, 54H, 09H, 00H       ; 40003818 _ .d...T..
        db 18H, 34H, 08H, 00H, 18H, 32H, 14H, 0F0H      ; 40003820 _ .4...2..
        db 12H, 0E0H, 10H, 70H, 01H, 18H, 0AH, 00H      ; 40003828 _ ...p....
        db 18H, 64H, 0AH, 00H, 18H, 54H, 09H, 00H       ; 40003830 _ .d...T..
        db 18H, 34H, 08H, 00H, 18H, 32H, 14H, 0F0H      ; 40003838 _ .4...2..
        db 12H, 0E0H, 10H, 70H, 01H, 18H, 0AH, 00H      ; 40003840 _ ...p....
        db 18H, 64H, 0AH, 00H, 18H, 54H, 09H, 00H       ; 40003848 _ .d...T..
        db 18H, 34H, 08H, 00H, 18H, 32H, 14H, 0F0H      ; 40003850 _ .4...2..
        db 12H, 0E0H, 10H, 70H                          ; 40003858 _ ...p

Import_table label dword
        db 90H, 39H, 00H, 00H, 00H, 00H, 00H, 00H       ; 4000385C _ .9......
        db 00H, 00H, 00H, 00H, 0F6H, 3AH, 00H, 00H      ; 40003864 _ .....:..
        db 80H, 30H, 00H, 00H, 0A8H, 39H, 00H, 00H      ; 4000386C _ .0...9..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003874 _ ........
        db 26H, 3BH, 00H, 00H, 98H, 30H, 00H, 00H       ; 4000387C _ &;...0..
        db 0C0H, 39H, 00H, 00H, 00H, 00H, 00H, 00H      ; 40003884 _ .9......
        db 00H, 00H, 00H, 00H, 2CH, 3DH, 00H, 00H       ; 4000388C _ ....,=..
        db 0B0H, 30H, 00H, 00H, 98H, 3AH, 00H, 00H      ; 40003894 _ .0...:..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 4000389C _ ........
        db 4CH, 3DH, 00H, 00H, 88H, 31H, 00H, 00H       ; 400038A4 _ L=...1..
        db 00H, 3AH, 00H, 00H, 00H, 00H, 00H, 00H       ; 400038AC _ .:......
        db 00H, 00H, 00H, 00H, 6CH, 3DH, 00H, 00H       ; 400038B4 _ ....l=..
        db 0F0H, 30H, 00H, 00H, 0F0H, 39H, 00H, 00H     ; 400038BC _ .0...9..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400038C4 _ ........
        db 8EH, 3DH, 00H, 00H, 0E0H, 30H, 00H, 00H      ; 400038CC _ .=...0..
        db 0E0H, 39H, 00H, 00H, 00H, 00H, 00H, 00H      ; 400038D4 _ .9......
        db 00H, 00H, 00H, 00H, 0AEH, 3DH, 00H, 00H      ; 400038DC _ .....=..
        db 0D0H, 30H, 00H, 00H, 10H, 39H, 00H, 00H      ; 400038E4 _ .0...9..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400038EC _ ........
        db 2EH, 3FH, 00H, 00H, 00H, 30H, 00H, 00H       ; 400038F4 _ .?...0..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400038FC _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003904 _ ........
        db 00H, 00H, 00H, 00H, 0F0H, 3EH, 00H, 00H      ; 4000390C _ .....>..
        db 00H, 00H, 00H, 00H, 0E4H, 3DH, 00H, 00H      ; 40003914 _ .....=..
        db 00H, 00H, 00H, 00H, 0FEH, 3DH, 00H, 00H      ; 4000391C _ .....=..
        db 00H, 00H, 00H, 00H, 12H, 3EH, 00H, 00H       ; 40003924 _ .....>..
        db 00H, 00H, 00H, 00H, 2EH, 3EH, 00H, 00H       ; 4000392C _ .....>..
        db 00H, 00H, 00H, 00H, 4CH, 3EH, 00H, 00H       ; 40003934 _ ....L>..
        db 00H, 00H, 00H, 00H, 60H, 3EH, 00H, 00H       ; 4000393C _ ....`>..
        db 00H, 00H, 00H, 00H, 74H, 3EH, 00H, 00H       ; 40003944 _ ....t>..
        db 00H, 00H, 00H, 00H, 90H, 3EH, 00H, 00H       ; 4000394C _ .....>..
        db 00H, 00H, 00H, 00H, 1AH, 3FH, 00H, 00H       ; 40003954 _ .....?..
        db 00H, 00H, 00H, 00H, 06H, 3FH, 00H, 00H       ; 4000395C _ .....?..
        db 00H, 00H, 00H, 00H, 0D0H, 3DH, 00H, 00H      ; 40003964 _ .....=..
        db 00H, 00H, 00H, 00H, 0D6H, 3EH, 00H, 00H      ; 4000396C _ .....>..
        db 00H, 00H, 00H, 00H, 0C0H, 3EH, 00H, 00H      ; 40003974 _ .....>..
        db 00H, 00H, 00H, 00H, 0AAH, 3EH, 00H, 00H      ; 4000397C _ .....>..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003984 _ ........
        db 00H, 00H, 00H, 00H, 0DEH, 3AH, 00H, 00H      ; 4000398C _ .....:..
        db 00H, 00H, 00H, 00H, 0C8H, 3AH, 00H, 00H      ; 40003994 _ .....:..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 4000399C _ ........
        db 00H, 00H, 00H, 00H, 1CH, 3BH, 00H, 00H       ; 400039A4 _ .....;..
        db 00H, 00H, 00H, 00H, 04H, 3BH, 00H, 00H       ; 400039AC _ .....;..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400039B4 _ ........
        db 00H, 00H, 00H, 00H, 40H, 3BH, 00H, 00H       ; 400039BC _ ....@;..
        db 00H, 00H, 00H, 00H, 38H, 3BH, 00H, 00H       ; 400039C4 _ ....8;..
        db 00H, 00H, 00H, 00H, 0BAH, 3CH, 00H, 00H      ; 400039CC _ .....<..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400039D4 _ ........
        db 00H, 00H, 00H, 00H, 0A4H, 3CH, 00H, 00H      ; 400039DC _ .....<..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400039E4 _ ........
        db 00H, 00H, 00H, 00H, 0A2H, 3BH, 00H, 00H      ; 400039EC _ .....;..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400039F4 _ ........
        db 00H, 00H, 00H, 00H, 0DAH, 3CH, 00H, 00H      ; 400039FC _ .....<..
        db 00H, 00H, 00H, 00H, 0F6H, 3CH, 00H, 00H      ; 40003A04 _ .....<..
        db 00H, 00H, 00H, 00H, 12H, 3DH, 00H, 00H       ; 40003A0C _ .....=..
        db 00H, 00H, 00H, 00H, 20H, 3DH, 00H, 00H       ; 40003A14 _ .... =..
        db 00H, 00H, 00H, 00H, 76H, 3CH, 00H, 00H       ; 40003A1C _ ....v<..
        db 00H, 00H, 00H, 00H, 6CH, 3CH, 00H, 00H       ; 40003A24 _ ....l<..
        db 00H, 00H, 00H, 00H, 62H, 3CH, 00H, 00H       ; 40003A2C _ ....b<..
        db 00H, 00H, 00H, 00H, 46H, 3CH, 00H, 00H       ; 40003A34 _ ....F<..
        db 00H, 00H, 00H, 00H, 54H, 3CH, 00H, 00H       ; 40003A3C _ ....T<..
        db 00H, 00H, 00H, 00H, 30H, 3CH, 00H, 00H       ; 40003A44 _ ....0<..
        db 00H, 00H, 00H, 00H, 28H, 3CH, 00H, 00H       ; 40003A4C _ ....(<..
        db 00H, 00H, 00H, 00H, 1AH, 3CH, 00H, 00H       ; 40003A54 _ .....<..
        db 00H, 00H, 00H, 00H, 0EH, 3CH, 00H, 00H       ; 40003A5C _ .....<..
        db 00H, 00H, 00H, 00H, 0EEH, 3BH, 00H, 00H      ; 40003A64 _ .....;..
        db 00H, 00H, 00H, 00H, 0CEH, 3BH, 00H, 00H      ; 40003A6C _ .....;..
        db 00H, 00H, 00H, 00H, 0B6H, 3BH, 00H, 00H      ; 40003A74 _ .....;..
        db 00H, 00H, 00H, 00H, 92H, 3BH, 00H, 00H       ; 40003A7C _ .....;..
        db 00H, 00H, 00H, 00H, 80H, 3BH, 00H, 00H       ; 40003A84 _ .....;..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003A8C _ ........
        db 00H, 00H, 00H, 00H, 4AH, 3BH, 00H, 00H       ; 40003A94 _ ....J;..
        db 00H, 00H, 00H, 00H, 5CH, 3BH, 00H, 00H       ; 40003A9C _ ....\;..
        db 00H, 00H, 00H, 00H, 0CAH, 3CH, 00H, 00H      ; 40003AA4 _ .....<..
        db 00H, 00H, 00H, 00H, 38H, 3CH, 00H, 00H       ; 40003AAC _ ....8<..
        db 00H, 00H, 00H, 00H, 76H, 3BH, 00H, 00H       ; 40003AB4 _ ....v;..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003ABC _ ........
        db 00H, 00H, 00H, 00H, 90H, 05H, 5FH, 51H       ; 40003AC4 _ ......_Q
        db 75H, 65H, 72H, 79H, 5FH, 70H, 65H, 72H       ; 40003ACC _ uery_per
        db 66H, 5FH, 63H, 6FH, 75H, 6EH, 74H, 65H       ; 40003AD4 _ f_counte
        db 72H, 00H                                     ; 40003ADC _ r.

Import_name_table label byte
        db 91H, 05H, 5FH, 51H, 75H, 65H, 72H, 79H       ; 40003ADE _ .._Query
        db 5FH, 70H, 65H, 72H, 66H, 5FH, 66H, 72H       ; 40003AE6 _ _perf_fr
        db 65H, 71H, 75H, 65H, 6EH, 63H, 79H, 00H       ; 40003AEE _ equency.
        db 4DH, 53H, 56H, 43H, 50H, 31H, 34H, 30H       ; 40003AF6 _ MSVCP140
        db 2EH, 64H, 6CH, 6CH, 00H, 00H, 08H, 00H       ; 40003AFE _ .dll....
        db 5FH, 5FH, 43H, 5FH, 73H, 70H, 65H, 63H       ; 40003B06 _ __C_spec
        db 69H, 66H, 69H, 63H, 5FH, 68H, 61H, 6EH       ; 40003B0E _ ific_han
        db 64H, 6CH, 65H, 72H, 00H, 00H, 3EH, 00H       ; 40003B16 _ dler..>.
        db 6DH, 65H, 6DH, 73H, 65H, 74H, 00H, 00H       ; 40003B1E _ memset..
        db 56H, 43H, 52H, 55H, 4EH, 54H, 49H, 4DH       ; 40003B26 _ VCRUNTIM
        db 45H, 31H, 34H, 30H, 2EH, 64H, 6CH, 6CH       ; 40003B2E _ E140.dll
        db 00H, 00H, 18H, 00H, 66H, 72H, 65H, 65H       ; 40003B36 _ ....free
        db 00H, 00H, 1AH, 00H, 72H, 65H, 61H, 6CH       ; 40003B3E _ ....real
        db 6CH, 6FH, 63H, 00H, 00H, 00H, 5FH, 5FH       ; 40003B46 _ loc...__
        db 61H, 63H, 72H, 74H, 5FH, 69H, 6FH, 62H       ; 40003B4E _ acrt_iob
        db 5FH, 66H, 75H, 6EH, 63H, 00H, 03H, 00H       ; 40003B56 _ _func...
        db 5FH, 5FH, 73H, 74H, 64H, 69H, 6FH, 5FH       ; 40003B5E _ __stdio_
        db 63H, 6FH, 6DH, 6DH, 6FH, 6EH, 5FH, 76H       ; 40003B66 _ common_v
        db 66H, 70H, 72H, 69H, 6EH, 74H, 66H, 00H       ; 40003B6E _ fprintf.
        db 8CH, 00H, 67H, 65H, 74H, 63H, 68H, 61H       ; 40003B76 _ ..getcha
        db 72H, 00H, 40H, 00H, 5FH, 73H, 65H, 68H       ; 40003B7E _ r.@._seh
        db 5FH, 66H, 69H, 6CH, 74H, 65H, 72H, 5FH       ; 40003B86 _ _filter_
        db 65H, 78H, 65H, 00H, 42H, 00H, 5FH, 73H       ; 40003B8E _ exe.B._s
        db 65H, 74H, 5FH, 61H, 70H, 70H, 5FH, 74H       ; 40003B96 _ et_app_t
        db 79H, 70H, 65H, 00H, 09H, 00H, 5FH, 5FH       ; 40003B9E _ ype...__
        db 73H, 65H, 74H, 75H, 73H, 65H, 72H, 6DH       ; 40003BA6 _ setuserm
        db 61H, 74H, 68H, 65H, 72H, 72H, 00H, 00H       ; 40003BAE _ atherr..
        db 19H, 00H, 5FH, 63H, 6FH, 6EH, 66H, 69H       ; 40003BB6 _ .._confi
        db 67H, 75H, 72H, 65H, 5FH, 77H, 69H, 64H       ; 40003BBE _ gure_wid
        db 65H, 5FH, 61H, 72H, 67H, 76H, 00H, 00H       ; 40003BC6 _ e_argv..
        db 35H, 00H, 5FH, 69H, 6EH, 69H, 74H, 69H       ; 40003BCE _ 5._initi
        db 61H, 6CH, 69H, 7AH, 65H, 5FH, 77H, 69H       ; 40003BD6 _ alize_wi
        db 64H, 65H, 5FH, 65H, 6EH, 76H, 69H, 72H       ; 40003BDE _ de_envir
        db 6FH, 6EH, 6DH, 65H, 6EH, 74H, 00H, 00H       ; 40003BE6 _ onment..
        db 29H, 00H, 5FH, 67H, 65H, 74H, 5FH, 69H       ; 40003BEE _ )._get_i
        db 6EH, 69H, 74H, 69H, 61H, 6CH, 5FH, 77H       ; 40003BF6 _ nitial_w
        db 69H, 64H, 65H, 5FH, 65H, 6EH, 76H, 69H       ; 40003BFE _ ide_envi
        db 72H, 6FH, 6EH, 6DH, 65H, 6EH, 74H, 00H       ; 40003C06 _ ronment.
        db 36H, 00H, 5FH, 69H, 6EH, 69H, 74H, 74H       ; 40003C0E _ 6._initt
        db 65H, 72H, 6DH, 00H, 37H, 00H, 5FH, 69H       ; 40003C16 _ erm.7._i
        db 6EH, 69H, 74H, 74H, 65H, 72H, 6DH, 5FH       ; 40003C1E _ nitterm_
        db 65H, 00H, 55H, 00H, 65H, 78H, 69H, 74H       ; 40003C26 _ e.U.exit
        db 00H, 00H, 23H, 00H, 5FH, 65H, 78H, 69H       ; 40003C2E _ ..#._exi
        db 74H, 00H, 54H, 00H, 5FH, 73H, 65H, 74H       ; 40003C36 _ t.T._set
        db 5FH, 66H, 6DH, 6FH, 64H, 65H, 00H, 00H       ; 40003C3E _ _fmode..
        db 04H, 00H, 5FH, 5FH, 70H, 5FH, 5FH, 5FH       ; 40003C46 _ ..__p___
        db 61H, 72H, 67H, 63H, 00H, 00H, 06H, 00H       ; 40003C4E _ argc....
        db 5FH, 5FH, 70H, 5FH, 5FH, 5FH, 77H, 61H       ; 40003C56 _ __p___wa
        db 72H, 67H, 76H, 00H, 16H, 00H, 5FH, 63H       ; 40003C5E _ rgv..._c
        db 65H, 78H, 69H, 74H, 00H, 00H, 15H, 00H       ; 40003C66 _ exit....
        db 5FH, 63H, 5FH, 65H, 78H, 69H, 74H, 00H       ; 40003C6E _ _c_exit.
        db 3DH, 00H, 5FH, 72H, 65H, 67H, 69H, 73H       ; 40003C76 _ =._regis
        db 74H, 65H, 72H, 5FH, 74H, 68H, 72H, 65H       ; 40003C7E _ ter_thre
        db 61H, 64H, 5FH, 6CH, 6FH, 63H, 61H, 6CH       ; 40003C86 _ ad_local
        db 5FH, 65H, 78H, 65H, 5FH, 61H, 74H, 65H       ; 40003C8E _ _exe_ate
        db 78H, 69H, 74H, 5FH, 63H, 61H, 6CH, 6CH       ; 40003C96 _ xit_call
        db 62H, 61H, 63H, 6BH, 00H, 00H, 08H, 00H       ; 40003C9E _ back....
        db 5FH, 63H, 6FH, 6EH, 66H, 69H, 67H, 74H       ; 40003CA6 _ _configt
        db 68H, 72H, 65H, 61H, 64H, 6CH, 6FH, 63H       ; 40003CAE _ hreadloc
        db 61H, 6CH, 65H, 00H, 16H, 00H, 5FH, 73H       ; 40003CB6 _ ale..._s
        db 65H, 74H, 5FH, 6EH, 65H, 77H, 5FH, 6DH       ; 40003CBE _ et_new_m
        db 6FH, 64H, 65H, 00H, 01H, 00H, 5FH, 5FH       ; 40003CC6 _ ode...__
        db 70H, 5FH, 5FH, 63H, 6FH, 6DH, 6DH, 6FH       ; 40003CCE _ p__commo
        db 64H, 65H, 00H, 00H, 34H, 00H, 5FH, 69H       ; 40003CD6 _ de..4._i
        db 6EH, 69H, 74H, 69H, 61H, 6CH, 69H, 7AH       ; 40003CDE _ nitializ
        db 65H, 5FH, 6FH, 6EH, 65H, 78H, 69H, 74H       ; 40003CE6 _ e_onexit
        db 5FH, 74H, 61H, 62H, 6CH, 65H, 00H, 00H       ; 40003CEE _ _table..
        db 3CH, 00H, 5FH, 72H, 65H, 67H, 69H, 73H       ; 40003CF6 _ <._regis
        db 74H, 65H, 72H, 5FH, 6FH, 6EH, 65H, 78H       ; 40003CFE _ ter_onex
        db 69H, 74H, 5FH, 66H, 75H, 6EH, 63H, 74H       ; 40003D06 _ it_funct
        db 69H, 6FH, 6EH, 00H, 1EH, 00H, 5FH, 63H       ; 40003D0E _ ion..._c
        db 72H, 74H, 5FH, 61H, 74H, 65H, 78H, 69H       ; 40003D16 _ rt_atexi
        db 74H, 00H, 67H, 00H, 74H, 65H, 72H, 6DH       ; 40003D1E _ t.g.term
        db 69H, 6EH, 61H, 74H, 65H, 00H, 61H, 70H       ; 40003D26 _ inate.ap
        db 69H, 2DH, 6DH, 73H, 2DH, 77H, 69H, 6EH       ; 40003D2E _ i-ms-win
        db 2DH, 63H, 72H, 74H, 2DH, 68H, 65H, 61H       ; 40003D36 _ -crt-hea
        db 70H, 2DH, 6CH, 31H, 2DH, 31H, 2DH, 30H       ; 40003D3E _ p-l1-1-0
        db 2EH, 64H, 6CH, 6CH, 00H, 00H, 61H, 70H       ; 40003D46 _ .dll..ap
        db 69H, 2DH, 6DH, 73H, 2DH, 77H, 69H, 6EH       ; 40003D4E _ i-ms-win
        db 2DH, 63H, 72H, 74H, 2DH, 73H, 74H, 64H       ; 40003D56 _ -crt-std
        db 69H, 6FH, 2DH, 6CH, 31H, 2DH, 31H, 2DH       ; 40003D5E _ io-l1-1-
        db 30H, 2EH, 64H, 6CH, 6CH, 00H, 61H, 70H       ; 40003D66 _ 0.dll.ap
        db 69H, 2DH, 6DH, 73H, 2DH, 77H, 69H, 6EH       ; 40003D6E _ i-ms-win
        db 2DH, 63H, 72H, 74H, 2DH, 72H, 75H, 6EH       ; 40003D76 _ -crt-run
        db 74H, 69H, 6DH, 65H, 2DH, 6CH, 31H, 2DH       ; 40003D7E _ time-l1-
        db 31H, 2DH, 30H, 2EH, 64H, 6CH, 6CH, 00H       ; 40003D86 _ 1-0.dll.
        db 61H, 70H, 69H, 2DH, 6DH, 73H, 2DH, 77H       ; 40003D8E _ api-ms-w
        db 69H, 6EH, 2DH, 63H, 72H, 74H, 2DH, 6DH       ; 40003D96 _ in-crt-m
        db 61H, 74H, 68H, 2DH, 6CH, 31H, 2DH, 31H       ; 40003D9E _ ath-l1-1
        db 2DH, 30H, 2EH, 64H, 6CH, 6CH, 00H, 00H       ; 40003DA6 _ -0.dll..
        db 61H, 70H, 69H, 2DH, 6DH, 73H, 2DH, 77H       ; 40003DAE _ api-ms-w
        db 69H, 6EH, 2DH, 63H, 72H, 74H, 2DH, 6CH       ; 40003DB6 _ in-crt-l
        db 6FH, 63H, 61H, 6CH, 65H, 2DH, 6CH, 31H       ; 40003DBE _ ocale-l1
        db 2DH, 31H, 2DH, 30H, 2EH, 64H, 6CH, 6CH       ; 40003DC6 _ -1-0.dll
        db 00H, 00H, 0CBH, 04H, 52H, 74H, 6CH, 43H      ; 40003DCE _ ....RtlC
        db 61H, 70H, 74H, 75H, 72H, 65H, 43H, 6FH       ; 40003DD6 _ aptureCo
        db 6EH, 74H, 65H, 78H, 74H, 00H, 0D2H, 04H      ; 40003DDE _ ntext...
        db 52H, 74H, 6CH, 4CH, 6FH, 6FH, 6BH, 75H       ; 40003DE6 _ RtlLooku
        db 70H, 46H, 75H, 6EH, 63H, 74H, 69H, 6FH       ; 40003DEE _ pFunctio
        db 6EH, 45H, 6EH, 74H, 72H, 79H, 00H, 00H       ; 40003DF6 _ nEntry..
        db 0D9H, 04H, 52H, 74H, 6CH, 56H, 69H, 72H      ; 40003DFE _ ..RtlVir
        db 74H, 75H, 61H, 6CH, 55H, 6EH, 77H, 69H       ; 40003E06 _ tualUnwi
        db 6EH, 64H, 00H, 00H, 0B4H, 05H, 55H, 6EH      ; 40003E0E _ nd....Un
        db 68H, 61H, 6EH, 64H, 6CH, 65H, 64H, 45H       ; 40003E16 _ handledE
        db 78H, 63H, 65H, 70H, 74H, 69H, 6FH, 6EH       ; 40003E1E _ xception
        db 46H, 69H, 6CH, 74H, 65H, 72H, 00H, 00H       ; 40003E26 _ Filter..
        db 73H, 05H, 53H, 65H, 74H, 55H, 6EH, 68H       ; 40003E2E _ s.SetUnh
        db 61H, 6EH, 64H, 6CH, 65H, 64H, 45H, 78H       ; 40003E36 _ andledEx
        db 63H, 65H, 70H, 74H, 69H, 6FH, 6EH, 46H       ; 40003E3E _ ceptionF
        db 69H, 6CH, 74H, 65H, 72H, 00H, 1BH, 02H       ; 40003E46 _ ilter...
        db 47H, 65H, 74H, 43H, 75H, 72H, 72H, 65H       ; 40003E4E _ GetCurre
        db 6EH, 74H, 50H, 72H, 6FH, 63H, 65H, 73H       ; 40003E56 _ ntProces
        db 73H, 00H, 92H, 05H, 54H, 65H, 72H, 6DH       ; 40003E5E _ s...Term
        db 69H, 6EH, 61H, 74H, 65H, 50H, 72H, 6FH       ; 40003E66 _ inatePro
        db 63H, 65H, 73H, 73H, 00H, 00H, 84H, 03H       ; 40003E6E _ cess....
        db 49H, 73H, 50H, 72H, 6FH, 63H, 65H, 73H       ; 40003E76 _ IsProces
        db 73H, 6FH, 72H, 46H, 65H, 61H, 74H, 75H       ; 40003E7E _ sorFeatu
        db 72H, 65H, 50H, 72H, 65H, 73H, 65H, 6EH       ; 40003E86 _ rePresen
        db 74H, 00H, 49H, 04H, 51H, 75H, 65H, 72H       ; 40003E8E _ t.I.Quer
        db 79H, 50H, 65H, 72H, 66H, 6FH, 72H, 6DH       ; 40003E96 _ yPerform
        db 61H, 6EH, 63H, 65H, 43H, 6FH, 75H, 6EH       ; 40003E9E _ anceCoun
        db 74H, 65H, 72H, 00H, 1CH, 02H, 47H, 65H       ; 40003EA6 _ ter...Ge
        db 74H, 43H, 75H, 72H, 72H, 65H, 6EH, 74H       ; 40003EAE _ tCurrent
        db 50H, 72H, 6FH, 63H, 65H, 73H, 73H, 49H       ; 40003EB6 _ ProcessI
        db 64H, 00H, 20H, 02H, 47H, 65H, 74H, 43H       ; 40003EBE _ d. .GetC
        db 75H, 72H, 72H, 65H, 6EH, 74H, 54H, 68H       ; 40003EC6 _ urrentTh
        db 72H, 65H, 61H, 64H, 49H, 64H, 00H, 00H       ; 40003ECE _ readId..
        db 0ECH, 02H, 47H, 65H, 74H, 53H, 79H, 73H      ; 40003ED6 _ ..GetSys
        db 74H, 65H, 6DH, 54H, 69H, 6DH, 65H, 41H       ; 40003EDE _ temTimeA
        db 73H, 46H, 69H, 6CH, 65H, 54H, 69H, 6DH       ; 40003EE6 _ sFileTim
        db 65H, 00H, 67H, 03H, 49H, 6EH, 69H, 74H       ; 40003EEE _ e.g.Init
        db 69H, 61H, 6CH, 69H, 7AH, 65H, 53H, 4CH       ; 40003EF6 _ ializeSL
        db 69H, 73H, 74H, 48H, 65H, 61H, 64H, 00H       ; 40003EFE _ istHead.
        db 7DH, 03H, 49H, 73H, 44H, 65H, 62H, 75H       ; 40003F06 _ }.IsDebu
        db 67H, 67H, 65H, 72H, 50H, 72H, 65H, 73H       ; 40003F0E _ ggerPres
        db 65H, 6EH, 74H, 00H, 7AH, 02H, 47H, 65H       ; 40003F16 _ ent.z.Ge
        db 74H, 4DH, 6FH, 64H, 75H, 6CH, 65H, 48H       ; 40003F1E _ tModuleH
        db 61H, 6EH, 64H, 6CH, 65H, 57H, 00H, 00H       ; 40003F26 _ andleW..
        db 4BH, 45H, 52H, 4EH, 45H, 4CH, 33H, 32H       ; 40003F2E _ KERNEL32
        db 2EH, 64H, 6CH, 6CH, 00H, 00H, 00H, 00H       ; 40003F36 _ .dll....
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F3E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F46 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F4E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F56 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F5E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F66 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F6E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F76 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F7E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F86 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F8E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F96 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003F9E _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FA6 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FAE _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FB6 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FBE _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FC6 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FCE _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FD6 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FDE _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FE6 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FEE _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40003FF6 _ ........
        db 00H, 00H                                     ; 40003FFE _ ..

.rdata  ENDS

_data   SEGMENT BYTE 'DATA'                             ; section number 3

?_137   label qword
        dq 00002B992DDFA232H                            ; 40004000 _ 00002B992DDFA232

?_138   label qword
        dq 0FFFFD466D2205DCDH                           ; 40004008 _ FFFFD466D2205DCD
        db 0FFH, 0FFH, 0FFH, 0FFH                       ; 40004010 _ ....

?_139   label dword
        dd 00000001H                                    ; 40004014 _ 1

?_140   label dword
        dd 00000001H                                    ; 40004018 _ 1

?_141   label dword
        dd 00000002H                                    ; 4000401C _ 2

?_142   label qword
        dq 000000000000202FH                            ; 40004020 _ 000000000000202F
        dq 0000000000000000H                            ; 40004028 _ 0000000000000000

?_143   label dword
        dd 00000001H, 00009875H                         ; 40004030 _ 1 39029
        dd 00000000H, 00000000H                         ; 40004038 _ 0 0

?_144   label dword
        dd 00000000H                                    ; 40004040 _ 0

?_145   label dword
        dd 00000000H, 00000000H                         ; 40004044 _ 0 0
        dd 00000000H                                    ; 4000404C _ 0

?_146   label qword
        dq 0000000000000000H                            ; 40004050 _ 0000000000000000

?_147   label dword
        dd 00000000H, 00000000H                         ; 40004058 _ 0 0

?_148   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004060 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004068 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004070 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004078 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004080 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004088 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004090 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004098 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040A0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040A8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040B0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040B8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040C0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040C8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040D0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040D8 _ ........

?_149   label byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040E0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040E8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040F0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400040F8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004100 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004108 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004110 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004118 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004120 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004128 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004130 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004138 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004140 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004148 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004150 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40004158 _ ........

?_150   label qword
        dq 0000000000000000H                            ; 40004160 _ 0000000000000000
        dq 0000000000000000H                            ; 40004168 _ 0000000000000000
        dq 0000000000000000H                            ; 40004170 _ 0000000000000000

?_151   label qword
        dq 0000000000000000H                            ; 40004178 _ 0000000000000000
        dq 0000000000000000H                            ; 40004180 _ 0000000000000000
        dq 0000000000000000H                            ; 40004188 _ 0000000000000000
        dq 0000000000000000H                            ; 40004190 _ 0000000000000000
        dq 0000000000000000H                            ; 40004198 _ 0000000000000000
        dq 0000000000000000H                            ; 400041A0 _ 0000000000000000
        dq 0000000000000000H                            ; 400041A8 _ 0000000000000000
        dq 0000000000000000H                            ; 400041B0 _ 0000000000000000
        dq 0000000000000000H                            ; 400041B8 _ 0000000000000000
        dq 0000000000000000H                            ; 400041C0 _ 0000000000000000
        dq 0000000000000000H                            ; 400041C8 _ 0000000000000000
        dq 0000000000000000H                            ; 400041D0 _ 0000000000000000

?_152   label qword
        dq 0000000000000000H                            ; 400041D8 _ 0000000000000000
        dq 0000000000000000H                            ; 400041E0 _ 0000000000000000
        dq 0000000000000000H                            ; 400041E8 _ 0000000000000000
        dq 0000000000000000H                            ; 400041F0 _ 0000000000000000
        dq 0000000000000000H                            ; 400041F8 _ 0000000000000000

        dq      118 dup (?)                             ; 40004200 _

?_153   label dword
        dd      ?                                       ; 400045B0

?_154   label byte
        db      4 dup (?)                               ; 400045B4

?_155   label qword
        dq      ?                                       ; 400045B8

?_156   label xmmword
        dq      2 dup (?)                               ; 400045C0

?_157   label qword
        dq      ?                                       ; 400045D0

?_158   label xmmword
        dq      2 dup (?)                               ; 400045D8

?_159   label qword
        dq      ?                                       ; 400045E8

?_160   label byte
        db      16 dup (?)                              ; 400045F0

?_161   label byte
        db      16 dup (?)                              ; 40004600

?_162   label byte
        db      8 dup (?)                               ; 40004610

?_163   label dword
        dd      ?                                       ; 40004618

?_164   label dword
        dd      ?                                       ; 4000461C

?_165   label byte
        db      16 dup (?)                              ; 40004620

?_166   label byte
        db      8 dup (?)                               ; 40004630

?_167   label byte
        db      8 dup (?)                               ; 40004638

_data   ENDS

.pdata  SEGMENT BYTE                                    ; section number 4

Exception_table label dword
        db 00H, 10H, 00H, 00H, 55H, 10H, 00H, 00H       ; 40005000 _ ....U...
        db 28H, 37H, 00H, 00H, 80H, 10H, 00H, 00H       ; 40005008 _ (7......
        db 0A1H, 10H, 00H, 00H, 38H, 37H, 00H, 00H      ; 40005010 _ ....87..
        db 0A4H, 10H, 00H, 00H, 54H, 11H, 00H, 00H      ; 40005018 _ ....T...
        db 3CH, 37H, 00H, 00H, 54H, 11H, 00H, 00H       ; 40005020 _ <7..T...
        db 64H, 11H, 00H, 00H, 44H, 37H, 00H, 00H       ; 40005028 _ d...D7..
        db 64H, 11H, 00H, 00H, 7DH, 11H, 00H, 00H       ; 40005030 _ d...}...
        db 44H, 37H, 00H, 00H, 80H, 11H, 00H, 00H       ; 40005038 _ D7......
        db 0FCH, 12H, 00H, 00H, 4CH, 37H, 00H, 00H      ; 40005040 _ ....L7..
        db 0FCH, 12H, 00H, 00H, 0EH, 13H, 00H, 00H      ; 40005048 _ ........
        db 44H, 37H, 00H, 00H, 10H, 13H, 00H, 00H       ; 40005050 _ D7......
        db 44H, 13H, 00H, 00H, 3CH, 37H, 00H, 00H       ; 40005058 _ D...<7..
        db 44H, 13H, 00H, 00H, 15H, 14H, 00H, 00H       ; 40005060 _ D.......
        db 8CH, 37H, 00H, 00H, 18H, 14H, 00H, 00H       ; 40005068 _ .7......
        db 89H, 14H, 00H, 00H, 94H, 37H, 00H, 00H       ; 40005070 _ .....7..
        db 8CH, 14H, 00H, 00H, 0C5H, 14H, 00H, 00H      ; 40005078 _ ........
        db 44H, 37H, 00H, 00H, 0C8H, 14H, 00H, 00H      ; 40005080 _ D7......
        db 11H, 15H, 00H, 00H, 3CH, 37H, 00H, 00H       ; 40005088 _ ....<7..
        db 14H, 15H, 00H, 00H, 0EEH, 15H, 00H, 00H      ; 40005090 _ ........
        db 0C8H, 37H, 00H, 00H, 0F0H, 15H, 00H, 00H     ; 40005098 _ .7......
        db 89H, 16H, 00H, 00H, 0A0H, 37H, 00H, 00H      ; 400050A0 _ .....7..
        db 8CH, 16H, 00H, 00H, 0B0H, 16H, 00H, 00H      ; 400050A8 _ ........
        db 3CH, 37H, 00H, 00H, 0B0H, 16H, 00H, 00H      ; 400050B0 _ <7......
        db 0DBH, 16H, 00H, 00H, 3CH, 37H, 00H, 00H      ; 400050B8 _ ....<7..
        db 0DCH, 16H, 00H, 00H, 2BH, 17H, 00H, 00H      ; 400050C0 _ ....+...
        db 3CH, 37H, 00H, 00H, 2CH, 17H, 00H, 00H       ; 400050C8 _ <7..,...
        db 43H, 17H, 00H, 00H, 44H, 37H, 00H, 00H       ; 400050D0 _ C...D7..
        db 44H, 17H, 00H, 00H, 0F1H, 17H, 00H, 00H      ; 400050D8 _ D.......
        db 0D4H, 37H, 00H, 00H, 28H, 18H, 00H, 00H      ; 400050E0 _ .7..(...
        db 43H, 18H, 00H, 00H, 44H, 37H, 00H, 00H       ; 400050E8 _ C...D7..
        db 68H, 18H, 00H, 00H, 0B2H, 19H, 00H, 00H      ; 400050F0 _ h.......
        db 0E0H, 37H, 00H, 00H, 0B4H, 19H, 00H, 00H     ; 400050F8 _ .7......
        db 06H, 1AH, 00H, 00H, 44H, 37H, 00H, 00H       ; 40005100 _ ....D7..
        db 18H, 1AH, 00H, 00H, 50H, 1AH, 00H, 00H       ; 40005108 _ ....P...
        db 44H, 37H, 00H, 00H, 50H, 1AH, 00H, 00H       ; 40005110 _ D7..P...
        db 8CH, 1AH, 00H, 00H, 0F0H, 37H, 00H, 00H      ; 40005118 _ .....7..
        db 8CH, 1AH, 00H, 00H, 0C8H, 1AH, 00H, 00H      ; 40005120 _ ........
        db 0F0H, 37H, 00H, 00H, 0C8H, 1AH, 00H, 00H     ; 40005128 _ .7......
        db 81H, 1CH, 00H, 00H, 0FCH, 37H, 00H, 00H      ; 40005130 _ .....7..
        db 30H, 1DH, 00H, 00H, 82H, 1EH, 00H, 00H       ; 40005138 _ 0.......
        db 14H, 38H, 00H, 00H, 90H, 1EH, 00H, 00H       ; 40005140 _ .8......
        db 0F2H, 1FH, 00H, 00H, 2CH, 38H, 00H, 00H      ; 40005148 _ ....,8..
        db 00H, 20H, 00H, 00H, 76H, 21H, 00H, 00H       ; 40005150 _ . ..v!..
        db 44H, 38H, 00H, 00H, 90H, 21H, 00H, 00H       ; 40005158 _ D8...!..
        db 92H, 21H, 00H, 00H, 10H, 38H, 00H, 00H       ; 40005160 _ .!...8..
        db 92H, 21H, 00H, 00H, 0B0H, 21H, 00H, 00H      ; 40005168 _ .!...!..
        db 84H, 37H, 00H, 00H, 0B0H, 21H, 00H, 00H      ; 40005170 _ .7...!..
        db 0C8H, 21H, 00H, 00H, 0C0H, 37H, 00H, 00H     ; 40005178 _ .!...7..
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40005180 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40005188 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40005190 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40005198 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051A0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051A8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051B0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051B8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051C0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051C8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051D0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051D8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051E0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051E8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051F0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400051F8 _ ........

.pdata  ENDS

.rsrc   SEGMENT BYTE 'CONST'                            ; section number 5

Resource_table label dword
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40006000 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 01H, 00H       ; 40006008 _ ........
        db 18H, 00H, 00H, 00H, 18H, 00H, 00H, 80H       ; 40006010 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40006018 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 01H, 00H       ; 40006020 _ ........
        db 01H, 00H, 00H, 00H, 30H, 00H, 00H, 80H       ; 40006028 _ ....0...
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40006030 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 01H, 00H       ; 40006038 _ ........
        db 09H, 04H, 00H, 00H, 48H, 00H, 00H, 00H       ; 40006040 _ ....H...
        db 60H, 60H, 00H, 00H, 7DH, 01H, 00H, 00H       ; 40006048 _ ``..}...
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40006050 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40006058 _ ........
        db 3CH, 3FH, 78H, 6DH, 6CH, 20H, 76H, 65H       ; 40006060 _ <?xml ve
        db 72H, 73H, 69H, 6FH, 6EH, 3DH, 27H, 31H       ; 40006068 _ rsion='1
        db 2EH, 30H, 27H, 20H, 65H, 6EH, 63H, 6FH       ; 40006070 _ .0' enco
        db 64H, 69H, 6EH, 67H, 3DH, 27H, 55H, 54H       ; 40006078 _ ding='UT
        db 46H, 2DH, 38H, 27H, 20H, 73H, 74H, 61H       ; 40006080 _ F-8' sta
        db 6EH, 64H, 61H, 6CH, 6FH, 6EH, 65H, 3DH       ; 40006088 _ ndalone=
        db 27H, 79H, 65H, 73H, 27H, 3FH, 3EH, 0DH       ; 40006090 _ 'yes'?>.
        db 0AH, 3CH, 61H, 73H, 73H, 65H, 6DH, 62H       ; 40006098 _ .<assemb
        db 6CH, 79H, 20H, 78H, 6DH, 6CH, 6EH, 73H       ; 400060A0 _ ly xmlns
        db 3DH, 27H, 75H, 72H, 6EH, 3AH, 73H, 63H       ; 400060A8 _ ='urn:sc
        db 68H, 65H, 6DH, 61H, 73H, 2DH, 6DH, 69H       ; 400060B0 _ hemas-mi
        db 63H, 72H, 6FH, 73H, 6FH, 66H, 74H, 2DH       ; 400060B8 _ crosoft-
        db 63H, 6FH, 6DH, 3AH, 61H, 73H, 6DH, 2EH       ; 400060C0 _ com:asm.
        db 76H, 31H, 27H, 20H, 6DH, 61H, 6EH, 69H       ; 400060C8 _ v1' mani
        db 66H, 65H, 73H, 74H, 56H, 65H, 72H, 73H       ; 400060D0 _ festVers
        db 69H, 6FH, 6EH, 3DH, 27H, 31H, 2EH, 30H       ; 400060D8 _ ion='1.0
        db 27H, 3EH, 0DH, 0AH, 20H, 20H, 3CH, 74H       ; 400060E0 _ '>..  <t
        db 72H, 75H, 73H, 74H, 49H, 6EH, 66H, 6FH       ; 400060E8 _ rustInfo
        db 20H, 78H, 6DH, 6CH, 6EH, 73H, 3DH, 22H       ; 400060F0 _  xmlns="
        db 75H, 72H, 6EH, 3AH, 73H, 63H, 68H, 65H       ; 400060F8 _ urn:sche
        db 6DH, 61H, 73H, 2DH, 6DH, 69H, 63H, 72H       ; 40006100 _ mas-micr
        db 6FH, 73H, 6FH, 66H, 74H, 2DH, 63H, 6FH       ; 40006108 _ osoft-co
        db 6DH, 3AH, 61H, 73H, 6DH, 2EH, 76H, 33H       ; 40006110 _ m:asm.v3
        db 22H, 3EH, 0DH, 0AH, 20H, 20H, 20H, 20H       ; 40006118 _ ">..
        db 3CH, 73H, 65H, 63H, 75H, 72H, 69H, 74H       ; 40006120 _ <securit
        db 79H, 3EH, 0DH, 0AH, 20H, 20H, 20H, 20H       ; 40006128 _ y>..
        db 20H, 20H, 3CH, 72H, 65H, 71H, 75H, 65H       ; 40006130 _   <reque
        db 73H, 74H, 65H, 64H, 50H, 72H, 69H, 76H       ; 40006138 _ stedPriv
        db 69H, 6CH, 65H, 67H, 65H, 73H, 3EH, 0DH       ; 40006140 _ ileges>.
        db 0AH, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 40006148 _ .
        db 20H, 3CH, 72H, 65H, 71H, 75H, 65H, 73H       ; 40006150 _  <reques
        db 74H, 65H, 64H, 45H, 78H, 65H, 63H, 75H       ; 40006158 _ tedExecu
        db 74H, 69H, 6FH, 6EH, 4CH, 65H, 76H, 65H       ; 40006160 _ tionLeve
        db 6CH, 20H, 6CH, 65H, 76H, 65H, 6CH, 3DH       ; 40006168 _ l level=
        db 27H, 61H, 73H, 49H, 6EH, 76H, 6FH, 6BH       ; 40006170 _ 'asInvok
        db 65H, 72H, 27H, 20H, 75H, 69H, 41H, 63H       ; 40006178 _ er' uiAc
        db 63H, 65H, 73H, 73H, 3DH, 27H, 66H, 61H       ; 40006180 _ cess='fa
        db 6CH, 73H, 65H, 27H, 20H, 2FH, 3EH, 0DH       ; 40006188 _ lse' />.
        db 0AH, 20H, 20H, 20H, 20H, 20H, 20H, 3CH       ; 40006190 _ .      <
        db 2FH, 72H, 65H, 71H, 75H, 65H, 73H, 74H       ; 40006198 _ /request
        db 65H, 64H, 50H, 72H, 69H, 76H, 69H, 6CH       ; 400061A0 _ edPrivil
        db 65H, 67H, 65H, 73H, 3EH, 0DH, 0AH, 20H       ; 400061A8 _ eges>..
        db 20H, 20H, 20H, 3CH, 2FH, 73H, 65H, 63H       ; 400061B0 _    </sec
        db 75H, 72H, 69H, 74H, 79H, 3EH, 0DH, 0AH       ; 400061B8 _ urity>..
        db 20H, 20H, 3CH, 2FH, 74H, 72H, 75H, 73H       ; 400061C0 _   </trus
        db 74H, 49H, 6EH, 66H, 6FH, 3EH, 0DH, 0AH       ; 400061C8 _ tInfo>..
        db 3CH, 2FH, 61H, 73H, 73H, 65H, 6DH, 62H       ; 400061D0 _ </assemb
        db 6CH, 79H, 3EH, 0DH, 0AH, 00H, 00H, 00H       ; 400061D8 _ ly>.....
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400061E0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400061E8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400061F0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400061F8 _ ........

.rsrc   ENDS

.reloc  SEGMENT BYTE 'CONST'                            ; section number 6

Base_relocation_table label dword
        db 00H, 30H, 00H, 00H, 1CH, 00H, 00H, 00H       ; 40007000 _ .0......
        db 0B8H, 0A1H, 0C0H, 0A1H, 0D0H, 0A1H, 0E8H, 0A1H; 40007008 _ ........
        db 0F0H, 0A1H, 20H, 0A2H, 28H, 0A2H, 98H, 0A3H  ; 40007010 _ .. .(...
        db 0B0H, 0A3H, 0B8H, 0A3H, 00H, 00H, 00H, 00H   ; 40007018 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007020 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007028 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007030 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007038 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007040 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007048 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007050 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007058 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007060 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007068 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007070 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007078 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007080 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007088 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007090 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007098 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070A0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070A8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070B0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070B8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070C0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070C8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070D0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070D8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070E0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070E8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070F0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400070F8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007100 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007108 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007110 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007118 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007120 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007128 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007130 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007138 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007140 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007148 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007150 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007158 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007160 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007168 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007170 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007178 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007180 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007188 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007190 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 40007198 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071A0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071A8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071B0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071B8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071C0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071C8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071D0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071D8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071E0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071E8 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071F0 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 400071F8 _ ........

.reloc  ENDS

; Error: Relocation number 168 at section 2 offset 000001B8 has a non-existing target index. Target: 0
; Error: Relocation number 169 at section 2 offset 000001C0 has a non-existing target index. Target: 0
; Error: Relocation number 170 at section 2 offset 000001D0 has a non-existing target index. Target: 0
; Error: Relocation number 171 at section 2 offset 000001E8 has a non-existing target index. Target: 0
; Error: Relocation number 172 at section 2 offset 000001F0 has a non-existing target index. Target: 0
; Error: Relocation number 173 at section 2 offset 00000220 has a non-existing target index. Target: 0
; Error: Relocation number 174 at section 2 offset 00000228 has a non-existing target index. Target: 0
; Error: Relocation number 175 at section 2 offset 00000398 has a non-existing target index. Target: 0
; Error: Relocation number 176 at section 2 offset 000003B0 has a non-existing target index. Target: 0
; Error: Relocation number 177 at section 2 offset 000003B8 has a non-existing target index. Target: 0

END