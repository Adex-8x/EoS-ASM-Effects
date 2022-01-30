; ------------------------------------------------------------------------------
; Delete Monster Entry
; Deletes a Chimecho Assembly member! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; If you are using this on current party members, call Irdkwia's "Remove Party" process before this one!
; Param 1: ent_id
; Returns: Nothing
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
		mov r0,#0
		strb r0,[r1]
		b ProcJumpAddress
		.pool
	.endarea
.close
