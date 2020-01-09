#pragma once
#pragma once
#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int tela3Instucoes(sf::RenderWindow &window) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc

	int tela = 0;
	sf::Texture tela3textura;
	sf::Texture sairtextura;
	tela3textura.loadFromFile("instrucoes3.png");
	sairtextura.loadFromFile("sair.png");

	sf::Sprite sair;
	sf::Sprite tela3;
	sair.setTexture(sairtextura);
	sair.setPosition(430, 500);
	tela3.setTexture(tela3textura);
	while (tela != 1) {
		window.draw(tela3);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(1)) {
		}
		if (spriteClick(sair, window))
		{
			return 0;
		}
	}
}