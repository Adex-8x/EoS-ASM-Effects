; ------------------------------------------------------------------------------
; Change Team Name
; Changes the team name to a predefined string!
; Returns: Nothing
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
	.area MaxSize ; Define the size of the area
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		ldr r1,=new_name
		mov r2,#10
		bl StrNCpy
		b ProcJumpAddress
		.pool
	new_name: ;Choose a name
		.ascii "NmW10Chars",0
	.endarea
.close