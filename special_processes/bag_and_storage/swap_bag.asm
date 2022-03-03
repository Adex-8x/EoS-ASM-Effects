; ------------------------------------------------------------------------------
; Swap Bag
; Swaps the first inputted bag's contents with the second (0 is Maingame, 1 is Special Episode, 2 is Rescue)!
; Param 1: bag_slot_1
; Param 2: bag_slot_2
; Returns: 1 if successful, 0 if not.
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
.definelabel BasePointer, 0x020af6b8
.definelabel Copy4BytesArray, 0x0200330C
.definelabel ClearItem, 0x0200D81C
.definelabel TeamPtr, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel BasePointer, 0x20aff70
;.definelabel Copy4BytesArray, 0x0200330C
;.definelabel ClearItem, 0x0200D8A4
;.definelabel TeamPtr, 0x20B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#2
		bgt @@ret
		cmp r6,#0
		blt @@ret
		cmp r6,#2
		bgt @@ret
		mov r3,r6
		mov r12,#2
@@both_team_clear1:
		ldr r0,=BasePointer
		ldr r0,[r0]
		mov r1,#300
		mla r0,r1,r3,r0 ; Compute correct location of a bag slot
		add r0,r0,#1
		mov r2,#0
@@clear_held_loop:
		strb r2,[r0],#6
		subs r1,r1,#6
		bne @@clear_held_loop
		subs r12,r12,#1
		mov r3,r7
		bne @@both_team_clear1

		sub r13,r13,#300
		ldr r1,=BasePointer
		ldr r1,[r1]
		mov r0,r13
		mov r2,#300
		mla r1,r2,r7,r1
		bl Copy4BytesArray
		ldr r1,=BasePointer
		ldr r1,[r1]
		mov r2,#300
		mla r0,r2,r7,r1
		mla r1,r2,r6,r1
		bl Copy4BytesArray
		ldr r1,=BasePointer
		ldr r1,[r1]
		mov r2,#300
		mla r0,r2,r6,r1
		mov r1,r13
		bl Copy4BytesArray
		add r13,r13,#300
		push r4,r5,r14
		mov r12,#2
		; Massive thanks to Irdkwia!
@@both_team_clear2:
    		ldr r4,=TeamPtr
    		ldr r4,[r4]
    		add r4,r4,#0x9300
    		add r4,r4,#0x6C ; First team pointer
    		mov r1,#0x1A0
    		mla r4,r3,r1,r4 ; Compute the correct location
    		mov r5,#0
@@loop_clear:
    		ldrb r0,[r4]
    		tst r0,#0x1
    		beq @@check_loop_clear
    		add r0,r4,#0x3E ; Item structure is at 0x3E
    		bl ClearItem
@@check_loop_clear:
    		add r5,r5,#1
    		add r4,r4,#0x68
    		cmp r5,#4
    		blt @@loop_clear
		subs r12,r12,#1
		mov r3,r6
		bne @@both_team_clear2
    		pop r4,r5,r14		
		mov r0,#1
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close
