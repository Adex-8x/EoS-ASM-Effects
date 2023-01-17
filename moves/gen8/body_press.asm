; ------------------------------------------------------------------------------
; Body Press
; Deals damage, but calculates damage based on the user's Defense stat instead of Attack!
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

		push r5,r6,r11
		sub r13,r13,#0x4
		ldr r0, [r9, #+0xb4]
		ldrb r5, [r0, #+0x1a]
		ldrh r6, [r0, #+0x24]
		ldr r11, [r0, #+0x34]
		ldrb r2, [r0, #+0x1c]
		strb r2, [r0, #+0x1a]
		ldrsh r2, [r0, #+0x28]
		strh r2, [r0, #+0x24]
		ldr r2, [r0, #+0x3c]
		str r2, [r0, #+0x34]
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		ldr r0, [r9, #+0xb4]
		strb r5, [r0, #+0x1a]
		strh r6, [r0, #+0x24]
		str r11, [r0, #+0x34]
		add r13,r13,#0x4
		pop r5,r6,r11
		b MoveJumpAddress
		.pool
	.endarea
.close