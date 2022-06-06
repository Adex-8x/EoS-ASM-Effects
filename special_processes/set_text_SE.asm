; ------------------------------------------------------------------------------
; Set Text Sound Effect
; Changes the text sound used when a message is being displayed!
; For reference, the default SE is 16133!
; Param 1: se_id
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
.definelabel TextboxSE, 0x02017D1C

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel TextboxSE, 0x02017DB8

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		ldr r0,=TextboxSE
		str r7,[r0]
		b ProcJumpAddress
		.pool
	.endarea
.close