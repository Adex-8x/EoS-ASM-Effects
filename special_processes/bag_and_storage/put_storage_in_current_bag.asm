; ------------------------------------------------------------------------------
; Put Storage in Current Bag
; Puts all Kangaskhan Storage items in the bag! This does not clear Kangaskhan Storage, so please see Irdkwia's process if you want to do so!
; No parameters.
; Returns: (# of items added to bag)*2
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
.definelabel AddItemToBag, 0x200f84c

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel BasePointer, 0x20aff70
;.definelabel AddItemToBag, 0x200f8f4


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area

		ldr r0,=BasePointer
		ldr r0,[r0]
		add r0,r0,#0x8A
		add r2,r0,#0x300
		mov r3,#0
@@bag_loop:
		ldrh r1,[r2,r3] ; Get item ID of Index r3
		cmp r1,#0
		beq @@ret
		add r0,r13,#0x38
		strh r1,[r13, #0x38]
		add r1,r2,#0x7d0
		ldrh r1,[r1,r3] ; Get stack count of Index r3
		strh r1,[r13, #0x3a]
		stmdb r13!,{r2,r3}
		bl AddItemToBag
		ldmia r13!,{r2,r3}
		cmp r0,#0
		subeq r3,r3,#0x2
		beq @@ret
		cmp r3,2*1000
		addlt r3,r3,#0x2
		blt @@bag_loop
@@ret:
		cmp r3,#0
		movlt r3,#0
		mov r0,r3
		b ProcJumpAddress
		.pool
	.endarea
.close