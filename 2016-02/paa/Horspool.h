#pragma once
#include <iostream>
#include <vector>
#include <string>
#include <SFML/Graphics.hpp>
#define posYApontador 480
#define posYDesloque 440
#define TAM_ALFABETO 256

using namespace std;

void tabela_d1(int desvio1[], string &palavra) {   //preenche a tabela de desvios  
    int i;
    for (i=0; i < TAM_ALFABETO; i++) {
        desvio1[i] = palavra.size();        // se o caractere não ocorre no padrão, o desvio é o tamanho deste
    }
    for (i=0; i < palavra.size() - 1; i++) {
        desvio1[palavra[i]] = palavra.size() - 1 - i;       //se o caractere ocorre no padrão, o desvio é a distância daquele para o final deste
    }
}

bool horspool(sf::RenderWindow &window, string &palavraDigitada, string &fraseDigitada){
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
    titulo.setString("Horspool");
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
    apontador.setPosition(posIniApontador + palavraDigitada.size()*saltoApontador,posYApontador);
    apontador.setTexture(seta);

    window.draw(menu); //desenha o menu
    window.draw(logotipo);
    window.draw(titulo);
    window.draw(fraseFixa);
    window.draw(palavraDesloque);
    window.draw(apontador);
    window.display(); //display da tela
    sf::Clock clock0;
    while (clock0.getElapsedTime() < sf::seconds(5.5)) {}

    /*Faz o Horspool*/
    int valores_tabela[256];
    int tamFrase = fraseDigitada.size();
    int tamPalavra = palavraDigitada.size();
    tabela_d1(valores_tabela,palavraDigitada);
    int i = tamPalavra - 1;
    int posAtualApontador = posIniApontador + palavraDigitada.size()*saltoApontador;
    int aux, j;

    if (tamPalavra>tamFrase){    //se a frase for menor do que o padrão, retorne falso
        return false;
    }
    else{ 			//se a frase for maior
        while(i < tamFrase){	//até chegar ao fim da frase
            j = tamPalavra - 1;
            aux = i;
            while(j >= 0 && (palavraDigitada[j] == fraseDigitada[i])){ //compare o padrão com a frase partindo da última posição daquele, até encontrar um caractere que não coincide ou até encontrar o padrão na frase
    			j--;
                i--;
                if(j >= 0)
                    posAtualApontador = posAtualApontador - saltoApontador;
                apontador.setPosition(posAtualApontador,posYApontador);
                window.draw(menu); //desenha o menu
                window.draw(logotipo);
                window.draw(titulo);
                window.draw(fraseFixa);
                window.draw(palavraDesloque);
                window.draw(apontador);
                window.display();
                sf::Clock clock2;
                while (clock2.getElapsedTime() < sf::seconds(2.5)) {}
            }
            if(j < 0)		//se o padrão for encontrado, 'j' será negativo, então retorne verdadeiro
                return true;
            else		//se não foi encontrado, o desvio está na tabela, na posição do caractere da frase alinhado com o último caractere do padrão
        	{
        		i += (aux - i) + valores_tabela[fraseDigitada[aux]];
        		posAtualApontador = posIniApontador + (i+1)*saltoApontador;
        		posIniDesloque = posIniDesloque + valores_tabela[fraseDigitada[aux]] * saltoApontador;
        		apontador.setPosition(posAtualApontador,posYApontador);
        		palavraDesloque.setPosition(posIniDesloque,posYDesloque);
            	window.draw(menu); //desenha o menu
            	window.draw(logotipo);
            	window.draw(titulo);
            	window.draw(fraseFixa);
            	window.draw(palavraDesloque);
            	window.draw(apontador);
            	window.display();
            	sf::Clock clock;
            	while (clock.getElapsedTime() < sf::seconds(2.5)) {}
			}
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


