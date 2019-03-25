#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include<time.h>
#include "FuncoesLetris1.h"
#include "Pilha.h"
#include "AssociaLetra.h"
#include "Destroi.h"
#include "EmpilhaNaPilhaCerta.h"
#include "EstaNaPilha.h"
#include "AssociaPilha.h"
#include "ChamaTelaJogo.h"
#include "MenuInicial.h"
#include "TelaDificuldade.h"
#include "TelaPerdeu.h"
#include "TelaInstrucoes1.h"
#include "TelaInstrucoes2.h"
#include "TelaInstrucoes3.h"
#include "TelaInstrucoes4.h"


#ifndef NUM_LETRAS
#define NUM_LETRAS 300 //numero maximo de quadrados que o jogo aceita, se passar disso, o jogo deverá finalizar e o jogador perde
#endif
#ifndef TAM_LETRAS
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#endif
#ifndef QTD_LETRAS
#define QTD_LETRAS 16 //qntd de letras diferentes
#endif
#ifndef DIST_PILHAS
#define DIST_PILHAS 15 //distancia entre as pilhas
#endif
#ifndef TAMY
#define TAMY 10 //numero maximo em y
#endif
#ifndef FIM
#define FIM (TAM_LETRAS*TAMY) //posicao da tela que indica o final dela
#endif
#ifndef BORDAESQ
#define BORDAESQ 0 //define o limite lateral esquerdo
#endif
#ifndef PALAVRASDISPONIVEIS
#define PALAVRASDISPONIVEIS 10 //qntd de palavras no banco de palavras
#endif
#ifndef PALAVRASSELECIONADAS
#define PALAVRASSELECIONADAS 3 //palavras selecionadas por jogo
#endif
#ifndef QTD_PILHAS
#define QTD_PILHAS 6 //numero de colunas (pilhas) do jogo
#endif
#ifndef BORDADIR
#define BORDADIR (QTD_PILHAS-1)*(TAM_LETRAS+DIST_PILHAS) //define o limite lateral direito
#endif
#ifndef INI
#define INI ((QTD_PILHAS*(TAM_LETRAS+DIST_PILHAS))-BORDAESQ)/2 //define o inicio
#endif


int main() {
	sf::RenderWindow window(sf::VideoMode(600, 600), "Letris 2"); //Inicializa a tela
	int tela;
	int pontuacao = 0;
	int dificuldade;
	tela = menuInicial(window);
	if (tela == 1) {
		dificuldade = telaDificuldade(window);
		tela = ChamaTelaJogo(window, dificuldade, pontuacao);
		telaPerdeu(window, pontuacao);
	}
	if (tela == 2) {
		tela = tela1Instucoes(window);
		tela = tela2Instucoes(window);
		tela = tela3Instucoes(window);
		tela = tela4Instucoes(window);
		dificuldade = telaDificuldade(window);
		tela = ChamaTelaJogo(window, dificuldade, pontuacao);
		telaPerdeu(window, pontuacao);
	}
	return 0;
}