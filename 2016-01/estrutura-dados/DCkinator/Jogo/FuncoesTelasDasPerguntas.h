#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include <stdlib.h>
using namespace std;

//*********PERGUNTA 1*********//
int telapergunta1(sf::RenderWindow &window) {
	int contador = 0;
	
	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 1
	sf::Text pergunta1;
	pergunta1.setString("Você prefere:");
	pergunta1.setPosition(140, 160);
	pergunta1.setFont(alamain);
	pergunta1.setColor(sf::Color::Black);
	pergunta1.setStyle(sf::Text::Style::Underlined);
	pergunta1.setCharacterSize(42);
	//lê as respostas pergunta 1
	sf::Text resposta1_1;
	sf::Text resposta1_2;
	resposta1_1.setString("Software");
	resposta1_1.setPosition(220, 340);
	resposta1_1.setFont(lucida);
	resposta1_1.setColor(sf::Color::Black);
	resposta1_1.setCharacterSize(48);
	resposta1_2.setString("Hardware");
	resposta1_2.setPosition(220, 480);
	resposta1_2.setFont(lucida);
	resposta1_2.setColor(sf::Color::Black);
	resposta1_2.setCharacterSize(48);
		
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");
	
	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta1);
	window.draw(resposta1_1);
	window.draw(resposta1_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta1);
	window.draw(resposta1_1);
	window.draw(resposta1_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela!=2 && tela!= 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta1);
		window.draw(resposta1_1);
		window.draw(resposta1_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}
 
//*********PERGUNTA 2*********//
int telapergunta2(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 2
	sf::Text pergunta2;
	pergunta2.setString("Você gostaria de trabalhar com\n um grande volume de informaçoes?");
	pergunta2.setPosition(100, 150);
	pergunta2.setFont(alamain);
	pergunta2.setColor(sf::Color::Black);
	pergunta2.setStyle(sf::Text::Style::Underlined);
	pergunta2.setCharacterSize(42);
	//lê as respostas pergunta 2
	sf::Text resposta2_1;
	sf::Text resposta2_2;
	resposta2_1.setString("Sim");
	resposta2_1.setPosition(220, 340);
	resposta2_1.setFont(lucida);
	resposta2_1.setColor(sf::Color::Black);
	resposta2_1.setCharacterSize(48);
	resposta2_2.setString("Não");
	resposta2_2.setPosition(220, 480);
	resposta2_2.setFont(lucida);
	resposta2_2.setColor(sf::Color::Black);
	resposta2_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta2);
	window.draw(resposta2_1);
	window.draw(resposta2_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta2);
	window.draw(resposta2_1);
	window.draw(resposta2_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta2);
		window.draw(resposta2_1);
		window.draw(resposta2_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 3*********//
int telapergunta3(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 3
	sf::Text pergunta3;
	pergunta3.setString("O que você gostaria de fazer\n com esse volume de informações?");
	pergunta3.setPosition(100, 145);
	pergunta3.setFont(alamain);
	pergunta3.setColor(sf::Color::Black);
	pergunta3.setStyle(sf::Text::Style::Underlined);
	pergunta3.setCharacterSize(42);
	//lê as respostas pergunta 3
	sf::Text resposta3_1;
	sf::Text resposta3_2;
	resposta3_1.setString("Organização");
	resposta3_1.setPosition(220, 340);
	resposta3_1.setFont(lucida);
	resposta3_1.setColor(sf::Color::Black);
	resposta3_1.setCharacterSize(48);
	resposta3_2.setString("Treinamento\n e Aprendizado");
	resposta3_2.setPosition(220, 480);
	resposta3_2.setFont(lucida);
	resposta3_2.setColor(sf::Color::Black);
	resposta3_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta3);
	window.draw(resposta3_1);
	window.draw(resposta3_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta3);
	window.draw(resposta3_1);
	window.draw(resposta3_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta3);
		window.draw(resposta3_1);
		window.draw(resposta3_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 4*********//
int telapergunta4(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 4
	sf::Text pergunta4;
	pergunta4.setString("O que você acha de trabalhar\n com informaçoes remotamente?");
	pergunta4.setPosition(120, 150);
	pergunta4.setFont(alamain);
	pergunta4.setColor(sf::Color::Black);
	pergunta4.setStyle(sf::Text::Style::Underlined);
	pergunta4.setCharacterSize(42);
	//lê as respostas pergunta 4
	sf::Text resposta4_1;
	sf::Text resposta4_2;
	resposta4_1.setString("Interessante");
	resposta4_1.setPosition(220, 340);
	resposta4_1.setFont(lucida);
	resposta4_1.setColor(sf::Color::Black);
	resposta4_1.setCharacterSize(48);
	resposta4_2.setString("Não Gosto");
	resposta4_2.setPosition(220, 480);
	resposta4_2.setFont(lucida);
	resposta4_2.setColor(sf::Color::Black);
	resposta4_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta4);
	window.draw(resposta4_1);
	window.draw(resposta4_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta4);
	window.draw(resposta4_1);
	window.draw(resposta4_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta4);
		window.draw(resposta4_1);
		window.draw(resposta4_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 5*********//
int telapergunta5(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 5
	sf::Text pergunta5;
	pergunta5.setString("Você gosta de biologia?");
	pergunta5.setPosition(140, 160);
	pergunta5.setFont(alamain);
	pergunta5.setColor(sf::Color::Black);
	pergunta5.setStyle(sf::Text::Style::Underlined);
	pergunta5.setCharacterSize(42);
	//lê as respostas pergunta 5
	sf::Text resposta5_1;
	sf::Text resposta5_2;
	resposta5_1.setString("Sim");
	resposta5_1.setPosition(220, 340);
	resposta5_1.setFont(lucida);
	resposta5_1.setColor(sf::Color::Black);
	resposta5_1.setCharacterSize(48);
	resposta5_2.setString("Não");
	resposta5_2.setPosition(220, 480);
	resposta5_2.setFont(lucida);
	resposta5_2.setColor(sf::Color::Black);
	resposta5_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta5);
	window.draw(resposta5_1);
	window.draw(resposta5_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta5);
	window.draw(resposta5_1);
	window.draw(resposta5_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta5);
		window.draw(resposta5_1);
		window.draw(resposta5_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 6*********//
int telapergunta6(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 6
	sf::Text pergunta6;
	pergunta6.setString("O que você acha de trabalhar\n com gerenciamento de projeto?");
	pergunta6.setPosition(90, 140);
	pergunta6.setFont(alamain);
	pergunta6.setColor(sf::Color::Black);
	pergunta6.setStyle(sf::Text::Style::Underlined);
	pergunta6.setCharacterSize(42);
	//lê as respostas pergunta 5
	sf::Text resposta6_1;
	sf::Text resposta6_2;
	resposta6_1.setString("Interessante");
	resposta6_1.setPosition(220, 340);
	resposta6_1.setFont(lucida);
	resposta6_1.setColor(sf::Color::Black);
	resposta6_1.setCharacterSize(48);
	resposta6_2.setString("Desinteressante");
	resposta6_2.setPosition(220, 480);
	resposta6_2.setFont(lucida);
	resposta6_2.setColor(sf::Color::Black);
	resposta6_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta6);
	window.draw(resposta6_1);
	window.draw(resposta6_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta6);
	window.draw(resposta6_1);
	window.draw(resposta6_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta6);
		window.draw(resposta6_1);
		window.draw(resposta6_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 7*********//
int telapergunta7(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 7
	sf::Text pergunta7;
	pergunta7.setString("Você se imagina, \nfuturamente, trabalhando em:");
	pergunta7.setPosition(120, 150);
	pergunta7.setFont(alamain);
	pergunta7.setColor(sf::Color::Black);
	pergunta7.setStyle(sf::Text::Style::Underlined);
	pergunta7.setCharacterSize(42);
	//lê as respostas pergunta 7
	sf::Text resposta7_1;
	sf::Text resposta7_2;
	resposta7_1.setString("Área Acadêmica");
	resposta7_1.setPosition(220, 340);
	resposta7_1.setFont(lucida);
	resposta7_1.setColor(sf::Color::Black);
	resposta7_1.setCharacterSize(48);
	resposta7_2.setString("Indústria");
	resposta7_2.setPosition(220, 480);
	resposta7_2.setFont(lucida);
	resposta7_2.setColor(sf::Color::Black);
	resposta7_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta7);
	window.draw(resposta7_1);
	window.draw(resposta7_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta7);
	window.draw(resposta7_1);
	window.draw(resposta7_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta7);
		window.draw(resposta7_1);
		window.draw(resposta7_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 8*********//
int telapergunta8(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 8
	sf::Text pergunta8;
	pergunta8.setString("O que você prefere?");
	pergunta8.setPosition(140, 160);
	pergunta8.setFont(alamain);
	pergunta8.setColor(sf::Color::Black);
	pergunta8.setStyle(sf::Text::Style::Underlined);
	pergunta8.setCharacterSize(42);
	//lê as respostas pergunta 8
	sf::Text resposta8_1;
	sf::Text resposta8_2;
	resposta8_1.setString("Projetos do \nProcesso Industrial");
	resposta8_1.setPosition(220, 340);
	resposta8_1.setFont(lucida);
	resposta8_1.setColor(sf::Color::Black);
	resposta8_1.setCharacterSize(48);
	resposta8_2.setString("Conjunto de Máquinas\n Partilhando Recursos");
	resposta8_2.setPosition(220, 480);
	resposta8_2.setFont(lucida);
	resposta8_2.setColor(sf::Color::Black);
	resposta8_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta8);
	window.draw(resposta8_1);
	window.draw(resposta8_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta8);
	window.draw(resposta8_1);
	window.draw(resposta8_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta8);
		window.draw(resposta8_1);
		window.draw(resposta8_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 9********//
int telapergunta9(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 9
	sf::Text pergunta9;
	pergunta9.setString("O que acha da interaçao entre ciencia da\n computaçao e outras grandes areas como\n psicologia, linguistica, sociologia?");
	pergunta9.setPosition(60, 120);
	pergunta9.setFont(alamain);
	pergunta9.setColor(sf::Color::Black);
	pergunta9.setStyle(sf::Text::Style::Underlined);
	pergunta9.setCharacterSize(34);
	//lê as respostas pergunta 9
	sf::Text resposta9_1;
	sf::Text resposta9_2;
	resposta9_1.setString("Positiva");
	resposta9_1.setPosition(220, 340);
	resposta9_1.setFont(lucida);
	resposta9_1.setColor(sf::Color::Black);
	resposta9_1.setCharacterSize(48);
	resposta9_2.setString("Desinteressante");
	resposta9_2.setPosition(220, 480);
	resposta9_2.setFont(lucida);
	resposta9_2.setColor(sf::Color::Black);
	resposta9_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta9);
	window.draw(resposta9_1);
	window.draw(resposta9_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta9);
	window.draw(resposta9_1);
	window.draw(resposta9_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta9);
		window.draw(resposta9_1);
		window.draw(resposta9_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 10*********//
int telapergunta10(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 10
	sf::Text pergunta10;
	pergunta10.setString("O que voce acha de objetos\n do dia-a-dia conectados à internet?");
	pergunta10.setPosition(90, 130);
	pergunta10.setFont(alamain);
	pergunta10.setColor(sf::Color::Black);
	pergunta10.setStyle(sf::Text::Style::Underlined);
	pergunta10.setCharacterSize(34);
	//lê as respostas pergunta 10
	sf::Text resposta10_1;
	sf::Text resposta10_2;
	resposta10_1.setString("Legal");
	resposta10_1.setPosition(220, 340);
	resposta10_1.setFont(lucida);
	resposta10_1.setColor(sf::Color::Black);
	resposta10_1.setCharacterSize(48);
	resposta10_2.setString("Desinteressante");
	resposta10_2.setPosition(220, 480);
	resposta10_2.setFont(lucida);
	resposta10_2.setColor(sf::Color::Black);
	resposta10_2.setCharacterSize(48);
	//lê as setas
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta10);
	window.draw(resposta10_1);
	window.draw(resposta10_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta10);
	window.draw(resposta10_1);
	window.draw(resposta10_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta10);
		window.draw(resposta10_1);
		window.draw(resposta10_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

//*********PERGUNTA 11*********//
int telapergunta11(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 11
	sf::Text pergunta11;
	pergunta11.setString("Com qual tipo de linguagem\n voce prefere trabalhar?");
	pergunta11.setPosition(140, 160);
	pergunta11.setFont(alamain);
	pergunta11.setColor(sf::Color::Black);
	pergunta11.setStyle(sf::Text::Style::Underlined);
	pergunta11.setCharacterSize(42);
	//lê as respostas pergunta 11
	sf::Text resposta11_1;
	sf::Text resposta11_2;
	resposta11_1.setString("Nível Alto");
	resposta11_1.setPosition(220, 340);
	resposta11_1.setFont(lucida);
	resposta11_1.setColor(sf::Color::Black);
	resposta11_1.setCharacterSize(48);
	resposta11_2.setString("Nível Baixo");
	resposta11_2.setPosition(220, 480);
	resposta11_2.setFont(lucida);
	resposta11_2.setColor(sf::Color::Black);
	resposta11_2.setCharacterSize(48);
	//lê as setasc
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta11);
	window.draw(resposta11_1);
	window.draw(resposta11_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta11);
	window.draw(resposta11_1);
	window.draw(resposta11_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta11);
		window.draw(resposta11_1);
		window.draw(resposta11_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}

int telapergunta12(sf::RenderWindow &window) {
	int contador = 0;

	//lê as fontes
	sf::Font alamain;
	sf::Font lucida;
	alamain.loadFromFile("alamain1.ttf");
	lucida.loadFromFile("Lucida.TTF");
	//lê a cor
	sf::Color azul(46, 90, 135);
	//lê o titulo
	sf::Text titulo;
	titulo.setString("Pergunta:");
	titulo.setPosition(40, 40);
	titulo.setFont(alamain);
	titulo.setColor(azul);
	titulo.setStyle(sf::Text::Style::Underlined);
	titulo.setCharacterSize(36);
	//lê o fundo
	sf::Texture fbackground;
	fbackground.loadFromFile("fundo.png");
	sf::Sprite background;
	background.setTexture(fbackground);
	background.setPosition(0, 0);
	//lê o logo
	sf::Texture flogo;
	flogo.loadFromFile("logopergunta.png");
	sf::Sprite logo;
	logo.setTexture(flogo);
	logo.setPosition(745, 20);
	//lê a pergunta 11
	sf::Text pergunta12;
	pergunta12.setString("Você se considera empreendedor?");
	pergunta12.setPosition(140, 160);
	pergunta12.setFont(alamain);
	pergunta12.setColor(sf::Color::Black);
	pergunta12.setStyle(sf::Text::Style::Underlined);
	pergunta12.setCharacterSize(42);
	//lê as respostas pergunta 11
	sf::Text resposta12_1;
	sf::Text resposta12_2;
	resposta12_1.setString("Sim");
	resposta12_1.setPosition(220, 340);
	resposta12_1.setFont(lucida);
	resposta12_1.setColor(sf::Color::Black);
	resposta12_1.setCharacterSize(48);
	resposta12_2.setString("Não");
	resposta12_2.setPosition(220, 480);
	resposta12_2.setFont(lucida);
	resposta12_2.setColor(sf::Color::Black);
	resposta12_2.setCharacterSize(48);
	//lê as setasc
	sf::Texture seta;
	sf::Texture setaselecionada;
	seta.loadFromFile("seta.png");
	setaselecionada.loadFromFile("setaselecionada.png");

	//setas opcoes
	sf::Sprite seta1;
	sf::Sprite seta2;
	seta1.setPosition(80, 300);
	seta2.setPosition(80, 450);
	seta1.setTexture(seta);
	seta2.setTexture(seta);

	window.draw(background);
	window.draw(logo);
	window.draw(pergunta12);
	window.draw(resposta12_1);
	window.draw(resposta12_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();

	int tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
	window.draw(background);
	window.draw(logo);
	window.draw(pergunta12);
	window.draw(resposta12_1);
	window.draw(resposta12_2);
	window.draw(titulo);
	window.draw(seta1);
	window.draw(seta2);
	window.display();
	while (tela != 1 && tela != 2 && tela != 0) {
		tela = selecionaOpcao(window, seta1, seta2, seta, setaselecionada, contador);
		window.draw(background);
		window.draw(logo);
		window.draw(pergunta12);
		window.draw(resposta12_1);
		window.draw(resposta12_2);
		window.draw(titulo);
		window.draw(seta1);
		window.draw(seta2);
		window.display();
	}

	return tela;
}



