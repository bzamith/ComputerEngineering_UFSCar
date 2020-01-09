#Trabalho 1 de Matemática Computacional
#Desafio 1: Algoritmo Simplex
#Implementar o algoritmo simplex para resolver problemas de programação linear na forma canônica (problema de maximização com restrições de menor e igual)

#Alunos: Bruna Zamith Santos (RA:628093) e Rodrigo Prata Salmen (RA: 598208)
#Data: 11/04/2017

#Linguagem: Python

#Especificações: O programa recebe uma matriz n x m 

#!/usr/bin/env python # -*- coding: utf-8 -*-

import math #importa a biblioteca matemática

def recebeMatrizInicial(linhas,colunas): #função que recebe a matriz do usuário
    matriz=[[0]*colunas for i in range(linhas)] #inicializa matriz linhas*colunas com '0'
    for i in range(0,linhas):
        for j in range(0,colunas):
            matriz[i][j]=int(input("Valor da linha " + str(i) + " e coluna " + str(j) + ":")) #lê o valor e transforma em inteiro
    return matriz

def achaColunaPivo(matriz,colunas): #função que acha a coluna pivô
    pivo = 0
    for j in range(0,colunas): #a linha zero é a linha Z, deve-se achar o primeiro negativo
        if matriz[0][j]<0:
            pivo=j
            break
    return pivo

def achaLinhaPivo(matriz,linhas,colunas,colunaPivo): #funcao que acha a linha pivô
    pivo = 0
    menor = 10000000 #numero suficientemente grande
    for i in range(1, linhas): #percorre as linhas, ignorando-se a linha Z (0) 
        if matriz[i][colunaPivo]!=0: #se for zero, a divisão é infinito, então não precisa fazer
            if matriz[i][colunas-1]/matriz[i][colunaPivo] < menor : #se for menor que o menor atual
                if matriz[i][colunas-1]/matriz[i][colunaPivo] > 0 : #se nao for negativo
                    menor = matriz[i][colunas-1]/matriz[i][colunaPivo]
                    pivo = i
    if menor == 10000000: #entao todos deram infinito ou negativo
        pivo = -1 #indica que deu problema
    return pivo

def multiplicaLinhaMatriz(matriz,linhaPivo,linhaAtual,fatorMult,colunas): #funcao auxiliar do Gauss
    for j in range(0,colunas):
        matriz[linhaAtual][j] = (matriz[linhaPivo][j]*fatorMult) - matriz[linhaAtual][j]
    if(linhaAtual==0): #se for a linha Z, nunca pode ser negativo depois da multiplicação
        if matriz[linhaAtual][0]<0:
            for j in range(0,colunas):
                matriz[linhaAtual][j]=matriz[linhaAtual][j]*(-1)
                if matriz[linhaAtual][j]==-0: #não existe -0
                    matriz[linhaAtual][j]=0
    return matriz

def fazGauss(matriz,linhas,colunas,linhaPivo,colunaPivo): #faz Gauss de acordo com o numero pivô
    for i in range(0,linhas):
        if i!=linhaPivo:
            if matriz[i][colunaPivo]!=int(0): #se for zero, nao precisa fazer
                fatorMult=matriz[i][colunaPivo]/matriz[linhaPivo][colunaPivo]
                matriz=multiplicaLinhaMatriz(matriz,linhaPivo,i,fatorMult,colunas)
    return matriz

def corrigeTabela(matriz,linhas,colunas): #se tiver -0, tem que multiplicar toda a linha
    for i in range(0,linhas):
        for j in range(0,colunas):
            if str(matriz[i][j])=="-0.0":
                for k in range(0,colunas):
                    if str(matriz[i][k])!="0" and str(matriz[i][k])!="0.0":
                        matriz[i][k]=matriz[i][k]*(-1)
    return matriz
	
#MAIN
print("\n\n****Programa Simplex Tabular! A entrada principal é a própria tabela!****\n\n")
linhas=int(input("Numero de linhas da tabela (Z, x1, x2, ..., xn): ")) #recebe o número de linhas e transforma em inteiro
colunas=int(input("Numero de colunas da tabela (Z, x1, x2, ..., xn, const): ")) #recebe o número de colunas e transforma em inteiro

encerra=0 #variavel que indica o encerramento do processo, porque achou a solucao otima

matriz = recebeMatrizInicial(linhas,colunas)

while encerra!=1: #enquanto encerra não for 1, não temos a solução otima e continua
    colunaPivo=achaColunaPivo(matriz,colunas) #acha a colunaPivo
    print("Coluna pivo: " + str(colunaPivo))
    if colunaPivo==0: #se a coluna pivo for 0, não tem mais nenhum negativo e acabou
        encerra=1 #variavel encerra
        break #sai do loop while
    else:
        linhaPivo=achaLinhaPivo(matriz,linhas,colunas,colunaPivo) #acha a linha pivo
        print("Linha pivo: " + str(linhaPivo))
        if linhaPivo == -1: #deu problema
            encerra = -2 #deu problema
            break #sai do looop
        print("Ponto: " + str(matriz[linhaPivo][colunaPivo]))
        matriz=fazGauss(matriz,linhas,colunas,linhaPivo,colunaPivo) #faz o Gauss

if encerra!=-2: #se nao deu problema
    print("Solucao Otima:") #mostra a solução ótima, isto é
    print(matriz[0][colunas-1]) #o valor de Z max
    #print("Matriz Final:")
    #print(corrigeTabela(matriz,linhas,colunas))
else: #se deu problema
    print("Nao foi possivel obter a solucao otima!")

    
