#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int menuInicial(sf::RenderWindow &window)
{
    int tela = -1; //inicializa a variavel tela
    int contador = 1; //variavel contador
    //Fontes
    sf::Font lucida;
    lucida.loadFromFile("Dependencies/Lucida.TTF");
    //Textos
    sf::Text forcaBruta;
    forcaBruta.setString("Força Bruta");
    forcaBruta.setPosition(260,220);
    forcaBruta.setFont(lucida);
    forcaBruta.setColor(sf::Color::Black);
    forcaBruta.setCharacterSize(36);
    sf::Text horspool;
    horspool.setString("Horspool");
    horspool.setPosition(260,320);
    horspool.setFont(lucida);
    horspool.setColor(sf::Color::Black);
    horspool.setCharacterSize(36);
    sf::Text boyerMoore;
    boyerMoore.setString("Boyer Moore");
    boyerMoore.setPosition(260,420);
    boyerMoore.setFont(lucida);
    boyerMoore.setColor(sf::Color::Black);
    boyerMoore.setCharacterSize(36);
    sf::Text comparaTempo;
    comparaTempo.setString("Compara Tempo");
    comparaTempo.setPosition(260,520);
    comparaTempo.setFont(lucida);
    comparaTempo.setColor(sf::Color::Black);
    comparaTempo.setCharacterSize(36);
    sf::Text creditos;
    creditos.setString("Créditos");
    creditos.setPosition(760,530);
    creditos.setFont(lucida);
    creditos.setColor(sf::Color::Black);
    creditos.setCharacterSize(36);
    //Texturas
    sf::Texture fundo; //textura do fundo
    sf::Texture seta1; //textura da seta 1 (primeira seta)
    sf::Texture seta2; //textura do fundo 2 (segunda seta)
    sf::Texture logo;
    //Carrega imagens
    fundo.loadFromFile("Dependencies/fundo.png"); //fundo
    seta1.loadFromFile("Dependencies/seta1.png"); //fundo da seta 1
    seta2.loadFromFile("Dependencies/seta2.png"); //fundo da seta 2
    logo.loadFromFile("Dependencies/logo.png"); //fundo do logo
    //Sprites
    sf::Sprite menu; //declara a sprite
    sf::Sprite setaForcaBruta;
    sf::Sprite setaHorspool;
    sf::Sprite setaBoyer;
    sf::Sprite setaComparaTempo;
    sf::Sprite logotipo;
    //set menu
    menu.setTexture(fundo);
    menu.setPosition(0, 0);
    //set logo
    logotipo.setPosition(180,30);
    logotipo.setTexture(logo);
    //5 setas
    setaForcaBruta.setTexture(seta2);
    setaForcaBruta.setPosition(170, 200);
    setaHorspool.setTexture(seta1);
    setaHorspool.setPosition(170, 300);
    setaBoyer.setTexture(seta1);
    setaBoyer.setPosition(170, 400);
    setaComparaTempo.setTexture(seta1);
    setaComparaTempo.setPosition(170, 500);


    window.draw(menu); //desenha o menu
    window.draw(setaForcaBruta);
    window.draw(setaHorspool);
    window.draw(setaBoyer);
    window.draw(setaComparaTempo);
    window.draw(logotipo);
    window.draw(forcaBruta);
    window.draw(horspool);
    window.draw(boyerMoore);
    window.draw(comparaTempo);
    window.draw(creditos);
    window.display(); //display da tela

    while (tela != 0)   //tela começa com -1 e só é 0 quando fecha
    {
        sf::Event event; //evento
        while (window.pollEvent(event)) //enquanto receber um evento
        {
            if (event.type == sf::Event::Closed)   //fecha
            {
                tela = 0;
                return tela;
            }

            if (event.type == sf::Event::KeyPressed)   //pressiona uma tecla
            {
                if (event.key.code == sf::Keyboard::Space || event.key.code == sf::Keyboard::Return)   //espaço equivale a enter
                {
                    return contador;
                }
                if (event.key.code == sf::Keyboard::Down || event.key.code == sf::Keyboard::Right) //para baixo
                    contador = contador + 1;
                if (event.key.code == sf::Keyboard::Up || event.key.code == sf::Keyboard::Left)   //para cima
                    contador = contador - 1;  //diminui
                if (contador==1||contador==6)
                {
                    if(contador==6)
                        contador=1;
                    creditos.setStyle(sf::Text::Regular);
                    setaForcaBruta.setTexture(seta2);
                    setaHorspool.setTexture(seta1);
                }
                else if (contador==2)
                {
                    setaForcaBruta.setTexture(seta1);
                    setaHorspool.setTexture(seta2);
                    setaBoyer.setTexture(seta1);
                }
                else if (contador==3)
                {
                    setaHorspool.setTexture(seta1);
                    setaBoyer.setTexture(seta2);
                    setaComparaTempo.setTexture(seta1);
                }
                else if(contador==4){
                    setaBoyer.setTexture(seta1);
                    setaComparaTempo.setTexture(seta2);
                    creditos.setStyle(sf::Text::Regular);
                }
                else if (contador==0 || contador ==5)
                {
                    if(contador==0)
                        contador=5;
                    setaComparaTempo.setTexture(seta1);
                    creditos.setStyle(sf::Text::Underlined);
                    setaForcaBruta.setTexture(seta1);
                }

            }
        }
        window.draw(menu); //desenha o menu
        window.draw(setaForcaBruta);
        window.draw(setaHorspool);
        window.draw(setaBoyer);
        window.draw(logotipo);
        window.draw(forcaBruta);
        window.draw(horspool);
        window.draw(boyerMoore);
        window.draw(creditos);
        window.draw(comparaTempo);
        window.draw(setaComparaTempo);
        window.display(); //display da tela
    }
}



