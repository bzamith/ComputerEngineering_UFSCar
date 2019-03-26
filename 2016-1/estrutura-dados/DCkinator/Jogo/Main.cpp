#include <SFML/Graphics.hpp>
#include <stdlib.h>
#include "MenuInicial.h"
#include "FuncoesTelasDosResultados.h"
#include "SelecionaOpcao.h"
#include "FuncoesTelasDasPerguntas.h"
#include "TelaInstrucoes.h"
#include "Arvore.h"

int main()
{
	sf::Texture fautomacao; //textura do fundo automacao
	fautomacao.loadFromFile("automacao.png"); //fundo do menu automacao
	sf::Texture fcompnuvem1; //textura do fundo computacao em nuvem
	fcompnuvem1.loadFromFile("compnuvem1.png"); //fundo do menu computacao em nuvem
	sf::Texture fcompnuvem2; //textura do fundo computacao em nuvem
	fcompnuvem2.loadFromFile("compnuvem2.png"); //fundo do menu computacao em nuvem
	sf::Texture fbioinformatica1; //textura do fundo bioinformatica
	fbioinformatica1.loadFromFile("bioinformatica1.png"); //fundo do menu bioinformatica
	sf::Texture fbioinformatica2; //textura do fundo bioinformatica
	fbioinformatica2.loadFromFile("bioinformatica2.png"); //fundo do menu bioinformatica
	sf::Texture fbancodedados1; //textura do fundo banco de dados
	fbancodedados1.loadFromFile("bd1.png"); //fundo do menu banco de dados
	sf::Texture fbancodedados2; //textura do fundo banco de dados
	fbancodedados2.loadFromFile("bd2.png"); //fundo do menu banco de dados
	sf::Texture fempreendedorismo; //textura do fundo empreendedorismo tecnologico
	fempreendedorismo.loadFromFile("empreendedorismo.png"); //empreendedorismo tecnologico
	sf::Texture fia1; //textura do fundo inteligencia artificial
	fia1.loadFromFile("ia1.png"); //inteligencia artificial
	sf::Texture fia2; //textura do fundo inteligencia artificial
	fia2.loadFromFile("ia2.png"); //inteligencia artificial
	sf::Texture fia3; //textura do fundo inteligencia artificial
	fia3.loadFromFile("ia3.png"); //inteligencia artificial
	sf::Texture fia4; //textura do fundo inteligencia artificial
	fia4.loadFromFile("ia4.png"); //inteligencia artificial
	sf::Texture fia5; //textura do fundo inteligencia artificial
	fia5.loadFromFile("ia5.png"); //inteligencia artificial
	sf::Texture fia6; //textura do fundo inteligencia artificial
	fia6.loadFromFile("ia6.png"); //inteligencia artificial
	sf::Texture iot1; //textura do fundo iot
	iot1.loadFromFile("iot.png"); //iot
	sf::Texture fcompiladores1; //textura do fundo compiladores
	fcompiladores1.loadFromFile("compiladores1.png"); //compiladores
	sf::Texture fcompiladores2; //textura do fundo compiladores
	fcompiladores2.loadFromFile("compiladores2.png"); //compiladores
	sf::Texture fengsoftware1; //textura do fundo eng software
	fengsoftware1.loadFromFile("engsoftware1.png"); //eng software
	sf::Texture fengsoftware2; //textura do fundo eng software
	fengsoftware2.loadFromFile("engsoftware2.png"); //eng software
	sf::Texture fengsoftware3; //textura do fundo eng software
	fengsoftware3.loadFromFile("engsoftware3.png"); //eng software
	sf::Texture fengsoftware4; //textura do fundo eng software
	fengsoftware4.loadFromFile("engsoftware4.png"); //eng software
	sf::Texture farq1; //textura do fundo arquitetura de computadores
	farq1.loadFromFile("arq1.png"); //arquitetura de computadores
	sf::Texture farq2; //textura do fundo arquitetura de computadores
	farq2.loadFromFile("arq2.png"); //arquitetura de computadores
	sf::Texture farq3; //textura do arquitetura de computadores
	farq3.loadFromFile("arq3.png"); //arquitetura de computadores
	sf::Texture fpis1; //textura do fundo processamento de imagens e sinais
	fpis1.loadFromFile("pis1.png"); //processamento de imagens e sinais
	sf::Texture fpis2; //textura do fundo processamento de imagens e sinais
	fpis2.loadFromFile("pis2.png"); //processamento de imagens e sinais
	sf::Texture fpis3; //textura do processamento de imagens e sinais
	fpis3.loadFromFile("pis3.png"); //processamento de imagens e sinais
	sf::Texture fpis4; //textura do fundo processamento de imagens e sinais
	fpis4.loadFromFile("pis4.png"); //processamento de imagens e sinais
	sf::Texture fpis5; //textura do fundo processamento de imagens e sinais
	fpis5.loadFromFile("pis5.png"); //processamento de imagens e sinais
	sf::Texture fredes1; //textura do fundo redes de computadores
	fredes1.loadFromFile("redes1.png"); //redes de computadores
	sf::Texture fredes2; //textura do fundo redes de computadores
	fredes2.loadFromFile("redes2.png"); //redes de computadores
	sf::Texture fihc1; //textura do fundo redes de computadores
	fihc1.loadFromFile("ihc1.png"); //interação humano-computador
	sf::Texture fihc2; //textura do fundo interação humano-computador
	fihc2.loadFromFile("ihc2.png"); //interação humano-computador
	sf::Texture fihc3; //textura do fundo interação humano-computador
	fihc3.loadFromFile("ihc3.png"); //interação humano-computador
	sf::Texture fihc4; //textura do fundo interação humano-computador
	fihc4.loadFromFile("ihc4.png"); //interação humano-computador


	ArvoreBinaria R;
	R = NULL;
	ArvoreBinaria Atual;
	insereNo(R, 20);
	insereNo(R, 10);
	insereNo(R, 40);
	insereNo(R, 6);
	insereNo(R, 15);
	insereNo(R, 22);
	insereNo(R, 50);
	insereNo(R, 4);
	insereNo(R, 8);
	insereNo(R, 12);
	insereNo(R, 11);
	insereNo(R, 14);
	insereNo(R, 16);
	insereNo(R, 21);
	insereNo(R, 24);
	insereNo(R, 45);
	insereNo(R, 55);
	insereNo(R, 3);
	insereNo(R, 5);
	insereNo(R, 7);
	insereNo(R, 9);
	insereNo(R, 23);
	insereNo(R, 26);
	insereNo(R, 25);
	insereNo(R, 30);
	Atual = R;

	sf::RenderWindow window(sf::VideoMode(1000, 660), "DCkinator"); //declara a tela
	int tela; //variavel tela
	int resposta; //variavel resposta
	tela = menuInicial(window); //chama o menu inicial
	//opções depois do menu inicial

	if (tela == 2) { //tela de como jogar
		tela = telaInstrucoes(window);
	}
	if (tela == 1) { //tela após o play
		resposta = telapergunta1(window);
		if (resposta == 1) {
			Atual = Atual->esq;
			resposta = telapergunta2(window);
			if (resposta == 1) {
				Atual = Atual->esq;
				resposta = telapergunta3(window);
				if (resposta == 1) {
					Atual = Atual->esq;
					resposta = telapergunta4(window);
					if (resposta == 1) {
						Atual = Atual->esq;
					}
					else {
						Atual = Atual->dir;
					}
				}
				else {
					Atual = Atual->dir;
					resposta = telapergunta5(window);
					if (resposta == 1) {
						Atual = Atual->esq;
					}
					else {
						Atual = Atual->dir;
					}
				}
			}
			else {
				Atual = Atual->dir;
				resposta = telapergunta6(window);
				if (resposta == 1) {
					Atual = Atual->esq;
					resposta = telapergunta12(window);
					if (resposta == 1) {
						Atual = Atual->esq;
					}
					else {
						Atual = Atual->dir;
					}
				}
				else {
					Atual = Atual->dir;
				}
			}
		}
		else {
			Atual = Atual->dir;
			resposta = telapergunta7(window);
			if (resposta == 1) {
				Atual = Atual->esq;
				resposta = telapergunta9(window);
				if (resposta == 1) {
					Atual = Atual->esq;
				}
				else {
					Atual = Atual->dir;
					resposta = telapergunta10(window);
					if (resposta == 1) {
						Atual = Atual->esq;
					}
					else {
						Atual = Atual->dir;
						resposta = telapergunta11(window);
						if (resposta == 1) {
							Atual = Atual->esq;
						}
						else {
							Atual = Atual->dir;
						}
					}
				}
			}
			else {
				Atual = Atual->dir;
				resposta = telapergunta8(window);
				if (resposta == 1) {
					Atual = Atual->esq;
				}
				else {
					Atual = Atual->dir;
				}
			}
		}
	}
	if (tela == 0) { //fechar tela
		window.close();
	}

	if (Atual->info == 3) {
		telaresultado2(window, fcompnuvem1, fcompnuvem2);
	}
	if (Atual->info == 5) {
		telaresultado2(window, fbancodedados2, fbancodedados1);
	}
	if (Atual->info == 7) {
		telaresultado2(window, fbioinformatica1, fbioinformatica2);
	}
	if (Atual->info == 9) {
		telaresultado6(window, fia1, fia2, fia3, fia4, fia5, fia6);
	}
	if (Atual->info == 11) {
		telaresultado1(window, fempreendedorismo);
	}
	if (Atual->info == 14) {
		telaresultado4(window, fengsoftware1, fengsoftware2, fengsoftware3, fengsoftware4);
	}
	if (Atual->info == 16) {
		telaresultado2(window, fcompiladores1, fcompiladores2);
	}
	if (Atual->info == 21) {
		telaresultado4(window, fihc4, fihc2, fihc3, fihc1);
	}
	if (Atual->info == 23) {
		telaresultado1(window, iot1);
	}
	if (Atual->info == 25) {
		telaresultado5(window, fpis1, fpis2, fpis3, fpis4, fpis5);
	}
	if (Atual->info == 30) {
		telaresultado3(window, farq1, farq2, farq3);
	}
	if (Atual->info == 45) {
		telaresultado1(window, fautomacao);
	}
	if (Atual->info == 55) {
		telaresultado2(window, fredes1, fredes2);
	}
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc
	while (clock.getElapsedTime() < sf::seconds(2.5)) {
	}
	sf::Event event; //evento
	while (window.pollEvent(event)) //enquanto receber um evento
	{
		if (event.type == sf::Event::Closed) { //fecha
			return 0;
		}
		if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
			return 0;
		}
	}
}