; ------------------------------------------------------------------------------
; Parabolic Charge
; Deals damage, but the user recovers 1/2 of the damage dealt!
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
		lsrs r10,r0,#1
		moveq r10,#1
		mov r0,r9
		mov r1,#0
		bl RandomChanceU
		cmp r0,#0
		beq @@success
		mov r2,r10
		ldr r0,[r9,#+0xb4]
		ldrb r1,[r0,#+0x108]
		cmp r1,#1
		movcc r1,#1
		strb r1,[r0,#+0x108]
		mov r0,r9
		mov r1,r9
		mov r3,#1
		str r3,[r13]
		mov r3,#0
		bl RaiseHP
@@success:
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close