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
.definelabel RNG, 0x22EAA98
.definelabel SwapEntity, 0x232C538

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel RNG, 0x22EB448
;.definelabel SwapEntity, 0x22EBB28

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize
		
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r2,#0
		bl SwapEntity
		mov r0,#5
		bl RNG
		mov r12,r0
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		cmp r0,#0
		bleq AttackStatUp
		beq @@ret
		cmp r12,#1
		moveq r2,#1
		bleq AttackStatUp
		beq @@ret
		cmp r12,#2
		bleq DefenseStatUp
		beq @@ret
		cmp r12,#3
		moveq r2,#1
		bleq DefenseStatUp
		beq @@ret
		cmp r12,#4
		movne r2,#1
		bl FocusStatUp
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close