Getchar macro char
	mov ah,07h
	int 21h
	mov char,al
	endm
	
PrintCHAR macro string
    mov ah,02h
	mov dx,string
	int 21h
endm

SetMode macro mode
    mov ah,00h
	mov al,mode
	int 10h
endm

SetColor macro color11
    mov ah,0Bh
	mov bh,00h
	mov bl,color11
	int 10h
endm

WrPixel macro row,col,color
    mov ah,0ch
	mov bh,00h
	mov al,color
	mov cx,col
	mov dx,row
	int 10h
endm

PrintStr macro string
    mov ah,09h
	mov dx,offset string
	int 21h
endm

MUS_RESET macro
    mov ax,0000h
	int 33h
endm

MUS_SHOW macro
    mov ax,0001h
    int 33h
endm

MUS_HIND macro
    mov ax,0002h
    int 33h
endm

MUS_GET03 macro
    mov ax,0003h
    int 33h
endm	

PrintStr macro a
    mov dx,offset a
    mov ah, 09h
    int 21h
endm
SET_CUR macro row,col
        mov dh,row
		mov dl,col
		mov bx,0000h
		mov ah,02h
		int 10h
endm

PrintTri macro ro,co,color1       ;;;;;;triangle;;;;;;;;
Local Lout,Lin,L2
    mov bx,ro
    mov rowMemTri,bx
	mov bx,co
	mov colMemTri,bx
	mov cx,sizetri
    Lout:
	    push cx
		mov cx,time1
		Lin:
		    push cx
			mov dx,rowsNow
			mov cx,colsNow
			WrPixel dx,cx,color1
		    mov cx,colsNow
	        inc cx
	        mov colsNow,cx
			pop cx
		loop Lin
        mov cx,colMemTri
		mov colsNow,cx
		mov dx,time1
		inc dx
		mov time1,dx
		mov dx,rowsNow
		inc dx
		mov rowsNow,dx
		pop cx
	loop Lout
    mov dx,1
	mov time1,dx
	mov dx,rowMemTri
	mov rowsNow,dx
	mov dx,colMemTri
	mov colsNow,dx
L2:
endm

check_1 macro rownow,columnnow                ;;;;;check 1
local cx1,cx2,dx1,dx2,checkok,valid,invalid
cx1:
	mov dx,rownow
	mov cx,columnnow
	cmp cx,135
	ja  cx2
	jmp invalid
cx2:
	cmp cx,585
	jb  dx1
	jmp invalid
dx1:
	cmp dx,15
	ja  dx2
	jmp invalid
dx2:	
	cmp dx,465
	jb  valid
	jmp invalid
valid:
	mov clickinboard,1
	jmp checkok
invalid:
	mov clickinboard,0
checkok:
endm

Printblack macro y1,x1,color                                    
local first,Adjustx,Adjusty,Second,Do_Print
first:
	mov cx,x1
	mov ax,initial_x
Adjustx:
	add ax,30
	dec cx
	mov print_x,ax
	cmp cx,0
	ja  Adjustx
	jmp Second
Second:
	mov cx,y1
	mov ax,initial_y
Adjusty:
	add ax,30
	dec cx
	mov print_y,ax
	cmp cx,0
	ja Adjusty
	jmp Do_Print
Do_Print:
    Printcircle print_x,print_y,radius1,color
endm
                   
changecolor macro color      ;;;;;ChangeColor
LOCAL b20,oil
    mov al,color
	cmp al,10h
	ja b20
	inc al
	mov color,al
	jmp oil
b20:
    mov al,0
	mov color,al
oil:
endm                        ;;;;;;ChangeColor endm
         ;;;;;;放黑子
Putblack macro y,x
LOCAL quit,stillblack
    mov ax,15
	mov bx,y
	xor dx,dx
	mul bx
	add ax,x
	mov bx,ax
	mov testput,bx
	mov al,chi0[bx]

	cmp al,0
	jne stillblack
	mov chi0[bx],1
	jmp quit
stillblack:
    jmp GO2DO
quit:
    ;jmp blackshia
endm
                      ;;;;;;放黑子end

Putwhite macro y1,x1       ;;;;;;放白子
LOCAL quit1
whiteput:
    mov ax,15
	mov bx,y1
	xor dx,dx
	mul bx
	add ax,x1
	mov bx,ax
	mov testput,bx
	mov al,chi0[bx]
	cmp al,0
	jne stillwhite
	mov chi0[bx],2
	jmp quit1
stillwhite:
    ;print 提示
	jmp GO2DO
quit1:
    ;jmp whiteshia
endm



Putin macro rowin,columnin 
	mov dx,rowin 
	sub dx,15
	mov ax,dx
	xor dx,dx
	mov bx,30
	div bx
	mov putrow,ax
	
	mov cx,columnin
	sub cx,135
	mov ax,cx
	xor dx,dx
	mov bx,30
	div bx
	mov putcolumn,ax
endm

include title.h				;;;;;;print picture
include drawcircle.h        ;;;;;;draw the circle
include checkerboard.h      ;;;;;;棋盤
include mouseframe.h		;;;;;;the next check location
include check_whowin.h      ;;;;;;checkwhowin
.8086
.model large
.stack 1024
.data
    strwel db "======5son===== $"
    str1  db "BLACKWIN!!! $"
	str2  db "WHITEWIN!!! $"
	str3  db "Peace!!     $"
	str4  db "Press R Return$"
	str5  db "Press ESC Exit!$"
	str6  db "====Press A or a Start !====$"
	str7  db "====Press ESC to  Exit !====$"
	str8  db "==Press Any Key!==$"
	Madeby db "Made by Paul & Manson @@__NTUST EE__$"
	strchg db 10,13,'$'
	space db "          $"
	charget  db ?
    ;;;;;DRAW A CIRCLE USE;;;;;;;;;;
    
	circlex_column dw ?            ;
	circley_row    dw ?            ; 
    radius1 dw 000ch               ;
	timecircle dw ?                ;
	;;;;;DRAW A CIRCLE USE;;;;;;;;;;
	;;;;;DRAW THE FRAME ;;;;;
	mouseinboard   dw 3		;
	iamcolumn      dw 0		;
	iamrow		   dw 0		;
	mousecircle	   dw 0		;
	justx		   dw 0		;
	justy		   dw 0		;
	;;;;;DRAW THE FRAME ;;;;;
    ;;;Macro triangle USE
	rowMemTri dw ?
	colMemTri dw ?
	time1 dw 1       
	rowsNow dw 220
    colsNow dw 300	
	sizetri dw 000ah
    ;;;Macro triangle USE	
	a		   dw ?              ;;;Macro triangle USE
	b		   dw ?              ;;;Macro triangle USE
	color100   db 0bh            ;;;Macro triangle USE          
    x_num db "x=",3 dup(' '),'$'
	y_num db "y=",3 dup(' '),'$'
	row	  	   dw 10
	column     dw 10
	columnnext dw 0
	time	   dw 1
	bigsmall   dw 10 
    ;;;Macro triangle USE
	
	;;;;;;;;checkboard USE INTEGRAL;;;;;;;;;;
    startrow dw 30
	rowMEM dw 30
	startcol dw 150
	colMEM dw 150
	colorline db 06h              ;colorline;
	;;;;;;;;checkboard USE INTEGRAL;;;;;;;;;;
	
	;;;;;;;;Print checkboard x,y when u click;;;;;;;
	row_num    db "R="   ,3 dup(' '),'$'
	column_num db "C=",3 dup(' '),'$'
	initial_x  dw 150
	initial_y  dw 30
	;;;;;;;;Print checkboard x,y when u click;;;;;;;
	
	;;;;;;;;;the location we put inside checkboard;;;;
	clickinboard dw 3
	putrow	  	 dw 0
	putcolumn  	 dw 0
	print_x		 dw 0
	print_y		 dw 0	
	;;;;;;;;;the location we put inside checkboard;;;;
	
	;;;;;;;;;whose turn
	count5son dw 0
	testput   dw ?
    background_color db 00h                 ;;;BACKGROUND COLOR
	;;;;;;;;;SCAN&PRINT_CHI USE ;;;;;;;
	KEEPDI DW ?
	X_inscan  DW ?
	Y_inscan  DW ?
	KEEPCX DW ?
	;;;;;;;;;CHECKWHO_WIN;;;;;;;;;;;;;
	BLACK_WIN DW 0
	WHITE_WIN DW 0
    COUNTER_BLACK DW 0
	COUNTER_WHITE DW 0
	ContinueFlag dw 0
	x_check dw 0
	y_check dw 0
	XYtoChi0 DW ?
	KEEPXorY_check dw ?
	;;;;;;;Peace
	countPeace dw 0
	;;;;;;;COLOR
	COLORP1 DB 06h
	COLORP2 DB 0FH
	;;;;;;;picture_use;;;;;;;
	playrow    dw 205
	playcol    dw 100
	fiverow    dw 0
	fivecol    dw 80
	coltime    dw 0
	rowtime    dw 0
	linetime   dw 0
	colorT 	   db 04h
	exitcol    dw 100
	exitrow    dw 300
	sharkrow   dw 90
	sharkcol   dw 20
	sharkcol2  dw 20
	sharkrow2  dw 270
	turnrow    dw 190
	turncol    dw 0
	turnrow2   dw 380
	turncol2   dw 0
	winrow     dw 84
	wincol 	   dw 170
	;;;;;;;picture_use;;;;;;;
	;;;;;;information_open;;;;;
	Information1 db 0
          ;0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
chi0  db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 0
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 1
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 2
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ; 3
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ; 4 
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ; 5
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ; 6
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 7
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 8
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ; 9
      db   2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 0 ;10
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ;11
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ;12
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ;13
      db   1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 0 ;14
	  
	  		  ;0 ;1 ;2 ;3 ;4 ;5 ;6 ;7 ;8 ;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47  	
five 	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;0
		db 0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;1
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ;2
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;3 
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;4
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ;5
		db 0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;6 
		db 0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;7 
		db 0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,1 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ;8 
		db 0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;9 
		db 0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;10 
		db 0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ;11 
		db 0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ;12 
		db 0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ;13 
		db 1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ;14 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ;15	



 	      ;0 ;1 ;2 ;3 ;4 ;5 ;6 ;7 ;8 ;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59
play 	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;1
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;2 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;3
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;4
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  
		db 0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;5
		db 0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;6
		db 0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;7
		db 0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;8
		db 0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;9
		db 0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;10
		db 1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;11
		db 1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 1 ,1 ,1 ,0 ,0 ,0 ,0, 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1  ;12
		db 1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;13
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;14
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
exit	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;0 
        db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
     	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;1
        db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
  	    db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;2 
        db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0    ;3
		db 1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;4
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;5
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;6
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;7
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;8
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;9
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;10
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ;11
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,1 ,0 ,0 ,0 ,0 ,1, 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0   ;12
		db 0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0    ;13
		db 1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0    ;14
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;shark;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shark1	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 
		db 1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,1, 1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,6 ,1 ,1 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,12,12,12,12,12,12,1 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,12,12,12,12,12,12,1 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,12,12,12,12,12,12,1 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,12,12,12,12,12,12,1 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,12,12,12,12,12,12,1 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 
		db 0 ,0 ,0 ,1 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,12,12,12,1 ,1 ,1 ,12,12,12,1 ,6 ,6 ,6 ,6
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,15,1 ,12,1 ,4 ,4 ,4 ,1 ,12,1 ,15,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,15,6 ,1 ,1 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,6 ,15,6 ,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,1 ,1 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,1 ,4 ,4 ,4 ,4 ,4 ,1 ,6 ,6 ,6 ,15,6 ,6 
		db 6 ,6 ,6 ,6 ,6 ,1 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,6 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,4 ,4 ,4 ,1 ,6 ,6 ,6 ,6 ,6 ,15,6 
		db 6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,6 ,1 ,6 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,15
		db 6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,6 ,6 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 ,6 
		db 6 ,6 ,6 ,15,6 ,6 ,6 ,6 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 
		db 1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;turn;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
turn	db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;1
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;2 
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;3
		db 0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;4
		db 0 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;5
		db 0 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;6
		db 0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;7
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,1 ,1 ;8
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;9
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,1 ;10
		db 0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 
		db 1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ;11
		db 0 ,1 ,0 ,0 ,0 ,0 ,0, 0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 
		db 1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ;12
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ;13
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
		db 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ;14
.code
.startup

       SetMode 12h
START_SHOW:
       SetMode 12h
	   Print5son
	   printplay
	   printexit
	   SET_CUR 14,40
	   PrintStr str6
	   SET_CUR 25,25
	   PrintStr Madeby
	   SET_CUR 20,40
	   PrintStr str7
       ;call start
	   Getchar charget
	   cmp al,1bh
	   je RQUIT
	   cmp al,41H
	   je Normal_Mode
	   CMP al,61H
	   je Normal_Mode
	   cmp al,20H
	   je Special_Mode
	   jmp START_SHOW
Normal_Mode:
        mov COLORP1,06H
		mov COLORP2,0FH
		JMP Restart
Special_Mode: 
        mov COLORP1,04H
		mov COLORP2,01H
Restart:
        call CLEARCHECK_WHOWIN_FLAG
		call CLEARchi0
		mov countPeace,0
        SetMode  12h
	    Setcolor background_color
		MUS_RESET
		MUS_SHOW
			printshark1
			printshark2
		;Main Proc;;;;;;;;主回圈;;;;;;;;;;;;
GOCH:	      
	    call SCANIN       ;Didn't wait input
		cmp al,52h
		je Restart
	    cmp al,1bh
	    je START_SHOW
	    cmp al,31h
	    je chline
		cmp al,69h
		je  information_open
	    cmp al,63h
	    jne GO2DO
	    changecolor background_color
	    Setcolor background_color
		jmp GOCH
		information_open:
				cmp Information1,0
			    je open_if
				mov Information1,0
						SET_CUR 0,0
						PrintStr space
						SET_CUR 1,0
						PrintStr space					
						set_cur  2,0
						PrintStr space
						set_cur  3,0
						PrintStr space
						set_cur  4,0
						PrintStr space
				jmp GO2DO
			open_if:
				mov Information1,1
			jmp GO2DO
    chline:
        changecolor colorline
        jmp GOCH
    GO2DO:

	    lea di,x_num                       ;CLEAR X NUM
	    call clear
	    lea di,y_num                       ;CLEAR Y NUM
	    call clear
	    lea di,column_num                  ;clear
	    call clear
	    lea di,row_num                     ;clear
	    call clear	
		    PrintTri rowsNow,colsNow,00h 		
		MUS_GET03      		;getMouse position
		push bx             ;save bx
		call checkEdge                     ;check Edge
		mov colsNow,cx
		mov rowsNow,dx
		check_2 rowsNow,colsNow 		;frame
		cmp mouseinboard,1
		je  Candoframe 
	FRAMEOK:
		pop bx
		cmp bx,1
		je check1
		jmp here2
	checkwin:
		CALL SCAN_PRINTCHI
	    CHECKWHO_WIN   ;CHECKWHO_WIN 		
        MOV bx,BLACK_WIN
        CMP BX,1
        JE  BLACK_WINRIGHTNOW
        MOV BX,WHITE_WIN
	    CMP BX,1
        JE  WHITE_WINRIGHTNOW
		call Check_Peace
    
	here2:     
	    mov ax,colsNow
	    mov di,offset x_num                ;column
	    call tran
   	    mov ax,rowsNow 
	    mov di,offset y_num                 
	    call tran
		
		;mov ax,putrow
		mov ax,putrow
		mov  di,offset row_num	
	    call tran	
        ;mov ax,putcolumn
		mov ax,putcolumn
	    mov  di,offset column_num
	    call tran		
        cmp count5son,0
		je BNOW
		jmp WNOW
	;;;;change mouse color and the turn words;;;;
		BNOW:
		    PrintTri rowsNow,colsNow,COLORP1
			printturnoffW
			printturnblack
            JMP OK
		WNOW:
			printturnoffB
			printturnwhite
		    PrintTri rowsNow,colsNow,COLORP2
        OK:		
		cmp Information1,0
		JE NOP_IF
        call Information
		NOP_IF:
        PrintChBoard colorline		
        CALL SCAN_PRINTCHI
        jmp  GOCH
	;;;;;can print the frame;;;;;
	Candoframe:
		iamin  rowsNow,colsNow
		mouseinprint iamrow,iamcolumn
		jmp FRAMEOK
	;;;;;first-check click in board ;;;;;			
	check1:
	    check_1 rowsNow,colsNow
	    cmp clickinboard,1
	    je  put
	    jmp  here2
    put: 
	    mov ax,count5son
		cmp ax,0
		je BLACK_TURN
		JMP WHITE_TURN
		BLACK_TURN:
		    Putin      rowsNow,colsNow
	        ;Printblack putrow,putcolumn,01h	;outside print
	        Putblack   putrow,putcolumn	;inside  record
			mov ax,1
			mov count5son,ax
	    
			jmp checkwin
	    WHITE_TURN:
		    Putin      rowsNow,colsNow
			Putwhite   putrow,putcolumn
	        ;Printblack putrow,putcolumn,0ffh	;outside print
			mov ax,0
			mov count5son,ax
			jmp checkwin		    
    check2:
	     jmp here2
		;;;;;;;;;;;;;;UP;;;;;;;;;;;;主回圈
Peace_NOoneWin:
    SetMode 12h
    PrintStr str3    
    jmp QUIT
WHITE_WINRIGHTNOW:
    SetMode 12h
		Setcolor background_color
		PrintChBoard colorline
		call SCAN_PRINTCHI
		PrintStr str2

		SET_CUR  2,0 
		PrintStr str8		
		Getchar charget
	SetMode 12h
		shark2win
		PrintStr str2
		PrintStr strchg
		PrintStr str4
		PrintStr strchg
		PrintStr str5
	jmp IFTYPEERR
BLACK_WINRIGHTNOW:	
    SetMode 12h
		Setcolor background_color
		PrintChBoard colorline
		call SCAN_PRINTCHI
		PrintStr str1

		SET_CUR  2,0 		
		PrintStr str8
		Getchar charget
	SetMode 12h
		shark1win
		PrintStr str1
		PrintStr strchg
		PrintStr str4
		PrintStr strchg
		PrintStr str5
	jmp IFTYPEERR
QUIT:
    PrintChBoard colorline
	call SCAN_PRINTCHI
		PrintStr strchg
		PrintStr str4
		PrintStr strchg
		PrintStr str5
IFTYPEERR:		
	Getchar charget
	MOV AL,charget
	cmp al,1bh
    jE  START_SHOW
	cmp al,52h
	je Restart
	cmp al,72h
	je Restart
	jmp IFTYPEERR
RQUIT:
	MUS_HIND
    SetMode  03h
.exit

SCAN_PRINTCHI proc far                       ;;;;;SCAN&PRINT_CHI;;;;;;;; INTEGRAL KEEPDI,
     
    mov bx,0
	MOV KEEPDI,bx
	
	MOV CX,225
	MOV KEEPCX,CX
	LCHECK: 
	        xor ax,ax
			MOV bx,KEEPDI
			mov al,chi0[bx]
			mov KEEPDI,bx
			cmp ax,1
			je PRINTBLACK1
			cmp ax,2
			je PRINTWHITE1
			jmp ENDOK
			PRINTBLACK1:
			    call di2pixelXY               
				;;;change di-> x,y and -> 150+x*30,30+y*30 
				Printblack Y_inscan,X_inscan,COLORP1				
				JMP ENDOK
			PRINTWHITE1:
			    call di2pixelXY  
				Printblack  Y_inscan,X_inscan,COLORP2
				JMP ENDOK
		ENDOK:
		MOV bx,KEEPDI
		INC bx
		MOV KEEPDI,bx
	    MOV CX,KEEPCX
		DEC CX
		MOV KEEPCX,CX
		CMP CX,0
		JNE LCHECK
RET
SCAN_PRINTCHI ENDP

SCANIN proc near      ;didn't wait input
    mov ah,06h
	mov dl,0ffh
	int 21h
	ret
SCANIN endp

tran proc near        ;tran 2 ascii
    mov cx,0
Hex2Dec:
    inc cx
	mov bx,10
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jne Hex2Dec
Dec2Ascii:
    pop ax
	add al,30h
	mov [di+2],al
	inc di
	loop Dec2Ascii
	ret
tran endp

Delay proc near       ;DELAY time proc
        mov cx,0000h
    L1:
        mov bp,03a0h
    L2:
        dec bp
	    cmp bp,0
	    jnz L2
    loop L1
    ret
Delay endp
clear proc near       ;clear
    mov cx,3
L111:     
    mov al,' '
	mov [di+2],al
	inc di
	loop L111
	ret 
clear endp

checkEdge proc near  
    push cx
	push dx
	mov ax,470
	pop dx
	cmp dx,ax
	ja keeprow
OKROW:
	mov ax,630
	pop cx
	cmp cx,ax
	ja keepcol
	jmp check_left	
keeprow:
    mov dx,ax
	jmp OKROW
keepcol:
    mov cx,ax
	jmp byebye
check_left:
	mov ax,120
	cmp cx,ax
	jb  keepcol
	jmp byebye
byebye:
    ret
checkEdge endp

di2pixelXY PROC NEAR 
    xor dx,dx
    mov ax,KEEPDI
	mov cx,15
	DIV	cx
	mov Y_inscan,ax
	mov X_inscan,dx
RET
di2pixelXY endp

XY2CHI0 proc near
		            mov ax,15
	                mov bx,y_check
	                xor dx,dx
	                mul bx
	                add ax,x_check
	                mov XYtoChi0,ax   
RET
XY2CHI0 endp

CLEARchi0 proc near
    mov cx,225
	mov bx,0
	CCclearchi0:
		mov chi0[bx],0
		inc bx
		dec cx
		jne CCclearchi0
ret 
CLEARchi0 endp

CLEARCHECK_WHOWIN_FLAG proc near
	XOR AX,AX
	MOV COUNTER_BLACK,AX
	MOV COUNTER_WHITE,AX
	MOV ContinueFlag,AX
	MOV x_check,ax
	mov y_check,ax
    mov BLACK_WIN,AX
	MOV WHITE_WIN,AX
	mov KEEPXorY_check,AX
ret
CLEARCHECK_WHOWIN_FLAG endp

Check_Peace proc near
    mov cx,225
	mov bx,0
	mov countPeace,0
	Looppp:
	    mov al,chi0[bx]
		cmp al,1
		je addcountPeace
		cmp al,2
		je addcountPeace
		jmp okk
	addcountPeace:
	    inc countPeace
	okk:
	    inc bx
		loop Looppp
	cmp countPeace,225
    je Peace_NOoneWin	
ret
Check_Peace endp

Information proc near
		SET_CUR 0,0
	    PrintStr x_num
	    SET_CUR 1,0
	    PrintStr y_num
	    set_cur  2,0
		PrintStr row_num
	    set_cur  3,0
	    PrintStr column_num 
		set_cur  4,0
		mov bx,testput
		xor ax,ax
		mov al,chi0[bx]
		PrintCHAR ax
ret
Information endp
end