; ------------------------------------------------------------------------------
; Befriend
; Once used, the user can recruit the target!
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
.definelabel SetupRecruitStruct, 0x022F9058
.definelabel RecruitTarget, 0x0230E064
.definelabel SearchAssemblySlot, 0x02055964
.definelabel Warp, 0x02320D08

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel SetupRecruitStruct, 0x022F9A64
;.definelabel RecruitTarget, 0x0230EAD8
;.definelabel SearchAssemblySlot, 0x02055CE0
;.definelabel Warp, 0x02321770


; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		sub r13,r13,#0x240 ; I don't actually know how big the recruit struct is, but it's notably big?
		ldr r0,[r4,#+0xb4]
		ldrb r1,[r0,#0x6]
		ldrb r2,[r0,#0x8]
		cmp r1,#1
		cmpeq r2,#0
		ldrne r1,=party_target
		bne @@fail
		bl SearchAssemblySlot
		cmp r0,#0
		ldreq r1,=friend_limit
		beq @@fail
		mov r0,r13
		mov r1,r4
		bl SetupRecruitStruct
		mov r0,r9
		mov r1,r4
		mov r2,r13
		bl RecruitTarget
		cmp r0,#0
		bne @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#0
		bl Warp
		mov r0,#1
		b @@ret
@@fail:
		mov r0,r9
		bl SendMessageWithStringCheckULog
		mov r0,#0
@@ret:
		mov r10,r0
		add r13,r13,#0x240
		b MoveJumpAddress
		.pool
	friend_limit:
		.asciiz "But you have too many recruits..."
	party_target:
		.asciiz "But nothing happened!"
	.endarea
.close
