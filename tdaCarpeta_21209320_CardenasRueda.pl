%TDA carpeta

:- module(tdaCarpeta_21209320_CardenasRueda, [existeCarpeta/2, nuevaCarpeta/4]).

%Predicado de "member"
%Pertenencia
%Dominio: Nombre carpeta (str) X carpetas (list)
%Meta: 1°:Verificar si la carpeta ya existe

existeCarpeta(_, []):- fail. %Este caso es cuando NO existe la carpeta en sistema
existeCarpeta([Nombre,_,Ruta], [[Nombre,_,Ruta]|_]). %En este caso, la carpeta ya existe (entrega "false")
existeCarpeta([Nombre,_,Ruta], [_|Resto]):- existeCarpeta([Nombre,_,Ruta], Resto). %Recursivamente busca si la carpeta está en sistema.

%Constructor
%Dominio: Nombre (str) X usuario (str) X ruta (str) X nueva carpeta (list).
%Meta:  1°:Listar una carpeta dados su nombre, usuario creador y ruta actual.

nuevaCarpeta(Nombre, Usuario_creador, Ruta, [Nombre, Usuario_creador, Ruta]).