; ------------------------------------------------------------------------------
; Dragon Tail
; Deals damage to the target, then blows it away in the user's direction!
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
.definelabel BlowAway, 0x0231FDE0

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel BlowAway, 0x02320848

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
		mov r0,r9
		mov r1,r4
		ldr r2,[r9,#+0xb4]
		ldrb r2,[r2,#+0x4c]
		bl BlowAway
@@success:
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close
