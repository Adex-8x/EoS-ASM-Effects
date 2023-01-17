; ------------------------------------------------------------------------------
; Spectral Thief
; Copies all of the target's positive stat changes, then deals damage!
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

		sub r13,r13,#0x4
		ldr r0,[r4,#+0xb4]
		ldr r2,[r9,#+0xb4]
		mov r3,#0x24
		mov r12,#0xa
		mov r10,#0
@@boost_loop:
		ldrh r1,[r0,r3]
		cmp r1,r12
		ble @@next_boost_iter
		ldrh r10,[r2,r3]
		add r10,r10,r1
		cmp r10,#0x14
		movgt r10,#0x14
		strh r10,[r2,r3]
		strh r12,[r0,r3]
@@next_boost_iter:
		cmp r3,#0x2e
		addlt r3,r3,#0x2
		blt @@boost_loop
		mov r3,#0x34
		mov r12,#0x100
@@multiplier_loop:
		ldr r1,[r0,r3]
		cmp r1,r12
		ble @@next_multiplier_iter
		ldr r10,[r2,r3]
		add r10,r10,r1
		ldr r1,=#25597
		cmp r10,r1
		movgt r10,r1
		str r10,[r2,r3]
		str r12,[r0,r3]
@@next_multiplier_iter:
		cmp r3,#0x40
		addlt r3,r3,#0x4
		blt @@multiplier_loop
		cmp r10,#0
		beq @@deal_damage
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=grand_larceny
		bl SendMessageWithStringCheckULog
@@deal_damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		mov r0,r9
		bl UpdateStatusIconFlags
		mov r0,r4
		bl UpdateStatusIconFlags
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	grand_larceny:
		.asciiz "[string:0] robbed [string:1][R]of all of its stat gains!"
	.endarea
.close