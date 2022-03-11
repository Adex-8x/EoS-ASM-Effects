; ------------------------------------------------------------------------------
; Copy Monster Entry
; Copies a Chimecho Assembly member's data onto another's!
; If you are using this on current party members, call Irdkwia's "Remove Party" process before this one!
; Param 1: ent_id_to_copy
; Param 2: ent_id_to_overwrite
; Returns: Nothing
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

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
;.definelabel AssemblyPointer, 0x20B138C
;.definelabel Copy4BytesArray, 0x0200330C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		ldr r0,=AssemblyPointer
		ldr r1,[r0]
		mov r2,#0x44
		mla r1,r7,r2,r1
		ldr r0,[r0]
		mla r0,r6,r2,r0
		bl Copy4BytesArray
		b ProcJumpAddress
		.pool
	.endarea
.close
