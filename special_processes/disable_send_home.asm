; ------------------------------------------------------------------------------
; Disable Send Home
; Disables the "Send Home" option when entering a dungeon!
; NOTE: This MUST be called in between main_EnterDungeon(ID, TIME); and main_EnterDungeon(-1, TIME);!
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
.definelabel DungeonBaseStructPtr, 0x2353538
.definelabel DungeonSetupStruct, 0x022AB4FC

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel DungeonBaseStructPtr, 0x2354138
;.definelabel DungeonSetupStruct, 0x022ABE3C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		
		ldr r0,=DungeonSetupStruct
		mov r1,#1
		strb r1,[r0,#+0xb]
		b ProcJumpAddress
		.pool
	.endarea
.close