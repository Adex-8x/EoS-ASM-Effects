; ------------------------------------------------------------------------------
; Set Option
; Changes one of the specified options to a new value!
; Param 1: option
; Param 2: new_value
; Returns: 1 if successful, 0 if an invalid argument was provided
;
; Setting Key:
; 0 - Touch Screen
; 1 - Bottom Screen
; 2 - Top Screen
; 3 - Grids
; 4 - Speed
; 5 - Far-off pals
; 6 - Damage turn
; 7 - DPad attack
; 8 - Check direction
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

.definelabel MaxSize, 0x810

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
	.area MaxSize

		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#8
		bgt @@ret
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0xd00
		sub r0,r0,#0x40
		strb r6,[r0,r7]
		mov r0,#1
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close