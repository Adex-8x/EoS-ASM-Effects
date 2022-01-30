; ------------------------------------------------------------------------------
; Knock Off GTI
; Deals damage and knocks off the target's held item! If an item was knocked off, increase damage!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel KnockOff, 0x232A6EC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.deifnelabel KnockOff, 0x232B158

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,[r4,#+0xb4]
		ldrh r0,[r0,#+0x66]
		cmp r0,#0
		movne r3,#0x180
		moveq r3,#0x100
		mov r0,r9
		mov r1,r4
		mov r2,r8		
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#0
		bl KnockOff
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close