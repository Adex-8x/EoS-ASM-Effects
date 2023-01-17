; ------------------------------------------------------------------------------
; V-Create
; Deals damage, but lowers the user's Defense, Special Defense, and Speed each by one stage!
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
.definelabel TryThawTarget, 0x02307C78

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel TryThawTarget, 0x023086A4

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		sub r13,r13,#0x8
		; The following effect will thaw the target, because this is intended for a Fire-type move. HOWEVER, if you do not want for this to happen, please comment this out with ";"!
		mov r0,r9
		mov r1,r4
		bl TryThawTarget

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,#0
		bl RandomChanceU
		cmp r0,#0
		moveq r0,#1
		beq @@ret
		mov r0,r9
		mov r1,r9
		mov r2,#0
		mov r3,#1
		str r3,[r13]
		str r3,[r13,#+0x4]
		bl DefenseStatDown
		mov r0,r9
		mov r1,r9
		mov r2,#1
		mov r3,#1
		str r3,[r13]
		str r3,[r13,#+0x4]
		bl DefenseStatDown
		mov r0,r9
		mov r1,r9
		mov r2,#1
		mov r3,#1
		bl SpeedStatDown
		mov r0,#1
@@ret:
		mov r10,r0
		add r13,r13,#0x8
		b MoveJumpAddress
		.pool
	.endarea
.close