#pragma once
#pragma once
#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int tela2Instucoes(sf::RenderWindow &window) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc

	int tela = 0;
	sf::Texture tela2textura;
	sf::Texture sairtextura;
	tela2textura.loadFromFile("instrucoes2.png");
	sairtextura.loadFromFile("sair.png");
	sf::Sprite sair;
	sf::Sprite tela2;
	sair.setTexture(sairtextura);
	sair.setPosition(430, 500);
	tela2.setTexture(tela2textura);
	while (tela != 1) {
		window.draw(tela2);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(1)) {
		}
		if (spriteClick(sair, window))
		{
			return 0;
		}
	}
}