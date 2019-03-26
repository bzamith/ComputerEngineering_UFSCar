; Display LCD indicando o valor do teclado

; Bruna Zamith (628093)
; Vinicius Peixoto (628263)

	org 0h
	lcall config_lcd
	lcall config_lcd
inicio: lcall sobrescreve
	mov r7, #0FFh
; P3 recebe o valor da coluna, que fica alternando
; Em P0 esta o valor da linha
; Combinacaoo P3 com P0 indica o botao pressionado
	mov p3, #80h
	mov A, p0
	anl A, #01h
; Coluna 0
	cjne A, #01h, label0
	mov DPTR, #mensa1
	jmp imprime
label0: call atraso
	mov A, p0
	anl A, #02h
	cjne A, #02h, label1
	mov DPTR, #mensa4
	jmp imprime
label1:	mov A, p0
	anl A, #04h
	cjne A, #04h, label2
	mov DPTR, #mensa7
	jmp imprime
label2:	mov A, p0
	anl A, #08h
	cjne A, #08h, label3
	mov DPTR, #mensa10
	jmp imprime
; Coluna 2
label3: lcall sobrescreve
	mov p3, #40h
	mov A, p0
	anl A, #01h
	cjne A, #01h, label4
	mov p2, #0F0h
	mov DPTR, #mensa2
	jmp imprime
label4:	mov A, p0
	anl A, #02h
	cjne A, #02h, label5
	mov DPTR, #mensa5
	jmp imprime
label5:	mov A, p0
	anl A, #04h
	cjne A, #04h, label6
	mov DPTR, #mensa8
	jmp imprime
label6: mov A, p0
	anl A, #08h
	cjne A, #08h, label7
	mov DPTR, #mensa0
	jmp imprime
; Inicio devido a estouro de endereco maximo
inicio_inter:
	jmp inicio
; Coluna 3
label7:	lcall sobrescreve
	mov p3, #20h
	mov A, p0
	anl A, #01h
	cjne A, #01h, label8
	mov DPTR, #mensa3
	jmp imprime
label8:	mov A, p0
	anl A, #02h
	cjne A, #02h, label9
	mov DPTR, #mensa6
	jmp imprime
label9: mov A, p0
	anl A, #04h
	cjne A, #04h, label10
	mov DPTR, #mensa9
	jmp imprime
label10:mov A, p0
	anl A, #08h
	cjne A, #08h, inicio_inter
	mov DPTR, #mensa11
	jmp imprime

; Imprime a mensagem
imprime:inc r7
	mov A, r7
	movc A, @A+DPTR
	mov p1, A
	lcall habi_dado
	cjne A, #0FEh, imprime
	call atraso
	jmp inicio

; Configuracoes iniciais do LCD
config_lcd:
	mov p1, #38h
	lcall habi_inst
	mov p1, #38h
	lcall habi_inst
	mov p1, #06h
	lcall habi_inst
	mov p1, #0Ch
	lcall habi_inst
	mov p1, #01h
	lcall habi_inst
	ret
	
; Habita instruçoes no LCD
habi_inst:
	mov p2, #01h
	mov p2, #00h
	lcall atraso
	ret
	
; Habilita dado no LCD
habi_dado:
	mov p2, #03h
	mov p2, #02h
	lcall atraso
	ret
	
; Atraso de 10000 ciclos
atraso:
	mov r1, #014h
volta:  mov r0, #0FAh
	djnz r0, $
	djnz r1, volta
	ret

; Ao inves de resetar o LCD toda vez, apenas coloca o cursor na posicao inicial	
sobrescreve:
	mov p1, #02h
	lcall habi_inst
	ret

; Mensagens a serem impressas
mensa0: db '0', 0FEh	
mensa1: db '1', 0FEh
mensa2: db '2', 0FEh
mensa3: db '3', 0FEh
mensa4: db '4', 0FEh
mensa5: db '5', 0FEh
mensa6: db '6', 0FEh
mensa7: db '7', 0FEh
mensa8: db '8', 0FEh
mensa9: db '9', 0FEh
mensa10: db '*', 0FEh
mensa11: db '#', 0FEh


END
