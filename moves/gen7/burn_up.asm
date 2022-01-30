; ------------------------------------------------------------------------------
; Burn Up
; If the user is a Fire type, it deals damage, then gets rid of its Fire-typing!
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
		mov r1,#0x5e
		ldrb r2,[r0,r1]
		cmp r2,#2
		beq @@is_fire
		add r1,r1,#1
		ldrb r2,[r0,r1]
		cmp r2,#2
		beq @@is_fire
		mov r0,r9
		ldr r1,=fail
		bl SendMessageWithStringLog
		b @@ret
@@is_fire:
		push {r0,r1}
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		pop {r0,r1}
		mov r2,#0
		strb r2,[r0,r1]
		mov r2,#1
        	strb r2,[r0,#+0xff]
		mov r0,r9
		ldr r1,=success
		bl SendMessageWithStringLog
@@ret:
		b MoveJumpAddress
		.pool
	success:
		.asciiz "[string:0] is all burnt out!"
	fail:
		.asciiz "But [string:0] was not a[R]Fire type!"
	.endarea
.close