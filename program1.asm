; Author: Jawad Alamgir
; Description: CS271 Program 1        
; Date: 07/03/2020
; Description:  This program gets two integers from the user,
; and calculates their sum, difference, product, quotient and remainder.
; Note: This program does not handle negative inputs or results

INCLUDE Irvine32.inc

.data

;intro
intro BYTE "My name is Jawad Alamgir and this is program1.asm",0 ; introduction for the program

;instructions
instructions BYTE "Enter 2 numbers and I will show you the product, sum, quotient, difference and remainder",0	;instructions for user
num1_prompt BYTE "Number1: ",0	;prompt to enter first number
num2_prompt BYTE "Number2: ",0	;prompt to enter second number

;Extra credit 1
temp DWORD ?	;Extra credit 1
pre_term_message BYTE "If you wish to enter more numbers enter 1 or any number greater otherwise press 0 to exit the program",0	; Extra credit 1

;extra credit 2
extra_credit_2_0 BYTE "It seems the first number you entered is greater than the second",0	;Extra credit 2  
extra_credit_2_1 BYTE "It seems the second number you entered is greater than the first",0	;Extra credit 2  
extra_credit_2_2 BYTE "It seems the numbers you have entered are equal to each other",0	;Extra credit 2 

;extra credit 3
extra_credit_3_0 BYTE "The quotient as a floating-point number, rounded to the nearest .001 is: ",0	;Extra credit 3
float_quot REAL4 ?	;Extra credit 3
thousandcounter DWORD 1000 ; setting up counter for the floating pointing division
storeFloatingpoint DWORD 0 ;store floating point number bigInt
floatremain DWORD ? ; store the remaing of floating point division floatremainder
dotvar BYTE ".", 0 ;assigning a dot to represent floating point
floattempvar1 DWORD ? ;first part
floattempvar2 DWORD ? ;second part
floattempvar3 DWORD ? ;temp

;user input
num1 DWORD ?	;First number
num2 DWORD ?	;second number

;sum
sum_result BYTE "Your sum  ",0 ; sum result message
sum DWORD ?		;variale to store sum
sum_resultop BYTE "+",0 ; addition sign
sum_resulteq BYTE "=",0 ;equals to sign

;division
div_result BYTE "Your quotient ",0	;division result message
quot DWORD ?	;variale to store quotient
div_resultop BYTE "/",0 

;difference
diff_result BYTE "Your difference ",0	; difference result message
diff DWORD ?	;variale to store difference
diff_resultop BYTE "-", 0

;remainder
rem_result BYTE " remainder ",0	;remainder result message
rem REAL4 ?		;variale to store remainder

;product
prod_result BYTE "Your product ",0	;product result message
prod REAL4 ?	;variale to store product
prod_resultop BYTE "*",0

;Terminating message 
term_message BYTE "Thank you for using my program I hope you have a great day",0	;terminating message





.code
main PROC


;display introduction of program
	mov edx,OFFSET intro
	call WriteString
	call Crlf

NOT_QUIT:
	mov edx,OFFSET instructions
	call WriteString
	call Crlf

;get input from user for number 1 and 2
	mov edx,OFFSET num1_prompt
	call WriteString
	call ReadInt
	mov num1, eax
	call Crlf
	mov edx,OFFSET num2_prompt
	call WriteString
	call ReadInt
	mov num2, eax
	call Crlf


;add num1 and num2
	add eax, num1
	mov sum, eax

;subtract num1 and num 2
	;mov eax, num2
	;sub eax, num1
	;mov diff,eax
	mov eax, num1
	sub eax, num2
	mov diff, eax	

;multiply num1 and num2
	mov eax, num1
	mov ebx, num2
	mul ebx
	mov prod, eax

;divide num1 and num2
	mov eax, num1
	mov ebx, num2
	div ebx
	mov quot, eax
	mov rem, edx

;quotient as a floating-point number, rounded to the nearest .001
	mov eax, num1
	div num2
	mov float_quot, 1000
	mul float_quot
	mov float_quot, eax

;Doing EC 3 floating point
	fld num1
	fdiv num2
	fimul thousandcounter
	fist storeFloatingpoint
	fst float_quot

;check if second number is greater than first
	mov eax,num1
	cmp eax,num2
	jg DP
	jl PDP
	jmp PRE_PAST

;display statement for extra credit 2 
DP:
	mov edx, OFFSET extra_credit_2_0
	call WriteString
	call Crlf
	call Crlf
	jmp PAST

PDP:
	mov edx, OFFSET extra_credit_2_1
	call WriteString
	call Crlf
	call Crlf
	jmp PAST

PRE_PAST:
	mov edx, OFFSET extra_credit_2_2
	call WriteString
	call Crlf
	call Crlf

PAST:

;display extra credit 3
	mov edx, OFFSET extra_credit_3_0
	call WriteString
	mov edx, 0
	mov eax, storeFloatingpoint
	cdq
	mov ebx, 1000
	cdq
	div ebx
	mov floattempvar1, eax
	mov floatremain, edx
	mov eax, floattempvar1
	call WriteDec
	mov edx, OFFSET dotvar
	call WriteString
	mov eax, floattempvar1
	mul thousandcounter
	mov floattempvar3, eax
	mov eax, storeFloatingpoint
	sub eax, floattempvar3
	mov floattempvar2, eax
	call WriteDec
	call Crlf
	call Crlf

;display sum
	mov edx, OFFSET sum_result
	call WriteString
	mov eax, num1
	call WriteDec
	mov edx, OFFSET sum_resultop
	call WriteString
	mov eax, num2
	call WriteDec
	mov edx, OFFSET sum_resulteq
	call WriteString
	mov eax, sum
	call WriteDec
	
	;call WriteDec
	call Crlf

;display difference
	mov edx,OFFSET diff_result
	call WriteString
	mov eax, num1
	call WriteDec
	mov edx, OFFSET diff_resultop
	call WriteString
	mov eax, num2
	call WriteDec
	mov edx, OFFSET sum_resulteq
	call WriteString
	mov eax, diff
	call WriteDec
	call Crlf

;display product
	mov edx,OFFSET prod_result
	call WriteString
	mov eax, num1
	call WriteDec
	mov edx, OFFSET prod_resultop
	call WriteString
	mov eax, num2
	call WriteDec
	mov edx, OFFSET sum_resulteq
	call WriteString
	mov eax, prod
	call WriteDec
	call Crlf

;display quotient and remiander
	mov edx, OFFSET div_result
	call WriteString
	mov eax, num1
	call WriteDec
	mov edx, OFFSET div_resultop
	call WriteString
	mov eax, num2
	call WriteDec
	mov edx, OFFSET sum_resulteq
	call WriteString
	mov eax, quot
	call WriteDec
	mov edx, OFFSET rem_result
	mov eax, rem
	call WriteString
	call WriteDec
	call Crlf

;display option to continue or quit
	mov edx, OFFSET pre_term_message
	call WriteString
	call Crlf

;take input from user for quitting or continuing
	call ReadInt
	mov temp, eax
	cmp eax, 0
	jg NOT_QUIT


;display terminating message
	mov edx, OFFSET term_message
	call WriteString
	call Crlf

;initialize accumulator and loop control
;mov eax,0 ;accumulator = 0
;mov ebx,a ;lower limit in ebx
;mov ecx,b ;calculate number of times to execute the loop
;sub ecx,a
;inc ecx ;loop count is b - a + 1
;add each integer in [a .. b] to the accumulator
top:
;add eax,ebx ;add current integer to accumulator
;inc ebx ;add 1 to current integer
;loop top ; repeat until ecx is 0

;save the result in sum
;mov sum,eax

;identify and display the result
;mov edx,OFFSET out1
;call WriteString ;"The summation of integers from "
;mov eax,a
;call WriteDec ;display a
;mov edx,OFFSET out2
;call WriteString ;" to "
;mov eax,b
;call WriteDec ;display b
;mov edx,OFFSET out3
;call WriteString ;" is "
;mov eax,sum
;call WriteDec ;display sum
;call Crlf
exit ;exit to operating system
main ENDP

END main

