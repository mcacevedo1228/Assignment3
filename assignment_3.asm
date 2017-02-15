; CS371 Assignment3
; Marc Acevedo
; This .asm file takes in two arrays of unsigned integers and prints their vector dot product.


        .486                                    ; create 32 bit code
        .model flat, stdcall                    ; 32 bit memory model
        option casemap :none                    ; case sensitive

        include \masm32\include\windows.inc     ; always first
        include \masm32\macros\macros.asm       ; MASM support macros

  ; include files that have MASM format prototypes for function calls
        include \masm32\include\masm32.inc
        include \masm32\include\gdi32.inc
        include \masm32\include\user32.inc
        include \masm32\include\kernel32.inc

  ; Library files that have definitions for function
  ; exports and tested reliable prebuilt code.
        includelib \masm32\lib\masm32.lib
        includelib \masm32\lib\gdi32.lib
        includelib \masm32\lib\user32.lib
        includelib \masm32\lib\kernel32.lib

        .const
CR                      equ     0dH
LF                      equ     0aH
ELEM_SIZE               equ     4
BUFFER_LENGTH           equ     20
ADDRESS_A               equ     offset A
ADDRESS_B               equ     offset B

        .data
        
unsigned_integer_format byte    "%lu", CR, LF, 0
A                       dword   2, 4, 6, 8, 10
B                       dword   1, 3, 5, 7, 9

        .data?
buffer                  byte    BUFFER_LENGTH dup(?)
A_count                 dword   ?
B_count                 dword   ?       


        .code
main    proc

        mov             A_count, 1
        mov             B_count, 1

        mov             ebx, ADDRESS_A
        add             eax, [ebx]
        mov             ecx, A_count
        shl             ecx, 2          
        




main    endp

        










