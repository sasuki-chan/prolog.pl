%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File learner.pl                                                    %
% Un pequeño programa que modifica su propia base de conocimientos.  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start :- consult('bdc.pl'),
         nl,
         write('Escribe los nombres completamente en minúsculas,'), nl,
         write('seguidos de un punto.'), nl,
         nl,
         process_a_query.

process_a_query :- write('País? '),
                   read(Pais),
                   answer(Pais).

% Si el usuario ingresa "stop.", entonces grabar la nueva
% base de conocimientos y salir.
answer(stop) :- write('Grabando la base de conocimientos...'), nl,
                tell('bdc.pl'),
                listing(capital_of),
                told,
                write('Listo.'), nl.

% Si el usuario ingresa "delete.", entonces borrar el pais de la
% base de conocimientos y salir.
answer(delete) :- write('Pais que desea borrar: '),
                  read(Pais),
                  borrar(Pais),
                  tell('bdc.pl'),
                  listing(capital_of),
                  told,
                  write('Listo.'), nl.

borrar(Pais) :- retract(capital_of(Pais,_)), !.
borrar(Pais) :- write("No existe ese pais"), nl.

% Si el país ya está en la base de conocimientos, entonces retornar
% el nombre de su capital.
answer(Pais) :- capital_of(Pais, Ciudad),
                write('La capital de '),
                write(Pais),
                write(' es '),
                write(Ciudad), nl,
                nl,
                process_a_query.

% Si el país no está en la base de conocimientos, entonces pedir
% el nombre de la capital e ingresar este fact a la base.
answer(Pais) :- \+ capital_of(Pais, Ciudad),
                write('No conozco la capital de ese país.'), nl,
                write('Por favor, dime cual es.'), nl,
                write('Capital? '),
                read(Ciudad),
                write('Gracias.'), nl, nl,
                assert(capital_of(Pais, Ciudad)),
                process_a_query.
