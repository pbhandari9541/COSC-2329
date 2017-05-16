;Parameshor Bhandari
;Program: 3
;Title: Conversion of octal to binary and base 4
	org	100h
	section .data
msg1	DB	0Ah,0Dh,'Parameshor Bhandari $' 
msg2	DB	0Ah,0Dh,'Enter an octal number onvert: $'
msg3	DB	0Ah,0Dh,'The converted character in binary is: $'
msg4	DB	0Ah,0Dh,'The converted character in Base4 is: $'
msg5	DB	0Ah,0Dh,'press 1 to continue:'
CHAR	DB	' ','$'
exCode	DB	0
	section .text
start:	mov	dx, msg1	;get message1 
	mov	ah,09h		;display string function
	int	21h		;Display message1
	mov	ah,09h		;display string function
	mov	dx, msg2	;get message2
	int	21h		;Display message2
	
; input base octal value	
	xor 	bx,bx		; bx holds input value
	mov	ah,1		; input char function
	int	21h		; read char into al
top1:				; while (char != CR)
	cmp	al,0Dh		; is char = CR?
	je	out1		; yes?  finished with input
	je	out2
	push	ax
	mov	ax,8		; set up to multiply bx by 8
	mul	bx		; dx:ax = bx*8
	mov	bx,ax			
	pop	ax
	
	and	ax,0Fh		; convert from ASCII to base 10 value
	add	bx,ax		; bx = old bx*8 + new digit 
        mov	ah,1		; input char function
	int	21h		; read next character
	jmp	top1		; loop until done

; restore the register
	pop	ax	
	pop	bx
	ret
	
; now, output it in binary	
out1:
	mov	ah,9		; print binary output label
	mov	dx,msg3
	int 	21h		
; for 16 times do this:
	mov	cx, 16		; loop counter
top2:	rol	bx,1		; rotate msb into CF
	jc	one		; CF = 1?
	mov	dl,'0'		; no, set up to print a 0
	jmp	print		; now print
one:	mov	dl,'1'		; printing a 1
print:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top2		; loop until done
	
;now, output it on base 4

out2:
	mov	ah,9		; print octal output label
	mov	dx,msg4
	int 	21h
; for 8 times do this:
	mov	cx, 8		; loop counter
top3:	rol	bx,2		; rotate top nybble into the bottom
	mov	dl,bl		; put a copy in dl
	and	dl,00000011b	; we only want the lower 2 bits
	cmp	dl,3		; is it in [0-3]?
	
	or	dl,30h		; convert 0-3 to '0'-'3'
	jmp	print2		; now print
 
print2:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top3		; loop until done

finish:	mov	ah,9		;user ask message
	mov	dx,msg5
	int 	21h
	mov	ah,1		; input char function
	int	21h		; read char into al
	cmp	al,031h		;compare if user input 1
	je	start		;jump start if user enter 1
	jne	exit		;else exit
exit:	mov	ah,4Ch		;DOS function: exit program 
	mov	al,[exCode]	;Return exit code value
	int	21h		;call DOS. Terminte Program
