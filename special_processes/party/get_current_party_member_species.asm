; ------------------------------------------------------------------------------
; Get Current Party Member Species
; Checks the species of a current party member (0-3)!
; Param 1: member_id 
; Returns: The species of the specified member!
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
.definelabel AssemblyPointer, 0x20B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		add r1,r1,#0x9800
		add r1,r1,#0x4c
		ldr r1,[r1]
		mov r2,#0x68
		mla r1,r7,r2,r1
		ldrh r0,[r1,#+0xc]
		b ProcJumpAddress
		.pool
	.endarea
.close