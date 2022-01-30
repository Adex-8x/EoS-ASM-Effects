; ------------------------------------------------------------------------------
; Final Gambit
; Lowers HP to 1 and the target receives the damage lost!
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

		ldr r0,[r9,#+0xb4]
		ldrsh r0,[r0,#+0x10] ; Target's current HP
		sub r1,r0,#1
		cmp r1,#0
		beq @@failure
		push r1
		mov r0,r9
		mov r2,#0
		mov r3,#0
		str r2,[r13,#+0x0c]
		bl ConstDamage
		pop r1
		mov r0,r4
		mov r2,#0
		mov r3,#0
		str r2,[r13,#+0x0c]
		bl ConstDamage
		b @@ret
@@failure:
		mov r0,#0
		mov r1,r9
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=one_HP
		bl SendMessageWithStringLog
		b @@ret
@@ret:
		b MoveJumpAddress
		.pool
	one_HP:
		.asciiz "But [string:0] couldn't lose[R]any more HP!"
	.endarea
.close