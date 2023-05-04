PrintCircle macro x_column,y_row,radius,color_cir  
local  circlein,circleout,okok100
local  next2,next3,next4,next5,next6,next7,next8,next9,next10,next11,next12,next13,next14,next15,next16,next17,next18,next19,next20,next21,next22,next23,next24,next25
local  upcircle_1,upcircle_2,upcircle_3,upcircle_4,upcircle_5,upcircle_6,upcircle_7,upcircle_8,upcircle_9,upcircle_10,upcircle_11,upcircle_12,upcircle_13
local  upcircle_14,upcircle_15,upcircle_16,upcircle_17,upcircle_18,upcircle_19,upcircle_20,upcircle_21,upcircle_22,upcircle_23,upcircle_24,upcircle_25
	mov dx,y_row
	sub dx,12
	mov y_row,dx
	mov cx,x_column
	sub cx,3
	mov x_column,cx
	mov timecircle,7
upcircle_1:   
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_1
	jmp next2
next2:
	mov cx,x_column
    sub cx,9
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,11
upcircle_2: 
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_2
	jmp next3
next3:
	mov cx,x_column
    sub cx,13
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,15
upcircle_3:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_3
	jmp next4
next4:
	mov cx,x_column
    sub cx,16
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,17
upcircle_4:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_4
	jmp next5
next5:
	mov cx,x_column
    sub cx,18
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,19
upcircle_5:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_5
	jmp next6
next6:
	mov cx,x_column
    sub cx,20
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,21
upcircle_6:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_6
	jmp next7
next7:
	mov cx,x_column
    sub cx,21
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,21
upcircle_7:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_7
	jmp next8
next8:
	mov cx,x_column
    sub cx,22
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,23
upcircle_8:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_8
	jmp next9
next9:
	mov cx,x_column
    sub cx,23
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,23
upcircle_9:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_9
	jmp next10
next10:
	mov cx,x_column
    sub cx,24
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_10:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_10
	jmp next11
next11:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_11:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_11
	jmp next12
next12:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_12:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_12
	jmp next13
next13:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_13:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_13
	jmp next14
next14:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_14:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_14
	jmp next15
next15:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_15:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_15
	jmp next16
next16:
	mov cx,x_column
    sub cx,25
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,25
upcircle_16:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_16
	jmp next17
next17:
	mov cx,x_column
    sub cx,24
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,23
upcircle_17:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_17
	jmp next18
next18:
	mov cx,x_column
    sub cx,23
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,23
upcircle_18:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_18
	jmp next19
next19:
	mov cx,x_column
    sub cx,22
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,21
upcircle_19:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_19
	jmp next20
next20:
mov cx,x_column
    sub cx,21
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,21
upcircle_20:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_20
	jmp next21
next21:
mov cx,x_column
    sub cx,20
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,19
upcircle_21:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_21
	jmp next22
next22:
	mov cx,x_column
    sub cx,18
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,17
upcircle_22:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_22
	jmp next23
next23:
	mov cx,x_column
    sub cx,16
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,15
upcircle_23:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_23
	jmp next24
next24:
	mov cx,x_column
    sub cx,13
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,11
upcircle_24:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_24
	jmp next25
next25:
	mov cx,x_column
    sub cx,9
	mov x_column,cx
	inc dx
	mov y_row,dx
	mov timecircle,7
upcircle_25:
	WrPixel y_row,x_column,color_cir
	inc x_column
	dec timecircle
	cmp timecircle,0
	ja  upcircle_25
	jmp okok100
okok100:
	mov timecircle,0
endm