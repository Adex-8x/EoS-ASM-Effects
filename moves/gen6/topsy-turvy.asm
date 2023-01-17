; ------------------------------------------------------------------------------
; Topsy-Turvy
; Reverses all the stat changes the target has! Boosts become nerfs and vice versa!
; (This does not invert speed, as Super Mystery Dungeon does not do so either.)
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
.definelabel NoClueWhatThisDoesButItWorks, 0x02001AB0
.definelabel UpdateStatusIconFlags, 0x022E3AB4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel NoClueWhatThisDoesButItWorks, 0x02001AB0
;.definelabel UpdateStatusIconFlags, 0x022E4464

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		push r6,r7
		sub r13,r13,#0x4
		ldr r10,[r4,#+0xb4]
		mov r2,#0x24
		mov r1,#0x14
@@boost_loop:
		ldrsh r0,[r10,r2]
		sub r0,r1,r0
		strh r0,[r10,r2]
		cmp r2,#0x2E
		addlt r2,r2,#2
		blt @@boost_loop
		ldr r7,=#25597 ; For whatever reason, THIS is the upper limit checked in the StatMultiplier functions.
		mov r6,#0x34
@@multiplier_loop:
		mov r0,#256
		ldr r1,[r10,r6]
		bl NoClueWhatThisDoesButItWorks
		cmp r0,r7
		strle r0,[r10,r6]
		strgt r7,[r10,r6]
		cmp r6,#0x40
		addlt r6,r6,#4
		blt @@multiplier_loop
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=flippity_flop
		bl SendMessageWithStringLog
		mov r0,r4
		bl UpdateStatusIconFlags
		mov r10,#1
		add r13,r13,#0x4
		pop r6,r7
		b MoveJumpAddress
		.pool
	flippity_flop:
		.asciiz "All of [string:0]'s stat changes[R]turned topsy-turvy!"
	.endarea
.close