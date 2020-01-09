; Desafios da aula do dia 21/08 
; Microcontroladores e Aplicações
; Professor Dr. Edilson Kato
; Depto de Computação - UFSCar
; Alunos: 	Bruna Zamith Santos, RA 628093
;			Vinicius de Oliveira Peixoto, RA 628263


; Desafio 5A
; Faça um programa que comece no endereço 100H
; Ele deve colocar o valor (32)d no registrador R0 do banco 0 e movê-Io para outros bancos

org 100h			; começo em 100h
mov psw,#00000000b	; garanto que começa no banco 0
mov R0, #32			; coloca o valor 32d no banco b0
mov psw,#00001000b	; seleciono o banco 1
mov R0, #32			; coloca o valor 32 no banco b1
mov psw,#00010000b	; seleciono o banco 2
mov R0, #32			; coloca o valor 32 no banco b2
mov psw,#00011000b	; seleciono o banco 3
mov R0, #32			; coloca o valor 32 no banco b3


; ---------------------------------------------------------------

; Desafio 9A
; Faça um programa que comece no endereço 00H.
; Ele deve comparar um valor inserido em p1 com um outro valor que deve estar em R0
; (valor de sua escolha). Faça a seguinte rotina:
; Se p1 = 0, então p3 = 0
; Se p1 = r0, então p3 = (33)h
; Se p1 for diferente de r0 e diferente de 0, então p3 = (AA)h

		org 00h				; começo em 00h
		mov R0, #32			; movo valor 32 para R0
		mov A, P1			; P1 é entrada
		subb A, #00h		; comparo P1 com 0
		jz jump1			; se for igual, vai pra jump1
		mov A, P1
		subb A, R0			; comparo P1 com R0
		jz jump2			; se for igual, vai pra jump2
		mov P3, #0AAh		; senão for igual a 0 nem a R0, então recebe AAh
		jmp fim
jump1: 	mov P3, #00h		; P3 recebe 0
		jmp fim
jump2:	mov P3, #33h		; P3 recebe 33h
		jmp fim
fim: 	
		end

; ---------------------------------------------------------------

; Desafio 17A
; Faça um programa que comece no endereço 00H e observe os seguintes passos:
; ENTRADA será P1
; faça uma tabela na própria eprom desta maneira:
; ENDEREÇO 		DADO
; 0100H			(45)H
; 0101H			(05)H
; 0102H			(33)H
; 0103H			(72)H
; - Se p1 = (FF)h, some os três primeiros valores da tabela.
; - Se p1 diferente de (FF)h, some todos os valores da tabela.
; - O resultado deve ter ajuste decimal.
; - O resultado só pode ser alterado após um tempo de sua escolha.
; - Se não houver mudança em p 1 após o tempo escolhido, o acc e o carry devem ser zerados.

		org 00h				; começo em 00h
		; Cria tabela
		; Como é simulação, usamos o mov
		; Se houvesse memória externa, seria movx
		mov 50h, #45h		; endereço - dado
		mov 51h, #05h		; endereço - dado
		mov 52h, #33h		; endereço - dado
		mov 53h, #72h		; endereço - dado
		mov B, P1			; Para armazenar o valor de P1 anterior
loop:	lcall delay			; Subrotina de delay
		mov A, P1			; P1 é entrada
		subb A, B 			; Verifica se o valor de P1 mudou
		mov B, P1			; Volto com valor antigo em B
		jnz loop2			; Se o valor de P1 não foi alterado...
		clr A 				; Limpa acc
		clr C 				; Limpa carry		
loop2:	mov A, 50h			; Soma os três primeiro valores de qualquer forma
		add A, 51h
		add A, 52h
		mov R1, A 			; R1 armazena as três primeiras somas
		mov A, B 			; A recebe novamente o valor de P1
		subb A, #0FFh		; compara P1 com FFh
		jz jump1			; se for igual, vai para jump1
		mov A, R1
		add A, 53h  		; faz a última soma
		DA A 				; valor decimal
		jmp fim
jump1:	mov A, R1
		DA A
fim:	jmp loop
delay:	mov R0, #100		; delay de 200 (2*100) ciclos de máquina
delay2: djnz R0, delay2		; Decrementa, compara com 0 e se for zero, vai pro ret 
		ret		
