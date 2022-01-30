; ------------------------------------------------------------------------------
; Add Monster Entry to Party
; Adds a Chimecho Assembly member to the current party! Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; Param 1: ent_id
; Returns: 0 if an invalid member was specified, 1 if successful!
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
.definelabel AddIndexedSlot, 0x2056554
.definelabel ApplyPartyChange, 0x2057464

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C
;.definelabel AddIndexedSlot, 0x20568D0
;.definelabel ApplyPartyChange, 0x20577E0


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
    	.org ProcStartAddress
    	.area MaxSize
        
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		mov r1,#0x44
		mla r0,r7,r1,r0
		ldrb r0,[r0]
		tst r0,#0x1
		beq @@ret
        	mov r0,r7
        	bl AddIndexedSlot
        	ldr r0,=AssemblyPointer
        	ldr r0,[r0]
		ldr r1,=9877h
        	ldrb r0,[r0, r1]
        	bl ApplyPartyChange
		mov r0,#1
@@ret:
        	b ProcJumpAddress
        	.pool
    	.endarea
.close
