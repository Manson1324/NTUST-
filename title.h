Print5son macro
local finish,print,do_print,do_print2,adjust,nextline,no_print
	mov cx,80
	mov dx,0
	mov bx,0
	mov colorT,0Bh
print:
	cmp  five[bx],1
	push bx
	je   do_print
	jmp  no_print
do_print:
	mov  dx,fiverow
	mov  cx,fivecol
	WrPixel dx,cx,colorT
	inc cx
	mov fivecol,cx
	inc coltime
	cmp coltime,10
	jb  do_print
	je do_print2
do_print2:
	mov  coltime,0
	mov dx,fiverow
	inc dx
	mov fiverow,dx
	
	mov cx,fivecol
	sub cx,10
	mov fivecol,cx
	inc rowtime
	cmp rowtime,10
	jb  do_print
	je  adjust
adjust:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,fiverow
	sub dx,10
	mov fiverow,dx
	
	mov cx,fivecol
	add cx,10
	mov fivecol,cx
	mov colorT,0Bh
	inc linetime
	cmp linetime,48
	jb  print
	jmp nextline
nextline:
	mov linetime,0
	mov dx,fiverow
	add dx,10
	mov fiverow,dx
	mov cx,80
	mov fivecol,cx
	mov colorT,0Bh
	cmp bx,767
	jb  print
	jmp finish
no_print:
	mov colorT,00h
	jmp do_print
finish:
    mov fiverow,0
	mov fivecol,80
endm
printplay macro 
local play1,do_play,do_play2,adjustplay,finishplay,no_play,nextlineplay
	mov cx,100
	mov dx,205
	mov bx,0
	mov colorT,04h
play1:
	cmp  play[bx],1
	push bx
	je   do_play
	jmp  no_play
do_play:
	mov  dx,playrow
	mov  cx,playcol
	WrPixel dx,cx,colorT
	inc cx
	mov playcol,cx
	inc coltime
	cmp coltime,3
	jb  do_play
	je  do_play2
do_play2:
	mov  coltime,0
	mov dx,playrow
	inc dx
	mov playrow,dx
	
	mov cx,playcol
	sub cx,3
	mov playcol,cx
	inc rowtime
	cmp rowtime,3
	jb  do_play
	je  adjustplay
adjustplay:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,playrow
	sub dx,3
	mov playrow,dx
	
	mov cx,playcol
	add cx,3
	mov playcol,cx
	mov colorT,04h
	inc linetime
	cmp linetime,60
	jb  play1
	jmp nextlineplay
nextlineplay:
	mov linetime,0
	mov dx,playrow
	add dx,3
	mov playrow,dx
	mov cx,100
	mov playcol,cx
	mov colorT,04h
	cmp bx,899
	jb  play1
	jmp finishplay
no_play:
	mov colorT,00h
	jmp do_play
finishplay:
	mov  playrow,205
	mov  playcol,100
endm
printexit macro 
local exit1,do_exit,do_exit2,adjustexit,finishexit,no_exit,nextlineexit
	mov cx,100
	mov dx,300
	mov bx,0
	mov colorT,04h
exit1:
	cmp  exit[bx],1
	push bx
	je   do_exit
	jmp  no_exit
do_exit:
	mov  dx,exitrow
	mov  cx,exitcol
	WrPixel dx,cx,colorT
	inc cx
	mov exitcol,cx
	inc coltime
	cmp coltime,3
	jb  do_exit
	je  do_exit2
do_exit2:
	mov  coltime,0
	mov dx,exitrow
	inc dx
	mov exitrow,dx
	
	mov cx,exitcol
	sub cx,3
	mov exitcol,cx
	inc rowtime
	cmp rowtime,3
	jb  do_exit
	je  adjustexit
adjustexit:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,exitrow
	sub dx,3
	mov exitrow,dx
	
	mov cx,exitcol
	add cx,3
	mov exitcol,cx
	mov colorT,04h
	inc linetime
	cmp linetime,60
	jb  exit1
	jmp nextlineexit
nextlineexit:
	mov linetime,0
	mov dx,exitrow
	add dx,3
	mov exitrow,dx
	mov cx,100
	mov exitcol,cx
	mov colorT,04h
	cmp bx,899
	jb  exit1
	jmp finishexit
no_exit:
	mov colorT,00h
	jmp do_exit
finishexit:
	mov  exitcol,100
	mov  exitrow,300
endm
printshark1 macro 
local print,do_print,do_print2,adjust,nextline,white,red,light_red,printblue,printbrown,no_print,finish
	mov bx,0
	mov colorT,00h
print:
	push bx
	cmp  shark1[bx],1
	je   printblue
	cmp  shark1[bx],6
	je   printbrown
	cmp  shark1[bx],12
	je   light_red
	cmp  shark1[bx],4
	je   red
	cmp  shark1[bx],15
	je   white
	cmp  shark1[bx],0
	je   no_print
do_print:
	mov  dx,sharkrow
	mov  cx,sharkcol
	WrPixel dx,cx,colorT
	inc cx
	mov sharkcol,cx
	inc coltime
	cmp coltime,2
	jb  do_print
	je  do_print2
do_print2:
	mov coltime,0
	mov dx,sharkrow
	inc dx
	mov sharkrow,dx
	
	mov cx,sharkcol
	sub cx,2
	mov sharkcol,cx
	inc rowtime
	cmp rowtime,2
	jb  do_print
	je  adjust
adjust:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,sharkrow
	sub dx,2
	mov sharkrow,dx
	
	mov cx,sharkcol
	add cx,2
	mov sharkcol,cx
	mov colorT,00h
	inc linetime
	cmp linetime,50
	jb  print
	jmp nextline
nextline:
	mov linetime,0
	mov dx,sharkrow
	add dx,2
	mov sharkrow,dx
	mov cx,20
	mov sharkcol,cx
	mov colorT,00h
	cmp bx,2599
	jb  print
	jmp finish
white:
	mov colorT,06h
	jmp do_print
printblue:
	mov colorT,08h
	jmp do_print
printbrown:
	mov colorT,06h
	jmp do_print
light_red:
	mov colorT,12
	jmp do_print
red:
	mov colorT,04h
	jmp do_print
no_print:
	mov colorT,00h
	jmp do_print
finish:
	mov  sharkcol,20
	mov  sharkrow,90
	mov coltime,0
	mov rowtime,0
	endm
printshark2 macro 
local print,do_print,do_print2,adjust,nextline,white,red,light_red,printblue,printbrown,no_print,finish
	mov bx,0
	mov colorT,00h
print:
	push bx
	cmp  shark1[bx],1
	je   printblue
	cmp  shark1[bx],6
	je   printbrown
	cmp  shark1[bx],12
	je   light_red
	cmp  shark1[bx],4
	je   red
	cmp  shark1[bx],15
	je   white
	cmp  shark1[bx],0
	je   no_print
do_print:
	mov  dx,sharkrow2
	mov  cx,sharkcol2
	WrPixel dx,cx,colorT
	inc cx
	mov sharkcol2,cx
	inc coltime
	cmp coltime,2
	jb  do_print
	je  do_print2
do_print2:
	mov  coltime,0
	mov dx,sharkrow2
	inc dx
	mov sharkrow2,dx
	
	mov cx,sharkcol2
	sub cx,2
	mov sharkcol2,cx
	inc rowtime
	cmp rowtime,2
	jb  do_print
	je  adjust
adjust:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,sharkrow2
	sub dx,2
	mov sharkrow2,dx
	
	mov cx,sharkcol2
	add cx,2
	mov sharkcol2,cx
	mov colorT,00h
	inc linetime
	cmp linetime,50
	jb  print
	jmp nextline
nextline:
	mov linetime,0
	mov dx,sharkrow2
	add dx,2
	mov sharkrow2,dx
	mov cx,20
	mov sharkcol2,cx
	mov colorT,00h
	cmp bx,2599
	jb  print
	jmp finish
white:
	mov colorT,0fh
	jmp do_print
printblue:
	mov colorT,08h
	jmp do_print
printbrown:
	mov colorT,0fh
	jmp do_print
light_red:
	mov colorT,12
	jmp do_print
red:
	mov colorT,04h
	jmp do_print
no_print:
	mov colorT,00h
	jmp do_print
finish:
	mov  sharkcol2,20
	mov  sharkrow2,270
	mov coltime,0
	mov rowtime,0
	endm
printturnblack macro 
local play1,do_play,do_play2,adjustplay,finishplay,no_play,nextlineplay
	mov cx,0
	mov dx,200
	mov bx,0
	mov colorT,06h
play1:
	cmp  turn[bx],1
	push bx
	je   do_play
	jmp  no_play
do_play:
	mov  dx,turnrow
	mov  cx,turncol
	WrPixel dx,cx,colorT
	inc cx
	mov turncol,cx
	inc coltime
	cmp coltime,2
	jb  do_play
	je  do_play2
do_play2:
	mov  coltime,0
	mov dx,turnrow
	inc dx
	mov turnrow,dx
	
	mov cx,turncol
	sub cx,2
	mov turncol,cx
	inc rowtime
	cmp rowtime,2
	jb  do_play
	je  adjustplay
adjustplay:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,turnrow
	sub dx,2
	mov turnrow,dx
	
	mov cx,turncol
	add cx,2
	mov turncol,cx
	mov colorT,06h
	inc linetime
	cmp linetime,58
	jb  play1
	jmp nextlineplay
nextlineplay:
	mov linetime,0
	mov dx,turnrow
	add dx,2
	mov turnrow,dx
	mov cx,0
	mov turncol,cx
	mov colorT,06h
	cmp bx,811
	jb  play1
	jmp finishplay
no_play:
	mov colorT,00h
	jmp do_play
finishplay:
	mov  turnrow,190
	mov  turncol,0
	mov coltime,0
	mov rowtime,0
endm
printturnoffB macro 
local play1,do_play,do_play2,adjustplay,finishplay,no_play,nextlineplay
	mov cx,0
	mov dx,200
	mov bx,0
	mov colorT,00h
play1:
	cmp  turn[bx],1
	push bx
	je   do_play
	jmp  no_play
do_play:
	mov  dx,turnrow
	mov  cx,turncol
	WrPixel dx,cx,colorT
	inc cx
	mov turncol,cx
	inc coltime
	cmp coltime,2
	jb  do_play
	je  do_play2
do_play2:
	mov  coltime,0
	mov dx,turnrow
	inc dx
	mov turnrow,dx
	
	mov cx,turncol
	sub cx,2
	mov turncol,cx
	inc rowtime
	cmp rowtime,2
	jb  do_play
	je  adjustplay
adjustplay:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,turnrow
	sub dx,2
	mov turnrow,dx
	
	mov cx,turncol
	add cx,2
	mov turncol,cx
	mov colorT,00h
	inc linetime
	cmp linetime,58
	jb  play1
	jmp nextlineplay
nextlineplay:
	mov linetime,0
	mov dx,turnrow
	add dx,2
	mov turnrow,dx
	mov cx,0
	mov turncol,cx
	mov colorT,00h
	cmp bx,811
	jb  play1
	jmp finishplay
no_play:
	mov colorT,00h
	jmp do_play
finishplay:
	mov  turnrow,190
	mov  turncol,0
	mov coltime,0
	mov rowtime,0
endm
printturnwhite macro 
local play1,do_play,do_play2,adjustplay,finishplay,no_play,nextlineplay
	mov cx,0
	mov dx,380
	mov bx,0
	mov colorT,0fh
play1:
	cmp  turn[bx],1
	push bx
	je   do_play
	jmp  no_play
do_play:
	mov  dx,turnrow2
	mov  cx,turncol2
	WrPixel dx,cx,colorT
	inc cx
	mov turncol2,cx
	inc coltime
	cmp coltime,2
	jb  do_play
	je  do_play2
do_play2:
	mov  coltime,0
	mov dx,turnrow2
	inc dx
	mov turnrow2,dx
	
	mov cx,turncol2
	sub cx,2
	mov turncol2,cx
	inc rowtime
	cmp rowtime,2
	jb  do_play
	je  adjustplay
adjustplay:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,turnrow2
	sub dx,2
	mov turnrow2,dx
	
	mov cx,turncol2
	add cx,2
	mov turncol2,cx
	mov colorT,0fh
	inc linetime
	cmp linetime,58
	jb  play1
	jmp nextlineplay
nextlineplay:
	mov linetime,0
	mov dx,turnrow2
	add dx,2
	mov turnrow2,dx
	mov cx,0
	mov turncol2,cx
	mov colorT,0fh
	cmp bx,811
	jb  play1
	jmp finishplay
no_play:
	mov colorT,00h
	jmp do_play
finishplay:
	mov  turnrow2,380
	mov  turncol2,0
	mov coltime,0
	mov rowtime,0
endm
printturnoffW macro 
local play1,do_play,do_play2,adjustplay,finishplay,no_play,nextlineplay
	mov cx,0
	mov dx,380
	mov bx,0
	mov colorT,00h
play1:
	cmp  turn[bx],1
	push bx
	je   do_play
	jmp  no_play
do_play:
	mov  dx,turnrow2
	mov  cx,turncol2
	WrPixel dx,cx,colorT
	inc cx
	mov turncol2,cx
	inc coltime
	cmp coltime,2
	jb  do_play
	je  do_play2
do_play2:
	mov  coltime,0
	mov dx,turnrow2
	inc dx
	mov turnrow2,dx
	
	mov cx,turncol2
	sub cx,2
	mov turncol2,cx
	inc rowtime
	cmp rowtime,2
	jb  do_play
	je  adjustplay
adjustplay:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,turnrow2
	sub dx,2
	mov turnrow2,dx
	
	mov cx,turncol2
	add cx,2
	mov turncol2,cx
	mov colorT,00h
	inc linetime
	cmp linetime,58
	jb  play1
	jmp nextlineplay
nextlineplay:
	mov linetime,0
	mov dx,turnrow2
	add dx,2
	mov turnrow2,dx
	mov cx,0
	mov turncol2,cx
	mov colorT,00h
	cmp bx,811
	jb  play1
	jmp finishplay
no_play:
	mov colorT,00h
	jmp do_play
finishplay:
	mov  turnrow2,380
	mov  turncol2,0
	mov coltime,0
	mov rowtime,0
endm
shark1win macro 
local print,do_print,do_print2,adjust,nextline,white,red,light_red,printblue,printbrown,no_print,finish
	mov bx,0
	mov colorT,00h
print:
	push bx
	cmp  shark1[bx],1
	je   printblue
	cmp  shark1[bx],6
	je   printbrown
	cmp  shark1[bx],12
	je   light_red
	cmp  shark1[bx],4
	je   red
	cmp  shark1[bx],15
	je   white
	cmp  shark1[bx],0
	je   no_print
do_print:
	mov  dx,winrow
	mov  cx,wincol
	WrPixel dx,cx,colorT
	inc cx
	mov wincol,cx
	inc coltime
	cmp coltime,5
	jb  do_print
	je do_print2
do_print2:
	mov  coltime,0
	mov dx,winrow
	inc dx
	mov winrow,dx
	
	mov cx,wincol
	sub cx,5
	mov wincol,cx
	inc rowtime
	cmp rowtime,5
	jb  do_print
	je  adjust
adjust:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,winrow
	sub dx,5
	mov winrow,dx
	
	mov cx,wincol
	add cx,5
	mov wincol,cx
	mov colorT,00h
	inc linetime
	cmp linetime,50
	jb  print
	jmp nextline
nextline:
	mov linetime,0
	mov dx,winrow
	add dx,5
	mov winrow,dx
	mov cx,170
	mov wincol,cx
	mov colorT,00h
	cmp bx,2599
	jb  print
	jmp finish
white:
	mov colorT,06h
	jmp do_print
printblue:
	mov colorT,08h
	jmp do_print
printbrown:
	mov colorT,06h
	jmp do_print
light_red:
	mov colorT,12
	jmp do_print
red:
	mov colorT,04h
	jmp do_print
no_print:
	mov colorT,00h
	jmp do_print
finish:
	mov  wincol,170
	mov  winrow,84
	mov coltime,0
	mov rowtime,0
	endm
shark2win macro 
local print,do_print,do_print2,adjust,nextline,white,red,light_red,printblue,printbrown,no_print,finish
	mov bx,0
	mov colorT,00h
print:
	push bx
	cmp  shark1[bx],1
	je   printblue
	cmp  shark1[bx],6
	je   printbrown
	cmp  shark1[bx],12
	je   light_red
	cmp  shark1[bx],4
	je   red
	cmp  shark1[bx],15
	je   white
	cmp  shark1[bx],0
	je   no_print
do_print:
	mov  dx,winrow
	mov  cx,wincol
	WrPixel dx,cx,colorT
	inc cx
	mov wincol,cx
	inc coltime
	cmp coltime,5
	jb  do_print
	je do_print2
do_print2:
	mov  coltime,0
	mov dx,winrow
	inc dx
	mov winrow,dx
	
	mov cx,wincol
	sub cx,5
	mov wincol,cx
	inc rowtime
	cmp rowtime,5
	jb  do_print
	je  adjust
adjust:
	mov coltime,0
	mov rowtime,0
    pop bx
	inc bx

	mov dx,winrow
	sub dx,5
	mov winrow,dx
	
	mov cx,wincol
	add cx,5
	mov wincol,cx
	mov colorT,00h
	inc linetime
	cmp linetime,50
	jb  print
	jmp nextline
nextline:
	mov linetime,0
	mov dx,winrow
	add dx,5
	mov winrow,dx
	mov cx,170
	mov wincol,cx
	mov colorT,00h
	cmp bx,2599
	jb  print
	jmp finish
white:
	mov colorT,0fh
	jmp do_print
printblue:
	mov colorT,08h
	jmp do_print
printbrown:
	mov colorT,0fh
	jmp do_print
light_red:
	mov colorT,12
	jmp do_print
red:
	mov colorT,04h
	jmp do_print
no_print:
	mov colorT,00h
	jmp do_print
finish:
	mov  wincol,170
	mov  winrow,84
	mov coltime,0
	mov rowtime,0
	endm