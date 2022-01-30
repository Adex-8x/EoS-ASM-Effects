; ------------------------------------------------------------------------------
; Swap Monster Entry Name
; Swaps the first specified Chimecho Assembly member's name with the second! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; If you are using this on current party members, call Irdkwia's "Remove Party" process before this one!
; Param 1: ent_id_1
; Param 2: ent_id_2
; Returns: nothing
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area

		sub r13,r13,#10
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r1
		add r1,r1,#0x3A
		mov r0,r13
		mov r2,#10
		bl StrNCpy
		ldr r1,=AssemblyPointer
		ldr r3,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r3
		add r0,r1,#0x3A
		mla r1,r6,r2,r3
		add r1,r1,#0x3A
		mov r2,#10
		bl StrNCpy
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		mov r2,#0x44
		mla r0,r6,r2,r0
		add r0,r0,#0x3A
		mov r1,r13
		mov r2,#10
		bl StrNCpy
		add r13,r13,#10
		b ProcJumpAddress
		.pool
	.endarea
.close