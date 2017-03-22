;****************************************************************************************************
; Program File:	MASM2.asm
; Program Name:	MASM2
;****************************************************************************************************
; Programmer: 		Jason Kahn
; Class:			CS3B 
; Creation Date: 	3/1/2017
; Purpose:
;		Input numeric information from the keyboard, perform addition, subtraction,
;			multiplication, and division. Check for overflow upon all operations  
;			
;****************************************************************************************************
	.486
	.model flat, stdcall
	option casemap :none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

	ExitProcess PROTO Near32 stdcall, dwExitCode:dword  				;capitalization not necessary
	ascint32  	PROTO  stdcall, lpStringToConvert:dword					;Converts ascii char to integer
	intasc32	PROTO Near32 stdcall, lpStringToHold:dword, dVal:dword	;Converts integer to ascii 
	putstring	PROTO Near32 stdcall, lpStringToPrint:dword				;Outputs string to screen 
	getche		PROTO Near32 stdcall  									;returns character in the AL register & echos to screen 
 	getch		PROTO Near32 stdcall  									;returns character in the AL register
	putch		PROTO Near32 stdcall, bChar:byte						;Outputs character to screen 	



  .data
	;Output and prompt strings 
strHeader			BYTE 13,10,9," Name: Jason Kahn",13,10 					
					BYTE 9,"Class: CS3B",13,10
					BYTE 9,"  Lab: MASM2",13,10
					BYTE 9," Date: 3/6/2017",0
strExitPrompt		BYTE 13,10,9, "Thanks for using my program!! Good Day!",0
strFirstNumPrompt 	BYTE 13,10,"Enter your first number:  ",0
strSecondNumPrompt 	BYTE 13,10,"Enter your second number: ",0
strSumPrompt		BYTE 13,10,"The sum is ",0
strProductPrompt 	BYTE 13,10,"The product is ",0
strQuotientPrompt	BYTE 13,10,"The quotient is ",0
strDifferencePrompt	BYTE 13,10,"The difference is ",0
strRemainderPrompt	BYTE 13,10,"The remainder is ",0
strOverflowConv		BYTE 13,10,"OVERFLOW OCCURRED. RE-ENTER VALUE",0
strDivideZero		BYTE 13,10,"You cannot divide by 0. Thus, there is NO quotient or remainder",0
strAddingOverflow	BYTE 13,10,"OVERFLOW OCCURRED WHEN ADDING",0
strMultOverflow		BYTE 13,10,"OVERFLOW OCCURRED WHEN MULTIPLYING",0
strInvalidString 	BYTE 13,10,"INVALID NUMERIC STRING. RE-ENTER VALUE",0
strBlank			BYTE 0
strNewLine			BYTE 13,10,0

;Memory space for input character & string 
cInputChar			BYTE ?
strString 			BYTE 11 dup(?)

;Signed dword values 
iVal1				SDWORD ?
iVal2				SDWORD ?
iSum				SDWORD ?
iDifference			SDWORD ?
iProduct			SDWORD ?
iRemainder			SDWORD ?
iQuotient			SDWORD ?
dLimitNum			DWORD 11

;Results converted to strings 
strSum				DWORD ?
strDiff				DWORD ?
strProd				DWORD ?
strRemainder		DWORD ?
strDiv				DWORD ?
			
	
	
  .code
_start:
	invoke putstring, addr strHeader			;Prints the header to the screen 
	
restart:										;Restart label
	invoke putstring, addr strNewLine			;Outputs newline
enterFirstNum:									;Enter first number label
	invoke putstring, addr strFirstNumPrompt	;Output prompt for first number
	call InputFromScreen						;Calls input from user procedure 
	invoke ascint32, addr strString				;converts string to integer
	jo Overflow1								;Checks for overflow
	jc Invalid1									;Checks for invalid number 
	jmp validNumber1							;Jumps if both tests pass 
	
Overflow1:										;Overflow error label 
	invoke putstring, addr strOverflowConv 		;Outputs overflow error message
	jmp enterFirstNum							;Re-enter first number 
	
Invalid1:										;Invalid character error label 
	cmp AL, 13									;Checks if only character is an enter key 
	je finish									;Jumps to finish if true
	invoke putstring, addr strInvalidString		;Output invalid string error message 
	jmp enterFirstNum							;Re-enter number 

validNumber1:									;valid first number 
	mov iVal1,eax								;moves integer value from general purpose register, inputted by the procedure
	
enterSecondNum:									;Enter second number label 
	invoke putstring, addr strSecondNumPrompt	;Output prompt for second number 
	call InputFromScreen						;Calls input from user procedure 
	invoke ascint32, addr strString				;converts string to integer
	jo Overflow2								;Checks for overflow error 
	jc Invalid2									;Checks for invalid number error 
	jmp validNumber2							;Passed all tests 
	
Overflow2:										;Overflow error 
	invoke putstring, addr strOverflowConv 		;Output overflow error message 
	jmp enterSecondNum							;Re-enter second number 
	
Invalid2:										;Invalid number error 
	cmp AL, 13									;Checks if only character is an enter key 
	je finish									;Jumps to finish if true
	invoke putstring, addr strInvalidString		;Output invalid string error message
	jmp enterSecondNum							;Re-enter number 
	
validNumber2:									;Valid second number 
	mov iVal2,eax								;moves integer value from general purpose register, inputted by the macro
	
	mov eax, 0									;Clears EAX
	mov eax, iVal1								;Moves iVal1 to EAX
	add eax, iVal2								;Adds iVal2 to EAX
	jno Adding									;Checks for overflow 
	
	invoke putstring, addr strAddingOverflow	;Outputs overflow error message 
	or eax, 0									;clears overflow flag 
	jmp Difference								;jump to substaction 
	
Adding:											
	mov iSum, eax								;Moves result to iSum 
	invoke intasc32, addr strSum, iSum			;Converts to string for output 
	
	invoke putstring, addr strSumPrompt			;Outputs the prompt 
	invoke putstring, addr strSum				;Outputs the result 
	
Difference:
	mov eax, 0									;Clears EAX 
	mov eax, iVal1								;Moves iVal1 to EAX
	sub eax, iVal2								;Subtracts iVal2 from EAX 

	mov iDifference, eax						;Moves result to memory 
	invoke intasc32, addr strDiff, iDifference	;Converts result to string 
	
	invoke putstring, addr strDifferencePrompt	;Outputs the difference prompt 
	invoke putstring, addr strDiff				;Outputs the result 
	
	mov eax, iVal1								;Moves iVal1 to EAX
	imul eax, iVal2								;Multiplies EAX by iVal2
	jno Multiply								;Jumps of no overflow error 
	
	invoke putstring, addr strMultOverflow		;Outputs overflow error message 
	or eax, 0									;Clears overflow flag 
	jmp CheckDivide								;Jumps to divide 
	
Multiply:
	mov iProduct, eax							;Moves result to memory 
	invoke intasc32, addr strProd, iProduct		;Converts result to string 
	invoke putstring, addr strProductPrompt		;Outputs product prompt 
	invoke putstring, addr strProd				;Outputs product result 
	
CheckDivide:
	mov EAX, 0									;Clear EAX register
	mov EAX, iVal2								;Moves iVal2 to EAX 
	cmp EAX, 0									;Checks if divisor is zero 
	jne Divide									;Jumps if not equal to zero 
	
	invoke putstring, addr strDivideZero		;Outputs divide by zero error
	jmp restart									;Jumps to start of program
	
Divide:
	mov eax, iVal1								;Moves iVal1 to EAX 
	cdq											;Extend the EAX register 
	mov ebx, iVal2								;Moves iVal2 to EBX 
	idiv ebx									;Divides EAX by EBX 
	
	mov iQuotient, eax							;Moves the dividend to iQuotient
	mov iRemainder, edx							;Moves the remainder to iRemainder
	
	invoke intasc32, addr strDiv, iQuotient		;Converts dividend to string 
	invoke intasc32, addr strRemainder, iRemainder	;Convert remainder to string 
	
	invoke putstring, addr strQuotientPrompt	;Output quotient result 
	invoke putstring, addr strDiv
	
	invoke putstring, addr strRemainderPrompt	;Output remainder result 
	invoke putstring, addr strRemainder

	jmp restart
	
finish:
	invoke putstring, addr strExitPrompt		;Outputs exit message 
	invoke ExitProcess, 0						;invokes the exit process
	PUBLIC _start
	
InputFromScreen proc 							;Starts of inputFromScreen procedure 
	mov ECX, 0									;Clears ECX register 
	mov ESI, 0									;Clears ESI register 
	
ResetInputStr:
	mov strString[ESI],0						;Moves through string array 
	inc ESI										;Clears the string array 
	cmp ESI, 10									;Clears upt to 10 characters
	jne ResetInputStr
	
	mov ESI, 0									;Clears ESI register 
	
inputCharLoop:
	INVOKE getch								;Retrieves character from screen 
	cmp Al, 8									;Compares to backspace char 
	je backSpace		 						;Jumps if there is a backspace 
	cmp AL, 13									;Compares to enter key 
	je return									;Jumps to end of program 
	cmp ECX, 10									;Stops input after 10 characters entered 
	je inputCharLoop							;Keeps inputting until enter 
	
	mov  strString[ESI], AL						;Moves character into string array 
	invoke putch, AL							;Outputs character to screen 
	inc ESI										;Increments index
	inc ECX										;Increments counter 
	jmp inputCharLoop							;Jumps to enter next character
	
backSpace:
	cmp ESI, 0									;Checks if any other characters have been entered
	je inputCharLoop							;Jumps to enter next character 					
	invoke putch, 8								;Moves the cursor back one space 
	invoke putch, strBlank						;Replaces cursor with a zero 
	invoke putch, 8								;Moves cursor back one space 
	dec ESI										;Decrements index register 
	dec ECX										;Decrements counter 
	mov strString[ESI], 0						;Places memor position with zero character 
	jmp inputCharLoop							;Jumps to enter next character

return: 
	or eax, 0									;Clears flags 
	clc
	ret											;returns to main program 
	
InputFromScreen endp							;End procedure 
	
END