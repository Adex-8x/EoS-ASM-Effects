; ------------------------------------------------------------------------------
; Add or Sub Play Time
; Performs addition or subtraction to the Play Time (will not underflow)!
; Param 1: time_to_operate
; Returns: The new Play Time.
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

		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		sub r1,r1,#0x700
		sub r1,r1,#0x4c
		ldr r0,[r1]
		adds r0,r0,r7
		movmi r0,#0
		str r0,[r1]
		b ProcJumpAddress
		.pool
	.endarea
.close