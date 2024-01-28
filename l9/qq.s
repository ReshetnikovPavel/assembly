.global main
main:
    mov $100500, %rdi
    call print
    ret

# /etc/ld.so.conf
# в этом конфиге написано, в каких папках могут лежать библиотеки
