; ------------------------------------------------------------------------------
; Has Species in Party
; Checks if a given Pokémon species is in the specified team (0 is Maingame, 1 is Special Episode, 2 is Rescue, and -1 is the current team)!
; Param 1: team_id
; Param 2: species_id
; Returns: (The slot in which the species is found) + 1, or 0 if not found.
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
		cmp r7,#2
		bgt @@ret
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		cmp r7,#0
		addlt r0,r0,#0x9800
		addlt r0,r0,#0x4c
		ldrlt r0,[r0]
		addge r0,r0,#0x9300
    		addge r0,r0,#0x6C
		movge r1,#0x1A0
    		mlage r0,r7,r1,r0
		mov r1,#0x1
@@member_loop:
		ldrb r2,[r0]
		tst r2,#0x1
		beq @@member_loop_next_iter
		ldrsh r2,[r0,#+0xC]
		cmp r2,r6
		moveq r0,r1
		beq @@ret
@@member_loop_next_iter:
		cmp r1,#4
		addlt r1,r1,#1
		addlt r0,r0,#0x68
		blt @@member_loop
		mov r0,#0
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close
