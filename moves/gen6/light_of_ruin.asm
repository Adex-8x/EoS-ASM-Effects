; ------------------------------------------------------------------------------
; Light of Ruin
; Deals damage to the target, then inflicts 1/2 of the damage done to the user!
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
.definelabel AbilityIsActiveVeneer, 0x02301D78
.definelabel CalcRecoilDamageFixed, 0x0230D18C


; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel AbilityIsActiveVeneer, 0x023027A4
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
		cmp r0,#0
		beq @@ret
		lsrs r10,r0,#1
		addeq r10,r10,#1
		mov r0,r9
		mov r1,#0x7
		bl AbilityIsActiveVeneer
		cmp r0,#0
		bne @@success
		mov r0,r9
		mov r1,#0
		bl RandomChanceU
		cmp r0,#0
		beq @@success
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
		mov r1,r10
		bl CalcRecoilDamageFixed
@@success:
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x18
		b MoveJumpAddress
		.pool
	.endarea
.close