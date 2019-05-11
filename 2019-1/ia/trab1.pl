:- include('lists_lib.pl').

% ----------------- COD BUSCA -----------------
solve(Node, Solution)  :- 
	depthfirst([], estado(Node,_), Solution).

depthfirst(Path, estado(Node,_), [Node|Path] )  :- 
	dock_station(Node).

depthfirst(Path, estado(Node,Es), Sol)  :-
  c(Node, Node1),
  estado(Node1,Es1),
  write(estado(Node,X)),write("-"),write(Node1),write("------"),
  

  not(belongs_to(Node1,[Node|Path])),
  not(parede(Node1)),

  depthfirst([Node|Path], estado(Node1,limpo), Sol), !.






% Pode voltar 
depthfirst(Path, estado(Node,_), Sol)  :-
  c(Node1, Node),
  write(Node),write("-"),write(Node1),write("------"),
  not(belongs_to(Node1,[Node|Path])),
  not(parede(Node1)),
  depthfirst([Node|Path], estado(Node1,limpo), Sol), !.

% ----------------- AMBIENTE -----------------
% Dock Station
dock_station(no(0,1)).

% Parede
parede(no(1,2)).

% Elevador
elevador(no(2,2)).
elevador(no(2,1)).
elevador(no(2,0)).

% Nos
no(0,0).
no(0,1).
no(0,2).
no(1,0).
no(1,1).
no(1,2).
no(2,0).
no(2,1).
no(2,2).

% ----------------- CAMINHOS -----------------
c(no(X1,Y),no(X2,Y)) :- no(X1,Y), no(X2,Y), XD is X1 +1, X2 == XD.
c(no(X1,Y),no(X2,Y)) :- no(X1,Y), no(X2,Y), XE is X2 -1, X1 == XE.
% Elevador
c(no(X,Y1),no(X,Y2)) :- no(X,Y1),no(X,Y2),Y2 is Y1+1, elevador(no(X,Y1)),!.
c(no(X,Y1),no(X,Y2)) :- no(X,Y1),no(X,Y2),Y2 is Y1-1, elevador(no(X,Y2)),!.

% ----------------- ESTADOS -----------------
estado(no(0,0),limpo).
estado(no(0,1),limpo).
estado(no(0,2),limpo).
estado(no(1,0),limpo).
estado(no(1,1),limpo).
estado(no(1,2),limpo).
estado(no(2,0),limpo).
estado(no(2,1),limpo).
estado(no(2,2),limpo).

limpa(estado(Node,sujo),estado(Node,limpo)).
limpa(estado(Node,limpo),estado(Node,limpo)).


%s(X,Y)

%s((estado(X,Y), sujo), (estado(X,Y), limpo))



depthfirst(Path, estado(Node,_), [Node|Path] )  :- 
	dock_station(Node).

depthfirst(Path, estado(Node,Es), Sol)  :-
  c(Node, Node1),
  estado(Node1,Es1),


  limpa(estado(Node,Es),NovoEs),

  %write(estado(Node,X)),write("-"),write(Node1),write("------"),
  

  not(belongs_to(Node1,[Node|Path])),
  not(parede(Node1)),

  depthfirst([Node|Path], estado(Node1,limpo), Sol), !.


bp(Caminho, Estado, Solucao) :- s(Estado, Sucessor), not(pertence(Sucessor,[Estado|Caminho])),
	bp([Estado|Caminho], Sucessor, Solucao).



s(Estado, Sucessor) :-  
