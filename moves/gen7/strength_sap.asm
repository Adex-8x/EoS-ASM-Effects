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
		; This is so bad hhh
		cmp r0,#0
		moveq r2,#50
		beq @@salvameporfa
		cmp r0,#1
		moveq r2,#52
		beq @@salvameporfa
		cmp r0,#2
		moveq r2,#54
		beq @@salvameporfa
		cmp r0,#3
		moveq r2,#56
		beq @@salvameporfa
		cmp r0,#4
		moveq r2,#58
		beq @@salvameporfa
		cmp r0,#5
		moveq r2,#60
		beq @@salvameporfa
		cmp r0,#6
		moveq r2,#63
		beq @@salvameporfa
		cmp r0,#7
		moveq r2,#67
		beq @@salvameporfa
		cmp r0,#8
		moveq r2,#70
		beq @@salvameporfa
		cmp r0,#9
		moveq r2,#80
		beq @@salvameporfa
		cmp r0,#10
		moveq r2,#100
		beq @@salvameporfa
		cmp r0,#11
		moveq r2,#120
		beq @@salvameporfa
		cmp r0,#12
		moveq r2,#130
		beq @@salvameporfa
		cmp r0,#13
		moveq r2,#140
		beq @@salvameporfa
		cmp r0,#14
		moveq r2,#150
		beq @@salvameporfa
		cmp r0,#15
		moveq r2,#160
		beq @@salvameporfa
		cmp r0,#16
		moveq r2,#165
		beq @@salvameporfa
		cmp r0,#17
		moveq r2,#170
		beq @@salvameporfa
		cmp r0,#18
		moveq r2,#175
		beq @@salvameporfa
		cmp r0,#19
		moveq r2,#180
		beq @@salvameporfa
		mov r2,#185
@@salvameporfa:
		mul r0,r1,r2
		mov r1,#100
		bl EuclidianDivision
		; Is this even necessary? I might be misunderstanding how the boosts differ from the multipliers, but just in case:
		mov r2,r0
		mov r3,#1
		ldr r0,[r4,#+0xb4]
		ldr r0,[r0,#+0x34]
		cmp r0,#0x100
		beq @@wrapping_up_at_last
		blt @@left_shift_loop
@@right_shift_loop:
		lsr r0,r0,r3
		cmp r0,#0x100
		addne r3,r3,#1
		bne @@right_shift_loop
		lsl r2,r2,r3
		b @@wrapping_up_at_last
@@left_shift_loop:
		lsl r0,r0,r3
		cmp r0,#0x100
		addne r3,r3,#1
		bne @@left_shift_loop
		lsr r2,r2,r3
@@wrapping_up_at_last:
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
	.endarea
.close