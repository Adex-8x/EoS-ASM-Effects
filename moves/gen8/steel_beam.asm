; ------------------------------------------------------------------------------
; Steel Beam
; Deals damage, then the user takes damage equal to half of its maximum HP!
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
.definelabel CalcRecoilDamageFixed, 0x0230D18C


; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel CalcRecoilDamageFixed, 0x0230DC00

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		sub r13,r13,#0x18
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		mov r10,r0
		; No check for the result--this is intentional!
		ldr r0,[r9,#+0xb4]
		ldrsh r1,[r0,#+0x16]
		ldrsh r2,[r0,#+0x12]
		add r1,r1,r2
		ldr r2,=#999
		cmp r1,r2
		movgt r1,r2
		lsrs r1,r1,#1
		moveq r1,#1
		ldrh r3,[r8,#+0x4]
		str r3,[r13]
		mov r3,#0x23C
		mov r2,#0
		str r2,[r13,#+0x4]
		str r3,[r13,#+0x8]
		mov r3,#0x14
		str r3,[r13,#+0xC]
		mov r3,#0x1
		str r3,[r13,#+0x10]
		mov r0,r9
		mov r3,r2
		str r2,[r13,#+0x14]
		bl CalcRecoilDamageFixed
		add r13,r13,#0x18
		b MoveJumpAddress
		.pool
	.endarea
.close
