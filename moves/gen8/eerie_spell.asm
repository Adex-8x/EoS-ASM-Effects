; ------------------------------------------------------------------------------
; Eerie Spell
; Deals damage and decreases the PP of the last move the target used by 3!
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

		sub r13,r13,#0x4
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#0
		bl RandomChanceUT
		cmp r0,#0
		beq @@success
		ldr r0,[r4,#+0xb4]
		mov r1,#0x124
@@move_loop:
		ldrb r2,[r0,r1]
		tst r2,#0x10
		bne @@move_found
		cmp r1,#0x13c
		addlt r1,r1,#0x8
		blt @@move_loop
		b @@success
@@move_found:
		add r1,r1,#0x6
		ldrb r2,[r0,r1]
		cmp r0,#0
		beq @@success
		subs r2,r2,#3
		movmi r2,#0
		strb r2,[r0,r1]
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		mov r1,r4
		ldr r2,=lost_PP
		bl SendMessageWithStringCheckUTLog
@@success:
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	lost_PP:
		.asciiz "[string:0] lost 3 PP under[R]the spell's influence!"
	.endarea
.close
