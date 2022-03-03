; ------------------------------------------------------------------------------
; Get Play Time
; Returns the Play Time!
; Param 1: mode (if 0, will not store result in Param 2)
; Param 2: global_variable
; Returns: The current Play Time in seconds.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; TODO: US version supported only (SetGameVar EU offset needed)

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48
.definelabel SetGameVar, 0x0204B820

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C
;.definelabel SetGameVar, 0x0204BB58

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x700
		sub r0,r0,#0x4c
		ldr r0,[r0]
		cmp r7,#0
		beq @@ret
		mov r1,r6
		mov r2,r0
		bl SetGameVar
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close
