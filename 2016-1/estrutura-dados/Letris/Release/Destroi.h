#pragma once
#include<iostream>
#include <SFML/Graphics.hpp>
#include<iostream>
#ifndef NUM_LETRAS
#define NUM_LETRAS 300 //numero maximo de quadrados que o jogo aceita, se passar disso, o jogo deverá finalizar e o jogador perde
#endif

//destroi a pilha
void Destroi(float x, Pilha<char> *pilha0, Pilha<char> *pilha1, Pilha<char> *pilha2, Pilha<char> *pilha3, Pilha<char> *pilha4, Pilha<char> *pilha5, sf::Sprite botao[]) {
	int distanciaTotal = TAM_LETRAS + DIST_PILHAS;
	bool DeuCerto = true;
	int j;
	char k;
	if (x == 0) {
		while (DeuCerto)
			pilha0->Desempilha(k, DeuCerto); //desempilha da pilha
		//remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (botao[j].getPosition().x == x && botao[j].getPosition().y!=0) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
	if (x == distanciaTotal) {
		while (DeuCerto)
			pilha1->Desempilha(k, DeuCerto); //desempilha da pilha
											 //remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (x == botao[j].getPosition().x) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
	if (x == distanciaTotal * 2) {
		while (DeuCerto)
			pilha2->Desempilha(k, DeuCerto); //desempilha da pilha
											 //remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (x == botao[j].getPosition().x) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
	if (x == distanciaTotal * 3) {
		while (DeuCerto)
			pilha3->Desempilha(k, DeuCerto); //desempilha da pilha
											 //remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (x == botao[j].getPosition().x) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
	if (x == distanciaTotal * 4) {
		while (DeuCerto)
			pilha4->Desempilha(k, DeuCerto); //desempilha da pilha
											 //remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (x == botao[j].getPosition().x) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
	if (x == distanciaTotal * 5) {
		while (DeuCerto)
			pilha5->Desempilha(k, DeuCerto); //desempilha da pilha
											 //remove as sprites
		for (j = 0; j < NUM_LETRAS; j++) {
			if (x == botao[j].getPosition().x) {
				botao[j].setColor(sf::Color::Black);
				botao[j].setPosition(sf::Vector2f(0, 0));
			}
		}
	}
}