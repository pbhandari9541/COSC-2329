	org	100h


start:  xor ah,ah 	;select display mode
    	mov al,3 	;80x25 color text mode
	int 10h
	
	
	 mov     ax,0B800h  ;color active display page
	 mov     es,ax       
	 mov     cx,2000    ;80*25 = 2000 words
	 mov     di,0       ;initialize DI
	 mov     ax,1E41h   ;yellow A on blue
;fill active display page
	
	 rep stosw
	
;clear window to red
	mov ah,6 	;scroll up function
	mov cx,0h	;upper left corner (1Ah,08h) (26,8)
	mov dx,1034h 	;lower right corner (34h,10h)(52,16)
	mov cx,2000
	
	mov di,0 	;initialize DI
	mov ax,00010000 	;yellow A on blue
;fill active display page
fillbuf:
	mov [di],ax 	;char in al, attribute in ah
	add di, 2 	;go to next word
	loop fillbuf
	mov al,1 	;scroll all lines
	

Exit:
	mov ah,04Ch 	;DOS function: Exit program
	mov al,0	;Return exit code value
	int 21h 	;Call DOS. Terminate program
			;END StartEnd of program / entry point