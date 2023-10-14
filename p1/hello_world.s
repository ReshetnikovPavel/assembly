.global _start
.data
str:
.ascii "hello world\n"
lstr=.-str

.text
_start:
mov $1, %rax
mov $1, %rdi
mov $str, %rsi
mov $lstr, %rdx
syscall

mov $60, %rax
mov $0, %rdx
syscall
