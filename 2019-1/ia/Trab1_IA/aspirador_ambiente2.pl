% Alunos: 
%   Alisson Hayasi da Costa (RA: 726494)
%   Bruna Zamith Santos (RA: 628093)

% ------------ Definicao de Ambiente
% Tamanho Cenario 
cenario(10,5).

% Paredes
parede(4,0).
parede(2,2).
parede(4,2).
parede(5,4).

% Elevadores
elevador(1,0).
elevador(1,1).
elevador(1,2).
elevador(1,3).
elevador(1,4).

% Dock Station
dockStation(9,1).

% Lixeira
lixeira(4,4).

% Sujeiras
sujeiras([[0,0],[6,1],[2,3]]).

% Capacidade AADP
capacidadeMax(2).

% ------------ Definicao das Regras Gerais
% pertence(Entrada1,Entrada2)
% Verifica se elemento pertence a lista
% Entrada1: Elem
% Entrada2: Lista 
pertence(Elem,[Elem|_]).
pertence(Elem,[_|Cauda]) :- pertence(Elem,Cauda).

% concatena(Entrada1,Entrada2,Saida)
% Concatena duas listas
% Entrada1: Lista 1
% Entrada2: Lista 2
% Saida: Concatenacao das entradas
concatena([X|Y],Z,[X|W]) :- concatena(Y,Z,W).  
concatena([],X,X).

% pop(Entrada,Saida1,Saida2)
% Faz um pop na lista 
% Entrada: Lista 
% Saida1: Primeiro elemento da lista 
% Saida2: Lista sem o elemento 
pop([Elem|Cauda],Elem,Cauda).

% reverse(Entrada,Saida)
% Inverte elementos na lista
% Entrada: Lista 
% Saida: Lista invertida 
reverse([],[]).
reverse([Cab|Cauda],R) :- reverse(Cauda,RCauda), concatena(RCauda,[Cab],R).

% ------------ Definicao das Regras de Movimentacao
% moveDir(Entrada1,Entrada2,Saida1,Saida2)
% Move para direita
% Entrada1: X inicial
% Entrada2: Y inicial 
% Saida1: X final 
% Saida2: Y final
moveDir(Xin,Y,Xout,Y) :-
    cenario(Lim,_),
    LimDir is Lim -1, % Eixo comeca no 0
    Xin < LimDir,
    X is Xin + 1,
    not(parede(X,Y)),
    Xout is X.

% sobeElev(Entrada1,Entrada2,Saida1,Saida2)
% Sobe pelo elevador
% Entrada1: X inicial
% Entrada2: Y inicial 
% Saida1: X final 
% Saida2: Y final
sobeElev(X,Yin,X,Yout) :-
    elevador(X,Yin),
    cenario(_,Lim),
    LimSup is Lim - 1, % Eixo comeca no 0
    Yin < LimSup,
    Yout is Yin + 1.

% moveEsq(Entrada1,Entrada2,Saida1,Saida2)
% Move para esquerda
% Entrada1: X inicial
% Entrada2: Y inicial 
% Saida1: X final 
% Saida2: Y final
moveEsq(Xin,Y,Xout,Y) :-
    Xin > 0,
    X is Xin - 1,
    not(parede(X,Y)),
    Xout is X.

% desceElev(Entrada1,Entrada2,Saida1,Saida2)
% Desce pelo elevador
% Entrada1: X inicial
% Entrada2: Y inicial 
% Saida1: X final 
% Saida2: Y final
desceElev(X,Yin,X,Yout) :-
    elevador(X,Yin),
    Yin > 0,
    Yout is Yin - 1.

% ------------ Definicao das Regras de Transicao de Estado
% s(Entrada,Saida)
% Transicao de estado
% Entrada: Estado inicial
% Saida: Estado final (sucessor)
s([X,Y],[X1,Y]) :- 
    moveDir(X,Y,X1,Y).
s([X,Y],[X,Y1]) :- 
    sobeElev(X,Y,X,Y1).
s([X,Y],[X1,Y]) :- 
    moveEsq(X,Y,X1,Y).
s([X,Y],[X,Y1]) :- 
    desceElev(X,Y,X,Y1).

% ------------ Definicao das Regras para Buscas
% meta(Entrada1,Entrada2)
% Checa se o estado atual eh o estado meta
% Entrada1: Estado atual
% Entrada2: Estado meta
meta(Estado,Meta) :- Meta == Estado.

% busca(Entrada1,Entrada2,Entrada3,Saida)
% Busca em Profundidade
% Entrada1: Caminho inicial 
% Entrada2: Estado atual
% Entrada3: Estado meta 
% Saida: Caminho da solucao 
% Fonte: Material de Apoio, professor Dr. Murilo Coelho Naldi
busca(Caminho,Estado,Final,[Estado|Caminho]) :- meta(Estado,Final).
busca(Caminho,Estado,Final,Solucao) :-
    s(Estado,Sucessor),
    not(pertence(Sucessor,[Estado|Caminho])),
    busca([Estado|Caminho],Sucessor,Final,Solucao).

% solucao(Entrada,Saida)
% Recebe estado inicial e retorna o caminho de solucao
% Entrada: Posicao inicial do AADP
% Saida: Caminho percorrido 
solucao(Inicial,Solucao) :- sujeiras(Sujeiras),limpa(Inicial,0,Sujeiras,[],Solucao).

% limpa(Entrada1,Entrada2,Entrada3,Entrada4,Saida)
% Define regras para limpeza
% Entrada1: Estado atual
% Entrada2: Capacidade do AADP
% Entrada3: Lista de sujeiras a serem encontradas
% Entrada4: Caminho atual
% Saida: Caminho final

% Quando nao tiver mais sujeira,vai para Dock Station
limpa(Estado,_,[],Caminho,SolucaoFinal) :-
    dockStation(X,Y),
    busca([],Estado,[X,Y],Solucao),
    concatena(Solucao,Caminho,SolucaoSaida),
    reverse(SolucaoSaida,SolucaoFinal).
% Busca sujeira se capacidade menor que capacidade maxima 
limpa(Estado,Capacidade,Sujeiras,Caminho,CaminhoResposta) :-
    capacidadeMax(CapacidadeMax),
    Capacidade < CapacidadeMax,
    pop(Sujeiras,Alvo,NovaSujeiras),
    busca([],Estado,Alvo,Solucao),
    NovaCapacidade is Capacidade + 1,
    concatena(Solucao,Caminho,NovoCaminho),
    limpa(Alvo,NovaCapacidade,NovaSujeiras,NovoCaminho,CaminhoResposta).
% Esvazia na lixeira se capacidade igual a capacidade maxima
limpa(Estado,Capacidade,Sujeiras,Caminho,CaminhoResposta) :-
    capacidadeMax(CapacidadeMax),
    Capacidade >= CapacidadeMax,
    lixeira(X,Y),
    busca([],Estado,[X,Y],Solucao),
    concatena(Solucao,Caminho,NovoCaminho),
    limpa([X,Y],0,Sujeiras,NovoCaminho,CaminhoResposta).