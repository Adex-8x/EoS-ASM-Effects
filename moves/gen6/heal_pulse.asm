; ------------------------------------------------------------------------------
; Heal Pulse
; Heals a target by 25% of the target's max HP!
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

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,[r4, #+0xb4]
		ldrsh r1,[r0, #+0x12]
		ldrsh r0,[r0, #+0x16]
		add r0,r0,r1 ; Compute the user's Max HP
		mov r1,#4
		bl EuclidianDivision
		mov r2,r0
		mov r0,r9
		mov r1,r4
		mov r3,#0
		bl RaiseHP
		b MoveJumpAddress
		.pool
	.endarea
.close