; ------------------------------------------------------------------------------
; After You
; Switches positions with the target (ally) and boosts a random stat by one stage!
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
.definelabel DungeonRandInt, 0x22EAA98
.definelabel SwapEntity, 0x0232C538
.definelabel GetTileAtEntity, 0x022E1628

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DungeonRandInt, 0x22EB448
;.definelabel SwapEntity, 0x022EBB28
;.definelabel GetTileAtEntity, 0x022E1F68

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize
		
		mov r0,r9
		bl GetTileAtEntity
		mov r10,r0
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r2,#0
		bl SwapEntity ; This or TrySwitchPlace don't return success/fail, so we have to check if the swap actually occured!
		mov r0,r9
		bl GetTileAtEntity
		cmp r0,r10
		moveq r10,#0
		beq MoveJumpAddress
		mov r0,#6
		bl DungeonRandInt
		tst r0,#1
		moveq r2,#0
		movne r2,#1
		lsr r0,r0,#0x1
		ldr r12,=boost_funcs
		ldr r12,[r12,r0,lsl #0x2]
		mov r0,r9
		mov r1,r4
		mov r3,#1
		blx r12
		mov r10,#1
		b MoveJumpAddress
		.pool
	boost_funcs:
		.word AttackStatUp, DefenseStatUp, FocusStatUp
	.endarea
.close