; ------------------------------------------------------------------------------
; Psyshock
; Deal damage to the target, but calculate damage based on its Defense instead of its Special Defense!
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
		ldrb r1,[r0,#+0x1d]
		ldrsh r2,[r0,#+0x2a]
		ldr r3,[r0,#+0x40]
		push {r0,r1,r2,r3}
		sub r13,r13,#0x4
		ldrb r1,[r0,#+0x1c]
		strb r1,[r0,#+0x1d]
		ldrsh r1,[r0,#+0x28]
		strh r1,[r0,#+0x2a]
		ldr r1,[r0,#+0x3c]
		str r1,[r0,#+0x40]
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		add r13,r13,#0x4
		pop {r0,r1,r2,r3}
		strb r1,[r0,#+0x1d]
		strh r2,[r0,#+0x2a]
		str r3,[r0,#+0x40]
		b MoveJumpAddress
		.pool
	.endarea
.close