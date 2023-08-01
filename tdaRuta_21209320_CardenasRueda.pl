%TDA ruta
:- module(tdaRuta_21209320_CardenasRueda, [nuevaDireccion/7, quitar_ultimo_elemento/2, actualizarRuta/4, cambiarRuta/3]).

%Modificador
%Dominio: Ruta (str) X comando (Str) X Login (Str) X Ruta (Str) X listaCarpetas (list) X Raiz (Str) X NuevaRuta (Str)
%Meta:	1°: Actualizar la ruta del sistema de acuerdo a un comando

nuevaDireccion(_, "/", _, _, _, Raiz, Raiz).
nuevaDireccion(Ruta, "..", _, _, _, _, NuevaRuta):-
	split_string(Ruta, "/", "", Aux),
	quitar_ultimo_elemento(Aux, Aux1),
	atomic_list_concat(Aux1, "/", Aux2),
	string_concat(Aux2, "/", NuevaRuta).
nuevaDireccion(Ruta, CarpetaIngresar, L, R, C, _, NuevaRuta):-
	crearCarpeta(CarpetaIngresar, L, R, Carpeta),
	existeCarpeta(Carpeta, C),
	string_concat(Ruta, CarpetaIngresar, Aux),
	string_concat(Aux, "/", NuevaRuta).


%Modificador
%Dominio: Lista (list) X nuevaLista (list)
%Meta:	1°: Elimina los ultimos dos elementos de una lista

quitar_ultimo_elemento([_,_], []). %Prosigue hasta que queden solo 2 elementos, siendo estos un elemento vacío "" y el ultimo directorio
quitar_ultimo_elemento([Elemento | Cola], [Elemento | Resto]) :-
    quitar_ultimo_elemento(Cola, Resto).


%Modificador
%Dominio: lista (list) X rutaPadre (str) X nuevaRutaPadre (str) X nuevaLista (list)
%Meta:	1°: Actualizar ruta de subelementos de una carpeta respecto a una dirección de la carpeta padre

actualizarRuta([], _, _, []).
actualizarRuta([[Nombre, Usuario, Ruta] | Cola], RutaPadreOld, RutaPadreNew, [[Nombre, Usuario, NuevaRuta] | NuevaCola]) :-
    atom_concat(RutaPadreOld, RestPath, Ruta),
    atom_concat(RutaPadreNew, RestPath, NuevaRuta),
    actualizarRuta(Cola, RutaPadreOld, RutaPadreNew, NuevaCola).
actualizarRuta([[Nombre, Usuario, Ruta] | Cola], RutaPadreOld, RutaPadreNew, [[Nombre, Usuario, Ruta] | NuevaCola]) :-
    \+ atom_concat(RutaPadreOld, _, Ruta),
    actualizarRuta(Cola, RutaPadreOld, RutaPadreNew, NuevaCola).


%Modificador
%Dominio: Archivo (list) X destino (Str) X nuevoArchivo (list)
%Meta:	1°: Actualizar la ruta de una carpeta por una dirección destino dada

cambiarRuta([N,C,U,_], Destino, [N,C,U,Destino]).