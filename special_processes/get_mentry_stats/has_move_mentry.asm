; ------------------------------------------------------------------------------
; Has Move Monster Entry
; Checks if a Chimecho Assembly member has a specified move! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; Param 1: ent_id
; Param 2: move_id
; Returns: 0 if the member does not have the specified move, and the move slot if it does have the move (1-4).
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x20B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area

		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r1
		mov r2,#0x24
		mov r3,#1
@@comparison_loop:
		ldrh r0,[r1,r2]
		cmp r0,r6
		moveq r0,r3
		beq @@ret
		cmp r3,#4
		addne r3,r3,#1
		addne r2,#0x6
		bne @@comparison_loop
		mov r0,#0
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close