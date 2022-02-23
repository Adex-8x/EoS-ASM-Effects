; ------------------------------------------------------------------------------
; Check Name
; Checks if a Chimecho Assembly member's name is equal to a predefined name! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; Param 1: ent_id
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
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r1
		add r0,r1,#0x3A
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
