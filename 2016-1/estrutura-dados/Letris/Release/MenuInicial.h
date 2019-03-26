#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int menuInicial(sf::RenderWindow &window) {
	int tela = 0;
	sf::Texture fundo;
	sf::Texture iniciotextura;
	sf::Texture instrucoestextura;
	fundo.loadFromFile("menu.png"); //fundo do menu
	iniciotextura.loadFromFile("inicio.png"); //textura inicio
	instrucoestextura.loadFromFile("instrucoes.png"); //textura instrucoes
	sf::Sprite fundomenu;
	sf::Sprite inicio;
	sf::Sprite instrucoes;
	inicio.setTexture(iniciotextura);
	inicio.setPosition(90, 240);
	instrucoes.setTexture(instrucoestextura);
	instrucoes.setPosition(90, 342);
	fundomenu.setTexture(fundo);
	fundomenu.setPosition(0, 0);
	while (tela != 1) {
		window.draw(fundomenu);
		window.display();
		if (spriteClick(inicio, window))
		{
			return 1;
		}
		else if (spriteClick(instrucoes, window))
		{
			return  2;
		}
	}
}