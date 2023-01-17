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

		push r5,r6
		sub r13,r13,#0x4
		ldr r5,[r4,#+0xb4]
		mov r6,#0x5e
		ldrb r10,[r5,r6]
		cmp r10,#3
		beq @@is_water
		add r6,r6,#1
		ldrb r10,[r5,r6]
		cmp r10,#3
		bne @@deal_damage
@@is_water:
		mov r0,#4
		strb r0,[r5,r6]
		mov r0,#1
		strb r0,[r5,#+0xff]
@@deal_damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		cmp r10,#3
		streqb r10,[r5,r6]
		mov r10,r0	
		add r13,r13,#0x4
		pop r5,r6
		b MoveJumpAddress
		.pool
	.endarea
.close