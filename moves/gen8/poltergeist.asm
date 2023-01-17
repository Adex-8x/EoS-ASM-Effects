; ------------------------------------------------------------------------------
; Poltergeist
; If the target is holding an item, deal damage!
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

		sub r13,r13,#0x4
		ldr r0,[r4,#+0xb4]
		ldrh r1,[r0,#+0x66]
		ldrh r2,[r0,#+0x62]
		cmp r1,#0
		tstne r2,#0x1
		beq @@no_item
		mov r0,r9
		mov r1,r4
		mov r2,r8
		str r7,[r13]
		mov r3,#0x100
		bl DealDamage
		cmp r0,#0
		beq @@ret
		mov r0,r9
		mov r1,r4
		mov r2,#0
		bl RandomChanceUT
		cmp r0,#0
		beq @@success
		bl TargetToString0
		mov r0,r9
		mov r1,r4
		ldr r2,=has_item
		bl SendMessageWithStringCheckUTLog
@@success:
		mov r0,#1
		b @@ret
@@no_item:
		bl TargetToString0
		mov r0,r9
		mov r1,r4
		ldr r2,=no_item
		bl SendMessageWithStringCheckUTLog
		mov r0,#0
@@ret:	
		mov r10,r0
		add r13,r13,#0x4
		b MoveJumpAddress
TargetToString0:
		push r14
		mov r0,#0
		mov r1,r4
		mov r2,#0
		bl ChangeString
		pop r15
		.pool
	has_item:
		.asciiz "[string:0] was attacked by[R]its own item!"
	no_item:
		.asciiz "But [string:0] has no item!"
	.endarea
.close
