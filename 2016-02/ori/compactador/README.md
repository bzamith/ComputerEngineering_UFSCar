# ori
Trabalho apresentado a disciplina de Organização e Recuperação da informação, ministrada pelo docente Jander Moreira, na Universidade Federal de São Carlos - UFSCar.

Data: 08/12/2016

## Objetivo

Criar um arquivo de formato .sar, contendo todos os diretórios, sub-diretórios e arquivos de um dado diretório, e a partir deste arquivo, conseguir recuperar todos os dados, de forma preservada e de mesma ordem cronológica de quando armazenados. Como objetivo para a disciplina, é necessário a utilização de índice para a organização dos arquivos; Neste caso é utilizado & como identificador de pasta e * como identificador de arquivos. Além desta formatação, para os arquivos é utilizado, em seguida ao identificador, o tamanho do arquivo. 

## Autores
* Bruna Zamith Santos                 628093
* João Victor Pacheco                 594970
* Marcos Augusto Faglioni Junior      628301

## Manual
Este programa esta implementado para ser executado em plataformas WINDOWS (Testado em Windows 7, 8 e 10), as funções -c e -l também estão disponiveis para plataforma linux (Testado em Mint 17+ e Ubuntu 14.4+), Mac IOS não foi testado.

Para utilizar o programa, basta executa-lo dentro do diretório onde a pasta a ser armazenada esta. Em seguida estão os comandos aceitos pelo programa:
Todos os comandos devem ser precedidos pela chamada sar:

- [x] sar -a []	- Exibe um menu de ajuda, com todas as possiveis funções
- [x] sar -c dir	- Armazena o diretório com nome dir, e cria um arquivo chamado dir.sar. (Esta opção não possui verificação de diretórios, assim caso seja passado um nome errado ou o nome de um arquivo inexistente, será criado um arquivo dir.sar, vazio).
- [x] sar -e arq.sar	- Extrai o arquivo arq.sar, mantendo a hierarquia do arquivo original.
- [x] sar -l arq.sar	- Lista todos os arquivos, diretórios e sub-diretórios do arq.sar, em ordem hierarquica.
- [x] sar -quit []	- Encerra a execução do programa.
