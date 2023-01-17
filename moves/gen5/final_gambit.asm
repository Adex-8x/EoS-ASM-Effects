; ------------------------------------------------------------------------------
; Final Gambit
; Lowers HP to 1 and the target receives the damage lost!
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
.definelabel GetMoveCategory, 0x020151C8
.definelabel GetMoveType, 0x02013864
.definelabel CalcDamageFixedWrapper, 0x0230D3F4
.definelabel GetFaintReasonWrapper, 0x02324E44

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel GetMoveCategory, 0x020151C8
;.definelabel GetMoveType, 0x0201390C
;.definelabel CalcDamageFixedWrapper, 0x0230DE68
;.definelabel GetFaintReasonWrapper, 0x023258AC

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		push r5,r6
		sub r13,r13,#0x20
		ldr r0,[r9,#+0xb4]
		ldrsh r0,[r0,#+0x10]
		subs r10,r0,#1
		beq @@failure
		mov r0,#0
		strb r0,[r13,#+0x1c]
		mov r0,r8
		bl GetMoveType
		mov r6,r0
		ldrh r0,[r8,#+0x4]
		bl GetMoveCategory
		mov r5,r0
		mov r0,r8
		mov r1,r7
		bl GetFaintReasonWrapper
		add r3,r13,#0x1C
		stmia r13,{r3,r6}
		str r5,[r13,#+0x8]
		str r0,[r13,#+0xc]
		mov r2,#0
		str r2,[r13,#+0x10]
		mov r3,#0x1
		str r3,[r13,#+0x14]
		str r2,[r13,#+0x18]
		mov r2,r10
		mov r1,r9
		mov r0,r9
		bl CalcDamageFixedWrapper
		mov r2,r10
		mov r1,r4
		mov r0,r9
		bl CalcDamageFixedWrapper
		mov r0,#1
		b @@ret
@@failure:
		mov r0,r9
		ldr r1,=one_HP
		bl SendMessageWithStringLog
		mov r0,#0
@@ret:
		mov r10,r0
		add r13,r13,#0x20
		pop r5,r6
		b MoveJumpAddress
		.pool
	one_HP:
		.asciiz "But [string:0] couldn't lose[R]any more HP!"
	.endarea
.close