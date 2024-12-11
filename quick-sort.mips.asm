.data
  array: 
    .word 5, 10, 9, 1, 6, 3, 0        # Array de inteiros para ordenar, terminado com 0
  size:
    .word 7                          # Tamanho do array (número de elementos)
  space:  
    .asciiz " "  
  breakline:  
    .asciiz "\n"  

.text
  .globl main

main:
  la   $a0, array                  # Passa o endereço do array como primeiro argumento para quicksort
  li   $a1, 0                      # $a1 se torna o segundo argumento
  lw   $a2, size                   # Passa o tamanho do array como terceiro argumento
  sub  $a2, $a2, 1                 # Ajusta para o índice máximo (size - 1)

  jal print # printa o array
  
  jal  quicksort                   # Chama a função quicksort -> $a0 (array), $a1 (left), $a2 (right)

  jal print # printa o array novamente agora ordenado

  j exit                          # Faz a syscall para encerrar o programa

# Quick Sort: quicksort(array, left, right)
quicksort:
  # Salva o contexto da função
  addi $sp, $sp, -16                # Reserva espaço na pilha para 16 bytes -> Pilha diminui
  sw   $ra, 4($sp)                  # Salva o endereço de retorno -> salva o valor de $ra 4 bytes acima de $sp
  sw   $s0, 0($sp)                  # Salva o valor de $s0 -> salva o valor de $s0 na posição de $sp
  sw   $a1, 8($sp)                  # Salva o valor de $a1 -> left
  sw   $a2, 12($sp)                 # Salva o valor de $a2 -> right

  move $s0, $a0                    # Salva o endereço do array em $s0 (variável local)
  move $t0, $a1                    # Passa left para $t0
  move $t1, $a2                    # Passa right para $t1

  bge  $t0, $t1, quicksort_done    # Se left >= right, retorna

  # Chama partition para 
  move $a0, $s0                    # Passa o endereço do array para partition
  move $a1, $t0                    # Passa left como segundo argumento
  move $a2, $t1                    # Passa right como terceiro argumento
  jal  partition                   # Chama partition $a0 (array), $a1 (left), $a2 (right) - carrega o pivô

  # Recebe o índice do pivô retornado por partition
  move $t2, $v0                    # Salva o índice do pivô em $t2

  # Recursão para a primeira metade do array
  lw $t0, 8($sp) # carrega o left novamente

  move $a1, $t0                    # Passa left como argumento
  addi $a2, $t2, -1                # Passa pivot - 1 como right
  jal  quicksort                   # Chama quicksort(array, left, pivot - 1)

  lw $t1, 12($sp) # carrega o right novamente

  # Recursão para a segunda metade do array
  addi $a1, $t2, 1                 # Passa pivot + 1 como left
  move $a2, $t1                    # Passa right como terceiro argumento
  jal  quicksort                   # Chama quicksort(array, pivot + 1, right)

  jal quicksort_done

quicksort_done:
  # Restaura o contexto da função
  lw   $ra, 4($sp)                  # Restaura o endereço de retorno
  lw   $s0, 0($sp)                  # Restaura o valor de $s0

  # elimina todo o espaço alocado para o quicksort
  addi $sp, $sp, 16                 # Restaura o ponteiro da pilha
  jr   $ra                          # Retorna da função

# Partition: partition(array, left, right) -> carrega o pivô
partition:
  # Salva o contexto da função
  addi $sp, $sp, -8                # Espaço na pilha para salvar o retorno
  sw   $ra, 4($sp)                 # Salva o endereço de retorno
  sw   $s0, 0($sp)                 # Salva o valor de $s0

  move $s0, $a0                    # Salva o endereço do array em $s0 (variável local)
  move $t0, $a1                    # Passa left para $t0
  move $t1, $a2                    # Passa right para $t1

  sll  $t2, $t1, 2                 # Calcula o deslocamento de array[left] (escalar por 4 bytes)
  add  $t2, $s0, $t2               # Adiciona o deslocamento ao endereço base do array

  lw   $t2, 0($t2)                 # Carrega o valor do pivô (array[right]) em $t2

  move $t3, $a1                    # Inicializa left
  move $t4, $a2                    # Inicializa right

  # t3 = left
  # t4 = right

  move $t6, $t3 # j = left
  move $t5, $t3
  addi $t5, $t5, -1 # i = left - 1


partition_loop:
 
  beq $t6, $t4, partition_done # array[j] == pivô

  sll  $t7, $t6, 2                 # Calcula o deslocamento de array[j]
  add  $t7, $s0, $t7               # Adiciona o deslocamento ao endereço base
  lw   $t7, 0($t7)                 # $t7 = array[j]

  blt  $t2, $t7, increment_j       # Se array[j] > pivô, incrementa j

  # caso # array[j] < pivô, continua

  addi $t5, $t5, 1                 # incrementa i
  jal swap # troca array[i] e array[j]
  j increment_j # incrementa j

increment_j:
  addi $t6, $t6, 1                 # Incrementa j
  j    partition_loop

swap:
  # Troca array[i] e array[j]
  sll  $t7, $t5, 2                 # Calcula o deslocamento de array[i]
  add  $t7, $s0, $t7               # Adiciona o deslocamento ao endereço base
  
  sll  $t8, $t6, 2                 # Calcula o deslocamento de array[j]
  add  $t8, $s0, $t8               # Adiciona o deslocamento ao endereço base
  
  lw   $t9, 0($t8)                 # Carrega array[j]
  lw   $k1, 0($t7)                 # Carrega array[i]

  sw   $t9, 0($t7)                 # Coloca array[j] em array[i]
  sw   $k1, 0($t8)                 # Coloca array[i] em array[j]
  
  jr $ra

partition_done:
  addi $t5, $t5, 1 # incrementa o i

 # Coloca o pivô na posição correta
  jal swap

  move  $v0, $t5 # retorna o indice de i

  lw   $ra, 4($sp)                  # Restaura o endereço de retorno
  lw   $s0, 0($sp)                  # Restaura o valor de $s0
  addi $sp, $sp, 8                  # Restaura o ponteiro da pilha
  jr   $ra

# iniciliza as variaveis para o loop
print:
  la   $t0, array         # Carrega o endereço base de 'array' em $t0
  lw   $t1, size          # Carrega o tamanho do array em $t1 (em $t1 temos o número de elementos)

  addi $sp, $sp, -4                # Espaço na pilha para salvar o retorno
  sw   $ra, 0($sp)                 # Salva o endereço de retorno
  
  jal loop

  lw   $ra, 0($sp) 
  addi $sp, $sp, 4

  la $a0, array

  jr $ra

# loop no array
loop:
  beq  $t1, $zero, goback  # Se $t2 (contador de elementos) for zero, sai do loop

  lw   $a0, 0($t0)       # Carrega o valor de array[i] (primeiro elemento do array) em $a0
  li   $v0, 1            # Preparando para imprimir inteiro (chamada de sistema 1)
  syscall                # Imprime o valor de $a0

  # Exibe um espaço
  li   $v0, 4             # Preparando para imprimir uma string (chamada de sistema 4)
  la   $a0, space         # Carrega o endereço de um espaço em branco
  syscall

  addi $t0, $t0, 4        # Avança para o próximo elemento do array (avança 4 bytes)
  subi $t1, $t1, 1        # Decrementa o contador de elementos
  j loop  


# saida do sistema
exit:
  li   $v0, 10            # Preparando para sair do programa (chamada de sistema 10)
  syscall

# retorna para a funcao que chamou o print
goback: 
  
  # Exibe um quebra de linha
  li   $v0, 4             # Preparando para imprimir uma string (chamada de sistema 4)
  la   $a0, breakline         # Carrega o endereço de quebra de linha
  syscall

  jr $ra