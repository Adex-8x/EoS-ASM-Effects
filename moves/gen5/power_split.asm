; ------------------------------------------------------------------------------
; Power Split
; Averages the user and target's Attack and Special Attack stats!
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

		ldr r0,[r9,#+0xb4]
		ldrb r1,[r0,#+0x1b]
		ldrb r0,[r0,#+0x1a]
		ldr r2,[r4,#+0xb4]
		ldrb r3,[r2,#+0x1b]
		ldrb r2,[r2,#+0x1a]
		push {r1,r3}
		add r0,r0,r2
		mov r1,#2
		bl EuclidianDivision
		cmp r1,#0
		addne r0,r0,#1
		ldr r1,[r9,#+0xb4]
		strb r0,[r1,#+0x1a]
		ldr r1,[r4,#+0xb4]
		strb r0,[r1,#+0x1a]
		pop {r1,r3}
		add r0,r1,r3
		mov r1,#2
		bl EuclidianDivision
		cmp r1,#0
		addne r0,r0,#1
		ldr r1,[r9,#+0xb4]
		strb r0,[r1,#+0x1b]
		ldr r1,[r4,#+0xb4]
		strb r0,[r1,#+0x1b]
		mov r0,#0
		mov r1,r9
		mov r2,#0
		bl ChangeString
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=power
		bl SendMessageWithStringLog
		b MoveJumpAddress
		.pool
	power:
		.asciiz "[string:0] shared its power[R]with [string:1]!"
	.endarea
.close