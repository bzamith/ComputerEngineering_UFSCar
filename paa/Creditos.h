#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int creditos(sf::RenderWindow &window)
{
    int tela = -1; //inicializa a variavel tela
    //Fontes
    sf::Font lucida;
    lucida.loadFromFile("Dependencies/Lucida.TTF");
    sf::Font arial;
    arial.loadFromFile("Dependencies/Arial.TTF");
    //Textos
    sf::Text texto;
    texto.setPosition(70,180);
    texto.setFont(arial);
    texto.setColor(sf::Color::Black);
    texto.setCharacterSize(36);
    texto.setString("Trabalho de PAA, 02/2016\nProfessor: Ednaldo Pizzolato\nDisciplina: Projeto e Análise de Algoritmos\n\nDesenvolvido por:\n- Bruna Zamith\n- Rodrigo Salmen\n- Tulio Reis");
    //Voltar
    sf::Text voltar;
    voltar.setString("Pressione enter para\nvoltar ao menu principal");
    voltar.setPosition(560,530);
    voltar.setFont(lucida);
    voltar.setCharacterSize(28);
    voltar.setColor(sf::Color::Black);

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
    window.draw(texto);
    window.draw(voltar);
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
            if (event.type == sf::Event::KeyPressed)   //pressiona uma tecla
            {
                if (event.key.code == sf::Keyboard::Space || event.key.code == sf::Keyboard::Return)   //espaço equivale a enter
                {
                    return -1;
                }
            }
        }
    }
    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(texto);
    window.draw(voltar);
    window.display(); //display da tela

}

