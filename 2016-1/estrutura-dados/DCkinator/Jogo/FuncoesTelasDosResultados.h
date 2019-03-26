#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int telaresultado1(sf::RenderWindow &window, sf::Texture ftextura) {
	sf::Sprite fundo; //declara a sprite
	fundo.setTexture(ftextura); //seta textura
	fundo.setPosition(0, 0); //seta a posicao inicial 
	sf::Event event; //evento
	while (window.pollEvent(event)) //enquanto receber um evento
	{
		window.draw(fundo); //desenha
		window.display(); //display da tela
		if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
			return 0;
		}
	}
}

int telaresultado2(sf::RenderWindow &window, sf::Texture ftextura1, sf::Texture ftextura2) {
	sf::Sprite fundo1; //declara a sprite 
	fundo1.setTexture(ftextura1); //seta textura
	fundo1.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo2; //declara a sprite
	fundo2.setTexture(ftextura2); //seta textura 
	fundo2.setPosition(0, 0); //seta a posicao inicial
	sf::Event event; //evento
	sf::Sprite atual;
	atual.setPosition(0,0);
	window.draw(fundo1); //desenha 
	window.display(); //display da tela
	int contador = 1; //contador para duas paginas
	while (contador == 1 || contador == 2) {
		while (window.pollEvent(event)) //enquanto receber um evento
		{
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					contador = contador + 1;
					if (contador == 2) {
						atual.setTexture(ftextura2);
					}
				}
				window.draw(atual);
				window.display();
			}
		}
	}
	return 0;
}

int telaresultado3(sf::RenderWindow &window, sf::Texture ftextura1, sf::Texture ftextura2, sf::Texture ftextura3) {
	sf::Sprite fundo1; //declara a sprite 
	fundo1.setTexture(ftextura1); //seta textura
	fundo1.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo2; //declara a sprite
	fundo2.setTexture(ftextura2); //seta textura 
	fundo2.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo3; //declara a sprite
	fundo3.setTexture(ftextura3); //seta textura 
	fundo3.setPosition(0, 0); //seta a posicao inicial
	sf::Event event; //evento
	sf::Sprite atual;
	atual.setPosition(0, 0);
	window.draw(fundo1); //desenha 
	window.display(); //display da tela
	int contador = 1; //contador para tres paginas
	while (contador == 1 || contador == 2 || contador==3) {
		while (window.pollEvent(event)) //enquanto receber um evento
		{
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					contador = contador + 1;
					if (contador == 2) {
						atual.setTexture(ftextura2);
					}
					if (contador == 3) {
						atual.setTexture(ftextura3);
					}
				}
				window.draw(atual);
				window.display();
			}
		}
	}
	return 0;
}


int telaresultado4(sf::RenderWindow &window, sf::Texture ftextura1, sf::Texture ftextura2, sf::Texture ftextura3, sf::Texture ftextura4) {
	sf::Sprite fundo1; //declara a sprite 
	fundo1.setTexture(ftextura1); //seta textura
	fundo1.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo2; //declara a sprite
	fundo2.setTexture(ftextura2); //seta textura 
	fundo2.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo3; //declara a sprite
	fundo3.setTexture(ftextura3); //seta textura 
	fundo3.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo4; //declara a sprite
	fundo4.setTexture(ftextura4); //seta textura 
	fundo4.setPosition(0, 0); //seta a posicao inicial
	sf::Event event; //evento
	sf::Sprite atual;
	atual.setPosition(0, 0);
	window.draw(fundo1); //desenha 
	window.display(); //display da tela
	int contador = 1; //contador para tres paginas
	while (contador == 1 || contador == 2 || contador == 3 || contador == 4) {
		while (window.pollEvent(event)) //enquanto receber um evento
		{
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					contador = contador + 1;
					if (contador == 2) {
						atual.setTexture(ftextura2);
					}
					if (contador == 3) {
						atual.setTexture(ftextura3);
					}
					if (contador == 4) {
						atual.setTexture(ftextura4);
					}
				}
				window.draw(atual);
				window.display();
			}
		}
	}
	return 0;
}


int telaresultado6(sf::RenderWindow &window, sf::Texture ftextura1, sf::Texture ftextura2, sf::Texture ftextura3, sf::Texture ftextura4, sf::Texture ftextura5, sf::Texture ftextura6) {
	sf::Sprite fundo1; //declara a sprite 
	fundo1.setTexture(ftextura1); //seta textura
	fundo1.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo2; //declara a sprite
	fundo2.setTexture(ftextura2); //seta textura 
	fundo2.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo3; //declara a sprite
	fundo3.setTexture(ftextura3); //seta textura 
	fundo3.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo4; //declara a sprite
	fundo4.setTexture(ftextura4); //seta textura 
	fundo4.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo5; //declara a sprite
	fundo5.setTexture(ftextura5); //seta textura 
	fundo5.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo6; //declara a sprite
	fundo6.setTexture(ftextura6); //seta textura 
	fundo6.setPosition(0, 0); //seta a posicao inicial
	sf::Event event; //evento
	sf::Sprite atual;
	atual.setPosition(0, 0);
	window.draw(fundo1); //desenha 
	window.display(); //display da tela
	int contador = 1; //contador para tres paginas
	while (contador == 1 || contador == 2 || contador == 3 || contador == 4 || contador == 5 || contador==6) {
		while (window.pollEvent(event)) //enquanto receber um evento
		{
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					contador = contador + 1;
					if (contador == 2) {
						atual.setTexture(ftextura2);
					}
					if (contador == 3) {
						atual.setTexture(ftextura3);
					}
					if (contador == 4) {
						atual.setTexture(ftextura4);
					}
					if (contador == 5) {
						atual.setTexture(ftextura5);
					}
					if (contador == 6) {
						atual.setTexture(ftextura6);
					}
				}
				window.draw(atual);
				window.display();
			}
		}
	}
	return 0;
}

int telaresultado5(sf::RenderWindow &window, sf::Texture ftextura1, sf::Texture ftextura2, sf::Texture ftextura3, sf::Texture ftextura4, sf::Texture ftextura5) {
	sf::Sprite fundo1; //declara a sprite 
	fundo1.setTexture(ftextura1); //seta textura
	fundo1.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo2; //declara a sprite
	fundo2.setTexture(ftextura2); //seta textura 
	fundo2.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo3; //declara a sprite
	fundo3.setTexture(ftextura3); //seta textura 
	fundo3.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo4; //declara a sprite
	fundo4.setTexture(ftextura4); //seta textura 
	fundo4.setPosition(0, 0); //seta a posicao inicial
	sf::Sprite fundo5; //declara a sprite
	fundo5.setTexture(ftextura5); //seta textura 
	fundo5.setPosition(0, 0); //seta a posicao inicial
	sf::Event event; //evento
	sf::Sprite atual;
	atual.setPosition(0, 0);
	window.draw(fundo1); //desenha 
	window.display(); //display da tela
	int contador = 1; //contador para tres paginas
	while (contador == 1 || contador == 2 || contador == 3 || contador == 4 || contador == 5) {
		while (window.pollEvent(event)) //enquanto receber um evento
		{
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					contador = contador + 1;
					if (contador == 2) {
						atual.setTexture(ftextura2);
					}
					if (contador == 3) {
						atual.setTexture(ftextura3);
					}
					if (contador == 4) {
						atual.setTexture(ftextura4);
					}
					if (contador == 5) {
						atual.setTexture(ftextura5);
					}
				}
				window.draw(atual);
				window.display();
			}
		}
	}
	return 0;
}