%TDA drives
:- module(tdaDrive_21209320_CardenasRueda, [existeDrive/2]).

%Predicado de "member"
%Pertenencia
%Dominio: Letra (str) X drives (list)
%Meta: 1°:Verificar si el drive existe

existeDrive(_, []):- fail. %Este caso es cuando NO existe el drive en sistema
existeDrive(Letra, [[Letra|_]|_]). %En este caso, el drive ya existe (entrega "false")
existeDrive(Letra, [_|Resto]):- existeDrive(Letra, Resto). %Recursivamente busca si el drive está en sistema.
