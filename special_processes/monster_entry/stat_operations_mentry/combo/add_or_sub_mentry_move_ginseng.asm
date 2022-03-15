; ------------------------------------------------------------------------------
; Add or Sub Monster Entry Move Ginseng Boost
; Performs addition or subtraction to a Chimecho Assembly member's Ginseng boost of a specific move! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; If you are using this on current party members, call Irdkwia's "Remove Party" process before this one!
; IMPORTANT: This is a combo process, and MUST be called directly after Irdkwia's "Select ID" special process!
; Param 1: move_index
; Param 2: operation_value
; Returns: The value of the new stat (will not overflow or underflow), or 0 if the index is out of bounds.
;
; Stat Key:
; 0 - Move 1
; 1 - Move 2
; 2 - Move 3
; 3 - Move 4
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

		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#3
		bgt @@ret
		ldr r3,=ProcStartAddress+MaxSize-4
		ldr r3,[r3]
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r3,r2,r1
		mov r2,#0x26
		mov r3,#0x6
		mla r2,r3,r7,r2
		add r1,r1,r2
		ldrb r0,[r1]
		add r0,r0,r6
		cmp r0,#255
		movgt r0,#255
		cmp r0,#0
		movlt r0,#0
		strb r0,[r1]
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close
