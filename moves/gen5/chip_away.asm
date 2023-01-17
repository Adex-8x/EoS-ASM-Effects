; ------------------------------------------------------------------------------
; Chip Away
; Deals damage to the target, ignoring their Defense and Evasion stat boosts!
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
		ldrsh r1,[r0,#+0x28]
		ldrsh r2,[r0,#+0x2e]
		ldr r3,[r0,#+0x3c]
		push r0-r3
		sub r13,r13,#0x4
		mov r1,#10
		strh r1,[r0,#+0x28]
		strh r1,[r0,#+0x2e]
		mov r1,#0x100
		str r1,[r0,#+0x3c]
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		add r13,r13,#0x4
		pop r0-r3
		strh r1,[r0,#+0x28]
		strh r2,[r0,#+0x2e]
		str r3,[r0,#+0x3c]
		b MoveJumpAddress
		.pool
	.endarea
.close
