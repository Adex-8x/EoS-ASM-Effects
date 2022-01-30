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
.definelabel BlowAway, 0x0231FDE0

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel BlowAway, 0x02320848

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		mov r0,r4
		ldr r1,=#9999
		bl ConstDamage
		mov r0,r9
		ldr r1,=recoil
		bl SendMessageWithStringLog
		ldr r2,[r9,#+0xb4]
		ldrb r2,[r2,#+0x4c] ; User Direction
		add r2,r2,#4
		cmp r2,#7
		subgt r2,r2,#8
		mov r0,r4
		mov r1,r9
		bl BlowAway
		b MoveJumpAddress
		.pool
	recoil:
		.asciiz "The kickback was overwhelming!"
	.endarea
.close