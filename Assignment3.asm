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


        .data
        
unsigned_integer_format byte    "%lu ", CR, LF, 0
A                       dword   0, 0, 0, 0, 0
B                       dword   0, 0, 0, 0, 0

message db 'Enter a number for',
           ' array A',CR,LF,0
message2 db 'Enter a number for',
           ' array B',CR,LF,0

        .data?
buffer                  byte    BUFFER_LENGTH dup(?)
loop_count              dword   ?       


        .code

setArrA proc

    mov edx, 0              ; counter = 0
    
    
    topL:                   ; top of loop

        push edx            ; counter to top of stack
        push offset message 
        call StdOut

        mov eax, 0          ; eax = 0
        push BUFFER_LENGTH
        push offset buffer
        call StdIn
        
        push offset buffer
        call atodw
        
        pop edx             ; pops edx from stack
        
        mov A[edx*ELEM_SIZE], eax ; value of array
    
        inc edx             ; counter++
        cmp edx, 4          ; if(counter ==4)
        jle topL            ; jumps to topL if not over
   ret
setArrA endp


setArrB proc

    mov edx, 0              ; counter = 0

    
    topLp:

        push edx            ; counter to stack
        
        push offset message2
        call StdOut

        mov eax, 0          ; eax = 0
        push BUFFER_LENGTH
        push offset buffer
        call StdIn

        push offset buffer
        call atodw
        
        pop edx             ; pops counter from stack
        
        mov B[edx*ELEM_SIZE], eax ; array[index] = eax
    
        inc edx             ; counter++
        cmp edx, 4          ; if(counter == 4)
        jle topLp           ; jumps to topL if not over
   ret

setArrB endp

getValue proc

mov eax, A[esi*ELEM_SIZE] 
mov edx, B[esi*ELEM_SIZE]
ret

getValue endp


calc proc

mov esi, 0  ; inc
mov edi, 0  ; sum

topLoop:

    call getValue ; eax -> A[n] edx -> B[n]

    mul edx       ; A[n] * B[n]
    add edi, eax  ; edi += eax
    inc esi       ; esi++
    
    cmp esi, 5
    jne topLoop

    ret

calc endp


main    proc


     call setArrA   ; sets the arr A from stdIn
     call setArrB   ; sets the arr B from stdIn
     call calc      ; Performs dot product

     call ExitProcess

main    endp


print_int proc
     push eax
     push ebx
     push ecx
     push edx

     push edi
     push offset unsigned_integer_format
     push offset buffer
     call wsprintf
     add  esp, 12

     push offset buffer
     call StdOut

     pop  edx
     pop  ecx
     pop  ebx
     pop  eax

     ret
     
print_int endp


end     main
        










