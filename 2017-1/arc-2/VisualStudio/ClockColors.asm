;Dados referentes a utiliza��o da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
;Este jogo refere-se ao trabalho final apresentado a disciplina de Laborat�rio de Arquitetura e Organiza��o de Computadores do Deparatamento de Computa��o da Universidade Federal de S�o Carlos -  UFSCar
;Docente respons�vel: Professor Doutor Luciano Neris
;Autores:
;	Bruna Zamith Santos		Ra 628093
;	Marcos Augusto Faglioni Junior		Ra 628301
INCLUDE Irvine32.inc

.data
	cor BYTE "COR SORTEADA:",0			;Nome do marcador das cores selecionadas
	tempo BYTE "TEMPO:", 0				;Nome do marcador de Tempo 
	pontuacao BYTE "PONTUACAO:", 0		;Nome do marcador de Pontua��o
	biniciar BYTE "INICIAR",0			;Nome do bot�o para iniciar o jogo
	bcreditos BYTE "CREDITOS",0			;Nome do bot�o para os creditos
	bcomoJogar BYTE "COMO JOGAR",0		;Nome do bot�o para as instru��es
	nome BYTE "CLOCK COLORS", 0			;Nome do Jogo
	bDificuldade1 BYTE "FACIL", 0		;Nome do bot�o para a dificuldade 1
	bDificuldade2 BYTE "MEDIO", 0		;Nome do bot�o para a dificuldade 2
	bDificuldade3 BYTE "DIFICIL", 0		;Nome do bot�o para a dificuldade 3
	timeMax BYTE 90						;Armazena o tempo maximo de jogo
	time BYTE 90						;Armazena o tempo do jogo
	score BYTE 0						;Armazena a pontua��o do jogo
	posSeta BYTE 0						;Armazena a posi��o da seta no menu 
	posSeta1 BYTE 0						;Armazena a posi��o da seta no menu 
	tMaxX BYTE 60						;Armazena a quantidade de colunas do ecr� do jogo
	tMaxY BYTE 26						;Armazena a quantidade de linhas do ecr� do jogo
	posXB BYTE 30						;Armazena a posi��o X do personagem
	posYB BYTE 24						;Armazena a posi��o Y do personagem
	distPlat BYTE 5						;Armazena a distancia entre as plataformas
	nArmadilhas BYTE 15					;Numero de armadilhas por plataforma
	quantArmadilhas BYTE 60				;Numero de elementos do vetor armadilhas
	armadilhas BYTE 60 DUP(?)			;Armazena as coordenadas x das armadilhas (s�o 3 armadilhas por plataforma)
	platInicial WORD 8					;Armazena qual � a altura Y da plataforma mais alta
	cont BYTE 0							;Contador auxiliar para trocar as cores da plataforma
	contTime BYTE 0						;Contador auxiliar para o tempo
	coresDisp WORD yellow, blue, green, 
					cyan, red, magenta, 
					white, lightRed 	;Vetor de Cores Dispon�veis para as plataformas (cores pre definidas pela biblioteca Irvine)
	corSele WORD 2 DUP(?)				;Vetor de cores sorteadas para as plataformas
	corPlatAtual WORD 1 DUP(?)			;Armazena a cor atual da plataforma imediatamente acima do personagem
	
	;Os dados seguintes salvos na mem�ria tem por objetivo armazenar o texto a ser exibido nas instruc�es
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
	
	;Os dados seguintes salvos na mem�ria tem por objetivo armazenar o texto a ser exibido nos cr�dito
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
;Objetivo: Limpar a tela do jogo em substitui��o a fun��o CLRSCR do Irvine, esta fun��o apenas escreve o caracter " "(espa�o) em toda a matriz que esta contida no jogo
;Recebe: Sem par�metros
;Retorna: Sem retorno
	mov eax, black+(black*16)	;Para a fun��o SETTEXTCOLOR deve ser passado al, onde os 4 bits HSB � a cor de fundo e os 4 LSB s�o a cor da letra, a multiplica��o por 16 � equivalente a dar um shift de 4 bits para a esquerda
	call SETTEXTCOLOR		;Fun��o Irvine: Configura a cor do texto recebendo como par�metro o registrador eax
	
	mov dl, 0			;Move o cursor para a posi��o 0,0
	mov dh, 0
	call GOTOXY			;Fun��o Irvine: Configura o cursor para a linha dh e a coluna dl
	
	movzx ecx, tMaxY		;Inicializa o contador do loop com a quantidade de colunas
	
LLP1:					
	mov dl, 0
	mov dh, cl
	call GOTOXY
	
	push ecx
	movzx ecx, tMaxX	;Inicializa o contador do loop com a quantidade de linhas
LLP2:
	mov al, ' '
	call WRITECHAR		;Fun��o Irvine: Escreve um caracter no terminal, tMaxX * tMaxY vezes (declarado de forma a ser dois loops aninhados)
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
;Recebe: bl - Coordenada y (correspondente a coluna) que o personagem aparece, considere o centro do boneco (posi��o desejada do caracter '#')
;        bh - Coordenada x (correspondente a linha) que o personagem aparece, considere o centro do boneco (posi��o desejada do caracter '#')
;Retorna: Sem retorno
	mov eax, lightGreen+(black*16)
	call SETTEXTCOLOR
	
	mov dh, bh			;Posiciona o cursor sobre a cabe�a do etevaldo
	mov dl, bl
	sub dh, 1
	call GOTOXY
	
	mov al, '@'			;Desenha a cabe�a do etevaldo
	call WRITECHAR
	
	mov dl, bl			;Posiciona o cursor sobre o bra�o direito do etevaldo
	dec dl
	mov dh, bh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR		;Desenha o bra�o direito
	mov al, '#'
	call WRITECHAR		;Desenha o corpo
	mov al, '\'
	call WRITECHAR		;Desenha o bra�o esquerdo
	
	mov dl, bl		;Posiciona o cursor sobre a perna direita do etevaldo
	dec dl
	mov dh, bh
	inc dh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR		;Desenha a perna direita
	mov al, ' '
	call WRITECHAR		;Desenha um espa�o somente para deslocar o cursor de uma forma mais r�pida que GOTOXY
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
;Objetivo: Apaga o personagem sobrescrevendo-o pelo caracter " "(espa�os)
;Recebe: O valor de entrada deve ser passado atravez de par�metros armazenados na mem�ria. Aten��o, a posi��o X e Y passadas representa o caracter "#" exatamente no centro do boneco. Este � o par�metro de refer�ncia para esta fun��o
;			posXB
;			posYB
;Retorna: Sem retorno
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov dl, posXB		;Posiciona o cursor sobre a cabe�a do etevaldo
	mov dh, posYB
	dec dh 
	call GOTOXY
	
	mov al, ' '		;Apaga a cabe�a do etevaldo
	call WRITECHAR
	
	mov dl, posXB		;Posiciona o cursor sobre o bra�o direito do etevaldo
	dec dl
	mov dh, posYB
	call GOTOXY
	
	mov ecx, 3		;Configura o loop para ser executado 3 vezes, apagando assim os dois bra�os e o corpo
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
;Objetivo: Apaga a seta da posi��o atual e reexibe na proxima op��o (seta atual + distPlat), caso dl seja 0026h, ou (seta atual - distPlat), caso dl seja 0028h 
;		   Esta fun��o verifica se a seta esta na posi��o mais alta antes de elevar, e verifica se esta na posi��o mais baixa antes de decrementar.
;Recebe: O valor de entrada deve ser passado atravez de par�metros armazenados na mem�ria.
;			dx - Recebe a tecla digitada antes da chamada da fun��o
;			posSeta - Recebe os valores possiveis 1, 2 ou 3
;			distPlat
;			platInicial
;Retorna: Sem retorno
	push dx
	
	mov ax, 0
	mov al, posSeta				;Recebe a posi��o atual da seta
	movzx dx, distPlat
	mul dx
	add ax, platInicial			;Adiciona a multiplica��o entre a dist�ncia entre as plataformas e a posSeta, com a platInicial
	
	mov dl, 20				;Seta sempre estar� na coluna 20			
	mov dh, al				;Atribui a linha com o valor calculado acima
	call GOTOXY
	
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov al, ' '				;Apaga a seta
	call WRITECHAR
	call WRITECHAR
	
	pop dx
	
	cmp dx, 0026h				;Realiza a compara��o do valor dx passado com o c�digo para a seta para cima, caso seja igual: ser� comparado se a posi��o da seta j� � a mais alta, se for, salta para o fim, se n�o, decrementa a posi��o da seta; caso seja diferente, o c�digo desvia para LPS1
	jne LPS1
	cmp posSeta, 0000h
	jbe LPS2
	dec posSeta
LPS1:	
	cmp dx, 0028h				;Realiza a compara��o do valor dx passado com o c�digo para a seta para baixo, caso seja igual: ser� comparado se a posi��o da seta j� � a mais baixa, se for, salta para o fim, se n�o, incrementa a posi��o da seta
	jne LPS2
	cmp posSeta, 0002h
	jae LPS2
	inc posSeta
LPS2:
	
	movzx ax, posSeta			;Prepara��o para a impress�o da seta (utiliza as contas da mesma forma que acima (adiciona e multiplica para atribuir a linha desejada de impress�o))
	movzx dx, distPlat
	mul dx
	add ax, platInicial
	
	mov dl, 20								
	mov dh, al
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'				;Impress�o da seta
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
;Recebe: tMaxX - Quantidade de colunas que comp�e o jogo
;		 tMaxY - Quantidade de linhas que comp�e o jogo
;Retorna: Sem retorno
	mov eax, red+(black*16)
	call SETTEXTCOLOR
	
	movzx ecx, tMaxX			;Trecho para impress�o da primeira linha da matriz do jogo, imprime tMaxX vezes o caracter "!"
	mov al, '!'
L1:
	call WRITECHAR
	loop L1

	movzx ecx, tMaxY			;Trecho para impress�o dos limites laterais do Jogo, imprime tMaxY vezes o caracter '!' de cada lado do inicio e fim da barra impressa anteriormente
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
	movzx ecx, tMaxX			;Trecho para impress�o da ultima linha da matriz do jogo, imprime tMaxX vezes o caracter "!"
L3:
	call WRITECHAR
	loop L3
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
Bordas ENDP	
	
Plataformas PROC
;Objetivo: Imprimir as plataformas do jogo compostas pelo caracter ":", na cor verde
;Recebe: platInicial, distPlat, tMaxX - Vari�veis na mem�ria
;Retorna: Sem retorno
	mov eax, green				;IRVINE green - Sele��o de cores pr� definidas no IRVINE
	call SETTEXTCOLOR
	mov ecx, 4				;Configura o contador da quantidade de plataformas (4)
	mov bx, platInicial						
	sub bx, 2
LP1:						;Propaga a execu��o da impress�o de cada plataforma, para as 4 plataformas no jogo
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
;Recebe: nome, biniciar, bcomoJogar, bcreditos, distPlat, tMaxX - Vari�veis na mem�ria
;Retorna: Sem retorno
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 24				;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 3
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
	movzx eax, platInicial
	mov dl, 26				;Trecho para imprimir a op��o iniciar na tela principal
	mov dh, al 
	call GOTOXY
	mov edx, OFFSET biniciar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 25				;Trecho para imprimir a op��o Como jogar na tela principal
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 26				;Trecho para imprimir a op��o creditos na tela principal
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
;Sorteia as cores que liberar�o a passagem do jogador para a plataforma acima
;Recebe:	corSele, coresDisp - Vari�veis na mem�ria
;Retorna:	corSele - Ap�s a fun��o corSele conter� duas cores selecionadase diferentes entre s�
    call Randomize              	;Configura o uso do Randomize
    mov  eax,9				;Define o intervalo do aleat�rio, 9 n�meros

    call RandomRange			;Seleciona um n�mero entre 0 e 8
    mov  corSele,ax            		;Transfere o valor aleat�rio para corSele

L1: mov  eax,9				;Define o intervalo do aleat�rio, 9 n�meros
	call RandomRange		;Seleciona um n�mero entre 0 e 8
    cmp ax, corSele			;Compara o segundo valor sorteado com o primeiro
    je L1                   		;Se for repetido, retorna para L1
    mov corSele[TYPE corSele],ax        ;Se n�o for repetido, transfere o valor de ax para corSele[2]
	
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
;Realiza as a��es caso a seta pressionada tenha sido a direita, durante o jogo
;Recebe:	tMaxX, posXB - Vari�veis na mem�ria
;Retorna:	Altera o valor de posXB
	;Verifica se o jogador por ir para a direita
	movzx eax, tMaxX					
	sub eax, 3
	cmp posXB, al	
	jae fimProcDir				;Caso n�o possa, ir para o fim
	
	call delPerso				;Caso possa, apaga o jogador da posi��o atual
	
	inc posXB				;Define a nova posi��o
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso				;Imprime o personagem
	
fimProcDir:
	ret
ProcSetaDir ENDP

ProcSetaEsq PROC
;Realiza as a��es caso a seta pressionada tenha sido a esquerda, durante o jogo
;Recebe:	tMaxX, posXB - Vari�veis na mem�ria
;Retorna:	Altera o valor de posXB
	;Verifica se o jogador por ir para a esquerda
	cmp posXB, 2
	jbe fimProcEsq				;Caso n�o possa, ir para o fim
	
	call delPerso				;Caso possa, apaga o jogador da posi��o atual
	
	dec posXB				;Define a nova posi��o
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso				;Imprime o personagem
	
fimProcEsq:
	ret	
ProcSetaEsq ENDP

Colisao PROC
;Detecta se houve colis�o com os obstaculos
;Recebe:	nArmadilhas, posXB - Vari�veis na mem�ria
;Retorna:	EAX - Retorna 1 em eax se n�o houve colis�o, ou 0 caso haja colis�o
	movzx ecx, nArmadilhas
	mov edi, 0
	
L1:							;Repete o la�o a quantidade de armadilhas por plataforma
	mov dl, armadilhas[edi]
	cmp dl, posXB					;Caso a posi��o do jogador seja igual a posi��o de alguma armadilha, direciona o fluxo para colidiu
	je colidiu
	inc edi						;Incrementa o registrador que est� contido o endere�o do vetor com as posi��es das armadilhas
	loop L1
	
	mov eax, 1					;Armazena 1 em eax, indicando que n�o houve colis�o
	jmp quit
	
colidiu:						;Armazena 0 em eax, indicando que houve colis�o
	mov eax, 0
	
quit:
	ret
Colisao ENDP

VerificaPos PROC
;Fun��o respons�vel por percorrer o vetor e verificar se o valor a ser inserido j� est� no vetor - esta fun��o verifica somente para uma plataforma
;Recebe: 	eax - par�metro passado pela pilha, e que armazena o valor do elemento a ser verifica se j� pertence ao vetor
;			edi - par�metro passado pela pilha, endere�o do vetor a ser comparado
;			nArmadilhas - numero de armadilhas por platafomas
;Retorna:	ebx - retorna 1 se o valor fornecido n�o pertencer ao vetor; ou 0 se pertencer
	push eax
	push edx
	push ecx
	
	movzx ecx, nArmadilhas
	mov edi, OFFSET armadilhas
	movzx ebx, quantArmadilhas
	sub ebx, ecx
	add edi, ebx
	mov ebx, 1				;Armazena 1 em ebx para a saida, caso n�o exista o valor fornecido no vetor
	cld					;Configura a flag como 1 para indicar que a fun��o scasb avan�ar� o vetor
	repne scasb				;repne - repete enquanto n for igual; scasb - compara o valor em al com o valor apontado por edi (incrementa edi a cada repeti��o (pois a carry flag � 1)
	jnz fim
	mov ebx, 0				;Troca o valor de ebx para 0, caso j� exista o valor no vetor
	
fim:						;Adiciona na pilha todos os valores dos registradores usados	
	pop ecx
	pop edx
	pop eax

	ret
VerificaPos ENDP

PrcSetaCima PROC
;Realiza as a��es caso a seta pressionada tenha sido para cima, durante o jogo. Essa fun��o valida a subida, � feita a compara��o com a cor selecionada e a se colidiu com algum obstaculo
;Recebe:	corPlatAtual, corSele, nArmadilhas, armadilhas, score, quantArmadilhas, tMaxX - Vari�veis na mem�ria
;Retorna:	EAX - Retorna 0 se falhou, ou seja, se o jogador n�o pode subir, e 1 se o jogador pode subir
	call Colisao				;Instancia a fun��o colidiu
	cmp eax, 0
	je diferente				;Caso tenha colidido, direcionar o fluxo de de execu��o para diferente

	;Verifica se a cor da plataforna no instante do salto, era compativel com a corSele
	mov ax, corPlatAtual
	cmp ax, corSele
	je igual
	mov ax, corPlatAtual
	cmp ax, (corSele+2)
	jne diferente
	
	movzx ecx, nArmadilhas
	mov ebx, OFFSET armadilhas
	
	
igual:						;Se tanto a cor da plataforma for compativel, quanto n�o colidiu:
	inc score				;Pontua��o � acrescida
	call ApagaArm				;Apaga as armadilhas existentes
	mov ebx, 0
	movzx eax, nArmadilhas
	mov edx, 3
	mul edx
	inc eax
	movzx edx, nArmadilhas
	mov ecx, eax
	
shiftByte:					;Realiza um shift no vetor afim de resultar no efeito de abaixar as armadilhas (esta fun��o foi implementada antes de  conhecermos o comando que realiza o shift, sendo assim, h� formas mais eficientes que est�.)
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
	
diferente:					;Se diferente retorna que n�o pode subir, indicado por 0 em aex
	mov eax, 0

fim:
	ret
	
PrcSetaCima ENDP

TelaJogo PROC
;Fun��o respons�vel por gerenciar a tela de jogo
;Recebe:	tempo, pontuacao, cor, posXB, posYB, contTime, cont, time - Vari�veis na mem�ria
;Retorna:	EAX - retorna 0 se perdeu por colidir com a plataforma ou por colidir com um obst�culo; 1 caso o usu�rio tenha pressionado 'q' para sair da tela de jogo; 2 caso o acabou o tempo
	call LimpaTela	
	call Bordas
	call Plataformas
	call TempoTela
	call ScoreTela
	call CriaArmInicio

	;Imprime as informa��es na tela do jogo
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
	
	mov bl, posXB				;Configura a posi��o do personagem
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
LTJ3:						;Troca a cor da plataforma cada vez que contTime � maior ou igual a 2
	call TrocaCorPlat
LTJ2:						;La�o mais interno, verifica o comando digitado pelo usu�rio
	mov eax, 50
	inc cont
	cmp cont, 10
	ja LTJ1
	cmp time, 0
	jbe fimTempo
    call Delay
    call ReadKey
    jz LTJ2

	;Seleciona a a��o com base no que foi digitado pelo usu�rio
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
	
;Invoca os procedimentos caso o jogador tenha perdido por colidir com algum obst�culo
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
;			nome, bDificuldade1, bDificuldade1, bDificuldade1 - Mensagens salvas na mem�ria 
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
;Imprime a tela de cr�ditos 
;Recebe:	tMaxX - Tamanho do jogo em X
;			nome, bcomoJogar, minstrucoes1 .. minstrucoes19 - Mensagens salvas na mem�ria 
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
	
	mov al, '-'				;Imprime as duas setas de indicativo de avan�ar lateralmente
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
LTI1:						;Aguarda o comando das setas laterais, ou "q" para executar a proxima a��o
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
	
	mov al, '<'				;Imprime as duas setas de indicativo de avan�ar lateralmente
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

LTI2:						;Aguarda o comando das setas laterais, ou "q" para executar a proxima a��o
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
;Imprime a tela de cr�ditos 
;Recebe:	tMaxX - Tamanho do jogo em X
;			nome, bcreditos, mcreditos1 .. mcreditos12 - Mensagens salvas na mem�ria 
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
;Imprime uma seta na posi��o desejada das telas de derrota
;Recebe:	tMaxX - Tamanho do jogo em X
;			posSeta1 - Vari�vel na mem�ria da posi��o da seta da tela de derrota
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
;Imprime a tela de derrota por colis�o
;Recebe:	mPerdeu1, mPerdeu21, mPerdeu22, mPerdeu3, mPerdeu4, mPerdeu5, mPerdeu6 - Mensagens salvas na mem�ria 
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
;Recebe:	mPerdeuTempo1, mPerdeu3, mPerdeu4, mPerdeu5, mPerdeu6 - Mensagens salvas na mem�ria 
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
;Imprime a pontua��o
;Recebe:	score - Vari�vel na mem�ria que armazena o valor da pontua��o
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
;Imprime as duas cores v�lidas para aceitar o salto na plataforma
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
;Fun��o respons�vel por apagar as armadilhas j� existentes na tela
;Recebe: 	nArmadilhas - quantidade de armadilhas por plataforma
;			armadilhas - vetor com as posi��es x das armadilhas
;			distPlat - Dist�ncia entre as plataformas
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
;Fun��o respons�vel por desenhar as armadilhas
;Recebe: 	nArmadilhas - quantidade de armadilhas por plataforma
;			armadilhas - vetor com as posi��es x das armadilhas
;			distPlat - Dist�ncia entre as plataformas
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
	
	mov eax, white+(black*16)			;Configura o texto com a cor padr�o
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
DesenhaArm ENDP

VerificaPosIni PROC
;Fun��o respons�vel por percorrer o vetor e verificar se o valor a ser inserido j� est� no vetor
;Recebe: 	eax - par�metro passado pela pilha, e que armazena o valor do elemento a ser verifica se j� pertence ao vetor
;			edi - par�metro passado pela pilha, endere�o do vetor a ser comparado
;			nArmadilhas - numero de armadilhas por platafomas
;Retorna:	ebx - retorna 1 se o valor fornecido n�o pertencer ao vetor; ou 0 se pertencer
	push eax
	push ecx
	push edi
	
	movzx ecx, nArmadilhas
	mov ebx, 1				;Armazena 1 em ebx para a saida, caso n�o exista o valor fornecido no vetor
	cld					;Configura a flag como 1 para indicar que a fun��o scasb avan�ar� o vetor
	repne scasb				;repne - repete enquanto n for igual; scasb - compara o valor em al com o valor apontado por edi (incrementa edi a cada repeti��o (pois a carry flag � 1)
	jnz fim								
	mov ebx, 0				;Troca o valor de ebx para 0, caso j� exista o valor no vetor
	
fim:						;Adiciona na pilha todos os valores dos registradores usados
	pop edi
	pop ecx
	pop eax

	ret
VerificaPosIni ENDP

CriaArmInicio PROC
;Cria as armadilhas �niciais do jogo
;Recebe: 	armadilhas - vetor com as posi��es x das armadilhas
;			nArmadilhas - quantidade de armadilhas por plataforma
;			tMaxX - Tamanho do jogo em X
;Retorna: Sem retorno
	mov ecx, 4					;N�mero de plataformas
	mov ebx, 1					;Vari�vel auxiliar
	mov edx, 0					;Vari�vel auxiliar
	mov edi, OFFSET armadilhas			
	
L2:							;Loop externo: Varia a plataforma da cria��o da armadilha
	push ebx
	push ecx
	movzx ecx, nArmadilhas
L1:							;Loop interno: Cria a posi��o das armadilhas de cada uma das 4 plataformas
	call Randomize					;Configura o uso do Randomize
    movzx eax, tMaxX					;Define o intervalo v�lido dos valores gerados aleatoriamente 0~ tamanho m�ximo em x
	sub eax, 4					;Retira 4 o intervalo (dois de cada uma das laterais, e dois pela dist�ncia dos bra�os do boneco
	
    call RandomRange					;Instancia a chamada do randomico
	inc al						;Incrementa o valor de retorno 
	call VerificaPosIni				;Verifica se a posi��o � v�lida
	cmp ebx, 1					;Compara o retorno da fun��o, e desvia o fluxo, caso a posi��o sorteada j� estreja no vetor
	jne L1
    mov  armadilhas[edx], al            ;Transfere o valor ale�torio para a mem�ria
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
;Recebe: 	coresDisp - Vetor com as cores dispon�veis
;			tMaxX - - Tamanho do jogo em X
;Retorna: 	corPlatAtual - Cor da platafoma inicial
    call Randomize						;Configura o uso do Randomize
	mov  eax, 9						;Armazena o intervalo do valor desejado - n�mero de cores dispon�veis
    call RandomRange						;Sortei um n�mero entre 0 e 8
	imul ax, TYPE coresDisp					;Multiplica ax pelo tipo do vetor das cores das platformas
	mov bx, [coresDisp + ax]				;Transfere para bx o conte�do de coresDisp+ax (cont�m o c�digo referente a uma cor)
	
	mov corPlatAtual, bx					;Transfere para a vari�vel que armazena a cor da plataforma atual

	movzx eax, bx
	call SETTEXTCOLOR					;Configura a cor do texto

	mov al, tMaxY						;Posiciona o cursor para a impress�o da platforma
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
;Respons�vel pela execu��o principal do jogo
;N�o possui argumentos de entrada nem de saida
	call CLRSCR						;IRVINE CLRSCR - Limpa a tela
start:								;start - � invocado toda vez que � necess�rio voltar para tela inicial
	call LimpaTela						;Instancia a fun��o limpa tela
	call Bordas						;Instancia a fun��o bordas
	call Plataformas					;Instancia a fun��o plataformas
	call TelaInicio						;Instancia a fun��o da tela inicial
	mov posSeta, 0						;Reseta a posi��o da seta e da pontua��o
	mov posSeta1, 0
	mov score, 0
	
	mov dl, 20						;Configura a posi��o inicial da seta e imprime
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
	
AguardaTecla1:							;Trecho respons�vel por ler as teclas, e printar a seta no lugar desejado
    mov  eax,50          					;Tempo para o SO esperar (50 milisegundos)
    call Delay           					;Interrompe a execu��o do programa pelo tempo em eax = 50 ms
    call ReadKey         					;Verifica se existe alguma tecla digitada
    jz   AguardaTecla1      				;Caso nenhuma tecla tenha sido pressionada, retorna para aguardaTecla1
	cmp  dx,000Dh  						;Compara a entrada do teclado com "enter"
	je LS1							;Caso seja "enter" direciona o programa para o trecho onde seleciona a proxima tela
	cmp dx, 0051h						;Caso seja 'q', o programa encerra
	je fim
	call PrintSeta						;Caso n�o seja nenhuma das op��es, ser� chamada a fun��o que reposiciona a seta
    jne  AguardaTecla1    					;Se o retorno da fun��o PrintSeta n�o for enter, direciona para AguardaTecla1
	
LS1:								;Verifica qual o valor na vari�vel posSeta e direciona para tela correta (tela de jogo, intru��es e cr�dito)
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
	
AguardaTecla2:							;Sele��o da dificuldade (mesma l�gica do aguardaTecla1)
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
	
facil:								;Nivel f�cil: n�mero de armadilhas: 3; tempo: 90
	mov nArmadilhas, 3	
	mov quantArmadilhas, 12
	mov time, 90
	mov timeMax, 90
	jmp play
medio:								;Nivel f�cil: n�mero de armadilhas: 7; tempo: 60
	mov nArmadilhas, 7
	mov quantArmadilhas, 28
	mov time, 60
	mov timeMax, 60
	jmp play
dificil:							;Nivel f�cil: n�mero de armadilhas: 15; tempo: 30
	mov nArmadilhas, 15	
	mov quantArmadilhas, 60
	mov time, 30
	mov timeMax, 30
	
play:								;Chama a tela de jogo com as configura��es selecionadas acima
	call TelaJogo
	cmp eax, 0
	je fim1
	cmp eax, 1
	je start
	cmp eax, 2
	je fim2
	jmp start
	
instrucoes:							;Chama a tela de instru��es 
	call TelaInstrucoes
	jmp start
	
creditos:							;Chama a tela de cr�ditos
	call TelaCreditos
	jmp start

	
fim1:								;Fim principal - esta tela � a tela de perdeu por colis�o
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

fim2:				;Fim alternativo: esta tela � a tela de perdeu por tempo
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
	

fim:				;Fim do jogo, executa algumas configura��es para n�o alterar o terminal ap�s a execu��o 
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
