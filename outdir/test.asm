segment .text
dump:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 64
    mov     QWORD [rbp-56], rdi
    mov     QWORD [rbp-8], 1
    mov     eax, 32
    sub     rax, QWORD [rbp-8]
    mov     BYTE  [rbp-48+rax], 10
.L2:
    mov     rcx, QWORD [rbp-56]
    mov     rdx, -3689348814741910323
    mov     rax, rcx
    mul     rdx
    shr     rdx, 3
    mov     rax, rdx
    sal     rax, 2
    add     rax, rdx
    add     rax, rax
    sub     rcx, rax
    mov     rdx, rcx
    mov     eax, edx
    lea     edx, [rax+48]
    mov     eax, 31
    sub     rax, QWORD [rbp-8]
    mov     BYTE  [rbp-48+rax], dl
    add     QWORD  [rbp-8], 1
    mov     rax, QWORD [rbp-56]
    mov     rdx, -3689348814741910323
    mul     rdx
    mov     rax, rdx
    shr     rax, 3
    mov     QWORD [rbp-56], rax
    cmp     QWORD [rbp-56], 0
    jne     .L2
    mov     eax, 32
    sub     rax, QWORD [rbp-8]
    lea     rdx, [rbp-48]
    lea     rcx, [rdx+rax]
    mov     rax, QWORD [rbp-8]
    mov     rdx, rax
    mov     rsi, rcx
    mov     edi, 1
    mov     rax, 1
    syscall
nop
leave
ret
global _start
_start:
    ;;-- push 89 --
    push 89
    ;;-- push 55 --
    push 55
    ;;-- plus --
    pop rax
    pop rbx
    add rax, rbx
    push rax
    ;; -- dump --
    pop rdi
    call dump
    ;;-- push 19 --
    push 19
    ;;-- push 9 --
    push 9
    ;;-- minus --
    pop rax
    pop rbx
    sub rbx, rax
    push rbx
    ;; -- dump --
    pop rdi
    call dump
    mov rax, 60
    mov rdi, 0
    syscall
