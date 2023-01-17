; ------------------------------------------------------------------------------
; Belch
; Deals damage if and only if the user has more than 20 Belly!
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

		sub r13,r13,#0x4
		ldr r0,[r9,#+0xb4]
		ldr r1,=#0x146
		ldrsh r0,[r0,r1]
		cmp r0,#20
		ble @@failure
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		str r7,[r13]
		bl DealDamage
		b @@ret
@@failure:
		mov r0,r9
		ldr r1,=hunger
		bl SendMessageWithStringCheckULog
		mov r0,#0
@@ret:
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
		.pool
	hunger:
		.asciiz "But [string:0] is too[R]famished to even try..."
	.endarea
.close