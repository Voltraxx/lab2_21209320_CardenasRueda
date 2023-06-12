%TDA archivo
:- module(tdaArchivo_21209320_CardenasRueda, [crearArchivo/4]).

%existeArchivo(_, []):- fail.
%existeArchivo([N,_,_,R], [[N,_,_,R]|_]):- !.
%existeArchivo([N,_,_,R], [_|Resto]):- existeArchivo([N,_,_,R], Resto).

crearArchivo([Nombre, Contenido], Usuario, Ruta, [Nombre, Contenido, Usuario, Ruta]). %Le agrega al archivo un usuario y la ruta actual

%anadirArchivo(ArchivoAnadir, Archivos, [ArchivoAnadir|Archivos]).

%reemplazarArchivo([N,C,U,R], [[N,_,_,R]|Resto], [[N, C, U, R]|Resto]):- !.
%reemplazarArchivo([N, C, U, R], [Archivo|Resto], [Archivo|NuevaLista]):- reemplazarArchivo([N, C, U, R], Resto, NuevaLista).