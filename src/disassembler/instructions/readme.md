# Opcodes

Note: Some information reproduced from the AMD64 Architecture Programmer's Manual Volume 3 (General Purpose and System Instructions) Revision 3.27 - July 2019

Reproduced from the
AMD64 Architecture
Programmer's Manual
Volume 3:
General-Purpose and System
Instructions
rev. 3.09 September 2003

## Opcode Maps

- Page 494 - Table A-1 One byte opcodes
- Page 498 - Table A-3 Two byte opcodes

## ModRM Information

- Page 55
- Page 534

## Opcode and Operand Encodings (Pages 491 - 494)

 | Note | Description
 |------|-------------
 | A    | A far pointer encoded in the instruction. No ModRM byte in the instruction encoding
 | B    | General-purpose register specified by the VEX or XOP vvvv field.
 | C    | Control register specified by the ModRM reg field.
 | D    | Debug register specified by the ModRM reg field.
 | E    | General purpose register or memory operand specified by the r/m field of the ModRM byte. For memory operands, the ModRM byte may be followed by a SIB byte to specify one of the indexed register-indirect addressing forms
 | F    | rFLAGS register.
 | G    | General purpose register specified by the ModRM reg field.
 | H    | YMM or XMM register specified by the VEX/XOP.vvvv field
 | I 	| Immediate value.
 | J    | The instruction includes a relative offset that is added to the rIP.
 | L    | YMM or XMM register specified using the most-significant 4 bits of an 8-bit immediate value.
 |      | In legacy or compatibility mode the most significant bit is ignored.
 | M 	| A memory operand specified by the ModRM byte. ModRM.mod ≠ 11b
 | M*   | A sparse array of memory operands addressed using the VSIB addressing mode
 | N    | 64-bit MMX register specified by the ModRM.r/m field. The ModRM.mod field must be 11b
 | O 	| The offset of an operand is encoded in the instruction. There is no ModRM byte in the instruction encoding. Indexed register-indirect addressing using the SIB byte is not supported
 | P 	| 64-bit MMX register specified by the ModRM reg field.
 | Q 	| 64-bit MMX-register or memory operand specified by the {mod, r/m} field of the ModRM byte. For memory operands, the ModRM byte may be followed by a SIB byte to specify one of the indexed - register-indirect addressing forms
 | R 	| General purpose register specified by the ModRM r/m field. The ModRM mod field must be 11b.
 | S 	| Segment register specified by the ModRM reg field.
 | U    | YMM/XMM register specified by the ModRM.r/m field. The ModRM.mod field must be 11b
 | V 	| YMM/XMM register specified by the ModRM.reg field The ModRM mod field must be 11b.
 | W 	| YMM/XMM register or memory operand specified by the {mod, r/m} field of the ModRM byte. For memory operands, the ModRM byte may be followed by a SIB byte to specify one of the indexed - register-indirect addressing forms
 | X 	| A memory operand addressed by the DS.rSI registers. Used in string instructions.
 | Y 	| A memory operand addressed by the ES.rDI registers. Used in string instructions.
 | a 	| Two 16-bit or 32-bit memory operands, depending on the effective operand size. Used in the BOUND instruction.
 | b 	| A byte, irrespective of the effective operand size.
 | d 	| A doubleword (32 bits), irrespective of the effective operand size.
 | do 	| A double-octword (256 bits), irrespective of the effective operand size.
 | i    | A 16 bit int
 | j    | A 32 bit int
 | m    | A bit mask of size equal to the source operand
 | mn   | Where n = 2,4,8, or 16. A bit mask of size n.
 | o    | An octword (128 bits), irrespective of the effective operand size
 | o.q  | Operand is either the upper or lower half of a 128-bit value
 | p 	| A 32-bit or 48-bit far pointer, depending on the effective operand size.
 | pb   | Vector with byte-wide (8-bit) elements (packed byte).
 | pd 	| A double-precision (64-bit) floating-point vector operand (packed double-precision)
 | pdw  | Vector composed of 32-bit doublewords
 | ph   | A half-precision (16-bit) floating-point vector operand (packed half-precision)
 | pi 	| Vector composed of 16-bit integers (packed integer).
 | pj   | Vector composed of 32-bit integers (packed double integer).
 | pk   | Vector composed of 8-bit integers (packed half-word integer).
 | pq   | Vector composed of 64-bit integers (packed quadword integer).
 | pqw  | Vector composed of 64-bit quadwords (packed quadword).
 | ps 	| A single-precision floating-point vector operand (packed single-precision).
 | pw   | Vector composed of 16-bit words (packed word).
 | q 	| A quadword (64 bits), irrespective of the effective operand size.
 | sd   | A scalar element of a 128 bit double precision floating data
 | ss	| A scalar single-precision floating-point operand (scalar single).
 | v	| A word, doubleword, or quadword, depending on the effective operand size.
 | w	| A word, irrespective of the effective operand size.
 | x    | Instruction supports both vector sizes (128 bits or 256 bits). Size is encoded using the VEX/XOP.L field. (L=0: 128 bits; L=1: 256 bits). This symbol may be appended to ps or pd to represent a packed single- or double-precision floating-point vector of either size; or to pk, pi, pj, or pq, to represent a packed 8-bit, 16-bit, 32-bit, or 64-bit packed integer vector of either size
 | y    | A doubleword or quadword depending on effective operand size
 | z	| A word if the effective operand size is 16 bits, or a doubleword if the effective operand size is 32 or 64 bits.

For some instructions, fields in the ModRM or SIB byte are used as encoding extensions.
This is indicated using the following notation:

/n A ModRM-byte reg field or SIB-byte base field, where n is a value between zero (000b) and 7 (111b).

## Online Opcode Tables

- http://ref.x86asm.net/coder64.html

## Instructions that default to 64 bit operand size and don't require a VEX prefix

Volume 1 - Page 109

- Jcc
- JMP
- LOOP / LOOPcc
- ENTER/LEAVE
- POP reg/mem/FS/GS
- POPF/POPFD,POPFQ
- PUSH imm32
- PUSH imm8
- PUSH reg/mem/FS/GS
- PUSHF/PUSHFD/PUSHFQ
- RET (near)
- MOV CRn/DRn
- LLDT/LIDT/LGDT/LTR

A REX prefix is still required if register R8 - R15 is used.