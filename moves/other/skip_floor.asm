; ------------------------------------------------------------------------------
; Skip Floor
; Proceeds to the next floor of a dungeon!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DungeonBaseStructPtr, 0x2353538

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DungeonBaseStructPtr, 0x2354138

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,=DungeonBaseStructPtr
		ldr r0,[r0]
		mov r1,#1
		strb r1,[r0,#+0x8]
		mov r10,#1
		b MoveJumpAddress
		.pool
	.endarea
.close