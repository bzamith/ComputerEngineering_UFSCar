#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int selecionaOpcao(sf::RenderWindow &window, sf::Sprite &seta1, sf::Sprite &seta2, sf::Texture &seta, sf::Texture &setaselecionada, int &contador) {
	int tela = -1;
		while (tela != 0) { //tela começa com -1 e só é 0 quando fecha
			sf::Event event; //evento
			while (window.pollEvent(event)) //enquanto receber um evento
			{
				if (event.type == sf::Event::Closed) { //fecha
					tela = 0;
					return tela;
				}

				if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
					if (event.key.code == sf::Keyboard::Down) { //para baixo
						contador = contador + 1; //aumenta o contador -> ímpar
						if (contador % 2 != 0){ //se não divisivel por 2 (impar), é seta 1
							seta1.setTexture(setaselecionada);
							seta2.setTexture(seta);
							return -1;
						}
						if (contador % 2 == 0) { //se divisivel por 2 (par), é seta 2
							seta1.setTexture(seta);
							seta2.setTexture(setaselecionada);
							return -1;
						}
					}
					if (event.key.code == sf::Keyboard::Up) { //para cima
						contador = contador - 1;  //diminui o contador -> par
						if (contador % 2 != 0) { //se não divisivel por 2 (impar), é seta 1
							seta1.setTexture(setaselecionada);
							seta2.setTexture(seta);
							return -1;
						}
						if (contador % 2 == 0) { //se divisivel por 2(impar), é par
							seta1.setTexture(seta);
							seta2.setTexture(setaselecionada);
							return -1;
						}
					}
					if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
						if (contador % 2 != 0) //se impar, vai pra tela da seta 1
							tela = 1;
						if (contador % 2 == 0) //se par, vai pra tela da seta 2
							tela = 2;
						return tela;
					}
				}
			}
		}
}