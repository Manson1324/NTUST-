frame macro mousex,mousey,mousecir 
local left_up1,left_up2,left_down1,left_down2,right_up1,right_up2,right_down1,right_down2
local next_1,next_2,next_3,L100,L200,L300,L400,finish00
	mov dx,mousey
	sub dx,12
	mov mousey,dx
	mov cx,mousex
	sub cx,2
	mov mousex,cx
	mov mousecircle,10
left_up1:	
	WrPixel mousey,mousex,mousecir 
	dec mousex
	dec mousecircle
	cmp mousecircle,0
	ja  left_up1
	jmp L100
L100:
	mov mousecircle,9
left_up2:
	inc mousey
	WrPixel mousey,mousex,mousecir 
	dec mousecircle
	cmp mousecircle,0
	ja  left_up2
	jmp next_1
next_1:
	mov dx,mousey
	add dx,5
	mov mousey,dx
	mov mousecircle,10
left_down1:
	WrPixel mousey,mousex,mousecir 
	inc mousey
	dec mousecircle
	cmp mousecircle,0
	ja  left_down1
	jmp L200
L200:
	mov mousecircle,9
left_down2:
	inc mousex
	WrPixel mousey,mousex,mousecir 
	dec mousecircle
	cmp mousecircle,0
	ja  left_down2
	jmp next_2
next_2:
	mov cx,mousex
	add cx,5
	mov mousex,cx
	mov mousecircle,10
right_down1:
	WrPixel mousey,mousex,mousecir 	
	inc mousex
	dec mousecircle
	cmp mousecircle,0
	ja  right_down1
	jmp L300
L300:
	mov mousecircle,9
right_down2:
	dec mousey
	WrPixel mousey,mousex,mousecir 
	dec mousecircle
	cmp mousecircle,0
	ja  right_down2
	jmp next_3
next_3:
	mov dx,mousey
	sub dx,5
	mov mousey,dx
	mov mousecircle,10
right_up1:
	WrPixel mousey,mousex,mousecir 
	dec mousey
	dec mousecircle
	cmp mousecircle,0
	ja  right_up1
	jmp L400
L400:
	mov mousecircle,9
right_up2:
	dec mousex
	WrPixel mousey,mousex,mousecir 
	dec mousecircle
	cmp mousecircle,0
	ja  right_up2
	jmp finish00
finish00:
	mov mousecircle,0
endm

mouseinprint macro y2,x2
local checkleft,cmpy,Do_Print,Adjustx1,Adjusty1,Second1,frameit,finish
local clearandframe,Adjustx11,Adjusty11,Second11
checkleft:
	push y2
	push x2
	mov cx,justx
	mov bx,x2
	cmp cx,bx
	je  cmpy
	jmp Do_Print
cmpy:
	mov cx,justy
	mov bx,y2
	cmp cx,bx
	je  finish
	jmp Do_Print
Do_Print:
	mov cx,x2
	mov ax,initial_x
Adjustx1:
	add ax,30
	dec cx
	mov iamcolumn,ax
	cmp cx,0
	ja  Adjustx1
	jmp Second1
Second1:
	mov cx,y2
	mov ax,initial_y
Adjusty1:
	add ax,30
	dec cx
	mov iamrow,ax
	cmp cx,0
	ja Adjusty1
	jmp clearandframe
	
clearandframe:
	mov cx,justx
	mov ax,initial_x
Adjustx11:
	add ax,30
	dec cx
	mov justx,ax
	cmp cx,0
	ja  Adjustx11
	jmp Second11
Second11:
	mov cx,justy
	mov ax,initial_y
Adjusty11:
	add ax,30
	dec cx
	mov justy,ax
	cmp cx,0
	ja Adjusty11
	frame  justx,justy,00H
frameit:
    frame  iamcolumn,iamrow,04H	
	jmp finish
finish: 
	pop justx
	pop justy
endm
iamin macro inrow,incolumn 
	
	mov dx,inrow
	sub dx,15
	mov ax,dx
	xor dx,dx
	mov bx,30
	div bx
	mov iamrow,ax

	mov cx,incolumn
	sub cx,135
	mov ax,cx
	xor dx,dx
	mov bx,30
	div bx
	mov iamcolumn,ax
endm
check_2 macro rownow,columnnow 
local cx10,cx20,dx10,dx20,checkok000,valid000,invalid000
cx10:
	mov dx,rownow
	mov cx,columnnow
	cmp cx,135
	ja  cx20
	jmp invalid000
cx20:
	cmp cx,585
	jb  dx10
	jmp invalid000
dx10:
	cmp dx,15
	ja  dx20
	jmp invalid000
dx20:	
	cmp dx,465
	jb  valid000
	jmp invalid000
valid000:
	mov mouseinboard,1
	jmp checkok000
invalid000:
	mov mouseinboard,0
checkok000:
endm