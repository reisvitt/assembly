# Comandos Assembly

## Seções (sections)

### .data

Usado para definir variáveis e inicializá-las com valores.

### .bss

Usado para reservar espaço para variáveis sem inicializá-las.

### .text

Seção que contém o código do programa. As instruções

## Global

Diretiva usada para declarar símbolos (geralmente funções ou variáveis) que devem ser acessíveis fora do arquivo de código fonte atual. Em outras palavras, o global torna o símbolo visível e acessível por outros módulos ou partes do programa, como no caso de uma função que será chamada de outro arquivo de código ou de uma biblioteca.

Ex:

```asm
global _start ; torna a função _start global
```

## Registradores x86 (32 Bits)

| Registrador   | Nome                 | Função Principal                                                                                                                             |
| ------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| eax           | Accumulator          | Armazena o valor de retorno de funções e syscalls. Frequentemente usado para operações aritméticas e como registrador de resultado.          |
| ebx           | Base                 | Usado para passar parâmetros em syscalls (ex: file descriptor). Também pode ser usado como base para operações de endereçamento.             |
| ecx           | Count                | Usado como contador e para passar parâmetros em syscalls, como ponteiros para strings ou buffers de leitura.                                 |
| edx           | Data                 | Usado para armazenar dados temporários e como parâmetro em syscalls (ex: tamanho de buffer para leitura ou escrita).                         |
| esi           | Source Index         | Usado para apontar para a fonte de dados em operações de cópia ou processamento de strings.                                                  |
| edi           | Destination Index    | Usado para apontar para o destino de dados em operações de cópia ou processamento de strings.                                                |
| ebp           | Base Pointer         | Usado para armazenar a base do frame de pilha, permitindo acessar parâmetros de funções e variáveis locais.                                  |
| esp           | Stack Pointer        | Aponta para o topo da pilha, onde os dados temporários e os endereços de retorno das funções são armazenados.                                |
| cs            | Code Segment         | Contém o segmento de código atual. Normalmente é constante durante a execução do programa.                                                   |
| ds            | Data Segment         | Contém o segmento de dados, onde variáveis globais e estáticas são armazenadas.                                                              |
| es            | Extra Segment        | Usado em operações de manipulação de strings e dados.                                                                                        |
| ss            | Stack Segment        | Contém o segmento da pilha, usado para armazenar informações temporárias (ex: parâmetros de funções e variáveis locais).                     |
| fs            | (Segmento Adicional) | Usado para acessar segmentos adicionais de dados (ex: informações de threads ou processos).                                                  |
| gs            | (Segmento Adicional) | Semelhante ao fs, usado para acessar segmentos específicos de dados, frequentemente para informações de threads.                             |
| eip           | Instruction Pointer  | Aponta para a próxima instrução a ser executada.                                                                                             |
| eflags        | Flags Register       | Contém informações sobre o estado do processador, como as flags zero, carry, sign, overflow e outras, que indicam o resultado das operações. |
| st(0) a st(7) | (Floating Point)     | Registradores usados para armazenar valores de ponto flutuante, se o processador suportar operações de ponto flutuante.                      |

## Registradores x86-64 (64 Bits)

| Registrador | Nome                    | Função Principal                                                                                                                           |
| ----------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| rax         | Accumulator             | Usado para armazenar valores de retorno de funções e syscalls. Comumente usado para operações aritméticas e como registrador de resultado. |
| rbx         | Base                    | Usado para passagem de parâmetros em algumas syscalls e também como base para operações de endereçamento.                                  |
| rcx         | Count                   | Usado para passar parâmetros e como contador. Frequentemente utilizado em loops e para contar repetições.                                  |
| rdx         | Data                    | Usado para armazenar dados temporários, como resultados intermediários e como parâmetro em syscalls (ex: tamanho de buffer).               |
| rsi         | Source Index            | Usado para apontar para a origem dos dados em operações de cópia e processamento de strings.                                               |
| rdi         | Destination Index       | Usado para apontar para o destino dos dados em operações de cópia e processamento de strings.                                              |
| rbp         | Base Pointer            | Usado para armazenar a base do frame de pilha, permitindo o acesso a parâmetros de funções e variáveis locais.                             |
| rsp         | Stack Pointer           | Aponta para o topo da pilha, onde os dados temporários e os endereços de retorno das funções são armazenados.                              |
| r8          | (Registrador adicional) | Usado como um registrador de propósito geral adicional. Pode ser utilizado para passagem de parâmetros ou armazenar dados temporários.     |
| r9          | (Registrador adicional) | Usado de forma semelhante ao r8. Pode ser utilizado para armazenar parâmetros ou dados temporários.                                        |
| r10         | (Registrador adicional) | Usado em algumas operações específicas e passagem de parâmetros em funções de 64 bits.                                                     |
| r11         | (Registrador adicional) | Usado de maneira geral, especialmente em algumas operações com o kernel ou no contexto de manipulação de dados de sistemas.                |
| r12         | (Registrador adicional) | Registrador de uso geral, comumente utilizado no contexto de operações de sistemas e funções de manipulação de dados.                      |
| r13         | (Registrador adicional) | Usado como registrador de propósito geral, frequentemente utilizado em contextos de manipulação de dados e controle de fluxo.              |
| r14         | (Registrador adicional) | Usado para armazenamento de dados temporários, e como registrador de controle em algumas operações de alto nível.                          |
| r15         | (Registrador adicional) | Usado para armazenar dados temporários e em operações de manipulação de dados no sistema.                                                  |
| rip         | Instruction Pointer     | Aponta para a próxima instrução a ser executada.                                                                                           |
| rflags      | Flags Register          | Contém as flags do processador, indicando o estado de operações aritméticas (ex: zero, carry, overflow, etc.).                             |

### Registradores de segmento

| Registrador | Nome                 | Função Principal                                                                                                             |
| ----------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| cs          | Code Segment         | Contém o segmento de código atual. Normalmente é constante durante a execução do programa.                                   |
| ds          | Data Segment         | Contém o segmento de dados, onde as variáveis globais e estáticas são armazenadas.                                           |
| es          | Extra Segment        | Usado para manipulação de strings e dados temporários.                                                                       |
| ss          | Stack Segment        | Contém o segmento da pilha, utilizado para armazenar informações temporárias, como parâmetros de funções e variáveis locais. |
| fs          | (Segmento adicional) | Usado para acessar segmentos adicionais de dados (ex: informações de threads ou processos).                                  |
| gs          | (Segmento adicional) | Similar ao fs, utilizado para acessar segmentos específicos de dados (frequentemente usado para informações de threads).     |

### Registradores de controle

| Registrador | Nome                | Função Principal                                                                                           |
| ----------- | ------------------- | ---------------------------------------------------------------------------------------------------------- |
| rip         | Instruction Pointer | Aponta para a próxima instrução a ser executada.                                                           |
| rflags      | Flags Register      | Contém informações sobre o estado do processador, como flags de zero, carry, sign, overflow, entre outras. |

## SYSCALLS

Em sistemas Linux, as interações com o sistema operacional (como exibir algo na tela ou sair do programa) são feitas usando "syscalls" (chamadas de sistema). As chamadas de sistema em Linux são feitas com a interrupção int 0x80.

| Número | Função           | Descrição                                                       |
| ------ | ---------------- | --------------------------------------------------------------- |
| 0      | sys_read         | Ler de um arquivo ou entrada padrão                             |
| 1      | sys_write        | Escrever em um arquivo ou saída padrão                          |
| 2      | sys_open         | Abrir um arquivo                                                |
| 3      | sys_close        | Fechar um arquivo                                               |
| 4      | sys_stat         | Obter status de um arquivo                                      |
| 5      | sys_fstat        | Obter status de um arquivo com file descriptor                  |
| 6      | sys_lstat        | Obter status de um link simbólico                               |
| 7      | sys_poll         | Esperar por eventos de E/S                                      |
| 8      | sys_lseek        | Modificar o ponteiro de leitura/escrita de um arquivo           |
| 9      | sys_mmap         | Mapear arquivos ou dispositivos na memória                      |
| 10     | sys_mprotect     | Modificar permissões de memória                                 |
| 11     | sys_munmap       | Desmapear memória                                               |
| 12     | sys_brk          | Alterar o ponto de alocação de memória                          |
| 13     | sys_cacheflush   | Limpar o cache (obsoleto)                                       |
| 14     | sys_gettimeofday | Obter o tempo atual                                             |
| 15     | sys_settimeofday | Definir o tempo atual                                           |
| 16     | sys_getpid       | Obter o PID do processo                                         |
| 17     | sys_setuid       | Definir o UID (usuário) do processo                             |
| 18     | sys_getuid       | Obter o UID do processo                                         |
| 19     | sys_setgid       | Definir o GID (grupo) do processo                               |
| 20     | sys_getgid       | Obter o GID do processo                                         |
| 21     | sys_signal       | Definir um manipulador de sinal                                 |
| 22     | sys_exit         | Terminar um processo                                            |
| 23     | sys_waitpid      | Esperar por um processo filho                                   |
| 24     | sys_fork         | Criar um novo processo (fork)                                   |
| 25     | sys_execve       | Executar um programa                                            |
| 26     | sys_ptrace       | Controlar um processo (usado para depuração)                    |
| 27     | sys_alarm        | Definir um alarme de tempo                                      |
| 28     | sys_fcntl        | Controlar as propriedades de um arquivo ou descritor de arquivo |
| 29     | sys_ioctl        | Enviar um comando de entrada/saída para um dispositivo          |
| 30     | sys_getdents     | Obter entradas de diretório                                     |
| 31     | sys_select       | Realizar operações de seleção para E/S (entrada/saída)          |
| 32     | sys_fsync        | Sincronizar o conteúdo de um arquivo com o disco                |
| 33     | sys_fdatasync    | Sincronizar dados de um arquivo com o disco                     |
| 34     | sys_truncate     | Alterar o tamanho de um arquivo                                 |
| 35     | sys_ftruncate    | Alterar o tamanho de um arquivo com file descriptor             |
| 36     | sys_getcwd       | Obter o diretório de trabalho atual                             |
| 37     | sys_chdir        | Mudar o diretório de trabalho atual                             |
| 38     | sys_fchdir       | Mudar o diretório de trabalho para um file descriptor           |
| 39     | sys_rename       | Renomear um arquivo ou diretório                                |
| 40     | sys_mkdir        | Criar um diretório                                              |
| 41     | sys_rmdir        | Remover um diretório                                            |
| 42     | sys_creat        | Criar um arquivo                                                |
| 43     | sys_link         | Criar um link para um arquivo                                   |
| 44     | sys_unlink       | Remover um link para um arquivo                                 |
| 45     | sys_symlink      | Criar um link simbólico                                         |
| 46     | sys_readlink     | Ler um link simbólico                                           |
| 47     | sys_chmod        | Alterar permissões de arquivo                                   |
| 48     | sys_fchmod       | Alterar permissões de arquivo com file descriptor               |
| 49     | sys_chown        | Alterar o dono e grupo de um arquivo                            |
| 50     | sys_fchown       | Alterar o dono e grupo de um arquivo com file descriptor        |
| 51     | sys_umask        | Definir a máscara de criação de arquivos                        |
| 52     | sys_gettimeofday | Obter a hora e data atual                                       |
| 53     | sys_getrusage    | Obter informações sobre o uso de recursos do processo           |
| 54     | sys_sysinfo      | Obter informações do sistema                                    |
| 55     | sys_times        | Obter tempos de execução do processo                            |
| 56     | sys_setuid       | Definir UID do processo (usuário)                               |
| 57     | sys_getuid       | Obter UID do processo (usuário)                                 |
| 58     | sys_setgid       | Definir GID do processo (grupo)                                 |
| 59     | sys_getgid       | Obter GID do processo (grupo)                                   |
| 60     | sys_setpgid      | Definir o ID do grupo de processos                              |
| 61     | sys_getpgid      | Obter o ID do grupo de processos                                |
| 62     | sys_setsid       | Criar uma nova sessão e se tornar o líder                       |
| 63     | sys_getsid       | Obter o SID de um processo                                      |
| 64     | sys_sigaction    | Modificar ou definir ações de sinal                             |
| 65     | sys_sigprocmask  | Bloquear ou desbloquear sinais                                  |
| 66     | sys_sigsuspend   | Suspender a execução até que um sinal seja recebido             |
| 67     | sys_sigpending   | Obter sinais pendentes                                          |
| 68     | sys_sigtimedwait | Esperar por sinais com tempo de espera                          |
| 69     | sys_sigwaitinfo  | Esperar por sinais e obter informações sobre eles               |

## Como os registradores são usados nos Syscalls

### x86 (32 Bits)

O número da syscall é armazenado no registrador **eax**. Os parâmetros das syscalls são passados pelos registradores ebx, ecx, edx, esi, edi, ebp (dependendo do número de parâmetros)
O valor de retorno da syscall é armazenado no **eax** após a execução da syscall.

### x86_64 (64 Bits)

O número da syscall é armazenado no **rax**.
Os parâmetros das syscalls são passados pelos registradores rdi, rsi, rdx, r10, r8, r9 (dependendo do número de parâmetros).
O valor de retorno da syscall é armazenado no **rax** após a execução da syscall.
