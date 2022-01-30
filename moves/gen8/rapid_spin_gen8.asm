; ------------------------------------------------------------------------------
; Rapid Spin Gen 8
; Slightly edits the existing move effect to give it something close to its Gen 8 counterpart: Raising the user's speed by one stage if damage is dealt!
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
.definelabel RapidSpin, 0x2327940

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel RapidSpin, 0x23283a8

.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,r7
		bl RapidSpin
		mov r10,r0
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r9
		mov r2,#0
		mov r3,#0
		bl SpeedStatUpOneStage
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close