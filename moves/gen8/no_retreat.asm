; ------------------------------------------------------------------------------
; No Retreat
; Raises all of the user's stats by one, but immobilizes it!
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

		; This won't be elegant and I don't care haha
		; AttackStatDown(r0: User, r1: Target, r2: StatType, r3: NbStages, [r13]: ???, [r13+0x4]: ???)
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		bl AttackStatUp
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		bl DefenseStatUp
		mov r0,r9
		mov r1,r4
		mov r2,#1
		mov r3,#1
		bl AttackStatUp
		mov r0,r9
		mov r1,r4
		mov r2,#1
		mov r3,#1
		bl DefenseStatUp
		mov r0,r9
		mov r1,r4
		mov r2,#4
		mov r3,#1
		bl SpeedStatUpOneStage
		mov r0,r9
		mov r1,r4
		mov r2,#0
		bl Immobilize
		b MoveJumpAddress
		.pool
	.endarea
.close