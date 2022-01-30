; ------------------------------------------------------------------------------
; Speed Swap
; Swaps the speed of the user and target!
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

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		; This code is the least elegant thing I've ever written, I'm sorry
		ldr r0,[r9,#+0xb4]
		ldr r2,[r4,#+0xb4]
		mov r12,#0x110
@@word_loop:
		ldr r1,[r0,r12]
		ldr r3,[r2,r12]
		str r1,[r2,r12]
		str r3,[r0,r12]
		cmp r12,#0x11c
		addlt r12,r12,#0x4
		blt @@word_loop
		ldrh r1,[r0,r12]
		ldrh r3,[r2,r12]
		strh r1,[r2,r12]
		strh r3,[r0,r12]
		mov r0,#0
		mov r1,r9
		mov r2,#0
		bl ChangeString
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=gotta_go_fast
		bl SendMessageWithStringLog
		b MoveJumpAddress
		.pool
	gotta_go_fast:
		.asciiz "[string:0] swapped its Speed[R]with [string:1]!"
	.endarea
.close