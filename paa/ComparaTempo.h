#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include<time.h>
#include<string>
#include <sstream>
#include "Horspool.h"
#include "BoyerMoore.h"

using namespace std;

/*Convert double para string*/
string stringalizar(double x)
{
    std::ostringstream oss;
    oss << x;
    return oss.str();
}

bool comparaTempo(sf::RenderWindow &window, string &palavraDigitada, string &fraseDigitada){
    /*Inicializa a Window*/
    int tela = -1; //inicializa a variavel tela
    //Fontes
    sf::Font lucida;
    lucida.loadFromFile("Dependencies/Lucida.TTF");
    sf::Font courier;
    courier.loadFromFile("Dependencies/cour.ttf");
    sf::Font arial;
    arial.loadFromFile("Dependencies/Arial.TTF");
    //Textos
    sf::Text tempoHorspool;
    sf::Text tempoBoyerMoore;
    sf::Text tempoForcaBruta;
    sf::Text tempoHorspool2;
    sf::Text tempoBoyerMoore2;
    sf::Text tempoForcaBruta2;
    tempoForcaBruta.setPosition(260,220);
    tempoForcaBruta.setFont(lucida);
    tempoForcaBruta.setColor(sf::Color::Black);
    tempoForcaBruta.setCharacterSize(36);
    tempoForcaBruta.setString("Força Bruta:");
    tempoHorspool.setPosition(260,320);
    tempoHorspool.setFont(lucida);
    tempoHorspool.setColor(sf::Color::Black);
    tempoHorspool.setCharacterSize(36);
    tempoHorspool.setString("Horspool:");
    tempoBoyerMoore.setPosition(260,420);
    tempoBoyerMoore.setFont(lucida);
    tempoBoyerMoore.setColor(sf::Color::Black);
    tempoBoyerMoore.setCharacterSize(36);
    tempoBoyerMoore.setString("BoyerMoore:");
    tempoForcaBruta2.setPosition(560,220);
    tempoForcaBruta2.setFont(lucida);
    tempoForcaBruta2.setColor(sf::Color::Black);
    tempoForcaBruta2.setCharacterSize(36);
    tempoForcaBruta2.setString("0");
    tempoHorspool2.setPosition(560,320);
    tempoHorspool2.setFont(lucida);
    tempoHorspool2.setColor(sf::Color::Black);
    tempoHorspool2.setCharacterSize(36);
    tempoHorspool2.setString("0");
    tempoBoyerMoore2.setPosition(560,420);
    tempoBoyerMoore2.setFont(lucida);
    tempoBoyerMoore2.setColor(sf::Color::Black);
    tempoBoyerMoore2.setCharacterSize(36);
    tempoBoyerMoore2.setString("0");


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
    window.draw(tempoForcaBruta);
    window.draw(tempoForcaBruta2);
    window.draw(tempoHorspool);
    window.draw(tempoHorspool2);
    window.draw(tempoBoyerMoore);
    window.draw(tempoBoyerMoore2);
    window.display(); //display da tela

    /********************************FAZ O FORÇA BRUTA********************************/
	int tamFrase=fraseDigitada.size();
    int tamPalavra=palavraDigitada.size();
    int diferenca = tamFrase-tamPalavra;

    /*Tempo*/
    double elapsed;
    time_t start,stop;
    string tempo;


    if (tamPalavra>tamFrase){
    	time (&start);
    	time (&stop);
	}
	else{
		time (&start);
        for(int i=0; i<=diferenca; i++){
            int j=0;
            while(j<tamPalavra&&(palavraDigitada[j]==fraseDigitada[i+j])){
                j=j+1;
                sf::Clock clockForcaBruta;
                while (clockForcaBruta.getElapsedTime() < sf::seconds(2.8)) {}
                time(&stop);
                elapsed = difftime (stop,start);
                tempo = stringalizar(elapsed) + " segundos";
                tempoForcaBruta2.setString(tempo);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(tempoForcaBruta);
                window.draw(tempoForcaBruta2);
                window.draw(tempoHorspool);
                window.draw(tempoHorspool2);
                window.draw(tempoBoyerMoore);
                window.draw(tempoBoyerMoore2);
                window.display(); //display da tela
            }
            if(j==tamPalavra){
                time(&stop);
                break;
            }
        }
    }
    elapsed = difftime (stop,start);
    tempo = stringalizar(elapsed) + " segundos";
    tempoForcaBruta2.setString(tempo);
    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(tempoForcaBruta);
    window.draw(tempoForcaBruta2);
    window.draw(tempoHorspool);
    window.draw(tempoHorspool2);
    window.draw(tempoBoyerMoore);
    window.draw(tempoBoyerMoore2);
    window.display(); //display da tela

    /********************************FAZ O HORSPOOL********************************/
    elapsed=0;
    start=0;
    stop=0;
    tempo="0";

    int valores_tabela[256];
    tabela_d1(valores_tabela,palavraDigitada);
    int i = tamPalavra - 1;
    int aux, j;
    

    if (tamPalavra>tamFrase){
        time(&start);
        time(&stop);
    }
    else{
    	time(&start);
        while(i < tamFrase){
            j = tamPalavra - 1;
            aux = i;
            while(j >= 0 && (palavraDigitada[j] == fraseDigitada[i])){
    			j--;
                i--;
				sf::Clock clockHorspool;
                while (clockHorspool.getElapsedTime() < sf::seconds(1.2)) {}
                time(&stop);
                elapsed = difftime (stop,start);
                tempo = stringalizar(elapsed) + " segundos";
                tempoHorspool2.setString(tempo);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(tempoForcaBruta);
                window.draw(tempoForcaBruta2);
                window.draw(tempoHorspool);
                window.draw(tempoHorspool2);
                window.draw(tempoBoyerMoore);
                window.draw(tempoBoyerMoore2);
                window.display(); //display da tela
            }
            if(j < 0){
                time(&stop);
                break;
        	}
            else
        	{
        		i += (aux - i) + valores_tabela[fraseDigitada[aux]];
				sf::Clock clockHorspool;
                while (clockHorspool.getElapsedTime() < sf::seconds(1.2)) {}
                time(&stop);
                elapsed = difftime (stop,start);
                tempo = stringalizar(elapsed) + " segundos";
                tempoHorspool2.setString(tempo);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(tempoForcaBruta);
                window.draw(tempoForcaBruta2);
                window.draw(tempoHorspool);
                window.draw(tempoHorspool2);
                window.draw(tempoBoyerMoore);
                window.draw(tempoBoyerMoore2);
                window.display(); //display da tela
			}
        }
    }

    elapsed = difftime (stop,start);
    tempo = stringalizar(elapsed) + " segundos";
    tempoHorspool2.setString(tempo);
    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(tempoForcaBruta);
    window.draw(tempoForcaBruta2);
    window.draw(tempoHorspool);
    window.draw(tempoHorspool2);
    window.draw(tempoBoyerMoore);
    window.draw(tempoBoyerMoore2);
    window.display(); //display da tela


    /********************************FAZ O BOYERMOORE********************************/
    elapsed=0;
    start=0;
    stop=0;
    tempo="0";
	int* valores_tabela2 = new int[palavraDigitada.size()];
    tabela_d(valores_tabela, palavraDigitada);
    tabela_d2(valores_tabela2,palavraDigitada);
    int i2 = tamPalavra - 1;
    int aux2, j2, k2;
    if (tamPalavra > tamFrase){
        time(&start);
        time(&stop);
	}
    else{
        time(&start);
        while(i2 < tamFrase){
            j2 = tamPalavra - 1;
            aux2 = i2;
            k2 = 0;
            while(j2 >= 0 && (palavraDigitada[j2] == fraseDigitada[i2])){
    			j2--;
                i2--;
                k2++;
                sf::Clock clockBoyerMoore;
                while (clockBoyerMoore.getElapsedTime() < sf::seconds(0.9)) {}
                elapsed = difftime (stop,start);
                tempo = stringalizar(elapsed) + " segundos";
                tempoBoyerMoore2.setString(tempo);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(tempoForcaBruta);
                window.draw(tempoForcaBruta2);
                window.draw(tempoHorspool);
                window.draw(tempoHorspool2);
                window.draw(tempoBoyerMoore);
                window.draw(tempoBoyerMoore2);
                window.display(); //display da tela
            }
            if(j2 < 0){
                time(&stop);
                break;
        	}
			else
        	{
        		if(k2 == 0)
				{
        			i2 += valores_tabela[fraseDigitada[i2]];
        			sf::Clock clockBoyerMoore;
                	while (clockBoyerMoore.getElapsedTime() < sf::seconds(0.7)) {}
        			time(&stop);
                	elapsed = difftime (stop,start);
                	tempo = stringalizar(elapsed) + " segundos";
                	tempoBoyerMoore2.setString(tempo);
	                window.draw(menu); //desenha o menu
	                window.draw(logotipo);
	                window.draw(tempoForcaBruta);
	                window.draw(tempoForcaBruta2);
	                window.draw(tempoHorspool);
	                window.draw(tempoHorspool2);
	                window.draw(tempoBoyerMoore);
	                window.draw(tempoBoyerMoore2);
	                window.display(); //display da tela
				}
        		else if(k2 > 0)
        		{
        			i2 += (aux2 - i2) + max(max(valores_tabela[fraseDigitada[i2]] - k2, 1),valores_tabela2[k2]);
        			sf::Clock clockBoyerMoore;
                	while (clockBoyerMoore.getElapsedTime() < sf::seconds(0.7)) {}
					time(&stop);
                	elapsed = difftime (stop,start);
                	tempo = stringalizar(elapsed) + " segundos";
                	tempoBoyerMoore2.setString(tempo);
	                window.draw(menu); //desenha o menu
	                window.draw(logotipo);
	                window.draw(tempoForcaBruta);
	                window.draw(tempoForcaBruta2);
	                window.draw(tempoHorspool);
	                window.draw(tempoHorspool2);
	                window.draw(tempoBoyerMoore);
	                window.draw(tempoBoyerMoore2);
	                window.display(); //display da tela
				}
			}
        }
    }

    elapsed = difftime (stop,start);
    tempo = stringalizar(elapsed) + " segundos";
    tempoBoyerMoore2.setString(tempo);
    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(tempoForcaBruta);
    window.draw(tempoForcaBruta2);
    window.draw(tempoHorspool);
    window.draw(tempoHorspool2);
    window.draw(tempoBoyerMoore);
    window.draw(tempoBoyerMoore2);
    
    //Texto
    sf::Text texto;
    texto.setPosition(150,550);
    texto.setFont(arial);
    texto.setColor(sf::Color::Black);
    texto.setCharacterSize(36);    
    texto.setString("Pressione Enter para Voltar ao Menu");
    
    window.draw(texto);
    window.display(); //display da tela

	

    /*Espera Comando*/
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
                    return -2;
                }
            }
        }
    }

    return false;
}