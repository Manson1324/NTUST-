PrintChBoard macro colorboard
LOCAL Lcolout,Lcolin,Lrowout,Lrowin
	mov cx,15
	Lrowout:
	    push cx
		mov cx,420
		    Lrowin:
			    push cx
				
				mov dx,startrow
				mov cx,startcol
				WrPixel dx,cx,colorboard
				inc dx
				mov startrow,dx
				
				pop cx
			loop Lrowin	
		mov dx,rowMEM
		mov startrow,dx
		mov cx,startcol
		add cx,30
		mov startcol,cx
		pop cx
	loop Lrowout

	mov cx,colMEM
	mov startcol,cx
	mov dx,rowMEM
	mov startrow,dx
	
    mov dx,startrow
	mov cx,15
	Lcolout:
	    PUSH cx
		mov cx,420
		Lcolin:
			PUSH CX
			
			mov cx,startcol
			WrPixel dx,cx,colorboard
			inc cx
			mov startcol,CX
			
			POP CX
		loop Lcolin
		mov cx,colMEM
	    mov startcol,cx
		add dx,30
		POP cx
	loop Lcolout

endm