format ELF64 executable
segment readable executable

entry $

   mov    rdx, msg_size
   lea    rsi, [msg]
   mov    rdi, 1
   mov    rax, 1
   syscall

   xor    rdi, rdi
   mov    rax, 60
   syscall

segment readable writeable

msg db "Hello, World!", 0xA
msg_size = $-msg

