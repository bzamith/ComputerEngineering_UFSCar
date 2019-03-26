#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include<ctime>
#define posYApontador 480
#define posYDesloque 440

using namespace std;

bool forcaBruta(sf::RenderWindow &window, string &palavraDigitada, string &fraseDigitada){
    /*Inicializa a Window*/
    int tela = -1; //inicializa a variavel tela
    int posIniApontador = 235;
    int posIniDesloque = 260;
    int saltoApontador = 22;
    //Fontes
    sf::Font lucida;
    lucida.loadFromFile("Dependencies/Lucida.TTF");
    sf::Font courier;
    courier.loadFromFile("Dependencies/cour.ttf");
    //Textos
    sf::Text fraseFixa;
    sf::Text palavraDesloque;
    sf::Text titulo;
    titulo.setPosition(260,220);
    titulo.setFont(lucida);
    titulo.setColor(sf::Color::Black);
    titulo.setCharacterSize(36);
    titulo.setString("Força Bruta");
    fraseFixa.setPosition(260,350);
    fraseFixa.setFont(courier);
    fraseFixa.setColor(sf::Color::Black);
    fraseFixa.setCharacterSize(36);
    fraseFixa.setString(fraseDigitada);
    palavraDesloque.setPosition(posIniDesloque,posYDesloque);
    palavraDesloque.setFont(courier);
    palavraDesloque.setColor(sf::Color::Black);
    palavraDesloque.setCharacterSize(36);
    palavraDesloque.setString(palavraDigitada);
    //Texturas
    sf::Texture fundo; //textura do fundo
    sf::Texture logo;
    sf::Texture seta;
    //Carrega imagens
    fundo.loadFromFile("Dependencies/fundo.png"); //fundo
    logo.loadFromFile("Dependencies/logo.png"); //fundo do logo
    seta.loadFromFile("Dependencies/apontador.png");
    //Sprites
    sf::Sprite menu; //declara a sprite
    sf::Sprite logotipo;
    sf::Sprite apontador;
    //set menu
    menu.setTexture(fundo);
    menu.setPosition(0, 0);
    //set logo
    logotipo.setPosition(180,30);
    logotipo.setTexture(logo);
    //set apontador
    apontador.setPosition(posIniApontador,posYApontador);
    apontador.setTexture(seta);

    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(titulo);
    window.draw(fraseFixa);
    window.draw(palavraDesloque);
    window.draw(apontador);
    window.display(); //display da tela

    /*Faz o Força Bruta*/
    int tamFrase=fraseDigitada.size();
    int tamPalavra=palavraDigitada.size();
    int diferenca = tamFrase-tamPalavra;
    sf::Clock clock;
    while (clock.getElapsedTime() < sf::seconds(1.5)) {}
    if (tamPalavra>tamFrase){
        return false;
    }
    else{
        for(int i=0; i<=diferenca; i++){
            int j=0;
            while(j<tamPalavra&&(palavraDigitada[j]==fraseDigitada[i+j])){
                j=j+1;
                apontador.setPosition((posIniApontador+(j*saltoApontador)),posYApontador);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(titulo);
                window.draw(fraseFixa);
                window.draw(palavraDesloque);
                window.draw(apontador);
                window.display();
                sf::Clock clock2;
                while (clock2.getElapsedTime() < sf::seconds(1.5)) {}
            }
            if(j==tamPalavra)
                return true;
            posIniDesloque=(posIniDesloque+(saltoApontador));
            palavraDesloque.setPosition(posIniDesloque,posYDesloque);
            posIniApontador=posIniDesloque-3;
            apontador.setPosition(posIniApontador,posYApontador);
            window.draw(menu); //desenha o menu
            window.draw(logotipo);
            window.draw(titulo);
            window.draw(fraseFixa);
            window.draw(palavraDesloque);
            window.draw(apontador);
            window.display();
            sf::Clock clock;
            while (clock.getElapsedTime() < sf::seconds(1.5)) {}
        }
    }
	sf::Event event; //evento
	while (window.pollEvent(event)) //enquanto receber um evento
	{
		if (event.type == sf::Event::Closed)   //fecha
		{
			return 0;
		}
	}
    return false;
}

