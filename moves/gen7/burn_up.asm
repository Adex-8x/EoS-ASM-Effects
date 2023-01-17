; ------------------------------------------------------------------------------
; Burn Up
; If the user is a Fire type, it deals damage, then gets rid of its Fire type!
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
.definelabel TryThawTarget, 0x02307C78

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel TryThawTarget, 0x023086A4

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		push r5,r6
		sub r13,r13,#0x4
		ldr r5,[r9,#+0xb4]
		mov r6,#0x5e
		ldrb r2,[r5,r6]
		cmp r2,#2
		beq @@is_fire
		add r6,r6,#1
		ldrb r2,[r5,r6]
		cmp r2,#2
		beq @@is_fire
		mov r0,r9
		ldr r1,=fail
		bl SendMessageWithStringCheckULog
		mov r0,#0
		b @@ret
@@is_fire:
		; The following effect will thaw the target, because this is intended for a Fire-type move. HOWEVER, if you do not want for this to happen, please comment this out with ";"!
		mov r0,r9
		mov r1,r4
		bl TryThawTarget

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r1,#0
		strb r1,[r5,r6]
		mov r1,#1
        	strb r1,[r5,#+0xff]
		mov r0,r9
		ldr r1,=success
		bl SendMessageWithStringCheckULog
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		pop r5,r6
		b MoveJumpAddress
		.pool
	success:
		.asciiz "[string:0] is all burnt out!"
	fail:
		.asciiz "But [string:0] is not a Fire type!"
	.endarea
.close