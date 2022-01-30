; ------------------------------------------------------------------------------
; Add or Sub Monster Entry Move 2 Ginseng Boost
; Performs addition (or subtraction) to a Chimecho Assembly member's Ginseng boost of the second move! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; If you are using this on current party members, call Irdkwia's "Remove Party" process before this one!
; Param 1: ent_id
; Param 2: operation_value
; Returns: The value of the new stat (will not overflow or underflow).
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
	.area MaxSize ; Define the size of the area

		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r1
		ldrb r0,[r1,#+0x2c]
		add r0,r0,r6
		cmp r0,#255
		movgt r0,#255
		cmp r0,#0
		movlt r0,#0
		strb r0,[r1,#+0x2c]
		b ProcJumpAddress
		.pool
	.endarea
.close