; ------------------------------------------------------------------------------
; Foul Play
; Deals damage based on the target's Attack stat and stat buffs, rather than the user's!
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
.create "./code_out.bin", 0x02330134
	.org MoveStartAddress
	.area MaxSize
		
		ldr r0,[r9,#+0xb4]
		ldr r1,[r4,#+0xb4]
		ldrb r2,[r0,#+0x1a]
		ldrsh r3,[r0,#+0x24]
		ldr r12,[r0,#+0x34]
		push {r2,r3,r12}
		sub r13,r13,#0x4
		ldrb r2,[r1,#+0x1a]
		strb r2,[r0,#+0x1a]
		ldrsh r2,[r1,#+0x24]
		strh r2,[r0,#+0x24]
		ldr r2,[r1,#+0x34]
		str r2,[r0,#+0x34]
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		add r13,r13,#0x4
		pop {r2,r3,r12}
		ldr r0,[r9,#+0xb4]
		strb r2,[r0,#+0x1a]
		strh r3,[r0,#+0x24]
		str r12,[r0,#+0x34]
		b MoveJumpAddress
		.pool
	.endarea
.close
