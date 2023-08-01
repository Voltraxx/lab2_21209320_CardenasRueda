%TDA drives
:- module(tdaDrive_21209320_CardenasRueda, [existeDrive/2]).

%Predicado de "member"
%Pertenencia
%Dominio: Letra (str) X drives (list)
%Meta: 1°:Verificar si el drive existe

existeDrive(_, []):- fail.
existeDrive(Letra, [[Letra,_,_]|_]).
existeDrive(Letra, [[LetraX,_,_]|_]):-  % Caso case sensitive
	downcase_atom(Letra, LetraMinuscula),
	downcase_atom(LetraX, LetraMinuscula). 
existeDrive(Letra, [_|Cola]):-  % Recursión para encontrar la letra en la lista
	existeDrive(Letra, Cola).