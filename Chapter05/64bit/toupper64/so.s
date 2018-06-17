SECTION .data
    message: db 'Hello, world!',0x0a    
    length:    equ    $-message        
    fname    db "result"
    fd       dq 0

SECTION .text
global _start   
_start:
        movq rax, 2            # 'open' syscall
        movq rdi, fname        # file name
        movq rsi, 0102o        # read and write mode, create if not
        movq rdx, 0666o        # permissions set
        syscall

        movq [fd], rax

        movq    rax, 1          # 'write' syscall
        movq    rdi, [fd]       # file descriptor
        movq    rsi, message    # message address
        movq    rdx, length     # message string length
        syscall

        movq rax, 3             # 'close' syscall
        movq rdi, [fd]          # file descriptor  
        syscall 

        movq    rax, 60        
        movq    rdi, 0        
        syscall
