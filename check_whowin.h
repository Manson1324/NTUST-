CHECKWHO_WIN macro
LOCAL LCHECK_HorizonIN,LCHECK_HorizonOUT,GOADDB,COUNTER_BLACKADD,COUNTER_WHITEADD,GOADDW
local BLACK_WINRIGHTNOW11,WHITE_WINRIGHTNOW11,QUIT121,RECORDWAY,QUIT1111
;;;;;HORIZON
local LCHECK_VerticalOUT,LCHECK_VerticalIN,COUNTER_BLACKADD1,COUNTER_WHITEADD1,RECORDWAY1
;;;;;RIGHT_DOWN;;;;
LOCAL LCHECK_RIGHTDOWN1,LCHECK_RIGHTDOWN1_Logic,RECORDWAY_2,RECORDWAY2
;2
LOCAL LCHECK_RIGHTDOWN2,RECORDWAY_22,RECORDWAY22,LCHECK_RIGHTDOWN2_Logic,COUNTER_BLACKADD22,COUNTER_WHITEADD22
;;;;;LEFTDOWN;;;;;;;
LOCAL LCHECK_LEFTDOWN1,LCHECK_LEFTDOWN1_Logic,COUNTER_BLACKADD3,COUNTER_WHITEADD3,RECORDWAY3,RECORDWAY_3
LOCAL LCHECK_LEFTDOWN2,LCHECK_LEFTDOWN2_Logic,COUNTER_BLACKADD33,COUNTER_WHITEADD33,RECORDWAY33,RECORDWAY_33
    ;;;;;SCAN--->>;;;;;
    call CLEARCHECK_WHOWIN_FLAG
	mov cx,15     ;row 15times
	LCHECK_HorizonOUT:
	    push cx
		mov cx,15
		LCHECK_HorizonIN:
		    push cx
                call XY2CHI0		;將xy--> 15*y+x=bx;;XY2CHI0;;
			mov bx,XYtoChi0
			xor ax,ax
			mov al,chi0[bx]
            cmp ax,1
			je COUNTER_BLACKADD
			cmp ax,2
			je COUNTER_WHITEADD
			
		    mov COUNTER_BLACK,0
			mov COUNTER_WHITE,0
			MOV ContinueFlag,0
			
			jmp RECORDWAY
		COUNTER_BLACKADD:
		    MOV COUNTER_WHITE,0
		    mov ax,COUNTER_BLACK
			inc ax			
			CMP AX,5
			JAE BLACK_WINRIGHTNOW11
			mov COUNTER_BLACK,ax
			jmp RECORDWAY
		COUNTER_WHITEADD:
		    mov COUNTER_BLACK,0
			MOV AX,COUNTER_WHITE
			inc ax
			CMP AX,5
			JAE WHITE_WINRIGHTNOW11
			mov COUNTER_WHITE,AX
            		
			RECORDWAY:
		    mov ax,x_check
		    inc ax
		    mov x_check,ax	
			pop cx
			dec cx
			jne LCHECK_HorizonIN  ;;Equal to loop LCHECK_HorizonIN
		    xor ax,ax
		    mov x_check,ax
		    mov ax,y_check
		    inc ax
		    mov y_check,ax
		    mov COUNTER_BLACK,0
			mov COUNTER_WHITE,0
			MOV ContinueFlag,0			
		pop cx
		dec cx
		jne LCHECK_HorizonOUT ;;Equal to loop LCHECK_HorizonOUT
	
	CALL CLEARCHECK_WHOWIN_FLAG
	;;;;;SCAN_DOWM;;;;;
	mov cx,15
	LCHECK_VerticalOUT:
	    push cx
		    MOV CX,15
		    LCHECK_VerticalIN:
			push cx
			    call XY2CHI0
				mov bx,XYtoChi0
				xor ax,ax
				mov al,chi0[bx]
				cmp ax,1
				je COUNTER_BLACKADD1
				cmp ax,2
				je COUNTER_WHITEADD1
				
				XOR AX,AX
				MOV COUNTER_BLACK,AX
				MOV COUNTER_WHITE,AX
		
				jmp RECORDWAY1
			COUNTER_BLACKADD1:
			    MOV COUNTER_WHITE,0
				mov ax,COUNTER_BLACK
				INC AX
				CMP AX,5
				JAE BLACK_WINRIGHTNOW11
				mov COUNTER_BLACK,AX
				JMP RECORDWAY1
			COUNTER_WHITEADD1:
			    MOV COUNTER_BLACK,0
				MOV AX,COUNTER_WHITE
				INC AX
				CMP AX,5
				JAE WHITE_WINRIGHTNOW11
				MOV COUNTER_WHITE,AX
				
				RECORDWAY1:
				MOV AX,y_check
				inc ax
				mov y_check,ax
			pop cx
			dec cx
			jne LCHECK_VerticalIN
		xor ax,ax
		mov y_check,ax
		mov ax,x_check
		inc ax
		mov x_check,ax
		    mov COUNTER_BLACK,0
			mov COUNTER_WHITE,0
		pop cx
		dec cx
		jne LCHECK_VerticalOUT
		
	    call CLEARCHECK_WHOWIN_FLAG
	;;;;;SCAN_\\\>;;;;
	mov cx,15
	LCHECK_RIGHTDOWN1:
	    PUSH CX 
		    MOV ax,x_check
			mov KEEPXorY_check,AX
		        LCHECK_RIGHTDOWN1_Logic:
			        cmp x_check,14
					ja RECORDWAY_2
					cmp y_check,14
					ja RECORDWAY_2
					    call XY2CHI0
						mov bx,XYtoChi0
						xor ax,ax
						mov al,chi0[bx]
						cmp ax,1
						je COUNTER_BLACKADD2
						cmp ax,2
						je COUNTER_WHITEADD2
						mov COUNTER_BLACK,0
						mov COUNTER_WHITE,0
						JMP RECORDWAY2
						COUNTER_BLACKADD2:
						    MOV COUNTER_WHITE,0
							MOV AX,COUNTER_BLACK
							INC AX
							CMP AX,5
							JAE BLACK_WINRIGHTNOW11
							MOV COUNTER_BLACK,AX
							JMP RECORDWAY2
						COUNTER_WHITEADD2:
						    MOV COUNTER_BLACK,0
							MOV AX,COUNTER_WHITE
							INC AX
							CMP AX,5
							JAE WHITE_WINRIGHTNOW11
							MOV COUNTER_WHITE,AX
							JMP RECORDWAY2						
						RECORDWAY2:
						MOV AX,x_check
						inc ax
						mov x_check,ax
						mov ax,y_check
						inc ax
						mov y_check,ax
					jmp LCHECK_RIGHTDOWN1_Logic
		RECORDWAY_2:
			MOV AX,KEEPXorY_check
            INC AX
            MOV x_check,ax
            mov y_check,0			
		POP CX
		DEC CX
		JNE LCHECK_RIGHTDOWN1
		
	CALL CLEARCHECK_WHOWIN_FLAG
	;;;;;左半邊;;;;;;;;;
	
	mov cx,15
	LCHECK_RIGHTDOWN2:
	    PUSH CX 
		    MOV ax,y_check
			mov KEEPXorY_check,AX
		        LCHECK_RIGHTDOWN2_Logic:
			        cmp x_check,14
					ja RECORDWAY_22
					cmp y_check,14
					ja RECORDWAY_22
					    call XY2CHI0
						mov bx,XYtoChi0
						xor ax,ax
						mov al,chi0[bx]
						cmp ax,1
						je COUNTER_BLACKADD22
						cmp ax,2
						je COUNTER_WHITEADD22
						mov COUNTER_BLACK,0
						mov COUNTER_WHITE,0
						JMP RECORDWAY22
						COUNTER_BLACKADD22:
						    MOV COUNTER_WHITE,0
							MOV AX,COUNTER_BLACK
							INC AX
							CMP AX,5
							JAE BLACK_WINRIGHTNOW11
							MOV COUNTER_BLACK,AX
							JMP RECORDWAY22
						COUNTER_WHITEADD22:
						    MOV COUNTER_BLACK,0
							MOV AX,COUNTER_WHITE
							INC AX
							CMP AX,5
							JAE WHITE_WINRIGHTNOW11
							MOV COUNTER_WHITE,AX
							JMP RECORDWAY22						
						RECORDWAY22:
						MOV AX,x_check
						inc ax
						mov x_check,ax
						mov ax,y_check
						inc ax
						mov y_check,ax
					jmp LCHECK_RIGHTDOWN2_Logic
		RECORDWAY_22:
			MOV AX,KEEPXorY_check
            INC AX
            MOV y_check,ax
            mov X_check,0			
		POP CX
		DEC CX
		JNE LCHECK_RIGHTDOWN2	
	call CLEARCHECK_WHOWIN_FLAG
	;;;;;SCAN_<///;;;;	
    MOV CX,15
	LCHECK_LEFTDOWN1:
	    PUSH CX
		    MOV ax,x_check
			mov KEEPXorY_check,AX
			LCHECK_LEFTDOWN1_Logic:
			    call XY2CHI0
				mov bx,XYtoChi0
				XOR AX,AX
				MOV al,chi0[bx]
				cmp ax,1
				je COUNTER_BLACKADD3
				cmp ax,2
				je COUNTER_WHITEADD3
				MOV COUNTER_BLACK,0
				MOV COUNTER_WHITE,0
				JMP RECORDWAY3
				COUNTER_BLACKADD3:
				    MOV COUNTER_WHITE,0
					MOV AX,COUNTER_BLACK
					INC AX
					CMP AX,5
					JAE BLACK_WINRIGHTNOW11
					MOV COUNTER_BLACK,AX
					JMP RECORDWAY3
				COUNTER_WHITEADD3:
				    MOV COUNTER_BLACK,0
					MOV AX,COUNTER_WHITE
					INC AX
					CMP AX,5
					JAE WHITE_WINRIGHTNOW11
					MOV COUNTER_WHITE,AX
					JMP RECORDWAY3
			RECORDWAY3:
			    cmp x_check,0
				je RECORDWAY_3
				cmp y_check,14
				je RECORDWAY_3
				MOV AX,x_check
				DEC AX
				MOV x_check,ax
				MOV AX,y_check
				inc ax
				mov y_check,ax
				jmp LCHECK_LEFTDOWN1_Logic				
			RECORDWAY_3:
			mov ax,KEEPXorY_check
			inc ax
			mov x_check,ax
			mov y_check,0
		POP CX
		DEC CX
		JNE LCHECK_LEFTDOWN1
		
	call CLEARCHECK_WHOWIN_FLAG
	
    MOV CX,15
	mov x_check,14
	LCHECK_LEFTDOWN2:
	    PUSH CX
		    MOV ax,y_check
			mov KEEPXorY_check,AX
			LCHECK_LEFTDOWN2_Logic:
			    call XY2CHI0
				mov bx,XYtoChi0
				XOR AX,AX
				MOV al,chi0[bx]
				cmp ax,1
				je COUNTER_BLACKADD33
				cmp ax,2
				je COUNTER_WHITEADD33
				MOV COUNTER_BLACK,0
				MOV COUNTER_WHITE,0
				JMP RECORDWAY33
				COUNTER_BLACKADD33:
				    MOV COUNTER_WHITE,0
					MOV AX,COUNTER_BLACK
					INC AX
					CMP AX,5
					JAE BLACK_WINRIGHTNOW11
					MOV COUNTER_BLACK,AX
					JMP RECORDWAY33
				COUNTER_WHITEADD33:
				    MOV COUNTER_BLACK,0
					MOV AX,COUNTER_WHITE
					INC AX
					CMP AX,5
					JAE WHITE_WINRIGHTNOW11
					MOV COUNTER_WHITE,AX
					JMP RECORDWAY33
			RECORDWAY33:
			    cmp x_check,0
				je RECORDWAY_33
				cmp y_check,14
				je RECORDWAY_33
				MOV AX,x_check
				DEC AX
				MOV x_check,ax
				MOV AX,y_check
				inc ax
				mov y_check,ax
				jmp LCHECK_LEFTDOWN2_Logic				
			RECORDWAY_33:
			mov ax,KEEPXorY_check
			inc ax
			mov y_check,ax
			mov x_check,14
		POP CX
		DEC CX
		JNE LCHECK_LEFTDOWN2
		;;;;;;;;;;;;;;;;;;END CHECK;;;;;;;;;;;;;
		call CLEARCHECK_WHOWIN_FLAG
        JMP QUIT121		
    WHITE_WINRIGHTNOW11:
	    mov ax,1
	    mov WHITE_WIN,ax
	    jmp QUIT121
	BLACK_WINRIGHTNOW11:
	    mov ax,1
	    mov BLACK_WIN,ax
		JMP QUIT121
	QUIT121:
endm
