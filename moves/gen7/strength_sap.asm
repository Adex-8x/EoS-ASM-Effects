; ------------------------------------------------------------------------------
; Strength Sap
; Lowers the target's Attack stat, then gains HP equal to the target's Attack stat before the move!
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
.definelabel MultiplyByFixedPoint, 0x02001A54
.definelabel OFFENSIVE_STAT_STAGE_MULTIPLIERS, 0x22C4D98

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel MultiplyByFixedPoint, 0x02001A54
;.definelabel OFFENSIVE_STAT_STAGE_MULTIPLIERS, 0x22C56F0

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		push r5,r6
		sub r13,r13,#0x8
		ldr r0,[r4,#+0xb4]
		ldrb r6,[r0,#+0x1a]
		ldrsh r5,[r0,#+0x24]
		cmp r5,#0
		ble @@too_weak
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		str r3,[r13]
		str r3,[r13,#+0x4]
		bl AttackStatDown
		mov r0,r6
		ldr r1,=OFFENSIVE_STAT_STAGE_MULTIPLIERS
		ldr r1,[r1,r5,lsl #+0x2]
 		bl MultiplyByFixedPoint
		ldr r1,[r4,#+0xb4]
		ldr r1,[r1,#+0x34]
		bl MultiplyByFixedPoint
		movs r2,r0
		moveq r2,#1
		mov r0,r9
		mov r1,r9
		mov r3,#1
		str r3,[r13]
		mov r3,#0
		bl RaiseHP
		mov r0,#1
		b @@ret
@@too_weak:
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=fail
		bl SendMessageWithStringCheckULog
		mov r0,#0
@@ret:
		mov r10,r0
		add r13,r13,#0x8
		pop r5,r6
		b MoveJumpAddress
		.pool
	fail:
		.asciiz "But [string:0] has no more[R]strength left to sap..."
	.endarea
.close
