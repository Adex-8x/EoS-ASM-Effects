; ------------------------------------------------------------------------------
; Reflect Type
; The user reflects the target's type, making it the same type as the target!
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

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel AbilityIsActiveVeneer, 0x023027A4

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		mov r0,r9
		mov r1,#0x25
		bl AbilityIsActiveVeneer
		cmp r0,#0
		beq @@no_forecast
		mov r0,r9
		mov r1,r4
		ldr r2,=#3523
		bl SendMessageWithIDCheckUTLog
		mov r10,#0
		b MoveJumpAddress
@@no_forecast:
		ldr r0,[r4,#+0xb4]
		ldrb r1,[r0,#+0x5e]
		ldrb r2,[r0,#+0x5f]
		ldr r0,[r9,#+0xb4]
		strb r1,[r0,#+0x5e]
		strb r2,[r0,#+0x5f]
		mov r2,#1
		strb r2,[r0,#+0xff]
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		mov r1,r4
		ldr r2,=type
		bl SendMessageWithStringCheckUTLog
		mov r10,#1
		b MoveJumpAddress
		.pool
	type:
		.asciiz "[string:0] is now the same[R]type as [string:1]!"
	.endarea
.close