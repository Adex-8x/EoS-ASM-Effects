; ------------------------------------------------------------------------------
; Instruct
; The target uses the last move it previously used!
; The target will perform Struggle if:
; - This move was the last move used
; - No move was used previously
; - The last used move is out of PP
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel SetMonsterActionFields, 0x022EB408
.definelabel ExecuteMonsterAction, 0x022FE4BC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel SetMonsterActionFields, 0x022EBDB8
;.definelabel ExecuteMonsterAction, 0x022FEEDC

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,[r4,#+0xb4]
		mov r1,#0x124
		mov r10,#0
@@move_loop:
		ldrb r2,[r0,r1]
		tst r2,#0x10
		bne @@move_found
		cmp r1,#0x13C
		addlt r1,r1,#0x8
		addlt r10,r10,#1
		blt @@move_loop
		b @@use_struggle
@@move_found:
		add r1,r1,#0x4
		ldrh r2,[r0,r1]
		ldrh r12,[r8,#+0x4]
		cmp r2,r12
		beq @@use_struggle
		add r1,r1,#0x2
		ldrb r2,[r0,r1]
		cmp r2,#0
		beq @@use_struggle
		ldrb r1,[r0,#+0x7]
		cmp r1,#1
		moveq r1,#0x14
		movne r1,#0x15
		b @@perform_move
@@use_struggle:
		mov r1,#0x17
@@perform_move:
		add r0,r0,#0x4A
		bl SetMonsterActionFields
		ldr r0,[r4,#+0xb4]
		strb r10,[r0,#+0x54]
		strb r10,[r0,#+0x4E]
		mov r0,r4
		bl ExecuteMonsterAction
		mov r10,#1	
		b MoveJumpAddress
		.pool
	.endarea
.close