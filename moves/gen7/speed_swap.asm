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
.definelabel UpdateStatusIconFlags, 0x022E3AB4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel UpdateStatusIconFlags, 0x022E4464

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		push r0-r7
		ldr r6,[r9,0B4h]
		ldr r7,[r4,0B4h]
		add r6,r6,110h
		add r7,r7,110h
		ldmia [r6],r0-r2
		ldmia [r7],r3-r5
		stmia [r7]!,r0-r2
		stmia [r6]!,r3-r5
		ldrh r0,[r6]
		ldrh r1,[r7]
		strh r0,[r7]
		strh r1,[r6]
		pop r0-r7
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		mov r1,r4
		ldr r2,=gotta_go_fast
		bl SendMessageWithStringCheckUTLog
		mov r0,r9
		bl UpdateStatusIconFlags
		mov r0,r4
		bl UpdateStatusIconFlags
		mov r10,#1
		b MoveJumpAddress
		.pool
	gotta_go_fast:
		.asciiz "[string:0] swapped its Speed[R]with [string:1]!"
	.endarea
.close