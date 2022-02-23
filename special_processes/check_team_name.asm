; ------------------------------------------------------------------------------
; Check Team Name
; Checks if the team name is equal to a predefined name!
; Returns: 0 if unequal, 1 if equal.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		ldr r1,=new_name

		sub r13,r13,#8
		str r0,[r13, #8]
		str r1,[r13, #4]
		mov r2,#0
@@comparison_loop:
		cmp r2,#10
		beq @@true
		ldr r3, [r13, #8]
		ldrb r0,[r3, r2]
		ldr r3,[r13, #4]
		ldrb r1,[r3, r2]
		cmp r0,r1
		bne @@false
		cmp r0,#0
		beq @@true
		add r2,r2,#1
		b @@comparison_loop
@@false:
		mov r0,#0
		b @@ret
@@true:
		mov r0,#1
@@ret:
		add r13,r13,#8
		b ProcJumpAddress
		.pool
	new_name: ; Choose a name to check!
		.ascii "NmW10Chars",0
	.endarea
.close