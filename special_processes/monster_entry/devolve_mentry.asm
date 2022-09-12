; ------------------------------------------------------------------------------
; Devolve Mentry
; Devolves a Chimecho Assembly member! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; Param 1: ent_id
; Returns: 0 if a de-evolution could not be performed, 1 if successful!
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
.definelabel GetPreEvoIndex, 0x020529A8
.definelabel IsNamedAfterSpecies, 0x02056070
.definelabel GetNameString, 0x020526C8

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C
;.definelabel GetPreEvoIndex, 0x02052CE0
;.definelabel IsNamedAfterSpecies, 0x020563EC
;.definelabel GetNameString, 0x02052A00

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		push r4,r5
		ldr r4,=AssemblyPointer
		ldr r4,[r4]
		mov r1,#0x44
		mla r4,r7,r1,r4
		mov r0,r4
		bl IsNamedAfterSpecies
		mov r5,r0 ; It's a surprise tool that'll help us for later!
		ldrh r0,[r4,#+0x4]
		mov r1,r13
		mov r2,#0
		mov r3,r2
		bl GetPreEvoIndex
		cmp r0,#0
		beq @@ret
		strh r0,[r4,#+0x4]
		ldrh r0,[r4,#+0xA]
		subs r0,r0,#5
		movmi r0,#1
		strh r0,[r4,#+0xA]
		add r0,r4,#0xC
		mov r1,#0
@@stat_nerf_loop:
		ldrb r2,[r0,r1]
		subs r2,r2,#5
		movmi r2,#1
		strb r2,[r0,r1]
		cmp r1,#3
		addlt r1,r1,#1
		blt @@stat_nerf_loop
		cmp r5,#0
		moveq r0,#1
		beq @@ret	
		ldrh r0,[r4,#+0x4]
		bl GetNameString
		mov r1,r0
		add r0,r4,#0x3A
		mov r2,#10
		bl StrNCpy
		mov r0,#1
@@ret:
		pop r4,r5
		b ProcJumpAddress
		.pool
	.endarea
.close