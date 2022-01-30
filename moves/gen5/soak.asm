; ------------------------------------------------------------------------------
; Soak
; Change the target's type to Water!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment the correct version

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

		mov r1,#3 ; Water's ID. For something like Magic Powder, change to 11!
		ldr r0,[r4,#+0xb4]
		strb r1,[r0,#+0x5e]
		mov r1,#0
		strb r1,[r0,#+0x5f]
		mov r1,#1
		strb r1,[r0,#+0xff]
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=soak
		bl SendMessageWithStringLog
@@ret:
		b MoveJumpAddress
		.pool
	soak:
		.asciiz "Changed [string:0] to Water type!" ; If desired, change this string!
	.endarea
.close