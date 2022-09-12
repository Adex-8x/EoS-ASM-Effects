; ------------------------------------------------------------------------------
; Get Explorer Rank
; Checks the Explorer Rank!
; Returns: The current Explorer Rank stage!
; Special thanks to Mond for a more compatible version with the Script Engine!
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
.definelabel RankUpPointsTable, 0x020A2B48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C
;.definelabel RankUpPointsTable, 0x020A30D0


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		push r5,r6
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		sub r1,r1,#0x400
		sub r1,r1,#0xbc
		ldr r0,[r1] ; Explorer Points in r0
		ldr r6,=RankUpPointsTable
		mov r5, #0
	LoopGetRankPoints:
		ldr r2, [r6]
		cmp r0, r2
		blt return
		cmp r5, #12
		addlt r5, r5, #1
		addlt r6, r6, #16
		blt LoopGetRankPoints
	return:
		mov r0, r5
		pop r5,r6
		b ProcJumpAddress
		.pool
	.endarea
.close
