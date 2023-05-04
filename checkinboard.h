check_1 macro rownow,columnnow 
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