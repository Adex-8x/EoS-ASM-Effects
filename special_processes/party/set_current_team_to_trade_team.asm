; ------------------------------------------------------------------------------
; Set Trade Team to Current Party
; Copies the current team to the Trade Team at the specified indices!
; Param 1: starting_team_index
; Param 2: ending_team_index
; Returns: 1 if successful, 0 if an invalid argument was provided.
;
; So for example, calling this process with (0, 3) as the arguments would copy the whole team!
; Calling this process with (2, 3) as the arguments would copy current party members 2 and 3 into Trade Team's slots 2 and 3!
; Any unused slots are set to null!
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
.definelabel MemZero, 0x2003250

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C
;.definelabel Copy4BytesArray, 0x0200330C
;.definelabel MemZero, 0x2003250

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		mov r0,#0
		cmp r7,r6
		bgt @@ret
		cmp r7,#0
		blt @@ret
		cmp r7,#3
		bgt @@ret
		cmp r6,#0
		blt @@ret
		cmp r6,#3
		bgt @@ret
		push r4,r5,r8
		ldr r8,=AssemblyPointer
		ldr r8,[r8]
		ldr r0,=#0x9898
		add r0,r8,r0
		mov r1,#0x110
		bl MemZero
		ldr r0,=#0x9870
		ldr r8,[r8,r0]
		lsl r4,r7,#1
		lsl r5,r6,#1
@@team_loop:
		ldrh r3,[r8,r4]
		mov r2,#0x44
		ldr r1,=AssemblyPointer
		ldr r1,[r1]
		add r0,r1,#0x9800
		add r0,r0,#0x98
		lsr r12,r4,#1
		mla r0,r12,r2,r0
		mla r1,r3,r2,r1
		bl Copy4BytesArray
		cmp r4,r5
		addlt r4,r4,#0x2
		blt @@team_loop
		pop r4,r5,r8
		mov r0,#1
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close