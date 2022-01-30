; ------------------------------------------------------------------------------
; Core Enforcer
; Deals damage, disabling the target's abilities if it used an item or move!
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

		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		cmp r0,#0
		beq @@ret
		ldr r0,[r4,#+0xb4]
		ldrb r1,[r0,#+0x4a]
		cmp r1,#0x12
		cmpne r1,#0x14
		cmpne r1,#0x15
		bne @@ret
		mov r1,#0
		strb r1,[r0,#+0x60]
		strb r1,[r0,#+0x61]
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=success
		bl SendMessageWithStringLog
@@ret:
		b MoveJumpAddress
		.pool
	success:
		.asciiz "[string:0] had its abilities[R]suppressed!"
	.endarea
.close