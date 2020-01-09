#include <iostream>
#include <SDL.h>
#include <SDL_image.h>
#include <time.h>
#include "Pilha.h"
using namespace std;

const int LARGURA = 600;
const int ALTURA = 600;
enum Cores
{
	Azul,
	Vermelho,
	Amarelo,
	Verde,
	TOTAL
};

SDL_Window *window = NULL;   
SDL_Surface *screenSurface = NULL;
SDL_Surface *Default = NULL; 
SDL_Surface *Atual = NULL;
SDL_Surface* Imagens[ TOTAL ];

SDL_Surface* loadSurface( std::string path )
{
	SDL_Surface* loadedSurface = IMG_Load( path.c_str() );
	if( loadedSurface == NULL )
	{
		cout << "Impossivel carregar imagem! SDL Error: " << path.c_str() << SDL_GetError() ;
	}

	return loadedSurface;
}

bool loadMedia()
{
	bool success = true;

	Default = loadSurface( "Default.png" );
	if( Default == NULL )
	{
		cout << "Impossivel carregar imagem";
		success = false;
	}

	
	Imagens[ Azul ] = loadSurface( "Azul.png" );
	if( Imagens[ Azul ] == NULL )
	{
		cout << "Impossivel carregar imagem";
		success = false;
	}

	Imagens[ Vermelho ] = loadSurface( "Vermelho.png" );
	if( Imagens[ Vermelho ] == NULL )
	{
		cout << "Impossivel carregar imagem";
		success = false;
	}

	Imagens[ Amarelo ] = loadSurface( "Amarelo.png" );
	if( Imagens[ Amarelo ] == NULL )
	{
		cout << "Impossivel carregar imagem";
		success = false;
	}

	Imagens[ Verde ] = loadSurface( "Verde.png" );
	if( Imagens[ Verde ] == NULL )
	{
		cout << "Impossivel carregar imagem";
		success = false;
	}

	return success;
}

void ImprimeSuperficie(SDL_Surface* Imagem ,SDL_Surface *tela, SDL_Window* window){
	SDL_BlitSurface( Imagem, NULL, tela, NULL );
	SDL_UpdateWindowSurface( window );
	SDL_Delay(400);
}

int main(int argc , char *argv[])
{
	Pilha <int> Sequencia(30);
	Pilha<int> Paux2(30);
	bool DeuCerto;
	int Sorteio;
	int j, Limite;
	srand(time(NULL));

    if( SDL_Init( SDL_INIT_VIDEO ) < 0 )
    {
        cout << "SDL nao pode ser inicializado! SDL_Error: " << SDL_GetError();
    }
	else
    {
        window = SDL_CreateWindow( "EDinius", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, LARGURA, ALTURA, SDL_WINDOW_SHOWN );
        if( window == NULL )
        {
            cout << "Problema ao criar janela! SDL_Error: " << SDL_GetError();
        }
		else
        {
			int imgFlags = IMG_INIT_PNG;
            if( !( IMG_Init( imgFlags ) & imgFlags ) )
            {
                cout << "Impossivel iniciar SDL_image! Erro:" << IMG_GetError() ;
            }
            screenSurface = SDL_GetWindowSurface( window );
        }

		//Carregando as superfícies
		loadMedia();
		
		bool rodando = true;
		bool errou = false;
		SDL_Event e, e2;

		// inicio do loop principal
		while( rodando )
		{   
			while(SDL_PollEvent(&e2)){
				if(e2.type == SDL_QUIT)
					rodando = false;
			}
			//Imprime a tela default/////////////////
			ImprimeSuperficie(Default,screenSurface,window);
			
			//Se a sequencia estiver vazia/////////////////
			if(Sequencia.Vazio() == true){
				Sorteio = rand() % 4;
				Sequencia.Empilha(Sorteio,DeuCerto);
				Atual = Imagens[Sorteio];
				ImprimeSuperficie(Atual,screenSurface,window);
			}//fim do está vazia
			
			//Se não estiver vazia ////////
			else{
				int elemento;
				Pilha <int> Paux(30);
				while(Sequencia.Vazio() == false){
					Sequencia.Desempilha(elemento,DeuCerto);
					Paux.Empilha(elemento,DeuCerto);
				}
				//Imprime os elementos já sorteados
				while(Paux.Vazio() == false){
					Paux.Desempilha(elemento,DeuCerto);
					Atual = Imagens[elemento];
					Sequencia.Empilha(elemento,DeuCerto);
					ImprimeSuperficie(Atual,screenSurface,window);
					ImprimeSuperficie(Default,screenSurface,window);
				}//Fim da impressão dos elementos
				//Sorteia um novo elemento
				Sorteio = rand() % 4;
				Sequencia.Empilha(Sorteio,DeuCerto);
				Atual = Imagens[Sorteio];
				ImprimeSuperficie(Atual,screenSurface,window);
				ImprimeSuperficie(Default,screenSurface,window);
			}//fim do se não estiver vazia
			
			ImprimeSuperficie(Default,screenSurface,window);
			//Espera o input do usuário
			j = 0;
			Limite = Sequencia.NumeroElementos();

			while(Sequencia.Vazio() == false){
				int X;
				Sequencia.Desempilha(X,DeuCerto);
				Paux2.Empilha(X,DeuCerto);
			}

			while(SDL_WaitEvent(&e) && !errou && j < Limite ) {
					int Y;
					
					if(e.type == SDL_MOUSEBUTTONDOWN){
						Paux2.Desempilha(Y,DeuCerto);
						Sequencia.Empilha(Y,DeuCerto);
						int x,y;
						SDL_GetMouseState(&x,&y);
						
						if(Y == Verde && x > LARGURA/2 && y > ALTURA/2 ){
							cout <<"acertou" <<endl;
							ImprimeSuperficie(Imagens[Verde],screenSurface,window);
							ImprimeSuperficie(Default,screenSurface,window);
							j++;
						}
						else if(Y == Amarelo && x < LARGURA/2 && y > ALTURA/2 ){
							cout <<"acertou" <<endl;
							ImprimeSuperficie(Imagens[Amarelo],screenSurface,window);
							ImprimeSuperficie(Default,screenSurface,window);
							j++;
						}
						else if(Y == Vermelho && x < LARGURA/2 && y < ALTURA/2 ){
							cout <<"acertou" << endl;
							ImprimeSuperficie(Imagens[Vermelho],screenSurface,window);
							ImprimeSuperficie(Default,screenSurface,window);
							j++;
						}
						else if(Y == Azul && x > LARGURA/2 && y < ALTURA/2 ){
							cout <<"acertou" << endl;
							ImprimeSuperficie(Imagens[Azul],screenSurface,window);
							ImprimeSuperficie(Default,screenSurface,window);
							j++;
						}
						else{
							cout <<"errou " << endl;
							errou = true;
							rodando = false;
						}
					}
			}//fim do input do usuário 
		}//fim do loop principal
    }
	
	//limpando as superfícies e encerrando SDL
	SDL_FreeSurface(Default);
	for( int x = 0; x < TOTAL; ++x )
	{
		SDL_FreeSurface( Imagens[ x ] );
		Imagens[ x ] = NULL;
	}
	SDL_DestroyWindow(window);
	window = NULL;
    SDL_Quit();
	//Finalizando
	
	return 0;
}
