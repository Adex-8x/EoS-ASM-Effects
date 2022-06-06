; ------------------------------------------------------------------------------
; Change Textbox Color Byte
; Edits a byte (can be R, G, or B) of the textbox color made with the ChangeTextboxColor patch!
; IMPORTANT: This special process ONLY works if the ChangeTextboxColor patch is applied! Do not use this process otherwise!
; Param 1: color_byte (0-2, RGB)
; Param 2: new_value
; Returns: 0 if an invalid argument was passed, 1 if successful!
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
.definelabel TextboxColor, 0x02027800

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel TextboxColor, 0x02027AF4

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		mov r0,#0
		cmp r7,#0
		blt @@ret
		cmp r7,#2
		bgt @@ret
		ldr r0,=TextboxColor
		strb r6,[r0,r7]
		mov r0,#1
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close