;Parameshor Bhandari
;Program: 5
;Title: String Processing Lab
;	
	org	100h
section .data
msg1	DB	'Parameshor Bhandari $' 
msg2	DB	0Ah,0Dh,'Enter the string(Maximum 75 character): $'
msg3	DB	0Ah,0Dh,'The character in reverse is: $'
exCode	DB	0
;section .bss
MAX_LEN	DB	3
ACT_LEN	DB	0
chars	TIMES	4	DB	0
section .text
start:	mov	dx, msg1	;get message1 
	mov	ah,09h		;display string function
	int	21h		;Display message1
	mov	ah,09h		;display string function
	mov	dx, msg2	;get message2 
	mov	ah,09h		;display string function
	int	21h		;Display message2

	mov	di,chars	
	
	cld                     ;process from left 
	xor     bx,bx           ;BX holds no. of chars read
	mov     ah,1            ;input char function
	int     21h             ;read a char into AL
WHILE1:	cmp     al,0Dh          ;<CR>? 
	je      ENDWHLE1	;yes, exit
;if char is backspace
	cmp     al,08h          ;is char a backspace? 
	jne     ELSE1           ;no, store in string
	dec     di              ;yes, move string ptr back
	dec     bx              ;decrement char counter
	jmp     READ            ;and go to read another char
ELSE1:	stosb                   ;store char in string
	inc     bx              ;increment char count
READ:	int     21h             ;read a char into AL
	jmp     WHILE1          ;and continue loop
ENDWHLE1:
	lea	si,[bx+chars-1]	;start of string
	std                     ;process from left 
	mov     cx,bx       	;cx holds no. of chars
	jcxz    exit        	;exit if none
	mov	dx, msg3	;get message3
	mov	ah,09h		;display string function
	int	21h
	mov     ah,2            ;display char function
TOP:
	lodsb                   ;char in al
	mov     dl,al           ;move it to dl
	int     21h             ;display character
	loop    TOP             ;loop until done
exit:	mov	ah,4Ch		;DOS function: exit program 
	mov	al,[exCode]	;Return exit code value
	int	21h		;call DOS. Terminte Program