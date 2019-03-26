#pragma once
#include <SFML/Graphics.hpp>
#include <iostream>
#include <vector>
#include <string>
#define posYApontador 480
#define posYDesloque 440
#define TAM_ALFABETO 256
using namespace std;

int max(int a, int b)   //retorna o máximo entre dois valores
{
	return (a > b) ? a : b;	
}

void tabela_d(int desvio1[], string &palavra) {   //preenche a tabela de desvios
    int i;
    for (i=0; i < TAM_ALFABETO; i++) {
        desvio1[i] = palavra.size();   // se o caractere não ocorre no padrão, o desvio é o tamanho deste
    }
    for (i=0; i < palavra.size() - 1; i++) {
        desvio1[palavra[i]] = palavra.size() - 1 - i;     //se o caractere ocorre no padrão, o desvio é a distância daquele para o final deste
    }
}

void tabela_d2(int desvio2[], string palavra)  //calcula a tabela do "good suffix"
{
    bool achou = false;
    int pos, j, aux2 = 1,k_achou;

	for(int i = 0; i < palavra.size(); i++)  //preenche os valores com -1
	{
		desvio2[i] = -1;
	}
	for(int i = 1; i < palavra.size(); i++)  //se algum sufixo ocorre em algum lugar da palavra, preenche a posição do tamanho do sufixo com a distância deste para a outra ocorrência mais a direita
	{
		pos = 0;
		while(pos < palavra.size() - i - 1)
		{
			j = 0;

			while(j < i && palavra[pos + j] == palavra[palavra.size() - i + j])
			{
				j++;
			}

			if((j == i) && palavra[pos + j - 1] == palavra[palavra.size() - 1])
				{
					desvio2[i] = palavra.size() - i - pos;
				}
			pos ++;
		}
	}

	while(aux2 < palavra.size() && !achou) //verifica se algum sufixo é também o prefixo do padrão, caso isso seja confirmado, todas as posições da tabela a partir desse sufixo recebem a diferença do tamanho do padrão e do prefixo
    {
        j = 0;
        while(j < aux2 && palavra[j] == palavra[palavra.size() - aux2 + j])
        {
            j++;
        }
        if((j == aux2) && palavra[j - 1] == palavra[palavra.size() - 1])
        {
            achou = true;
            for(int a = aux2 + 1; a < palavra.size(); a++)
                desvio2[a] = palavra.size() - aux2;
        }
        aux2++;
    }
}

bool boyerMoore(sf::RenderWindow &window, string &palavraDigitada, string &fraseDigitada){
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
    titulo.setString("Boyer Moore");
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
    while (clock0.getElapsedTime() < sf::seconds(2.5)) {}

    /*Faz o Horspool*/
	int valores_tabela[TAM_ALFABETO];
	int* valores_tabela2 = new int[palavraDigitada.size()];
    tabela_d(valores_tabela, palavraDigitada);
    tabela_d2(valores_tabela2,palavraDigitada);
    int tamFrase = fraseDigitada.size();
    int tamPalavra = palavraDigitada.size();
    int posAtualApontador = posIniApontador + palavraDigitada.size()*saltoApontador;
    int i = tamPalavra - 1;
    int posAtualDesloque = posIniDesloque;
    int aux, j, k;
    if (tamPalavra > tamFrase){       //se a frase for menor do que o padrão, retorne falso
        return false;
    } 
    else{                            //se a frase for maior
        while(i < tamFrase){         //até chegar ao fim da frase
            j = tamPalavra - 1;
            aux = i;
            k = 0;
            while(j >= 0 && (palavraDigitada[j] == fraseDigitada[i])){    //compare o padrão com a frase partindo da última posição daquele, até encontrar um caractere que não coincide ou até encontrar o padrão na frase
    			j--;
                i--;
                k++;
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
            if(j < 0)         //se o padrão for encontrado, 'j' será negativo, então retorne verdadeiro
                return true;
            else             //se não foi encontrado
        	{
        		if(k == 0)  //se não houve nenhum caractere coincidente, o desvio está na primeira tabela, na posição do caractere da frase alinhado com o último caractere do padrão 
				{
        			i += valores_tabela[fraseDigitada[i]];
        			posAtualDesloque = posIniDesloque + (i - palavraDigitada.size() + 1)* saltoApontador;
        		}
        		else if(k > 0)  //se houve pelo menos uma coincidência, o desvio é dado pelo maior valor entre a primeira e a segunda tabela
        		{
        			i += (aux - i) + max(max(valores_tabela[fraseDigitada[i]] - k, 1),valores_tabela2[k]);
        			posAtualDesloque = posIniDesloque + (i - palavraDigitada.size() + 1 ) * saltoApontador;
				}
        		posAtualApontador = posIniApontador + (i+1)*saltoApontador;
        		apontador.setPosition(posAtualApontador,posYApontador);
        		palavraDesloque.setPosition(posAtualDesloque,posYDesloque);
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
    return false;
}


