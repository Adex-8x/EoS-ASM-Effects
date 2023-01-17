; ------------------------------------------------------------------------------
; No Retreat
; Raises all of the target's stats by one, but immobilizes it!
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
		ldrb r0,[r0,#+0xc4]
		cmp r0,#2
		bne @@success
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=failure
		bl SendMessageWithStringCheckULog
		mov r10,#0
		b MoveJumpAddress
@@success:
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
		mov r10,#1
		b MoveJumpAddress
		.pool
	failure:
		.asciiz "But [string:0] is already immobile!"
	.endarea
.close
