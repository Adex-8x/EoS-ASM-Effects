; ------------------------------------------------------------------------------
; Mentry to Trade Team Entry
; Copies a member of Chimecho Assembly's data to a a Trade Team member!
; Param 1: ent_id_to_copy
; Param 2: ent_id_to_overwrite
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
.definelabel Copy4BytesArray, 0x0200330C

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C
;.definelabel Copy4BytesArray, 0x0200330C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		mov r2,#0x44
		ldr r1,=AssemblyPointer
		ldr r0,[r1]
		add r0,r0,#0x9800
		add r0,r0,#0x98
		mla r0,r7,r2,r0
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r6,r2,r1
		bl Copy4BytesArray
		b ProcJumpAddress
		.pool
	.endarea
.close