; ------------------------------------------------------------------------------
; Instruct
; If a party member uses this move, it will warp its target to the stairs, minimize its defenses, and petrify it (if the target is the leader, it will raise the leader's Special Attack by one and do nothing else)!
; If an enemy uses this move, it will switch its target with the leader! 
; NOTE: This move is intended to target allies! The higher the range, the higher the chaos :)
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
.definelabel Warp, 0x02320D08
.definelabel DungeonBasePtr, 0x2353538
.definelabel Switcher, 0x232c538

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel Warp, 0x02321770
;.definelabel DungeonBasePtr, 0x2354138
;.definelabel Switcher, 0x22EBB28

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize

		ldr r0,[r9,#+0xb4]
		ldrb r1,[r0,#0x6]
		ldrb r2,[r0,#0x8]
		cmp r1,#1
		cmpeq r2,#0
		bne @@ally_user
		ldr r0,=DungeonBasePtr
		ldr r0,[r0]
    		add r0,r0,#0x12000
    		ldr r0,[r0,#+0x0B28]
		mov r1,r4
		mov r2,#0
		mov r3,#0
		bl Switcher
		b @@ret
@@ally_user:
		ldr r0,[r4,#+0xb4]
		ldrb r0,[r0,#+0x7]
		cmp r0,#0
		bne @@not_leader
		mov r0,r9
		mov r1,r4
		mov r2,#0x4
		mov r3,#0
		bl Warp
		mov r0,r9
		mov r1,r4
		bl Petrify
		mov r0,r9
		mov r1,r4
		mov r2,#0
		mov r3,#0
		bl DefenseStatMinMax
		mov r0,r9
		mov r1,r4
		mov r2,#1
		mov r3,#0
		bl DefenseStatMinMax
		b @@ret
@@not_leader:
		mov r0,r9
		mov r1,r4
		mov r2,#1
		mov r3,#1
		bl AttackStatUp
@@ret:
		b MoveJumpAddress
		.pool
	.endarea
.close