; ------------------------------------------------------------------------------
; Acrobatics
; If the user is not holding an item, deal 1.5x the damage!
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
		mov r3,#0x100
		ldr r0,[r9,#+0xB4]
		ldrh r1,[r0,#+0x66]
		ldrh r2,[r0,#+0x62]
		cmp r1,#0
		tstne r2,#0x1
		bne @@deal_damage
		mov r0,r9
		ldr r1,=no_item
		bl SendMessageWithStringCheckULog
		mov r3,#0x180
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
	no_item:
		.asciiz "Carrying no item boosts the power!"
	.endarea
.close