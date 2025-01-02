; ------------------------------------------------------------------------------
; Gun
; Pew pew
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
.definelabel DoMoveOhko, 0x02328B88

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMoveOhko, 0x023295F4

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,r7
		bl DoMoveOhko
		mov r10,r0
		mov r0,r9
		ldr r1,=recoil
		bl SendMessageWithStringCheckULog
		ldr r2,[r9,#+0xb4]
		ldrb r2,[r2,#+0x4c]
		subs r2,r2,#4
		addmi r2,r2,#8
		mov r0,r4
		mov r1,r9
		bl BlowAway
		b MoveJumpAddress
		.pool
	recoil:
		.asciiz "The kickback was overwhelming!"
	.endarea
.close
