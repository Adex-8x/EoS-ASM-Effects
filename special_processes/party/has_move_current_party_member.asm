; ------------------------------------------------------------------------------
; Has Move Current Party Member
; Checks if a member (0-3) of the current team has a given move!
; Param 1: member_id
; Param 2: move_id
; Returns: (The slot in which the move is found) + 1, or 0 if not found.
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
.definelabel AssemblyPointer, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		
		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#3
		bgt @@ret
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		add r0,r0,#0x9800
		add r0,r0,#0x4c
		ldr r0,[r0]
		mov r1,#0x68
		mla r0,r7,r1,r0
		add r0,r0,#0x20
		mov r1,#1
@@move_loop:
		ldrh r2,[r0],#0x8
		cmp r2,r6
		moveq r0,r1
		beq @@ret
		cmp r1,#4
		addlt r1,r1,#1
		blt @@move_loop
		mov r0,#0
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close