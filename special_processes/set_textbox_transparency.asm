; ------------------------------------------------------------------------------
; Set Textbox Transparency
; Changes the textbook to be either transparent or not!
; Param 1: If 0, set the textbook to solid. Else, set the textbook to transparent!
; Returns: Nothing
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
.definelabel TextboxTransparent, 0x02027148
.definelabel TextboxSolid, 0x0202715C

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel TextboxTransparent, 0x0202743C
;.definelabel TextboxSolid, 0x02027450

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		cmp r7,#0
		bleq TextboxSolid
		blne TextboxTransparent
		b ProcJumpAddress
		.pool
	.endarea
.close