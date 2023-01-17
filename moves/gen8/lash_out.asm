; ------------------------------------------------------------------------------
; Lash Out
; If any of the user's stats are lowered, this move deals twice the damage!
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
		mov r2,#0x24
		mov r3,#0x100
@@boost_loop:
		ldrh r1,[r0,r2]
		cmp r1,#0xa
		movlt r3,#0x200
		blt @@deal_damage
		cmp r2,#0x2e
		addlt r2,r2,#0x2
		blt @@boost_loop
		mov r2,#0x34
@@multiplier_loop:
		ldr r1,[r0,r2]
		cmp r1,#0x100
		movlt r3,#0x200
		blt @@deal_damage
		cmp r2,#0x40
		addlt r2,r2,#0x4
		blt @@multiplier_loop
@@deal_damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		str r7,[r13]
		bl DealDamage	
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close