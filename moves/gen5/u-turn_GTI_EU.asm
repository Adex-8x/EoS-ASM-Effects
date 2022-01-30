; ------------------------------------------------------------------------------
; U-Turn GTI
; Deals damage, then switches with an ally if one is directly behind them!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; TODO: EU versions supported only (GetTilePointer and SwapEntity US offsets needed)

; For US
;.include "lib/stdlib_us.asm"
;.include "lib/dunlib_us.asm"
;.definelabel MoveStartAddress, 0x02330134
; definelabel MoveJumpAddress, 0x023326CC
;.definelabel GetTilePointer, 0x23360CC ; TODO: Find appropriate offset
;.definelabel SwapEntity, 0x22EB1E8

; For EU
.include "lib/stdlib_eu.asm"
.include "lib/dunlib_eu.asm"
.definelabel MoveStartAddress, 0x02330B74
.definelabel MoveJumpAddress, 0x0233310C
.definelabel GetTilePointer, 0x2336CCC
.definelabel SwapEntity, 0x22EBB28

; File creation
.create "./code_out.bin", 0x02330B74 ; For US: 0x02330134
	.org MoveStartAddress
	.area MaxSize

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		cmp r0,#0
		beq @@ret
		ldr r0,[r9,#+0xb4]
		ldrb r12,[r0,#+0x4c] ; User Direction
		ldrh r0,[r9,#+0x4] ; User X Pos
		ldrh r1,[r9,#+0x6] ; User Y Pos
		; DIRECTIONS: 0 - Down, 1 - DownRight, 2 - Right, 3 - UpRight, 4 - Up, 5 - UpLeft, 6 - Left, 7 - DownLeft
		cmp r12,#0
		subeq r1,r1,#1
		beq @@check_tile
		cmp r12,#1
		subeq r0,r0,#1
		subeq r1,r1,#1
		beq @@check_tile
		cmp r12,#2
		subeq r0,r0,#1
		beq @@check_tile
		cmp r12,#3
		subeq r0,r0,#1
		addeq r1,r1,#1
		beq @@check_tile
		cmp r12,#4
		addeq r1,r1,#1
		beq @@check_tile
		cmp r12,#5
		addeq r0,r0,#1
		addeq r1,r1,#1
		beq @@check_tile
		cmp r12,#6
		addeq r0,r0,#1
		beq @@check_tile
		; Else, 7
		add r0,r0,#1
		sub r1,r1,#1
@@check_tile:
		bl GetTilePointer
		ldr r0,[r0,#+0xc]
		cmp r0,#0
		beq @@ret ; If null, don't switch!
		ldr r12,[r0,#+0xb4]
		ldrb r1,[r12,#0x6]
		ldrb r2,[r12,#0x8]
		cmp r1,#1
		cmpeq r2,#0
		moveq r12,#1
		movne r12,#0
		ldr r1,[r9,#+0xb4]
		ldrb r2,[r1,#0x6]
		ldrb r3,[r1,#0x8]
		cmp r2,#1
		cmpeq r3,#0
		moveq r1,#1
		movne r1,#0
		cmp r12,r1
		bne @@ret
		mov r1,r9
		mov r2,#0
		mov r3,#0
		bl SwapEntity
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close
