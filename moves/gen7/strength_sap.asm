; ------------------------------------------------------------------------------
; Strength Sap
; Lowers the target's Attack stat, then gains HP equal to the target's Attack stat before the move!
; NOTE: This move has not been thoroughly tested! Please inform Adex of any oddities or if you notice any glaring issues with how the HP is raised!
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
		ldrb r1,[r0,#+0x1a] ; Actual Attack Stat
		ldrsh r0,[r0,#+0x24] ; Attack Stage (0-20)
		cmp r0,#0
		ble @@too_weak
		push {r0,r1}
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#1
		bl AttackStatDown
		pop {r0,r1}
		sub r0,r0,#1
		ldr r2,=stat_changes
		ldrb r2,[r2,r0]
		mul r0,r1,r2
		mov r1,#100 
 		bl EuclidianDivision
		ldr r1,[r4,#+0xb4]
		ldr r1,[r1,#+0x34]
		mul r0,r0,r1
		movs r2,r0,lsr #8
		moveq r2,#1 ; Always heal at least 1 HP!
		mov r0,r9
		mov r1,r9
		mov r3,#0
		bl RaiseHP
		b @@ret
@@too_weak:
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=fail
		bl SendMessageWithStringLog
@@ret:
		b MoveJumpAddress
		.pool
	fail:
		.asciiz "But [string:0] has[R]no more strength left to sap..."
	stat_changes:
		.byte 52, 54, 56, 58, 60, 63, 67, 70, 80, 100, 120, 130, 140, 150, 165, 170, 175, 180, 185
	.endarea
.close