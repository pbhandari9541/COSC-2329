;Parameshor Bhandari
;Program: 2
;Title: Conversion of letter to uppercase and lowercase
;	
	org	100h
	section .data
msg1	DB	'Parameshor Bhandari $' 
msg2	DB	0Ah,0Dh,'Enter a letter to convert: $'
msg3	DB	0Ah,0Dh,'The converted character is: $'
CHAR	DB	' ','$'
exCode	DB	0
	section .text
start:	mov	dx, msg1	;get message1 
	mov	ah,09h		;display string function
	int	21h		;Display message1
	mov	ah,09h		;display string function
	mov	dx, msg2	;get message2
	int	21h		;Display message2
;read a character	
	mov	ah,1h		;read char fcn
	int	21h		;read it into al
;if
	cmp	al,41h		;compare al> 'A'
	jl	exit		;Jump to exit if less than"A"
	cmp	al,5Ah		;Compare al>'Z'
	jle	then		; jump if less or eual to 'Z'
	cmp	al,61h		;compare al>'a'
	jl	exit		;jump exit if less
	cmp	al,7Ah		;compare al>'z'
	jle	else		;jump if less or equal'z'
then:	add	al,20h		; subtract 32 from al register 
	mov	[CHAR],al	; transfer content of al to CHAR memory location
	jmp	endif		; jump to endif
else:	sub	al,20h		; add 32 to the al register
	mov	[CHAR],al	; transfer content of al to CHAR memory location
	jmp	endif		;jump to endif
endif:	mov	ah,09h		;display string function
	mov	dx, msg3	;get message3
	int	21h		;Display message3
	mov	ah,2		;display char fcn
	mov	dl,[CHAR]
	int	21h		;display it
exit:	mov	ah,4Ch		;DOS function: exit program 
	mov	al,[exCode]	;Return exit code value
	int	21h		;call DOS. Terminte Program
