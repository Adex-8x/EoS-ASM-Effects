; ------------------------------------------------------------------------------
; Synchronoise
; Deals damage to the target if and only if it shares a type with the user!
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
		ldr r0,[r9,#+0xb4]
		ldrb r1,[r0,#+0x5f]
		ldrb r0,[r0,#+0x5e]
		ldr r2,[r4,#+0xb4]
		ldrb r3,[r2,#+0x5f]
		ldrb r2,[r2,#+0x5e]
		cmp r0,#0
		beq @@second_check
		cmp r0,r2
		cmpne r0,r3
		beq @@success
@@second_check:
		cmp r1,#0
		beq @@failure
		cmp r1,r2
		cmpne r1,r3
		beq @@success
@@failure:
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		mov r1,r4
		ldr r2,=type
		bl SendMessageWithStringCheckUTLog
		mov r0,#0
		b @@ret
@@success:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	type:
		.asciiz "But [string:0] doesn't share[R]a type with [string:1]!"
	.endarea
.close
