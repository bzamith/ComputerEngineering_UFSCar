%Problema Utilizado: Estudantes no ENEM (https://rachacuca.com.br/logica/problemas/estudantes-no-enem/)

%Alunos: 
%	1. Bruna Zamith Santos, RA: 628093
%	2. Leila Aparecida da Silva, RA: 628166
%	3. Marcos Augusto Faglioni Junior, RA: 628301
%	4. Rodrigo Prata Salmen, RA: 598208
%	PLP Turma C

%Regras
exatamente_esquerda_de(X,Y) :- Y is X+1.
esquerda_de(X,Y) :- X<Y.
aolado_de(X,Y) :- exatamente_esquerda_de(Y,X); exatamente_esquerda_de(X,Y).
entre(X,Y,Z) :- X>Y, X<Z.
ponta(X) :- X is 1; X is 5.

imprime([]).
imprime([A|B]) :-
  format('Garoto = ~w\t=> ~w\t=> ~w\t=> ~w\t=> ~w\t=> ~w\t=> ~w~n',A),
  imprime(B).


%Inicializa Lista
inicializa(X) :- X = [[1,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(_)],
			[2,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(_)],
			[3,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(_)],
			[4,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(_)],
			[5,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(_)]].

%Solucao
solucao :-
	inicializa(Garotos),
	%Inicializa Nome Tiago (Não Utilizado Anteriormente)
	member([_,mochila(_),nome(tiago),universidade(_),curso(_),idade(_),bairro(_)],Garotos),
	%Inicializa Mochila Azul (Não Utilizado Anteriormente)			
	member([_,mochila(azul),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos),	
	%Inicializa Idade Vinte (Não Utilizado Anteriormente)		
	member([_,mochila(_),nome(_),universidade(_),curso(_),idade(vinte),bairro(_)],Garotos),			
	%S1. O rapaz mais velho mora na Liberdade.
	member([_,mochila(_),nome(_),universidade(_),curso(_),idade(vinteeum),bairro(liberdade)],Garotos), 
	%S2. Quem mora no Bom Retiro está sentado ao lado de quem mora na Bela Vista.	
	member([A,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(belaVista)],Garotos), 		
	member([B,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(bomRetiro)],Garotos), 		
	aolado_de(A,B),												
	%S3. O rapaz que mora na Bela Vista quer estudar na UNIFESP.
	member([_,mochila(_),nome(_),universidade(unifesp),curso(_),idade(_),bairro(belaVista)],Garotos), 	
	%S4. Na quinta posição está o rapaz que mora na Consolação.
	member([5,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(consolacao)],Garotos), 		
	%S5. O garoto de 17 anos quer cursar Direito.
	member([_,mochila(_),nome(_),universidade(_),curso(direito),idade(dezessete),bairro(_)],Garotos), 	
	%S6. O rapaz de 19 anos está sentado ao lado de quem vai prestar Economia.
	member([C,mochila(_),nome(_),universidade(_),curso(_),idade(dezenove),bairro(_)],Garotos), 		
	member([D,mochila(_),nome(_),universidade(_),curso(economia),idade(_),bairro(_)],Garotos), 		
	aolado_de(C,D),												
	%S7. Quem quer estudar UNICAMP está sentado exatamente à esquerda de quem tem 18 anos.
	member([E,mochila(_),nome(_),universidade(unicamp),curso(_),idade(_),bairro(_)],Garotos), 		
	member([F,mochila(_),nome(_),universidade(_),curso(_),idade(dezoito),bairro(_)],Garotos), 		
	exatamente_esquerda_de(E,F),										
	%S8. O rapaz que mora na Liberdade está sentado ao lado do que tem 17 anos.
	member([G,mochila(_),nome(_),universidade(_),curso(_),idade(dezessete),bairro(_)],Garotos), 		
	member([H,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(liberdade)],Garotos), 		
	aolado_de(G,H),												
	%S9. Quem vai prestar Medicina está em algum lugar entre o Bruno e o garoto da mochila Branca, nessa ordem.
	member([I,mochila(_),nome(_),universidade(_),curso(medicina),idade(_),bairro(_)],Garotos), 		
	member([J,mochila(_),nome(bruno),universidade(_),curso(_),idade(_),bairro(_)],Garotos), 		
	member([K,mochila(branca),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos),		
	entre(I,J,K),												
	%S10. O garoto que quer cursar Computação tem 18 anos.
	member([_,mochila(_),nome(_),universidade(_),curso(computacao),idade(dezoito),bairro(_)],Garotos),	
	%S11. O rapaz de 17 anos quer estudar na UFSCAR.
	member([_,mochila(_),nome(_),universidade(ufscar),curso(_),idade(dezessete),bairro(_)],Garotos),	
	%S12. O Bruno mora no Bom Retiro.
	member([_,mochila(_),nome(bruno),universidade(_),curso(_),idade(_),bairro(bomRetiro)],Garotos),		
	%S13. Quem mora em Higienópolis está exatamente à esquerda de quem quer estudar na UNESP.
	member([L,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(higienopolis)],Garotos),		
	member([M,mochila(_),nome(_),universidade(unesp),curso(_),idade(_),bairro(_)],Garotos),			
	exatamente_esquerda_de(L,M),										
	%S14. O garoto que quer estudar na UNICAMP está em uma das pontas.
	member([N,mochila(_),nome(_),universidade(unicamp),curso(_),idade(_),bairro(_)],Garotos),		
	ponta(N),												
	%S15. O rapaz da mochila Branca está em algum lugar à esquerda do Rafael.
	member([O,mochila(branca),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos),		
	member([P,mochila(_),nome(rafael),universidade(_),curso(_),idade(_),bairro(_)],Garotos),		
	esquerda_de(O,P),											
	%S16. O Luíz é o dono da mochila Branca.
	member([_,mochila(branca),nome(luiz),universidade(_),curso(_),idade(_),bairro(_)],Garotos),		
	%S17. O garoto da mochila vermelha está em algum lugar entre quem mora em Higienópolis e quem quer estudar na USP, nessa ordem.
	member([Q,mochila(vermelha),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos), 		
	member([R,mochila(_),nome(_),universidade(_),curso(_),idade(_),bairro(higienopolis)],Garotos), 		
	member([S,mochila(_),nome(_),universidade(usp),curso(_),idade(_),bairro(_)],Garotos),			
	entre(Q,R,S),												
	%S18. O André está em alguma das pontas.
	member([T,mochila(_),nome(andre),universidade(_),curso(_),idade(_),bairro(_)],Garotos), 		
	ponta(T),												
	%S19. O rapaz da mochila Verde está em algum lugar entre quem quer estudar na UNICAMP e quem quer estudar Economia, nessa ordem.
	member([U,mochila(verde),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos), 		
	member([V,mochila(_),nome(_),universidade(unicamp),curso(_),idade(_),bairro(_)],Garotos), 		
	member([X,mochila(_),nome(_),universidade(_),curso(economia),idade(_),bairro(_)],Garotos),		
	entre(U,V,X),												
	%S20. Na segunda posição está o garoto da mochila Vermelha.
	member([2,mochila(vermelha),nome(_),universidade(_),curso(_),idade(_),bairro(_)],Garotos), 		
	%S21. O dono da mochila Amarela quer estudar Odontologia.	
	member([_,mochila(amarela),nome(_),universidade(_),curso(odontologia),idade(_),bairro(_)],Garotos), 	
	imprime(Garotos).