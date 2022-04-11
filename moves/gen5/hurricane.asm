; ------------------------------------------------------------------------------
; Hurricane
; Deals damage and has a 30% chance to confuse the target!
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

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#30
		bl RandomChanceUT
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#1
		mov r3,#0
		bl Confuse
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close