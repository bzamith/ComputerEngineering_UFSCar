#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include<string>

#define numMaxChar 32

using namespace std;

int digitaTela(sf::RenderWindow &window, string &palavraDigitada, int comando)
{
    int tela = -1; //inicializa a variavel tela
    //Fontes
    sf::Font lucida;
    lucida.loadFromFile("Dependencies/Lucida.TTF");
    sf::Font arial;
    arial.loadFromFile("Dependencies/Arial.TTF");
    //Textos
    sf::Text palavra;
    sf::Text pedido;
    pedido.setPosition(260,220);
    pedido.setFont(lucida);
    pedido.setColor(sf::Color::Black);
    pedido.setCharacterSize(36);
    if(comando==1)
        pedido.setString("Favor digitar a frase:");
    if(comando==2)
        pedido.setString("Favor digitar a palavra:");
    palavra.setPosition(260,350);
    palavra.setFont(arial);
    palavra.setColor(sf::Color::Black);
    palavra.setCharacterSize(36);
    //Shapes
    sf::RectangleShape barra;
    sf::Color cor1(243, 91, 105);
    barra.setPosition(200,350);
    barra.setFillColor(cor1);
    barra.setSize(sf::Vector2f(640, 50));
    //Texturas
    sf::Texture fundo; //textura do fundo
    sf::Texture logo;
    //Carrega imagens
    fundo.loadFromFile("Dependencies/fundo.png"); //fundo
    logo.loadFromFile("Dependencies/logo.png"); //fundo do logo
    //Sprites
    sf::Sprite menu; //declara a sprite
    sf::Sprite logotipo;
    //set menu
    menu.setTexture(fundo);
    menu.setPosition(0, 0);
    //set logo
    logotipo.setPosition(180,30);
    logotipo.setTexture(logo);

    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(pedido);
    window.draw(barra);
    window.draw(palavra);
    window.display(); //display da tela

    while (tela != 0)   //tela começa com -1 e só é 0 quando fecha
    {
        sf::Event event; //evento
        while (window.pollEvent(event)) //enquanto receber um evento
        {
            if (event.type == sf::Event::Closed)   //fecha
            {
                return 0;
            }
            if (event.type == sf::Event::TextEntered)   //fecha
            {
                if (event.text.unicode == '\b'&&palavraDigitada.size()>0){
                    palavraDigitada.erase(palavraDigitada.size() - 1, 1);
                    palavra.setString(palavraDigitada);
                }
                else if(event.text.unicode < 128)
                {
                    if(palavraDigitada.size()!=numMaxChar&&event.text.unicode!='\r'){
                        palavraDigitada+=static_cast<char>(event.text.unicode);
                        palavra.setString(palavraDigitada);
                    }
                }
            }
            if (event.type == sf::Event::KeyPressed)   //pressiona uma tecla
            {
                if (event.key.code == sf::Keyboard::Return)   //espaço equivale a enter
                {
                    if(comando==1)
                        return 5;
                    if(comando==2)
                        return -1;
                }
            }
			if (event.type == sf::Event::Closed)   //fecha
			{
					return 0;
			}

        }
        window.draw(menu); //desenha o menu
        window.draw(logotipo);
        window.draw(pedido);
        window.draw(barra);
        window.draw(palavra);
        window.display(); //display da tela
    }
}




