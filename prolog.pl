progenitor(pedro,[ana,ramon,javier]).
progenitor(juan, [ramon, pepe, juan]).

padreDe(Padre,Hijo) :- progenitor(Padre,Hijos), member(Hijo,Hijos).



%forma numero 2  la menos efectiva porque lleva mas codigo
padre(Padre,Hijo) :- progenitor(Padre,Hijos), buscar(Hijo,Hijos).

buscar(Hijo, []) :- !, fail.
buscar(Hijo, [Hijo|L]) :- !, true.
buscar(Hijo, [C|L]) :- buscar(Hijo,L).

ladosiguales(P) :- P =.. [_|Lista], iguales(Lista).

iguales([]) :- !, true.
iguales([_]) :- !, true.
iguales([X,X|Lista]) :- iguales([X|Lista]).


li(P) :- functor(P, Nombre, Cantidad), bi(P,Cantidad).
bi(P,0) :- !,true.
bi(P,1) :- !,true.
bi(P,N) :- arg(N,P,Num1), Ant is N-1, arg(Ant,P,Num2), Num1 == Num2, bi(P,Ant).



existe(persona(nombre,apellido,edad,sexo)).

dameNombre(persona(Nombre, apellido,edad, sexo), Nombre).
codigo(P) :- dameNombre(P, Nombre).