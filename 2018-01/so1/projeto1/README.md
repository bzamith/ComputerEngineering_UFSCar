# so1

Projeto desenvolvido para a disciplina de Sistemas Operacionais 1, primeiro semestre de 2018.

Trabalho 1 de Sistemas Operacionais 

Implementar Syscall no QEMU

Professora: Kelen Vivaldini

Data: 20/04/2018

## Alunos 
* Bruna Zamith Santos (628093)
* Henrique Frajacomo (726536)
* João Victor Pacheco (594970)
* Marcos Augusto Faglioni Junior (628301)

## Entrega
O trabalho entregue contém 2 arquivos:
- [x] proc_prior.c
- [x] ex-proc_prior.c

## Descrição
Implementamos a syscall chamada "Proc_Prior". Ela recebe dois argumentos, 
sendo eles uma PID e um valor de Prioridade, respectivamente. A syscall 
altera a prioridade do processo cuja PID é a informada, caso ele exista. 
Para testar a syscall, podemos executar no terminal:
``` shell
./ex-proc_prior <PID> <Prioridade>
```
A própria syscall verifica se a prioridade é válida (valor entre -20 e 19) e 
se o processo cuja PID é a informada existe. Então, realiza a alteração de 
prioridade. 
	
## Configuração e utilização
Para execução da proc_prior, é necessário seguir certas etapas, sendo elas:
* 1. Instalação do QEMU.
* 2. Alteração a tabela linux-3.17.2/arch/x86/syscalls/syscall_32.tbl de modo a incluir:
```
N	i386	proc_prior	sys_proc_prior
```
N corresponde à id da nova syscall, sendo igual ao ultimo id na tabela + 1
* 3. Inclusão da declaração da função sys_proc_prior em um ponto adequado do arquivo linux-3.17.2/include/linux/syscalls.h:
```
asmlinkage long sys_proc_prior(pid_t, int);
```
* 4. Inclusão do código proc_prior.c no diretório linux-3.17.2/arch/x86/kernel/ 
* 5. Alteração do Makefile do diretório linux-3.17.2/arch/x86/kernel/, incluindo a linha:
```
obj-y	+= proc_prior.o
```
* 6. No diretório linux-3.17.2 executar:
```
sudo make -j 5 ARCH=i386
```
* 7. Compilar o programa de teste da syscall (ex-proc_prior.c)
```
gcc -m32 -static ex-proc_prior.c -o ex-proc_prior
```
* 8. Rodar o programa no QEMU, da seguinte forma:
```
cat /dev/hdb > ex-proc_prior
```
```
chmod +x ex-proc_prior
```
```
./ex-proc_prior
```		

## Observações
As etapas aqui descritas partem do pressuposto de que o usuário possui uma imagem compatível do Linux na interface QEMU. No caso deste procedimento, foi utilizada a versão 3.17.2 do kernel do Linux.
