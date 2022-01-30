; ------------------------------------------------------------------------------
; Topsy-Turvy
; Reverses all the stat changes the target has! Boosts become nerfs and vice versa!
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

		push r5
		ldr r0,[r4,#+0xb4]
		mov r12,#0x24
		mov r3,#0x2
		mov r5,#0xa
@@boost_loop:
		ldrh r1,[r0,r12]
		cmp r1,r5
		beq @@next_boost_iter
		subgt r2,r1,r5
		mulgt r2,r2,r3
		subgt r1,r1,r2
		sublt r2,r5,r1
		mullt r2,r2,r3
		addlt r1,r1,r2
		strh r1,[r0,r12]
@@next_boost_iter:
		cmp r12,#0x2e
		addlt r12,r12,#0x2
		blt @@boost_loop
		mov r12,#0x34
		mov r5,#0x100
		; I thought about going about this using another loop and with bitshifting, but I'm not sure if that'd be faster?
@@multiplier_loop:
		ldr r1,[r0,r12]
		cmp r1,r5
		beq @@next_multiplier_iter
		push {r0,r1,r3,r12}
		movgt r0,r1
		movgt r1,r5
		movlt r0,r5
		movlt r1,r0
		bl EuclidianDivision
		mov r2,r0
		pop {r0,r1,r3,r12}
		mul r2,r2,r3
		cmp r1,r5
		bgt @@divide_multiplier
		mullt r1,r1,r2
		str r1,[r0,r12]
		b @@next_multiplier_iter
@@divide_multiplier:
		push {r0,r1,r3,r12}
		mov r0,r1
		mov r1,r2
		bl EuclidianDivision
		mov r2,r0
		pop {r0,r1,r3,r12}
		str r2,[r0,r12]
@@next_multiplier_iter:
		cmp r12,#0x40
		addlt r12,r12,#0x4
		blt @@multiplier_loop
		pop r5
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=flippity_flop
		bl SendMessageWithStringLog
		b MoveJumpAddress
		.pool
	flippity_flop:
		.asciiz "All of [string:0]'s stat changes[R]turned topsy-turvy!"
	.endarea
.close