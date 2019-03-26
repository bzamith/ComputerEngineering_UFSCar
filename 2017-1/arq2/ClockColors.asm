;Dados referentes a utilização da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
;Este jogo refere-se ao trabalho final apresentado a disciplina de Laboratório de Arquitetura e Organização de Computadores do Deparatamento de Computação da Universidade Federal de São Carlos -  UFSCar
;Docente responsável: Professor Doutor Luciano Neris
;Autores:
;	Bruna Zamith Santos		Ra 628093
;	Marcos Augusto Faglioni Junior		Ra 628301
INCLUDE Irvine32.inc

.data
	cor BYTE "COR SORTEADA:",0			;Nome do marcador das cores selecionadas
	tempo BYTE "TEMPO:", 0				;Nome do marcador de Tempo 
	pontuacao BYTE "PONTUACAO:", 0		;Nome do marcador de Pontuação
	biniciar BYTE "INICIAR",0			;Nome do botão para iniciar o jogo
	bcreditos BYTE "CREDITOS",0			;Nome do botão para os creditos
	bcomoJogar BYTE "COMO JOGAR",0		;Nome do botão para as instruções
	nome BYTE "CLOCK COLORS", 0			;Nome do Jogo
	bDificuldade1 BYTE "FACIL", 0		;Nome do botão para a dificuldade 1
	bDificuldade2 BYTE "MEDIO", 0		;Nome do botão para a dificuldade 2
	bDificuldade3 BYTE "DIFICIL", 0		;Nome do botão para a dificuldade 3
	timeMax BYTE 90						;Armazena o tempo maximo de jogo
	time BYTE 90						;Armazena o tempo do jogo
	score BYTE 0						;Armazena a pontuação do jogo
	posSeta BYTE 0						;Armazena a posição da seta no menu 
	posSeta1 BYTE 0						;Armazena a posição da seta no menu 
	tMaxX BYTE 60						;Armazena a quantidade de colunas do ecrã do jogo
	tMaxY BYTE 26						;Armazena a quantidade de linhas do ecrã do jogo
	posXB BYTE 30						;Armazena a posição X do personagem
	posYB BYTE 24						;Armazena a posição Y do personagem
	distPlat BYTE 5						;Armazena a distancia entre as plataformas
	nArmadilhas BYTE 15					;Numero de armadilhas por plataforma
	quantArmadilhas BYTE 60				;Numero de elementos do vetor armadilhas
	armadilhas BYTE 60 DUP(?)			;Armazena as coordenadas x das armadilhas (são 3 armadilhas por plataforma)
	platInicial WORD 8					;Armazena qual é a altura Y da plataforma mais alta
	cont BYTE 0							;Contador auxiliar para trocar as cores da plataforma
	contTime BYTE 0						;Contador auxiliar para o tempo
	coresDisp WORD yellow, blue, green, 
					cyan, red, magenta, 
					white, lightRed 	;Vetor de Cores Disponíveis para as plataformas (cores pre definidas pela biblioteca Irvine)
	corSele WORD 2 DUP(?)				;Vetor de cores sorteadas para as plataformas
	corPlatAtual WORD 1 DUP(?)			;Armazena a cor atual da plataforma imediatamente acima do personagem
	
	;Os dados seguintes salvos na memória tem por objetivo armazenar o texto a ser exibido nas instrucões
	mInstrucoes1 BYTE "ESTE JOGO CONSISTE EM GUIAR O ETEVALDO ATE A",0
	mInstrucoes2 BYTE "PLATAFORMA MAIS ALTA QUE O JOGADOR CONSEGUIR CHEGAR",0
	mInstrucoes3 BYTE "EM 30, 60 ou 90 SEGUNDOS.",0
	
	mInstrucoes4 BYTE "NESSA AVENTURA, O ETEVALDO SO PODE PULAR SE A",0 
	mInstrucoes5 BYTE "PLATAFORMA IMEDIATAMENTE ACIMA DELE ESTIVER COM",0 
	mInstrucoes6 BYTE "UMA DAS DUAS CORES SORTEADAS.",0
	
	mInstrucoes7 BYTE "PARA CADA PLATAFORMA EXISTIRAO OITO POSSIVEIS",0
	mInstrucoes8 BYTE "CORES, E NO TOTAL SERAO SELECIONADAS DUAS DESSAS CORES",0
	mInstrucoes9 BYTE "QUE LIBERARAO A PASSAGEM DO ET PARA A PLATAFORMA ACIMA.",0
	
	mInstrucoes10 BYTE "ALEM DE RESPEITAR AS CORES, DEVE-SE TOMAR CUIDADO",0
	mInstrucoes11 BYTE "PARA QUE NAO PULE ONDE EXISTE UM BURACO BRANCO. ESTE",0
	mInstrucoes12 BYTE "LEVERA O ETEVALDO PARA OUTRA DIMENSAO, FAZENDO O",0
	mInstrucoes13 BYTE "JOGADOR PERDER.",0
	
	mInstrucoes14 BYTE "PARA GUIAR O ET NESSE JOGO BASTA:",0			
	mInstrucoes15 BYTE "-PRESSIONAR A SETA PARA CIMA PARA PULAR;",0			
	mInstrucoes16 BYTE "-PRESSIONAR AS SETAS PARA A DIREITA OU ESQUERDA",0
	mInstrucoes17 BYTE "PARA SE MOVIMENTAR LATERALMENTE;",0			
	mInstrucoes18 BYTE "-TAMBEM E POSSIVEL SAIR DO JOGO A QUALQUER",0
	mInstrucoes19 BYTE "MOMENTO, PRESSIONANDO 'Q'.",0
	
	;Os dados seguintes salvos na memória tem por objetivo armazenar o texto a ser exibido nos crédito
	mcreditos1 BYTE "JOGO DESENVOLVIDO PARA A DISCIPLINA DE LABORATORIO DE",0
	mcreditos2 BYTE "ARQUITETURA E ORGANIZACAO DE COMPUTADORES, MINISTRADA",0
	mcreditos3 BYTE "PELO DOCENTE LUCIANO NERIS, NA UNIVERSIDADE FEDERAL",0
	mcreditos4 BYTE "DE SAO CARLOS - UFSCAR, COM ENTREGA NO PRIMEIRO",0	
	mcreditos5 BYTE "SEMESTRE DE 2017.",0
	
	mcreditos6 BYTE "PROJETO LICENCIADO POR GLP-3.0 E DISPONIVEL NO GITHUB",0
	mcreditos7 BYTE "EM: GITHUB.COM/MARCOSFAGLI/CLOCK-COLLORS",0
	
	mcreditos8 BYTE "DESENVOLVEDORES E MEMBROS DO GRUPO:",0			
	mcreditos9 BYTE "BRUNA ZAMITH SANTOS",0			
	mcreditos10 BYTE "RA 628093",0
	mcreditos11 BYTE "MARCOS AUGUSTO FAGLIONI JUNIOR",0			
	mcreditos12 BYTE "RA 628301",0
	
	;Dados para a tela de derrota
	mPerdeu1 BYTE "VOCE PERDEU!",0
	mPerdeu21 BYTE "VOCE FOI DESCUIDADO E O ETEVALDO SOFREU",0
	mPerdeu22 BYTE "COM AS CONSEQUENCIAS",0
	mPerdeu3 BYTE "SUA PONTUACAO: ",0
	mPerdeu4 BYTE "SEU TEMPO: ",0
	mPerdeu5 BYTE "JOGAR NOVAMENTE",0
	mPerdeu6 BYTE "SAIR",0

	;Dados para a tela de fim de jogo por tempo
	mPerdeuTempo1 BYTE "SEU TEMPO ACABOU!",0
	
.code
LimpaTela PROC
;Objetivo: Limpar a tela do jogo em substituição a função CLRSCR do Irvine, esta função apenas escreve o caracter " "(espaço) em toda a matriz que esta contida no jogo
;Recebe: Sem parâmetros
;Retorna: Sem retorno
	mov eax, black+(black*16)	;Para a função SETTEXTCOLOR deve ser passado al, onde os 4 bits HSB é a cor de fundo e os 4 LSB são a cor da letra, a multiplicação por 16 é equivalente a dar um shift de 4 bits para a esquerda
	call SETTEXTCOLOR		;Função Irvine: Configura a cor do texto recebendo como parâmetro o registrador eax
	
	mov dl, 0			;Move o cursor para a posição 0,0
	mov dh, 0
	call GOTOXY			;Função Irvine: Configura o cursor para a linha dh e a coluna dl
	
	movzx ecx, tMaxY		;Inicializa o contador do loop com a quantidade de colunas
	
LLP1:					
	mov dl, 0
	mov dh, cl
	call GOTOXY
	
	push ecx
	movzx ecx, tMaxX	;Inicializa o contador do loop com a quantidade de linhas
LLP2:
	mov al, ' '
	call WRITECHAR		;Função Irvine: Escreve um caracter no terminal, tMaxX * tMaxY vezes (declarado de forma a ser dois loops aninhados)
	loop LLP2
	
	pop ecx
	loop LLP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, 0
	call GOTOXY
	
	ret
LimpaTela ENDP

ImpPerso PROC
;Objetivo: Imprime um personagem na tela como sendo o seguinte:
;     @
;    /#\
;    / \
;Recebe: bl - Coordenada y (correspondente a coluna) que o personagem aparece, considere o centro do boneco (posição desejada do caracter '#')
;        bh - Coordenada x (correspondente a linha) que o personagem aparece, considere o centro do boneco (posição desejada do caracter '#')
;Retorna: Sem retorno
	mov eax, lightGreen+(black*16)
	call SETTEXTCOLOR
	
	mov dh, bh			;Posiciona o cursor sobre a cabeça do etevaldo
	mov dl, bl
	sub dh, 1
	call GOTOXY
	
	mov al, '@'			;Desenha a cabeça do etevaldo
	call WRITECHAR
	
	mov dl, bl			;Posiciona o cursor sobre o braço direito do etevaldo
	dec dl
	mov dh, bh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR		;Desenha o braço direito
	mov al, '#'
	call WRITECHAR		;Desenha o corpo
	mov al, '\'
	call WRITECHAR		;Desenha o braço esquerdo
	
	mov dl, bl		;Posiciona o cursor sobre a perna direita do etevaldo
	dec dl
	mov dh, bh
	inc dh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR		;Desenha a perna direita
	mov al, ' '
	call WRITECHAR		;Desenha um espaço somente para deslocar o cursor de uma forma mais rápida que GOTOXY
	mov al, '\'
	call WRITECHAR		;Desenha a perna esquerda
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	
	ret
ImpPerso ENDP


delPerso PROC
;Objetivo: Apaga o personagem sobrescrevendo-o pelo caracter " "(espaços)
;Recebe: O valor de entrada deve ser passado atravez de parâmetros armazenados na memória. Atenção, a posição X e Y passadas representa o caracter "#" exatamente no centro do boneco. Este é o parâmetro de referência para esta função
;			posXB
;			posYB
;Retorna: Sem retorno
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov dl, posXB		;Posiciona o cursor sobre a cabeça do etevaldo
	mov dh, posYB
	dec dh 
	call GOTOXY
	
	mov al, ' '		;Apaga a cabeça do etevaldo
	call WRITECHAR
	
	mov dl, posXB		;Posiciona o cursor sobre o braço direito do etevaldo
	dec dl
	mov dh, posYB
	call GOTOXY
	
	mov ecx, 3		;Configura o loop para ser executado 3 vezes, apagando assim os dois braços e o corpo
LDP1:
	mov al, ' '
	call WRITECHAR
	loop LDP1
	
	mov dh, posYB		;Posiciona o cursor sobre a perna direita do etevaldo
	mov dl, posXB
	inc dh
	dec dl
	call GOTOXY
	
	mov ecx, 3		;Configura um segundo loop para ser executado 3 vezes possibilitando apagar a duas perna
LDP2:
	mov al, ' '
	call WRITECHAR
	loop LDP2
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	
	ret
delPerso ENDP


PrintSeta PROC
;Objetivo: Apaga a seta da posição atual e reexibe na proxima opção (seta atual + distPlat), caso dl seja 0026h, ou (seta atual - distPlat), caso dl seja 0028h 
;		   Esta função verifica se a seta esta na posição mais alta antes de elevar, e verifica se esta na posição mais baixa antes de decrementar.
;Recebe: O valor de entrada deve ser passado atravez de parâmetros armazenados na memória.
;			dx - Recebe a tecla digitada antes da chamada da função
;			posSeta - Recebe os valores possiveis 1, 2 ou 3
;			distPlat
;			platInicial
;Retorna: Sem retorno
	push dx
	
	mov ax, 0
	mov al, posSeta				;Recebe a posição atual da seta
	movzx dx, distPlat
	mul dx
	add ax, platInicial			;Adiciona a multiplicação entre a distância entre as plataformas e a posSeta, com a platInicial
	
	mov dl, 20				;Seta sempre estará na coluna 20			
	mov dh, al				;Atribui a linha com o valor calculado acima
	call GOTOXY
	
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov al, ' '				;Apaga a seta
	call WRITECHAR
	call WRITECHAR
	
	pop dx
	
	cmp dx, 0026h				;Realiza a comparação do valor dx passado com o código para a seta para cima, caso seja igual: será comparado se a posição da seta já é a mais alta, se for, salta para o fim, se não, decrementa a posição da seta; caso seja diferente, o código desvia para LPS1
	jne LPS1
	cmp posSeta, 0000h
	jbe LPS2
	dec posSeta
LPS1:	
	cmp dx, 0028h				;Realiza a comparação do valor dx passado com o código para a seta para baixo, caso seja igual: será comparado se a posição da seta já é a mais baixa, se for, salta para o fim, se não, incrementa a posição da seta
	jne LPS2
	cmp posSeta, 0002h
	jae LPS2
	inc posSeta
LPS2:
	
	movzx ax, posSeta			;Preparação para a impressão da seta (utiliza as contas da mesma forma que acima (adiciona e multiplica para atribuir a linha desejada de impressão))
	movzx dx, distPlat
	mul dx
	add ax, platInicial
	
	mov dl, 20								
	mov dh, al
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'				;Impressão da seta
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
PrintSeta ENDP	

Bordas PROC
;Objetivo: Desenha todas as bordas do jogo compostas pelo caracter "!"; 2 bordas laterais, borda superior e borda inferior, com a cor da letra vermelha e a cor do fundo preta.
;Recebe: tMaxX - Quantidade de colunas que compõe o jogo
;		 tMaxY - Quantidade de linhas que compõe o jogo
;Retorna: Sem retorno
	mov eax, red+(black*16)
	call SETTEXTCOLOR
	
	movzx ecx, tMaxX			;Trecho para impressão da primeira linha da matriz do jogo, imprime tMaxX vezes o caracter "!"
	mov al, '!'
L1:
	call WRITECHAR
	loop L1

	movzx ecx, tMaxY			;Trecho para impressão dos limites laterais do Jogo, imprime tMaxY vezes o caracter '!' de cada lado do inicio e fim da barra impressa anteriormente
	mov dh, 1
L2:
	mov dl, 0
	call GOTOXY
	call WRITECHAR

	mov dl, tMaxX
	dec dl
	call GOTOXY
	call WRITECHAR
	inc dh
	loop L2


	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	movzx ecx, tMaxX			;Trecho para impressão da ultima linha da matriz do jogo, imprime tMaxX vezes o caracter "!"
L3:
	call WRITECHAR
	loop L3
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
Bordas ENDP	
	
Plataformas PROC
;Objetivo: Imprimir as plataformas do jogo compostas pelo caracter ":", na cor verde
;Recebe: platInicial, distPlat, tMaxX - Variáveis na memória
;Retorna: Sem retorno
	mov eax, green				;IRVINE green - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR
	mov ecx, 4				;Configura o contador da quantidade de plataformas (4)
	mov bx, platInicial						
	sub bx, 2
LP1:						;Propaga a execução da impressão de cada plataforma, para as 4 plataformas no jogo
	mov dl, 1
	mov dh, bl
	call GOTOXY
	add bl, distPlat
	push ecx
	movzx eax, tMaxX
	sub eax, 2
	mov ecx, eax
LP2:						;Imprime cada plataforma
	mov al, ':'
	call WRITECHAR
	loop LP2

	pop ecx
	loop LP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
Plataformas ENDP

TelaInicio PROC
;Objetivo: Imprimir a tela inicial do jogo
;Recebe: nome, biniciar, bcomoJogar, bcreditos, distPlat, tMaxX - Variáveis na memória
;Retorna: Sem retorno
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 24				;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 3
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
	movzx eax, platInicial
	mov dl, 26				;Trecho para imprimir a opção iniciar na tela principal
	mov dh, al 
	call GOTOXY
	mov edx, OFFSET biniciar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 25				;Trecho para imprimir a opção Como jogar na tela principal
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 26				;Trecho para imprimir a opção creditos na tela principal
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bcreditos
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaInicio ENDP

SorteiaCores PROC
;Sorteia as cores que liberarão a passagem do jogador para a plataforma acima
;Recebe:	corSele, coresDisp - Variáveis na memória
;Retorna:	corSele - Após a função corSele conterá duas cores selecionadase diferentes entre sí
    call Randomize              	;Configura o uso do Randomize
    mov  eax,9				;Define o intervalo do aleatório, 9 números

    call RandomRange			;Seleciona um número entre 0 e 8
    mov  corSele,ax            		;Transfere o valor aleatório para corSele

L1: mov  eax,9				;Define o intervalo do aleatório, 9 números
	call RandomRange		;Seleciona um número entre 0 e 8
    cmp ax, corSele			;Compara o segundo valor sorteado com o primeiro
    je L1                   		;Se for repetido, retorna para L1
    mov corSele[TYPE corSele],ax        ;Se não for repetido, transfere o valor de ax para corSele[2]
	
	;Armazena a primeira cor
	mov bx, corSele
	imul bx, TYPE corSele
	mov ax, [coresDisp + bx]
	mov corSele, ax
	
	;Armazena a segunda cor
	mov bx, corSele[TYPE corSele]
	imul bx, TYPE corSele
	mov ax, [coresDisp + bx]
	mov corSele[TYPE corSele], ax

	ret
SorteiaCores ENDP

ProcSetaDir PROC
;Realiza as ações caso a seta pressionada tenha sido a direita, durante o jogo
;Recebe:	tMaxX, posXB - Variáveis na memória
;Retorna:	Altera o valor de posXB
	;Verifica se o jogador por ir para a direita
	movzx eax, tMaxX					
	sub eax, 3
	cmp posXB, al	
	jae fimProcDir				;Caso não possa, ir para o fim
	
	call delPerso				;Caso possa, apaga o jogador da posição atual
	
	inc posXB				;Define a nova posição
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso				;Imprime o personagem
	
fimProcDir:
	ret
ProcSetaDir ENDP

ProcSetaEsq PROC
;Realiza as ações caso a seta pressionada tenha sido a esquerda, durante o jogo
;Recebe:	tMaxX, posXB - Variáveis na memória
;Retorna:	Altera o valor de posXB
	;Verifica se o jogador por ir para a esquerda
	cmp posXB, 2
	jbe fimProcEsq				;Caso não possa, ir para o fim
	
	call delPerso				;Caso possa, apaga o jogador da posição atual
	
	dec posXB				;Define a nova posição
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso				;Imprime o personagem
	
fimProcEsq:
	ret	
ProcSetaEsq ENDP

Colisao PROC
;Detecta se houve colisão com os obstaculos
;Recebe:	nArmadilhas, posXB - Variáveis na memória
;Retorna:	EAX - Retorna 1 em eax se não houve colisão, ou 0 caso haja colisão
	movzx ecx, nArmadilhas
	mov edi, 0
	
L1:							;Repete o laço a quantidade de armadilhas por plataforma
	mov dl, armadilhas[edi]
	cmp dl, posXB					;Caso a posição do jogador seja igual a posição de alguma armadilha, direciona o fluxo para colidiu
	je colidiu
	inc edi						;Incrementa o registrador que está contido o endereço do vetor com as posições das armadilhas
	loop L1
	
	mov eax, 1					;Armazena 1 em eax, indicando que não houve colisão
	jmp quit
	
colidiu:						;Armazena 0 em eax, indicando que houve colisão
	mov eax, 0
	
quit:
	ret
Colisao ENDP

VerificaPos PROC
;Função responsável por percorrer o vetor e verificar se o valor a ser inserido já está no vetor - esta função verifica somente para uma plataforma
;Recebe: 	eax - parâmetro passado pela pilha, e que armazena o valor do elemento a ser verifica se já pertence ao vetor
;			edi - parâmetro passado pela pilha, endereço do vetor a ser comparado
;			nArmadilhas - numero de armadilhas por platafomas
;Retorna:	ebx - retorna 1 se o valor fornecido não pertencer ao vetor; ou 0 se pertencer
	push eax
	push edx
	push ecx
	
	movzx ecx, nArmadilhas
	mov edi, OFFSET armadilhas
	movzx ebx, quantArmadilhas
	sub ebx, ecx
	add edi, ebx
	mov ebx, 1				;Armazena 1 em ebx para a saida, caso não exista o valor fornecido no vetor
	cld					;Configura a flag como 1 para indicar que a função scasb avançará o vetor
	repne scasb				;repne - repete enquanto n for igual; scasb - compara o valor em al com o valor apontado por edi (incrementa edi a cada repetição (pois a carry flag é 1)
	jnz fim
	mov ebx, 0				;Troca o valor de ebx para 0, caso já exista o valor no vetor
	
fim:						;Adiciona na pilha todos os valores dos registradores usados	
	pop ecx
	pop edx
	pop eax

	ret
VerificaPos ENDP

PrcSetaCima PROC
;Realiza as ações caso a seta pressionada tenha sido para cima, durante o jogo. Essa função valida a subida, é feita a comparação com a cor selecionada e a se colidiu com algum obstaculo
;Recebe:	corPlatAtual, corSele, nArmadilhas, armadilhas, score, quantArmadilhas, tMaxX - Variáveis na memória
;Retorna:	EAX - Retorna 0 se falhou, ou seja, se o jogador não pode subir, e 1 se o jogador pode subir
	call Colisao				;Instancia a função colidiu
	cmp eax, 0
	je diferente				;Caso tenha colidido, direcionar o fluxo de de execução para diferente

	;Verifica se a cor da plataforna no instante do salto, era compativel com a corSele
	mov ax, corPlatAtual
	cmp ax, corSele
	je igual
	mov ax, corPlatAtual
	cmp ax, (corSele+2)
	jne diferente
	
	movzx ecx, nArmadilhas
	mov ebx, OFFSET armadilhas
	
	
igual:						;Se tanto a cor da plataforma for compativel, quanto não colidiu:
	inc score				;Pontuação é acrescida
	call ApagaArm				;Apaga as armadilhas existentes
	mov ebx, 0
	movzx eax, nArmadilhas
	mov edx, 3
	mul edx
	inc eax
	movzx edx, nArmadilhas
	mov ecx, eax
	
shiftByte:					;Realiza um shift no vetor afim de resultar no efeito de abaixar as armadilhas (esta função foi implementada antes de  conhecermos o comando que realiza o shift, sendo assim, há formas mais eficientes que está.)
	mov al, armadilhas[edx]
	mov armadilhas[ebx], al 
	inc edx
	inc ebx
	loop shiftByte
	
	movzx ecx, nArmadilhas
	movzx edx, quantArmadilhas
	sub edx, ecx

;Funcionamento semelhante a cria armadilhas incial, mas aplicavel somente a uma plataforma
L1:
	call Randomize
    movzx eax, tMaxX
	sub eax, 4
	
    call RandomRange
	inc al
	call VerificaPos
	cmp ebx, 1
	jne L1
    mov  armadilhas[edx], al 
	inc edx
	loop L1
	
	mov  al, 07h 
    call WriteChar
	
	call DesenhaArm
	
	mov eax, 1
	jmp fim
	
diferente:					;Se diferente retorna que não pode subir, indicado por 0 em aex
	mov eax, 0

fim:
	ret
	
PrcSetaCima ENDP

TelaJogo PROC
;Função responsável por gerenciar a tela de jogo
;Recebe:	tempo, pontuacao, cor, posXB, posYB, contTime, cont, time - Variáveis na memória
;Retorna:	EAX - retorna 0 se perdeu por colidir com a plataforma ou por colidir com um obstáculo; 1 caso o usuário tenha pressionado 'q' para sair da tela de jogo; 2 caso o acabou o tempo
	call LimpaTela	
	call Bordas
	call Plataformas
	call TempoTela
	call ScoreTela
	call CriaArmInicio

	;Imprime as informações na tela do jogo
	mov eax, red
	call SETTEXTCOLOR
	mov dl, 6
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET tempo
	call WRITESTRING
	mov dl, 19
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET pontuacao
	call WRITESTRING
	mov dl, 35
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET cor
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov bl, posXB				;Configura a posição do personagem
	mov bh, posYB
	call ImpPerso
	
	call SorteiaCores
	call CorSelPlat
	
LTJ1:						;Executa a cada vez que cont chega em 10 (quase semelhante a 10ms)
	mov cont, 0
	inc contTime
	cmp contTime, 2
	jnae LTJ3
	call ScoreTela
	call TempoTela
	mov contTime, 0
LTJ3:						;Troca a cor da plataforma cada vez que contTime é maior ou igual a 2
	call TrocaCorPlat
LTJ2:						;Laço mais interno, verifica o comando digitado pelo usuário
	mov eax, 50
	inc cont
	cmp cont, 10
	ja LTJ1
	cmp time, 0
	jbe fimTempo
    call Delay
    call ReadKey
    jz LTJ2

	;Seleciona a ação com base no que foi digitado pelo usuário
	cmp  dx, 0026h
	je setaCima
	cmp dx, 0025h
	je setaEsq
	cmp dx, 0027h
	je setaDir
	cmp dx, 0051h
	je fimTelaJogo
	jmp LTJ2
	
;Invoca os procedimentos caso tenha sido pressionado a tecla para cima
setaCima:
	call PrcSetaCima
	cmp eax, 0
	je fimPerdeuObs
	call CorSelPlat
	jmp LTJ2
	
;Invoca os procedimentos caso tenha sido pressionado a tecla para esquerda
setaEsq:
	call ProcSetaEsq
	jmp LTJ2
	
;Invoca os procedimentos caso tenha sido pressionado a tecla para direita
setaDir:
	call ProcSetaDir
	jmp LTJ2
	
;Invoca os procedimentos caso o jogador tenha perdido por colidir com algum obstáculo
fimPerdeuObs:
	mov eax, 0
	ret
	
;Invoca os procedimentos caso o jogador tenha pressionado 'q', para sair do jogo
fimTelaJogo:	
	mov eax, 1
	ret

;Invoca os procedimentos caso o jogador tenha perdido por acabar o tempo limite
fimTempo:
	mov eax, 2
	ret
TelaJogo ENDP

TelaDificuldade PROC
;Imprime a tela de dificuldades
;Recebe:	tMaxX - Tamanho do jogo em X
;			nome, bDificuldade1, bDificuldade1, bDificuldade1 - Mensagens salvas na memória 
;Retorna:	Sem retorno
	call LimpaTela
	call Bordas
	call Plataformas
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 24				;Trecho para imprimir o nome do  jogo na tela de dificuldades
	mov dh, 3
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
	movzx eax, platInicial
	mov dl, 27
	mov dh, al 
	call GOTOXY
	mov edx, OFFSET bDificuldade1
	call WRITESTRING
	
	add al, distPlat
	mov dl, 27
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bDificuldade2
	call WRITESTRING
	
	add al, distPlat
	mov dl, 26
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bDificuldade3
	call WRITESTRING
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaDificuldade ENDP


TelaInstrucoes PROC
;Imprime a tela de créditos 
;Recebe:	tMaxX - Tamanho do jogo em X
;			nome, bcomoJogar, minstrucoes1 .. minstrucoes19 - Mensagens salvas na memória 
;Retorna:	Sem retorno
LTI3:
	call LimpaTela
	call Bordas

	mov eax, green+(black*16)
	call SETTEXTCOLOR

	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mInstrucoes1
	call WRITESTRING
	mov dl, 3
	mov dh, 5
	call GOTOXY
	mov edx, OFFSET mInstrucoes2
	call WRITESTRING
	mov dl, 3
	mov dh, 6
	call GOTOXY
	mov edx, OFFSET mInstrucoes3
	call WRITESTRING
	
	mov dl, 5
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET mInstrucoes4
	call WRITESTRING
	mov dl, 3
	mov dh, 9
	call GOTOXY
	mov edx, OFFSET mInstrucoes5
	call WRITESTRING
	mov dl, 3
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mInstrucoes6
	call WRITESTRING
	
	mov dl, 5
	mov dh, 12
	call GOTOXY
	mov edx, OFFSET mInstrucoes7
	call WRITESTRING
	mov dl, 3
	mov dh, 13
	call GOTOXY
	mov edx, OFFSET mInstrucoes8
	call WRITESTRING
	mov dl, 3
	mov dh, 14
	call GOTOXY
	mov edx, OFFSET mInstrucoes9
	call WRITESTRING

	mov dl, 5
	mov dh, 16
	call GOTOXY
	mov edx, OFFSET mInstrucoes10
	call WRITESTRING
	mov dl, 3
	mov dh, 17
	call GOTOXY
	mov edx, OFFSET mInstrucoes11
	call WRITESTRING
	mov dl, 3
	mov dh, 18
	call GOTOXY
	mov edx, OFFSET mInstrucoes12
	call WRITESTRING
	mov dl, 3
	mov dh, 19
	call GOTOXY
	mov edx, OFFSET mInstrucoes13
	call WRITESTRING
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'				;Imprime as duas setas de indicativo de avançar lateralmente
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
LTI1:						;Aguarda o comando das setas laterais, ou "q" para executar a proxima ação
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI1
	cmp  dx, 0027h
	jne LTI1
	
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	mov dl, 13
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mInstrucoes14
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 7
	call GOTOXY
	mov edx, OFFSET mInstrucoes15
	call WRITESTRING
	mov dl, 5
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mInstrucoes16
	call WRITESTRING
	mov dl, 3
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET mInstrucoes17
	call WRITESTRING
	mov dl, 5
	mov dh, 14
	call GOTOXY
	mov edx, OFFSET mInstrucoes18
	call WRITESTRING
	mov dl, 3
	mov dh, 15
	call GOTOXY
	mov edx, OFFSET mInstrucoes19
	call WRITESTRING
	
	mov dl, 3
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '<'				;Imprime as duas setas de indicativo de avançar lateralmente
	call WRITECHAR
	mov al, '-'
	call WRITECHAR
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY

LTI2:						;Aguarda o comando das setas laterais, ou "q" para executar a proxima ação
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI2
	cmp  dx, 0025h
	je LTI3
	cmp dx, 0027h
	jne LTI2
	
	ret
TelaInstrucoes ENDP

TelaCreditos PROC
;Imprime a tela de créditos 
;Recebe:	tMaxX - Tamanho do jogo em X
;			nome, bcreditos, mcreditos1 .. mcreditos12 - Mensagens salvas na memória 
;Retorna:	
	call LimpaTela
	call Bordas

	mov eax, green+(black*16)
	call SETTEXTCOLOR

	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcreditos
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mcreditos1
	call WRITESTRING
	mov dl, 3
	mov dh, 5
	call GOTOXY
	mov edx, OFFSET mcreditos2
	call WRITESTRING
	mov dl, 3
	mov dh, 6
	call GOTOXY
	mov edx, OFFSET mcreditos3
	call WRITESTRING
	mov dl, 3
	mov dh, 7
	call GOTOXY
	mov edx, OFFSET mcreditos4
	call WRITESTRING
	mov dl, 3
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET mcreditos5
	call WRITESTRING
	
	mov dl, 5
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mcreditos6
	call WRITESTRING
	mov dl, 3
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET mcreditos7
	call WRITESTRING
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 12
	mov dh, 16
	call GOTOXY
	mov edx, OFFSET mcreditos8
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 3
	mov dh, 18
	call GOTOXY
	mov edx, OFFSET mcreditos9
	call WRITESTRING
	mov dl, 30
	mov dh, 19
	call GOTOXY
	mov edx, OFFSET mcreditos10
	call WRITESTRING
	mov dl, 3
	mov dh, 21
	call GOTOXY
	mov edx, OFFSET mcreditos11
	call WRITESTRING
	mov dl, 30
	mov dh, 22
	call GOTOXY
	mov edx, OFFSET mcreditos12
	call WRITESTRING
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
LTI1:
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI1
	cmp  dx, 0027h
	jne LTI1
	
	ret
TelaCreditos ENDP

SetaTelaPerdeu PROC
;Imprime uma seta na posição desejada das telas de derrota
;Recebe:	tMaxX - Tamanho do jogo em X
;			posSeta1 - Variável na memória da posição da seta da tela de derrota
;Retorna:	Sem retorno
	push dx

	mov dl, 15
	mov dh, 18
	call GOTOXY
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	mov al, ' '
	call WRITECHAR
	call WRITECHAR
	
	mov dl, 15
	mov dh, 21
	call GOTOXY
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	mov al, ' '
	call WRITECHAR
	call WRITECHAR
	
	pop dx
	
	cmp dx, 0026h
	jne LPS1
	cmp posSeta1, 0000h
	jbe LPS2
	dec posSeta1
LPS1:	
	cmp dx, 0028h
	jne LPS2
	cmp posSeta1, 0001h
	jae LPS2
	inc posSeta1
LPS2:
	
	cmp posSeta1, 0
	je seta1
	mov dh, 21
	jmp setasai
seta1:	
	mov dh, 18
setasai:
	
	mov dl, 15
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
SetaTelaPerdeu ENDP

TelaPerdeu PROC
;Imprime a tela de derrota por colisão
;Recebe:	mPerdeu1, mPerdeu21, mPerdeu22, mPerdeu3, mPerdeu4, mPerdeu5, mPerdeu6 - Mensagens salvas na memória 
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 23
	mov dh, 3
	call GOTOXY

	mov edx, OFFSET mPerdeu1
	call WRITESTRING
	
	mov dl, 15
	mov dh, 18
	call GOTOXY

	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 10
	mov dh, 7
	call GOTOXY
	
	mov edx, OFFSET mPerdeu21
	call WRITESTRING
	
	mov dl, 19
	mov dh, 8
	call GOTOXY
	
	mov edx, OFFSET mPerdeu22
	call WRITESTRING
	
	mov dl, 22
	mov dh, 11
	call GOTOXY
	
	mov edx, OFFSET mPerdeu3
	call WRITESTRING
	
	movzx eax, score
	call WRITEDEC
	
	mov dl, 24
	mov dh, 13
	call GOTOXY
	
	mov edx, OFFSET mPerdeu4
	call WRITESTRING
	
	movzx eax, timemax
	sub al, time
	call WRITEDEC	
	
	mov dl, 22
	mov dh, 18
	call GOTOXY
	
	mov edx, OFFSET mPerdeu5
	call WRITESTRING
	
	mov dl, 27
	mov dh, 21
	call GOTOXY
	
	mov edx, OFFSET mPerdeu6
	call WRITESTRING
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaPerdeu ENDP

TelaAcabaTempo PROC
;Imprime a tela de derrota por tempo
;Recebe:	mPerdeuTempo1, mPerdeu3, mPerdeu4, mPerdeu5, mPerdeu6 - Mensagens salvas na memória 
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 21
	mov dh, 6
	call GOTOXY

	mov edx, OFFSET mPerdeuTempo1
	call WRITESTRING
	
	mov dl, 15
	mov dh, 18
	call GOTOXY
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	
	mov dl, 22
	mov dh, 11
	call GOTOXY
	
	mov edx, OFFSET mPerdeu3
	call WRITESTRING
	
	movzx eax, score
	call WRITEDEC
	
	mov dl, 24
	mov dh, 13
	call GOTOXY
	
	mov edx, OFFSET mPerdeu4
	call WRITESTRING
	
	movzx eax, timemax
	call WRITEDEC	
	
	mov dl, 22
	mov dh, 18
	call GOTOXY
	
	mov edx, OFFSET mPerdeu5
	call WRITESTRING
	
	mov dl, 27
	mov dh, 21
	call GOTOXY
	
	mov edx, OFFSET mPerdeu6
	call WRITESTRING
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaAcabaTempo ENDP

TempoTela PROC
;Imprime o tempo restante do jogador na tela
;Recebe:	time - Tempo percorrido de jogo
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	mov dl, 13
	mov dh, 1
	call GOTOXY
	movzx eax, time
	call WRITEDEC
	dec eax
	mov time, al
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	ret
TempoTela ENDP
	
ScoreTela PROC
;Imprime a pontuação
;Recebe:	score - Variável na memória que armazena o valor da pontuação
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	mov dl, 30
	mov dh, 1
	call GOTOXY
	movzx eax, score
	call WRITEDEC
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
ScoreTela ENDP

CorSelPlat PROC
;Imprime as duas cores válidas para aceitar o salto na plataforma
;Recebe:	corSele - Vetor contendo as duas cores selecionadas para aceitar o salto
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	mov dl, 49
	mov dh, 1
	call GOTOXY

	movzx eax, corSele
	mov edx, 00000016
	mul edx
	call SETTEXTCOLOR
	
	mov al, ' '
	call WRITECHAR
	
	mov dl, 51
	mov dh, 1
	call GOTOXY
	
	movzx eax, (corSele+2)
	mov edx, 00000016
	mul edx
	call SETTEXTCOLOR
	
	mov al, ' '
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY

	ret
CorSelPlat ENDP
	
ApagaArm PROC
;Função responsável por apagar as armadilhas já existentes na tela
;Recebe: 	nArmadilhas - quantidade de armadilhas por plataforma
;			armadilhas - vetor com as posições x das armadilhas
;			distPlat - Distância entre as plataformas
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	mov eax, black+(black*16)
	call SETTEXTCOLOR

	mov ecx, 4
	mov bx, 21
	sub bx, 2
	mov esi, 0
	
LP1:							;Permuta entre as 4 plataformas
	mov dh, bl
	push ecx
	
	movzx ecx, nArmadilhas
	
LP2:							;Apaga todas as armadilhas em uma plataforma
	mov dl,armadilhas[esi]
	call GOTOXY
	inc esi
	mov al, ' '
	call WRITECHAR
	loop LP2

	pop ecx
	sub bl, distPlat
	loop LP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
ApagaArm ENDP	
	
DesenhaArm PROC
;Função responsável por desenhar as armadilhas
;Recebe: 	nArmadilhas - quantidade de armadilhas por plataforma
;			armadilhas - vetor com as posições x das armadilhas
;			distPlat - Distância entre as plataformas
;			tMaxX - Tamanho do jogo em X
;Retorna:	Sem retorno
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov ecx, 4
	mov bx, 21
	sub bx, 2
	mov esi, 0
	
LP1:							;Permuta entre as 4 plataformas
	mov dh, bl
	push ecx
	
	movzx ecx, nArmadilhas
	
LP2:							;Imprime todas as armadilhas em uma plataforma
	mov dl,armadilhas[esi]	
	call GOTOXY
	inc esi
	mov al, '&'
	call WRITECHAR
	loop LP2

	pop ecx
	sub bl, distPlat
	loop LP1
	
	mov eax, white+(black*16)			;Configura o texto com a cor padrão
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
DesenhaArm ENDP

VerificaPosIni PROC
;Função responsável por percorrer o vetor e verificar se o valor a ser inserido já está no vetor
;Recebe: 	eax - parâmetro passado pela pilha, e que armazena o valor do elemento a ser verifica se já pertence ao vetor
;			edi - parâmetro passado pela pilha, endereço do vetor a ser comparado
;			nArmadilhas - numero de armadilhas por platafomas
;Retorna:	ebx - retorna 1 se o valor fornecido não pertencer ao vetor; ou 0 se pertencer
	push eax
	push ecx
	push edi
	
	movzx ecx, nArmadilhas
	mov ebx, 1				;Armazena 1 em ebx para a saida, caso não exista o valor fornecido no vetor
	cld					;Configura a flag como 1 para indicar que a função scasb avançará o vetor
	repne scasb				;repne - repete enquanto n for igual; scasb - compara o valor em al com o valor apontado por edi (incrementa edi a cada repetição (pois a carry flag é 1)
	jnz fim								
	mov ebx, 0				;Troca o valor de ebx para 0, caso já exista o valor no vetor
	
fim:						;Adiciona na pilha todos os valores dos registradores usados
	pop edi
	pop ecx
	pop eax

	ret
VerificaPosIni ENDP

CriaArmInicio PROC
;Cria as armadilhas íniciais do jogo
;Recebe: 	armadilhas - vetor com as posições x das armadilhas
;			nArmadilhas - quantidade de armadilhas por plataforma
;			tMaxX - Tamanho do jogo em X
;Retorna: Sem retorno
	mov ecx, 4					;Número de plataformas
	mov ebx, 1					;Variável auxiliar
	mov edx, 0					;Variável auxiliar
	mov edi, OFFSET armadilhas			
	
L2:							;Loop externo: Varia a plataforma da criação da armadilha
	push ebx
	push ecx
	movzx ecx, nArmadilhas
L1:							;Loop interno: Cria a posição das armadilhas de cada uma das 4 plataformas
	call Randomize					;Configura o uso do Randomize
    movzx eax, tMaxX					;Define o intervalo válido dos valores gerados aleatoriamente 0~ tamanho máximo em x
	sub eax, 4					;Retira 4 o intervalo (dois de cada uma das laterais, e dois pela distância dos braços do boneco
	
    call RandomRange					;Instancia a chamada do randomico
	inc al						;Incrementa o valor de retorno 
	call VerificaPosIni				;Verifica se a posição é válida
	cmp ebx, 1					;Compara o retorno da função, e desvia o fluxo, caso a posição sorteada já estreja no vetor
	jne L1
    mov  armadilhas[edx], al            ;Transfere o valor aleátorio para a memória
	inc edx
	loop L1
	
	pop ecx						;Reposiciona os registradores para os determinados valores
	pop ebx
	movzx eax, nArmadilhas
	push edx
	mul ebx
	pop edx
	mov edi, OFFSET armadilhas
	add edi, eax
	inc edi
	inc ebx
	loop L2
	
	call DesenhaArm					;Desenha as armadilhas

	ret
CriaArmInicio ENDP


TrocaCorPlat PROC
;Troca a cor da plaforma mais baixa
;Recebe: 	coresDisp - Vetor com as cores disponíveis
;			tMaxX - - Tamanho do jogo em X
;Retorna: 	corPlatAtual - Cor da platafoma inicial
    call Randomize						;Configura o uso do Randomize
	mov  eax, 9						;Armazena o intervalo do valor desejado - número de cores disponíveis
    call RandomRange						;Sortei um número entre 0 e 8
	imul ax, TYPE coresDisp					;Multiplica ax pelo tipo do vetor das cores das platformas
	mov bx, [coresDisp + ax]				;Transfere para bx o conteúdo de coresDisp+ax (contém o código referente a uma cor)
	
	mov corPlatAtual, bx					;Transfere para a variável que armazena a cor da plataforma atual

	movzx eax, bx
	call SETTEXTCOLOR					;Configura a cor do texto

	mov al, tMaxY						;Posiciona o cursor para a impressão da platforma
	sub al, 5
	mov dl, 1
	mov dh, al
	call GOTOXY

	movzx eax, tMaxX
	sub eax, 2
	mov ecx, eax	

LTCP1:								;Imprime a plataforma com a nova cor
	mov al, ':'
	call WRITECHAR
	loop LTCP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TrocaCorPlat ENDP
	
main PROC
;Responsável pela execução principal do jogo
;Não possui argumentos de entrada nem de saida
	call CLRSCR						;IRVINE CLRSCR - Limpa a tela
start:								;start - é invocado toda vez que é necessário voltar para tela inicial
	call LimpaTela						;Instancia a função limpa tela
	call Bordas						;Instancia a função bordas
	call Plataformas					;Instancia a função plataformas
	call TelaInicio						;Instancia a função da tela inicial
	mov posSeta, 0						;Reseta a posição da seta e da pontuação
	mov posSeta1, 0
	mov score, 0
	
	mov dl, 20						;Configura a posição inicial da seta e imprime
	mov dh, BYTE PTR [platInicial]
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
AguardaTecla1:							;Trecho responsável por ler as teclas, e printar a seta no lugar desejado
    mov  eax,50          					;Tempo para o SO esperar (50 milisegundos)
    call Delay           					;Interrompe a execução do programa pelo tempo em eax = 50 ms
    call ReadKey         					;Verifica se existe alguma tecla digitada
    jz   AguardaTecla1      				;Caso nenhuma tecla tenha sido pressionada, retorna para aguardaTecla1
	cmp  dx,000Dh  						;Compara a entrada do teclado com "enter"
	je LS1							;Caso seja "enter" direciona o programa para o trecho onde seleciona a proxima tela
	cmp dx, 0051h						;Caso seja 'q', o programa encerra
	je fim
	call PrintSeta						;Caso não seja nenhuma das opções, será chamada a função que reposiciona a seta
    jne  AguardaTecla1    					;Se o retorno da função PrintSeta não for enter, direciona para AguardaTecla1
	
LS1:								;Verifica qual o valor na variável posSeta e direciona para tela correta (tela de jogo, intruções e crédito)
	cmp posSeta, 0000h
	je jogo
	cmp posSeta, 0001h
	je instrucoes
	cmp posSeta, 0002h
	je creditos
	
jogo:								;Direcionamento para o jogo
	call TelaDificuldade

	mov dl, 20							
	mov dh, BYTE PTR [platInicial]
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
AguardaTecla2:							;Seleção da dificuldade (mesma lógica do aguardaTecla1)
    mov  eax,50
    call Delay
    call ReadKey
    jz   AguardaTecla2
	cmp  dx,000Dh
	je LS2
	cmp dx, 0051h
	je fim
	call PrintSeta
    jne  AguardaTecla2
	
LS2:								;Direciona para configurar as dificuldades
	cmp posSeta, 0000h
	je facil
	cmp posSeta, 0001h
	je medio
	cmp posSeta, 0002h
	je dificil
	
facil:								;Nivel fácil: número de armadilhas: 3; tempo: 90
	mov nArmadilhas, 3	
	mov quantArmadilhas, 12
	mov time, 90
	mov timeMax, 90
	jmp play
medio:								;Nivel fácil: número de armadilhas: 7; tempo: 60
	mov nArmadilhas, 7
	mov quantArmadilhas, 28
	mov time, 60
	mov timeMax, 60
	jmp play
dificil:							;Nivel fácil: número de armadilhas: 15; tempo: 30
	mov nArmadilhas, 15	
	mov quantArmadilhas, 60
	mov time, 30
	mov timeMax, 30
	
play:								;Chama a tela de jogo com as configurações selecionadas acima
	call TelaJogo
	cmp eax, 0
	je fim1
	cmp eax, 1
	je start
	cmp eax, 2
	je fim2
	jmp start
	
instrucoes:							;Chama a tela de instruções 
	call TelaInstrucoes
	jmp start
	
creditos:							;Chama a tela de créditos
	call TelaCreditos
	jmp start

	
fim1:								;Fim principal - esta tela é a tela de perdeu por colisão
	call TelaPerdeu
	
AguardaTecla3:
    mov  eax,50
    call Delay 
    call ReadKey
    jz   AguardaTecla3
	cmp  dx,000Dh
	je saiAguardaTecla3
	call SetaTelaPerdeu
    jne  AguardaTecla3

saiAguardaTecla3:
	cmp posSeta1, 0
	je start
	jmp fim

fim2:				;Fim alternativo: esta tela é a tela de perdeu por tempo
	call TelaAcabaTempo

AguardaTecla4:
    mov  eax,50
    call Delay 
    call ReadKey
    jz   AguardaTecla4
	cmp  dx,000Dh
	je saiAguardaTecla4
	call SetaTelaPerdeu
    jne  AguardaTecla4

saiAguardaTecla4:
	cmp posSeta1, 0
	je start
	jmp fim
	

fim:				;Fim do jogo, executa algumas configurações para não alterar o terminal após a execução 
	movzx eax, tMaxY
	inc eax
	mov dl, 0
	mov dh, al 
	call GOTOXY
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	exit
main ENDP
END main
