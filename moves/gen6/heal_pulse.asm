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

		sub r13,r13,#0x4
		ldr r0,[r4,#+0xb4]
		ldrsh r1,[r0,#+0x12]
		ldrsh r2,[r0,#+0x16]
		add r2,r2,r1
		lsrs r2,r2,#2
		addeq r2,r2,#1
		mov r0,r9
		mov r1,r4
		mov r3,#1
		str r3,[r13]
		mov r3,#0
		bl RaiseHP
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close