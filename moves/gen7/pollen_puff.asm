; ------------------------------------------------------------------------------
; Pollen Puff
; If targeting an enemy, the move will deal damage! If targeting an ally, it will restore up to 50% of the target's maximum HP!
; NOTE: This move is meant to target everyone!
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
		ldrb r1,[r0,#0x6]
		ldrb r2,[r0,#0x8]
		cmp r1,#1
		cmpeq r2,#0
		moveq r0,#1
		movne r0,#0
		ldr r1,[r9,#+0xb4]
		ldrb r2,[r1,#0x6]
		ldrb r3,[r1,#0x8]
		cmp r2,#1
		cmpeq r3,#0
		moveq r1,#1
		movne r1,#0
		cmp r0,r1
		beq @@ally_target
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		b @@ret
@@ally_target:
		ldr r0,[r4,#+0xb4]
		ldrsh r1,[r0, #+0x12]
		ldrsh r0,[r0, #+0x16]
		add r0,r0,r1 ; Compute the user's Max HP
		mov r1,#2
		bl EuclidianDivision
		mov r2,r0
		mov r0,r9
		mov r1,r4
		mov r3,#0
		bl RaiseHP
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close