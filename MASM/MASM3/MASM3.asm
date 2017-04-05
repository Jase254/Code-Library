;****************************************************************************************************
; Program File:	MASM3.asm
; Program Name:	MASM3
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
	ascint32  	PROTO Near32 stdcall, lpStringToConvert:dword					;Converts ascii char to integer
	intasc32	PROTO Near32 stdcall, lpStringToHold:dword, dVal:dword	;Converts integer to ascii 
	putstring	PROTO Near32 stdcall, lpStringToPrint:dword				;Outputs string to screen 
	getche		PROTO Near32 stdcall  									;returns character in the AL register & echos to screen 
 	getch		PROTO Near32 stdcall  									;returns character in the AL register
	putch		PROTO Near32 stdcall, bChar:byte						;Outputs character to screen 
	
	EXTERN testLink:PROC
	
  .code
_start:
	mov EAX,0
	call testLink
	invoke ExitProcess, 0						;invokes the exit process
	PUBLIC _start
END