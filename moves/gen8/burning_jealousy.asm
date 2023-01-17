; ------------------------------------------------------------------------------
; Burning Jealousy
; Deals damage and burns the target if they have any kind of stat gain (not including Speed)!
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
		mov r3,#0x24
@@boost_loop:
		ldrsh r1,[r0,r3]
		cmp r1,#0xa
		bgt @@has_stat_gain
		cmp r3,#0x2E
		addlt r3,r3,#0x2
		blt @@boost_loop
		mov r3,#0x34
@@multiplier_loop:
		ldr r1,[r0,r3]
		cmp r1,#0x100
		bgt @@has_stat_gain
		cmp r3,#0x40
		addlt r3,r3,#0x4
		blt @@multiplier_loop
		b @@success
@@has_stat_gain:
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		str r2,[r13]
		bl Burn
@@success:
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close