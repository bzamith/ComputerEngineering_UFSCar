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
#include "DesempilhaUm.h"

void imprimePilha(Pilha<char> *P) {
	Pilha <char> Paux(P->Tamanho);
	char X;
	bool DeuCerto;

	while (P->Vazio() == false) {
		P->Desempilha(X, DeuCerto);
		Paux.Empilha(X, DeuCerto);
		cout << X << " ";
	}
	while (Paux.Vazio() == false) {
		Paux.Desempilha(X, DeuCerto);
		P->Empilha(X, DeuCerto);
	}
}


int ChamaTelaJogo(sf::RenderWindow &window, int dificuldade, int &pontuacao){

#ifndef NUM_LETRAS
#define NUM_LETRAS 300 //numero maximo de quadrados que o jogo aceita, se passar disso, o jogo deverá finalizar e o jogador perde
#endif
#ifndef TAM_LETRAS
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#endif
#ifndef QTD_LETRAS
#define QTD_LETRAS 17 //qntd de letras diferentes
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


using namespace std;
int qtd_letras2;
	sf::Font font;
	font.loadFromFile("fonte.TTF"); //lê a fonte
	sf::Font font2;
	font2.loadFromFile("fonte2.TTF");
	Pilha<char> pilha0(TAMY);
	Pilha<char> pilha1(TAMY);
	Pilha<char> pilha2(TAMY);
	Pilha<char> pilha3(TAMY);
	Pilha<char> pilha4(TAMY);
	Pilha<char> pilha5(TAMY);
	sf::Texture texture[QTD_LETRAS];
	texture[0].loadFromFile("letraa.png"); //lê as texturas
	texture[1].loadFromFile("letrac.png"); //lê as texturas
	texture[2].loadFromFile("letrae.png"); //lê as texturas
	texture[3].loadFromFile("letrag.png"); //lê as texturas
	texture[4].loadFromFile("letral.png"); //lê as texturas
	texture[5].loadFromFile("letrao.png"); //lê as texturas
	texture[6].loadFromFile("letrap.png"); //lê as texturas
	texture[7].loadFromFile("letrar.png"); //lê as texturas
	texture[8].loadFromFile("letras.png"); //lê as texturas
	texture[9].loadFromFile("letrat.png"); //lê as texturas
	texture[10].loadFromFile("letraespecial.png"); //lê as texturas
	texture[11].loadFromFile("letraespecial2.png"); //lê as texturas
	texture[12].loadFromFile("letrat.png"); //lê as texturas
	texture[13].loadFromFile("letrap.png"); //lê as texturas
	texture[14].loadFromFile("letraa.png"); //lê as texturas
	texture[15].loadFromFile("letrao.png"); //lê as texturas
	texture[16].loadFromFile("letrao.png"); //lê as texturas

	float tempo = 0.5;

	//logo 
	sf::Texture logo;
	logo.loadFromFile("logopng.png"); //lê o logo
	sf::Sprite ologo;
	ologo.setTexture(logo); //textura do primeiro
	ologo.setPosition(350, 10); //posicao do primeiro
								//ologo.setScale(sf::Vector2f(1, 1)); //escala do primeiro


	//Do Letris 1
	string bancoPalavras[PALAVRASDISPONIVEIS] = { "porta","pasto","placa","posto","prego","peste","porco","parto","preto", "prato" }; //banco de palavras
	string selecionadas[PALAVRASSELECIONADAS]; //retorna as palavras selecionadas dentro do banco de palavras
	palavrasSelecionadas(bancoPalavras, selecionadas);
	sf::Sprite botao[NUM_LETRAS]; //botao é o quadrado, inicializa
	int i = 0;
	float x,y;
	int alocou[NUM_LETRAS]; //variavel alocou indica que o quadrado foi alocado
	int j,k,s;
	j = i;
	k = 0;
	int sorteia[NUM_LETRAS];
	char letras[NUM_LETRAS];
	int tela = 0;
	bool verifica = false;
	bool verifica2 = false;
	float temTextura[NUM_LETRAS];
	float perdeu = 0;

	for (int g = 0; g < NUM_LETRAS; g++) { //inicializa as texturas
		temTextura[g] = 0;
	}

	i = 0;
	sf::IntRect r1(0, 0, TAM_LETRAS, TAM_LETRAS); //cria o intrect que vai cortar a textura

	int valor;
	if (dificuldade == 1) {
		valor = 4;
	}
	if (dificuldade == 2 || dificuldade == 3) {
		valor = 13;
	}

	if (dificuldade == 1) {
		qtd_letras2 = 17;
	}
	else {
		qtd_letras2 = 12;
	}

	srand(time(NULL));
	sorteia[0] = rand() % qtd_letras2;
	if (rand() % valor < PALAVRASSELECIONADAS)
		sorteia[0] = 10;
	botao[0].setTexture(texture[sorteia[0]]); //textura do primeiro
	botao[0].setPosition(INI, 0); //posicao do primeiro
	botao[0].setTextureRect(r1); //corta a textura do primeiro
	botao[0].setScale(sf::Vector2f(1, 1)); //escala do primeiro
	associaLetra(sorteia[0], letras, 0);
	cout << "Palavras selecionadas:\n1. " << selecionadas[0] << "\n2. " << selecionadas[1] << "\n3. " << selecionadas[2] << endl;
	cout << "Letra caindo: " << letras[0] << endl;

	for (int g = 0; g < NUM_LETRAS; g++) //inicializa os alocou com 0
		alocou[g] = 0;

	while (window.isOpen())//enquanto a janela esta aberta
	{
			while (perdeu == 0) {
				sf::Event event; //detecta acontecimento de um evento
				while (window.pollEvent(event))
				{
					switch (event.type) { //switch pro evento
					case sf::Event::Closed: //evento fechar a tela
						window.close();
						break;
					case sf::Event::EventType::KeyPressed: //evento pressionar tecla
						if (alocou[k] == 0) { //se a peça nao está alocada
							if (event.key.code == sf::Keyboard::Left) { //se o botao pressionado é o de esquerda
								if (botao[i].getPosition().x != BORDAESQ) { //se nao esta na borda (limite) esquerda
									for (s = 0; s < NUM_LETRAS; s++) { //se nenhuma das outras letras está alocada a esquerda da peça
										if (s != i) {
											if ((botao[i].getPosition().x == (botao[s].getPosition().x + TAM_LETRAS + DIST_PILHAS)) && (botao[i].getPosition().y == botao[s].getPosition().y)) {
												verifica2 = true;
											}
										}
									}
									if (verifica2 == false) //entao move pra esquerda
										botao[i].move(sf::Vector2f(-(TAM_LETRAS + DIST_PILHAS), 0));
								}
							}

							if (event.key.code == sf::Keyboard::Right) { //se o botao pressionado é o de direita
								if (botao[i].getPosition().x != BORDADIR) { //se nao esta na borda (limite) direito
									for (s = 0; s < NUM_LETRAS; s++) { //se nenhuma das outras letras está alocada a direita da peça
										if (s != i) {
											if ((botao[i].getPosition().x == botao[s].getPosition().x - (TAM_LETRAS + DIST_PILHAS)) && (botao[i].getPosition().y == botao[s].getPosition().y)) {
												verifica2 = true;
											}
										}
									}
									if (verifica2 == false) //entao move para a direita
										botao[i].move(sf::Vector2f((TAM_LETRAS + DIST_PILHAS), 0));
								}
							}
							verifica2 = false;

						}
					}
				}
				//--------------------------------textos
				//pontuacao
				sf::Text textinho;
				textinho.setString("Pontos: ");
				textinho.setPosition(sf::Vector2f(397, 100));
				textinho.setColor(sf::Color::White);
				textinho.setCharacterSize(24);
				textinho.setFont(font2);
				sf::Text textinho2;
				string textoo2;
				textoo2 = to_string(pontuacao);
				textinho2.setString(textoo2);
				textinho2.setPosition(sf::Vector2f(460, 100));
				textinho2.setColor(sf::Color::White);
				textinho2.setFont(font);
				//peças restantes
				sf::Text text;
				text.setString("Letras restantes: ");
				text.setPosition(sf::Vector2f(397, 200));
				text.setColor(sf::Color::White);
				text.setCharacterSize(24);
				text.setFont(font2);
				sf::Text text2;
				int restantes = NUM_LETRAS - i;
				string textoo;
				textoo = to_string(restantes);
				text2.setString(textoo);
				text2.setPosition(sf::Vector2f(550, 200));
				text2.setColor(sf::Color::White);
				text2.setFont(font);

				//palavras selecionadas
				sf::Text text3;
				text3.setString("Palavras: ");
				text3.setPosition(sf::Vector2f(397, 300));
				text3.setColor(sf::Color::White);
				text3.setCharacterSize(27);
				text3.setFont(font2);
				sf::Text palavra1;
				palavra1.setString(selecionadas[0]);
				palavra1.setPosition(sf::Vector2f(400, 330));
				palavra1.setColor(sf::Color::White);
				palavra1.setFont(font2);
				sf::Text palavra2;
				palavra2.setString(selecionadas[1]);
				palavra2.setPosition(sf::Vector2f(400, 360));
				palavra2.setColor(sf::Color::White);
				palavra2.setFont(font2);
				sf::Text palavra3;
				palavra3.setString(selecionadas[2]);
				palavra3.setPosition(sf::Vector2f(400, 390));
				palavra3.setColor(sf::Color::White);
				palavra3.setFont(font2);

				if (dificuldade == 1) {
					tempo = 0.5;
				}
				if (dificuldade == 2) {
					tempo = tempo - 0.00001;
				}
				if (dificuldade == 3) {
					tempo = 0.08;
				}

				sf::Clock clock; //clock para cair e ser compativel com qualquer pc
				while (clock.getElapsedTime() < sf::seconds(tempo)) {
				}
				if (alocou[k] == 0) { //se a peça nao está alocada
					for (s = 0; s < NUM_LETRAS; s++) { //verifica se nao tem nenhuma peça embaixo dela, já alocada
						if (s != i) {
							if ((botao[i].getPosition().x == botao[s].getPosition().x) && ((botao[i].getPosition().y + TAM_LETRAS) == botao[s].getPosition().y)) {
								verifica = true;
							}
						}
					}
					if (verifica == false) { //caso nao, então move para baixo
						botao[i].move(sf::Vector2f(0, TAM_LETRAS));
					}
					if (verifica == true) { //caso sim, entao aloca essa peça
						associaLetra(sorteia[i], letras, i);
						x = botao[i].getPosition().x;
						if (letras[i] == '*') { //se for o caractere especial
							cout << "Empilhou em " << empilhaNaPilhaCerta(x, letras[i], &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5) << endl;
							alocou[k] = 2;
						}
						/*if (letras[i] == '%') { //se for o outro caractere especial
							cout << "Empilhou em " << empilhaNaPilhaCerta(x, letras[i], &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5) << endl;
							alocou[k] = 4;
						}*/
						else { //senao
							x = botao[i].getPosition().x;
							y = botao[i].getPosition().y;
							botao[i].setPosition(sf::Vector2f(x, y));
							associaLetra(sorteia[i], letras, i);
							cout << "Empilhou em " << empilhaNaPilhaCerta(x, letras[i], &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5) << endl;
							alocou[k] = 1; //foi alocado
						}
					}
				}
				verifica = false;
				if (botao[i].getPosition().y == FIM && alocou[k] == 0) { //se a peca nao esta alocada mas chegou ao fim da tela
					x = botao[i].getPosition().x;
					botao[i].setPosition(sf::Vector2f(x, FIM));
					associaLetra(sorteia[i], letras, i);
					cout << "Empilhou em " << empilhaNaPilhaCerta(x, letras[i], &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5) << endl;
					alocou[k] = 1; //aloca
				}

				//verifica se a palavra está na pilha
				if (estaNaPilha(&pilha0, selecionadas) || estaNaPilha(&pilha1, selecionadas) || estaNaPilha(&pilha2, selecionadas) || estaNaPilha(&pilha3, selecionadas) || estaNaPilha(&pilha4, selecionadas) || estaNaPilha(&pilha5, selecionadas)) {
					alocou[k] = 3;
				}
				// fim do verifica se esta na pilha

				if (alocou[k] == 1) { //se durante esse while, alocou e nao era * nem -, entao muda a peça
					if (botao[i].getPosition().y == 0) //se a pessoa nao perder
						perdeu = 1;
					if (i == NUM_LETRAS - 1) {
						perdeu = 1;
					}
					else { //aloca
						k = k + 1;
						j = i;
						i = i + 1;
						sorteia[i] = rand() % qtd_letras2;
						if (rand() % valor < PALAVRASSELECIONADAS)
							sorteia[i] = 10;
						botao[i].setTexture(texture[sorteia[i]]); //se alocar, cria a textura do proximo
						associaLetra(sorteia[i], letras, i);
						botao[i].setPosition(INI, 0);
						botao[i].setTextureRect(r1);
						botao[i].setScale(sf::Vector2f(1, 1));
						cout << "Palavras selecionadas:\n1. " << selecionadas[0] << "\n2. " << selecionadas[1] << "\n3. " << selecionadas[2] << endl;
						cout << "Letra caindo: " << letras[i] << endl;
						imprimePilha(&pilha0);
						cout << endl;
						imprimePilha(&pilha1);
						cout << endl;
						imprimePilha(&pilha2);
						cout << endl;
						imprimePilha(&pilha3);
						cout << endl;
						imprimePilha(&pilha4);
						cout << endl;
						imprimePilha(&pilha5);
						cout << endl;
						cout << "Letras Restantes: " << NUM_LETRAS - i << endl;

					}
				}
				
				if (alocou[k] == 2) {
					x = botao[i].getPosition().x;
					Destroi(x, &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5, botao);
					k = k + 1;
					j = i;
					i = i + 1;
					sorteia[i] = rand() % qtd_letras2;
					if (rand() % valor < PALAVRASSELECIONADAS)
						sorteia[i] = 10;
					botao[i].setTexture(texture[sorteia[i]]); //se alocar, cria a textura do proximo
					associaLetra(sorteia[i], letras, i);
					botao[i].setPosition(INI, 0);
					botao[i].setTextureRect(r1);
					botao[i].setScale(sf::Vector2f(1, 1));
					cout << "Palavras selecionadas:\n1. " << selecionadas[0] << "\n2. " << selecionadas[1] << "\n3. " << selecionadas[2] << endl;
					cout << "Letra caindo: " << letras[i] << endl;
					imprimePilha(&pilha0);
					cout << endl;
					imprimePilha(&pilha1);
					cout << endl;
					imprimePilha(&pilha2);
					cout << endl;
					imprimePilha(&pilha3);
					cout << endl;
					imprimePilha(&pilha4);
					cout << endl;
					imprimePilha(&pilha5);
					cout << endl;
					cout << "Letras Restantes: " << NUM_LETRAS - i << endl;
				}
				/*
				if (alocou[k] == 4) {
					x = botao[i].getPosition().x;
					y = botao[i].getPosition().y;
					DesempilhaUm(x, y, &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5, botao);
					k = k + 1;
					j = i;
					i = i + 1;
					sorteia[i] = rand() % qtd_letras2;
					if (rand() % valor < PALAVRASSELECIONADAS)
						sorteia[i] = 10;
					botao[i].setTexture(texture[sorteia[i]]); //se alocar, cria a textura do proximo
					associaLetra(sorteia[i], letras, i);
					botao[i].setPosition(INI, 0);
					botao[i].setTextureRect(r1);
					botao[i].setScale(sf::Vector2f(1, 1));
					cout << "Palavras selecionadas:\n1. " << selecionadas[0] << "\n2. " << selecionadas[1] << "\n3. " << selecionadas[2] << endl;
					cout << "Letra caindo: " << letras[i] << endl;
					imprimePilha(&pilha0);
					cout << endl;
					imprimePilha(&pilha1);
					cout << endl;
					imprimePilha(&pilha2);
					cout << endl;
					imprimePilha(&pilha3);
					cout << endl;
					imprimePilha(&pilha4);
					cout << endl;
					imprimePilha(&pilha5);
					cout << endl;
					cout << "Letras Restantes: " << NUM_LETRAS - i << endl;
				}
				*/

				//alocações referentes a estaNaPilha
				if (alocou[k] == 3) {
					x = botao[i].getPosition().x;
					Destroi(x, &pilha0, &pilha1, &pilha2, &pilha3, &pilha4, &pilha5, botao);
					k = k + 1;
					j = i;
					i = i + 1;
					pontuacao = pontuacao + 1; //aumenta o ponto do jogador
					sorteia[i] = rand() % qtd_letras2;
					if (rand() % 11 < PALAVRASSELECIONADAS)
						sorteia[i] = 10;
					botao[i].setTexture(texture[sorteia[i]]); //se alocar, cria a textura do proximo
					associaLetra(sorteia[i], letras, i);
					botao[i].setPosition(INI, 0);
					botao[i].setTextureRect(r1);
					botao[i].setScale(sf::Vector2f(1, 1));
					cout << "Palavras selecionadas:\n1. " << selecionadas[0] << "\n2. " << selecionadas[1] << "\n3. " << selecionadas[2] << endl;
					cout << "Letra caindo: " << letras[i] << endl;
					imprimePilha(&pilha0);
					cout << endl;
					imprimePilha(&pilha1);
					cout << endl;
					imprimePilha(&pilha2);
					cout << endl;
					imprimePilha(&pilha3);
					cout << endl;
					imprimePilha(&pilha4);
					cout << endl;
					imprimePilha(&pilha5);
					cout << endl;
					cout << "Letras Restantes: " << NUM_LETRAS - i << endl;

				}

				clock.restart(); //recomeça o clock anterior
				window.clear(); //limpa a tela

				for (s = 0; s < NUM_LETRAS; s++) { //desenha todos os quadradinhos
					window.draw(botao[s]);
				}
				window.draw(ologo);
				window.draw(text);
				window.draw(text2);
				window.draw(text3);
				window.draw(palavra1);
				window.draw(palavra2);
				window.draw(palavra3);
				window.draw(textinho);
				window.draw(textinho2);
				window.display();


			if (perdeu == 1) //se a pessoa perder, passa pra tela 2
				return 0;
		}


	}

}