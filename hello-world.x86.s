.section .data # secao de data -> define variaveis
  message:
    .string "Hello world!\n"  # String com terminador nulo
  msglength:
    .long 13    

.section .text # Secao de text -> define as instruções. 
.globl main # define a funcao main para acesso global

main: 
  movl $4, %eax           # insere 4 no registrado eax - syscall número 4 (sys_write)
  movl $1, %ebx           # descritor de arquivo (stdout)
  movl $message, %ecx     # endereço da mensagem
  movl msglength, %edx           # comprimento da mensagem
  int $0x80               # chamada de interrupção para executar a syscall

  movl $1, %eax           # syscall número 1 (sys_exit)
  xorl %ebx, %ebx         # código de saída (0 - sucesso)
  int $0x80                     # Chama a interrupcao para sair do programa
