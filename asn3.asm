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
        
unsigned_integer_format byte    "%lu ", CR, LF, 0
A                       dword   1, 2, 3, 4, 5
B                       dword   6, 7, 8, 9, 10


        .data?
buffer                  byte    BUFFER_LENGTH dup(?)
loop_count              dword   ?       


        .code
main    proc

start:
        mov             loop_count, 0                      ; Sets counter to 0        

        mov             eax, 0                              ; Clears registers prior to execution of main loop
        mov             ebx, 0
        mov             ecx, 0
        mov             edx, 0
        mov             edi, 0
        
loop_top:

        mov             ebx, ADDRESS_A                  ; Moves the offset address of each array into its own register
        mov             esi, ADDRESS_B 
               
        mov             ecx, loop_count                 ; Keeps track of loop iterations as well as used for multiplication
        
        shl             ecx, 2                          ; Multiplies given index by 4 using the shift.

        add             ebx, ecx                        ; Value needed for proper index
        add             esi, ecx
        mov             eax, [ebx]                      
        mov             edx, [esi]                      
        imul            edx                             ; multiplies each index
        
        add             edi, eax                        ; Now, add whatever is left from last go around to edi
                 
        cmp             loop_count, 5
        je              finished
        inc             loop_count
        jmp             loop_top

finished:
        mov             eax, 0
        mov             ebx, 0
        mov             ecx, 0
        mov             edx, 0

        mov             eax, edi
        call            print_int

        call ExitProcess
main    endp


print_int proc

     push 		eax
     push 		ebx	
     push 		ecx
     push 		edx

     push 		eax
     push 		offset unsigned_integer_format
     push 		offset buffer
     call 		wsprintf
     add  		esp, 12

     push 		offset buffer
     call 		StdOut

     pop  		edx
     pop  		ecx
     pop  		ebx
     pop  		eax

     ret
     
print_int endp


end     main
        










