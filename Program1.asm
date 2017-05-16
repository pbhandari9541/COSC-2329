;Parameshor Bhandari
;Program: 1
;Title: Display the name 
;	
	org	100h
	section .data
msg1	DB	'Parameshor Bhandari $' 
exCode	DB	0
	section .text
start:	mov	dx, msg1	;get message1 
	mov	ah,09h		;display string function
	int	21h		;Display message1

exit:	mov	ah,4Ch		;DOS function: exit program 
	mov	al,[exCode]	;Return exit code value
	int	21h		;call DOS. Terminte Program
