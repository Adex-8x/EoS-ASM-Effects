; ------------------------------------------------------------------------------
; Entrainment
; Sets the target's abilities to the users' own!
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
.definelabel TryNewAbilityChecks, 0x022FA7DC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel TryNewAbilityChecks, 0x022FB1E8

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,[r9,#+0xb4]
		ldrb r1,[r0,#+0x60]
		ldrb r2,[r0,#+0x61]
		ldr r0,[r4,#+0xb4]
		strb r1,[r0,#+0x60]
		strb r2,[r0,#+0x61]
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=ability
		bl SendMessageWithStringCheckULog
		mov r0,r9
		mov r1,r4
		bl TryNewAbilityChecks
		mov r10,#1
		b MoveJumpAddress
		.pool
	ability:
		.asciiz "[string:1] acquired the abilities[R]of [string:0]!"
	.endarea
.close