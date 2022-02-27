; ------------------------------------------------------------------------------
; Surefire OHKO
; Never fails to instantly KO the target, regardless of whether they have a Reviver Seed! 
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

		ldr r0,[r4,#+0xb4]
		ldrb r1,[r0,#+0x9E]
		push r0,r1
		and r1,r1,#0xBF
		strb r1,[r0,#+0x9E]
		mov r0,r4
		ldr r1,=#9999
		bl ConstDamage
		pop r0,r1
		strb r1,[r0,#+0x9E]
		b MoveJumpAddress
		.pool
	.endarea
.close