; ------------------------------------------------------------------------------
; U-Turn GTI
; Deals damage, then switches with an ally if one is directly behind them!
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
.definelabel SwapEntity, 0x022EB178
.definelabel GetTilePointer, 0x023360FC
.definelabel DIRECTIONS_XY, 0x0235171C

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel GetTilePointer, 0x02336CCC
;.definelabel SwapEntity, 0x022EBB28
;.definelabel DIRECTIONS_XY, 0x02352328

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		sub r13,r13,#0x4
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,#0
		bl RandomChanceU
		cmp r0,#0
		moveq r0,#1
		beq @@ret
		ldr r2,=DIRECTIONS_XY
		add r3,r2,#2
		ldr r0,[r9,#+0xb4]
		ldrb r0,[r0,#+0x4C]
		subs r0,r0,#4
		addmi r0,r0,#8
		lsl r0,r0,#2
		ldrsh r1,[r3,r0]
		ldrsh r0,[r2,r0]
		ldrh r2,[r9,#+0x4]
		ldrh r3,[r9,#+0x6]
		add r0,r0,r2
		add r1,r1,r3
@@check_tile:
		bl GetTilePointer
		ldr r0,[r0,#+0xC]
		cmp r0,#0
		moveq r0,#1
		beq @@ret
		ldr r12,[r0,#+0xb4]
		ldrb r1,[r12,#0x6]
		ldrb r2,[r12,#0x8]
		eor r12,r1,r2
		ldr r1,[r9,#+0xb4]
		ldrb r2,[r1,#0x6]
		ldrb r3,[r1,#0x8]
		eor r1,r2,r3
		cmp r12,r1
		movne r0,#1
		bne @@ret
		mov r1,r9
		bl SwapEntity
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	.endarea
.close
