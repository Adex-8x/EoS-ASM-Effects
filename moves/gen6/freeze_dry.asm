; ------------------------------------------------------------------------------
; Freeze-Dry
; Deals damage to the target! If the target is a Water-type, this move treats Ice as being super effective toward it!
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

		ldr r0,[r4,#+0xb4]
		mov r1,#0x5e
		ldrb r2,[r0,r1]
		cmp r2,#3
		beq @@is_water
		add r1,r1,#1
		ldrb r2,[r0,r1]
		cmp r2,#3
		beq @@is_water
		b @@deal_damage
@@is_water:
		push {r0,r1,r2}
		mov r2,#4
		strb r2,[r0,r1]
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		pop {r0,r1,r2}
		strb r2,[r0,r1]
		b @@ret
@@deal_damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close