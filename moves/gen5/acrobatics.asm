; ------------------------------------------------------------------------------
; Acrobatics
; If the user is not holding an item, deal twice the damage!
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
		ldrh r0,[r0,#+0x66]
		cmp r0,#0
		movne r3,#0x100
		bne @@deal_damage
		mov r0,r9
		ldr r1,=no_item
		bl SendMessageWithStringLog
		mov r3,#0x200
@@deal_damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		bl DealDamage
		b MoveJumpAddress
		.pool
	no_item:
		.asciiz "Carrying no item boosts the power!"
	.endarea
.close