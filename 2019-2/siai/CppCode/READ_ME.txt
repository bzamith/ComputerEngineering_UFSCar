Projeto Algoritmo Genético - Robô Cartesiano no Eixo Z

- Bruna Zamith Santos, RA: 628093
- Matheus Vrech Silveira Lima, RA: 727349

------------------------------------------------------------

Requisitos para rodar AG:
- GCC 

Requisitos para rodar AG + Simulação
- Matlab instalado
- Sistema operacional Linux

------------------------------------------------------------

Para rodar AG + Simulação:
- Acesse o arquivo SimulacaoMatlab.cpp
	- Altere o parâmetro this->matlabPath para o caminho 
	do Matlab instalado no seu computador
	- Altere o parâmetro this->workspaceAtual para o dire-
	tório atual do projeto
- Rode o comando
	- $ export PATH=DIRETORIO_MATLAB/:$PATH; g++ *.cpp 
		-o projeto.out; ./projeto.out
	- Onde DIRETORIO_MATLAB é o mesmo parâmetro setado em 
	this->matlabPath. Exemplo: usr/local/MATLAB/R2018b/bin/