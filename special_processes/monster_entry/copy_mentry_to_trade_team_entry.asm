; ------------------------------------------------------------------------------
; Mentry to Trade Team Entry
; Copies a member of Chimecho Assembly's data to a Trade Team member!
; For Chimecho Assembly: Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; For Trade Team: Slots 0-3 are available.
; Param 1: mentry_id
; Param 2: trade_team_entry_id
; Returns: 1 if successful, 0 if an out-of-bounds Trade Team slot was provided.
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

		mov r0,#0
		cmp r6,#0
		blt @@ret
		cmp r6,#3
		bgt @@ret
		mov r2,#0x44
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		add r0,r1,#0x9800
		add r0,r0,#0x98
		mla r0,r6,r2,r0
		mov r2,#0x44
		mla r1,r7,r2,r1
		bl Copy4BytesArray
		mov r0,#1
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close
