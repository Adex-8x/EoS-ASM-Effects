; ------------------------------------------------------------------------------
; Put Any Bag in Current Storage
; Puts all of a specified bag items to the current Kangaskhan Storage! This does not clear the bag, so please see Irdkwia's process if you want to do so!
; Param 1: bag_slot (0 is Maingame, 1 is Special Episode, 2 is Rescue)
; Returns: (# of items added to storage)*6
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
.definelabel AddItemToStorage, 0x201031c

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel BasePointer, 0x20aff70
;.definelabel AddItemToStorage, 0x20103c4


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area

		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#2
		bgt @@ret
		ldr r0,=BasePointer
		ldr r0,[r0]
		mov r3,#0
		mov r1,#300
		mla r2,r1,r7,r0
@@storage_loop:
		add r1,r3,#0x4
		ldrh r1,[r2,r1] ; Get item ID of Index r3
		cmp r1,#0
		beq @@ret
		add r0,r13,#0x30
		strh r1,[r13, #+0x30]
		add r1,r3,#0x2 ; Get stack count of Index r3
		ldrh r1,[r2,r1]
		strh r1,[r13, #+0x32]
		stmdb r13!,{r2,r3}
		bl AddItemToStorage
		ldmia r13!,{r2,r3}
		cmp r0,#0
		subeq r3,r3,#0x6
		beq @@ret
		cmp r3,50*6
		addlt r3,r3,#0x6
		blt @@storage_loop
@@ret:
		cmp r3,#0
		movlt r3,#0
		mov r0,r3
		b ProcJumpAddress
		.pool
	.endarea
.close