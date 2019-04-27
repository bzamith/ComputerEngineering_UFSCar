%swipl -s listsLib.pl

%Kind of a library implementing different lists operations in prolog
%By Bruna Zamith Santos, based on the material provided by professor Murilo Naldi - UFSCar

%SELF-NOTES:
% Lembrar de singletons variaveis e substituir por variavel anonima, sempre checar
% Lembrar quando a sentença com is vem antes ou depois no and (exemplo: check_consec e count_elements)
% Saber quando colocar corte
% Ver variações do sep_posit_negat sem incluir zero e a variação sem corte

%GETS NTH ELEMENT OF A LIST
% Return the nth element of a list
% Base case: Poistion is 0
% Recursive case: Decrements position and calls recursivly
% find(List,Position,Result)
find([Head|_],0,Head).
find([_|Tail],N,R) :- N1 is N-1, find(Tail,N1,R).

%CHECK TWO CONSECUTIVE NUMBERS
% Checks if any two consecutive numbers on a list are, in fact, consecutive
% Base case: Lists first two elements are consecutive
% Recursive case: Ignores the first element, keeps the second one and calls recursivly
% check_consec(List)
check_consec([Elem1,Elem2|_]) :- X is Elem2 - 1, Elem1 == X.
check_consec([Elem1,Elem2|Tail]) :- X is Elem2 - 1, Elem1 \== X, check_consec([Elem2|Tail]).

%BELONGS TO 
% Checks whether a given element belongs to a list or not
% Base case: It is on the head
% Recursive case: Check the tail
% belongs_to(Elem,List)
belongs_to(Elem,[Elem|_]).
belongs_to(Elem,[_|Tail]) :- belongs_to(Elem,Tail).

%BELONGS TO AN EVEN POSITION
% Checks whether a given element belongs to a list in an even position
% Base case: It is on the second position
% Recursive case: Removes the head and the one ahead of it
% belongs_to_even_pos(Elem,List)
belongs_to_even_pos(Elem,[_,Elem|_]).
belongs_to_even_pos(Elem,[_,_|Tail]) :- belongs_to_even_pos(Elem,Tail).

%BELONGS TO AN ODD POSITION
% Checks whether a given element belongs to a list in an odd position
% Base case: It is on the first position
% Recursive case: Removes the head and the one ahead of it
% belongs_to_odd_pos(Elem,List)
belongs_to_odd_pos(Elem,[Elem,_|_]).
belongs_to_odd_pos(Elem,[_,_|Tail]) :- belongs_to_even_pos(Elem,Tail).

%DOESN'T BELONG TO
% Checks if a given element doesnt belong to a list
% Base case: Not for belongs_to
% doesnt_belong_to(Elem,List)
doesnt_belong_to(Elem,List) :- not(belongs_to(Elem,List)).

%DOESN'T BELONG TO (SECOND WAY)
% Checks if a given element doesnt belong to a list
% Base case: Empty list
% Recursive case: Call again but Elem different from head
% doesnt_belong_to_versiontwo(Elem,List)
doesnt_belong_to_versiontwo(_,[]).
doesnt_belong_to_versiontwo(Elem,[Head|Tail]) :- Elem \== Head, doesnt_belong_to_versiontwo(Elem,Tail).

%SUBLIST FROM START
% Checks whether a list is a sublist of another list, but only from start :P
% Base case: Just one element
% Recursive case: Go to the next one
% sublist_start(Sublist,List)
sublist_start([Elem|[]],[Elem|_]).
sublist_start([Elem|Tail],[Elem|Tail2]) :- sublist_start(Tail,Tail2).

%SUBLIST 
% Checks whether a list is a sublist of another list
% Base case: sublist_start
% Recursive case: Remove head from List and try again
% sublist(Sublist,List)
sublist(List1,List2) :- sublist_start(List1,List2).
sublist(List,[_|Tail]) :- sublist(List,Tail).

%FIRST ELEMENT OF A LIST
% Returns the first element of a list
% Base case: Just return the head of a list
% first_elem(List,Result)
first_elem([Elem|_],Elem).

%LAST ELEMENT OF A LIST
% Returns the last element of a list
% Base case: Tail is empty
% Recursive case: Remove the element and try again
% last_elem(List,Result)
last_elem([Elem|[]],Elem).
last_elem([_|Tail],R) :- last_elem(Tail,R).

%INSERTS ELEMENT ON FIRST POSITION OF A LIST
% Returns the updated list
% Base case: Just insert, dont know how to explain because it is pretty simple
% push(Elem,List,Result)
push(Elem,List,[Elem|List]).

%INSERTS ELEMENT ON THE FIRST POSITION ONLY IF IT DOESNT BELONG
% Return the updated list if doesnt belong, or the original list
% Base case: List is empty
% Recursive case: Checks if if doesnt belong and insert
% insert_first_if_doesnt_belong(Elem,List,R)
insert_first_if_doesnt_belong(Elem,List,R) :- doesnt_belong_to(Elem,List), push(Elem,List,R).
insert_first_if_doesnt_belong(_,List,List).

%INSERTS ELEMENT ON LAST POSITION OF A LIST
% Returns the updated list
% Base case: List is empty
% Recursive case: Keeps the head and call recursivly
% insert_last_pos(Elem,List,Result)
insert_last_pos(Elem,[],[Elem]).
insert_last_pos(Elem,[Head|Tail],[Head|R]) :- insert_last_pos(Elem,Tail,R).

%INSERTS ELEMENT ON GIVEN POSITION OF A LIST
% Returns the updated list 
% Base case: List
% Recursive case:
% insert_given_pos(Elem,Pos,List,Result) 
insert_given_pos(Elem,0,List,[Elem|List]).
insert_given_pos(Elem,N,[Head|Tail],[Head|R]) :- N1 is N-1, insert_given_pos(Elem,N1,Tail,R).

%REMOVES FIRST ELEMENT OF A LIST
% Returns the updated list
% Base case: Quite simple!
% pop(List,Result)
pop([_|Tail],Tail).

%REMOVES LAST ELEMENT OF A LIST
% Returns the updated list
% Base case: List has just one element
% Recursive case: Keep the head and call recursivly
% removes_last_elem(List,Result)
removes_last_elem([_|[]],[]).
removes_last_elem([Head|Tail],[Head|R]) :- removes_last_elem(Tail,R).

%REMOVES FIRST OCCURANCE OF AN ELEMENT ON A LIST
% Returns the update list
% Base case: Elem is on the head
% Recursive case: Keeps the head and call recursivly
% removes_first_occ(Elem,List,Result)
removes_first_occ(Elem,[Elem|Tail],Tail). 
removes_first_occ(Elem,[Head|Tail],[Head|R]) :- Elem \== Head, removes_first_occ(Elem,Tail,R).

%REMOVES ALL OCCURANCES OF AN ELEMENT ON A LIST
% Returns the update list
% Base case: List is empty
% Recursive case: Keeps the head and call recursivly, but it depends if head is elem or not
% removes_all_occ(Elem,List,Result)
removes_all_occ(_,[],[]) :- !.
removes_all_occ(Elem,[Elem|Tail],R) :- removes_all_occ(Elem,Tail,R), !.
removes_all_occ(Elem,[Head|Tail],[Head|R]) :- Elem \== Head, removes_all_occ(Elem,Tail,R).

%REMOVES ALL THE ELEMENTS EXCEPT FOR THE LAST ONE
% Returns the update list
% Base case: List has just one element
% Recursive case: Keeps the head and call recursivly
% removes_all_except_last(List,Result)
removes_all_except_last([Elem|[]],[Elem]).
removes_all_except_last([_|Tail],R) :- removes_all_except_last(Tail,R).

%CONCATENATE LISTS
% Returns a list that is the concatenation of two 
% Base case: First list is empty
% Recursive case: Get head, keeps it and call recursivly
% concatenate(List1,List2,Result)
concatenate([],L,L).
concatenate([Head|Tail],List2,[Head|R]) :- concatenate(Tail,List2,R).

%FLATTEN LIST
% Returns a flatten list
% Base case: The list is empty (already flat)
% Recursive: Flat the head, the tail and append recursivly. But have to check if head is a list or not.
% flatten(List,Result)
flatten([],[]).
flatten([Head|Tail],R) :- flatten(Head,FlatHead), flatten(Tail,FlatTail), concatenate(FlatHead,FlatTail,R).
flatten([Head|Tail],[Head|FlatTail]) :- Head \= [], Head \= [_|_], flatten(Tail,FlatTail).

%SUM ELEMENTS IN LIST
% Returns the sum of the elements
% Base case: Empty list has sum equal to 0
% Recursive case: Sum head and sums tail recursivly
% sum(List,Result)
sum([],0).
sum([Head|Tail],S) :- sum(Tail,S1), S is S1 + Head.

%COUNT NUMBER OF ELEMENTS IN LIST 
% Returns the number of elements in a list
% Base case: List is empty, count equal to 0
% Recursive case: Count one and calls recursion for tail
% count_elements(List,Result)
count_elements([],0).
count_elements([_|Tail],N) :- count(Tail,N1), N is N1+1.

%COUNT NUMBER OF OCCURANCIES OF ELEMENT IN LIST 
% Returns the number of occurancies of a given element in a list
% Base case: List is empty, count equal to 0
% Recursive case: Count one and calls recursion for tail
% count_occ(Elem,List,Result)
count_occ(_,[],0) :- !.
count_occ(Elem,[Elem|Tail],N) :- count_occ(Elem,Tail,N1), N is N1+1, !.
count_occ(Elem,[_|Tail],N) :- count_occ(Elem,Tail,N).

%RETURN IS LIST AS EVEN OR ODD SIZE 
% Returns if lists size is even or odd
% Base case: Is even
% Base case: Is odd
% even_or_odd_list(List,Result)
even_or_odd_list(L,"Even") :- count_elements(L,R), X is mod(R,2), X == 0.
even_or_odd_list(L,"Odd") :- count_elements(L,R), X is mod(R,2), X \== 0.

% POT 
% Return the pot of two numbers 
% Base case: Pot is 0
% Recursive case: See below
% pot(X,Y,Result)
pot(_,0,1).
pot(X,Y,R) :- Y > 0, Y1 is Y-1, pot(X,Y1,R1), R is X * R1.

% FACTORIAL
% Returns the factorial of a given number
% Base case: X is 0
% Recursive case: See below
% factorial(Number,Result)
factorial(X,R) :- X>=0, fat(X,R).
fat(0,1) :- !.
fat(X,R) :- X1 is X-1, fat(X1,R1), R is R1*X.

% INVERT LIST (REVERSE)
% Inverts the elements of a given list
% Base case: List is empty 
% Recursive case: Reverses tail and concatenates with head 
% invert_list(List,Result)
invert_list([],[]).
invert_list([Head|Tail],R) :- invert_list(Tail,RTail), concatenate(RTail,[Head],R).

% SEPARATES LIST IN POSITIVES (+ ZERO) AND NEGATIVES NUMBERS
% Given a list of numbers, create another two, one with positive numbers and other with negative
% Base case: List is empty
% Recursive case: See below 
% sep_posit_negat(List,Positive,Negative)
sep_posit_negat([],[],[]) :- !.
sep_posit_negat([Head|Tail],[Head|TailPosit],LN) :- Head >=0, sep_posit_negat(Tail,TailPosit,LN),!.
sep_posit_negat([Head|Tail],LP,[Head|TailNegat]) :- sep_posit_negat(Tail,LP,TailNegat).

% SEPARATES LIST IN EVEN AND ODD NUMBERS
% Given a list of numbers, create another two, one with even numbers and other with odd
% Base case: List is empty
% Recursive case: See below 
% sep_even_odd(List,Even,Odd)
sep_even_odd([],[],[]) :- !.
sep_even_odd([Head|Tail],[Head|TailEven],LO) :- X is mod(Head,2), X == 0, sep_even_odd(Tail,TailEven,LO),!.
sep_even_odd([Head|Tail],LE,[Head|TailOdd]) :- sep_even_odd(Tail,LE,TailOdd).