; ------------------------------------------------------------------------------
; Befriend
; Once used, the user can recruit the target!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; TODO: US Version supported only!

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel SetupRecruitStruct, 0x22f9058
.definelabel RecruitTarget, 0x230E064
.definelabel SearchAssemblySlot, 0x2055964
.definelabel Warp, 0x02320D08

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
		ldrb r1,[r0,#0x6]
		ldrb r2,[r0,#0x8]
		cmp r1,#1
		cmpeq r2,#0
		ldrne r1,=party_target
		bne @@fail
		bl SearchAssemblySlot
		cmp r0,#0
		ldrne r1,=friend_limit
		beq @@fail
		sub r13,r13,#0x240 ; I don't actually know how big the recruit struct is, but it's notably big?
		mov r0,r13
		mov r1,r4
		bl SetupRecruitStruct
		mov r0,r9
		mov r1,r4
		mov r2,r13
		bl RecruitTarget
		add r13,r13,#0x240
		cmp r0,#0
		bne @@ret
		; This is just a custom effect--you can remove it if you want
		; Warp the target away and give 1 PP back to the player if they decline to recruit the target!
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#0
		bl Warp
		ldrb r0,[r8,#+0x6]
		add r0,r0,#1
		strb r0,[r8,#+0x6]
		b @@ret
@@fail:
		mov r0,r9
		bl SendMessageWithStringLog
@@ret:
		b MoveJumpAddress
		.pool
	friend_limit:
		.asciiz "But you have too many friends..."
	party_target:
		.asciiz "But nothing happened!"
	.endarea
.close