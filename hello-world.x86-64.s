.section .data # secao de data -> define variaveis
  message:
    .string "Hello world!\n"  # String com terminador nulo
  msglength:
    .long 13    

.section .text # Secao de text -> define as instruções. 
.globl main # define a funcao main para acesso global

main: 
  mov $4, %rax           # insere 4 no registrado rax - syscall número 4 (sys_write)
  mov $1, %rbx           # descritor de arquivo (stdout)
  mov $message, %rcx     # endereço da mensagem
  mov msglength, %rdx           # comprimento da mensagem
  int $0x80               # chamada de interrupção para executar a syscall

  mov $1, %rax           # syscall número 1 (sys_exit)
  xor %rbx, %rbx         # código de saída (0 - sucesso)
  int $0x80                     # Chama a interrupcao para sair do programa
