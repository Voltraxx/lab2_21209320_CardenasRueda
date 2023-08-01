%TDA carpeta
:- module(tdaCarpeta_21209320_CardenasRueda, [existeCarpeta/2, existeCarpetaNom/3, crearCarpeta/4, eliminarCarpeta/3, eliminarSubArchivos/3, eliminarSubCarpetas/3, copiarCarpeta/5, copiarSubCarpetas/3, copiarSubArchivos/3, anadirCarpeta/3]).

%Predicado de "member"
%Pertenencia
%Dominio: Carpeta (list) X listaCarpetas (list)
%Meta: 1°:Verificar si la carpeta ya existe

existeCarpeta([_,_,_], []):- fail.
existeCarpeta([NombreCarpeta,_,Ruta], [[NombreCarpeta,_,Ruta]|_]).
existeCarpeta([NombreCarpeta,U,Ruta], [_|Cola]):-
	existeCarpeta([NombreCarpeta,U,Ruta], Cola).

%Predicado de "member"
%Pertenencia
%Dominio: Carpeta (Str) X Ruta (Str) X listaCarpetas (list)
%Meta: 1°:Verificar si la carpeta ya existe
%A diferencia de existeCarpeta/2, este predicado toma como entradas el nombre de la carpeta y la ruta, no la carpeta como tal

existeCarpetaNom(_, _,[]):- fail.
existeCarpetaNom(Nombre, Ruta, [[Nombre,_,Ruta]|_]).
existeCarpetaNom(Nombre, Ruta, [_|Cola]):- % Recursión
	existeCarpetaNom(Nombre, Ruta, Cola).

%Constructor
%Dominio: Nombre (str) X usuario (str) X ruta (str) X nueva carpeta (list).
%Meta:  1°:Listar una carpeta dados su nombre, usuario creador y ruta actual.

crearCarpeta(Nombre, NombreUsuario, Ruta, [Nombre, NombreUsuario, Ruta]).


%Modificador
%Dominio: Nombre (str) X listaCarpetas (list) X listaCarpetas (list)
%Meta: 1°:Eliminar una carpeta de la lista de carpetas

eliminarCarpeta(_, [], []).
eliminarCarpeta(Nombre, [[Nombre, _, _]|Cola], NuevasCarpetas):-
	eliminarCarpeta(Nombre, Cola, NuevasCarpetas).
eliminarCarpeta(Nombre, [[OtroNombre, Usuario, Ruta]|Cola], [[OtroNombre, Usuario, Ruta]|NuevasCarpetas]):-
	Nombre \= OtroNombre, %Verifica que el nombre no sea el mismo
	eliminarCarpeta(Nombre, Cola, NuevasCarpetas).


%Modificador
%Dominio: Ruta (str) X listaArchivos (list) X listaArchivos (list)
%Meta:  1°:Eliminar uno o muchos archivos de su lista que esten dentro de una carpeta padre
%		2°:Comparar los archivos, revisando cual de ellos es parte de la carpeta padre mediante su ruta

eliminarSubArchivos(_, [], []).
eliminarSubArchivos(Ruta, [[_, _, _, RutaArchivo]|Cola], NuevaLista) :-
    sub_atom(RutaArchivo, _, _, _, Ruta),
    eliminarSubArchivos(Ruta, Cola, NuevaLista).
eliminarSubArchivos(Ruta, [[Nombre, Contenido, Usuario, RutaArchivo]|Cola], [[Nombre, Contenido, Usuario, RutaArchivo]|NuevaLista]) :-
    \+ sub_atom(RutaArchivo, _, _, _, Ruta),
    eliminarSubArchivos(Ruta, Cola, NuevaLista).


%Modificador
%Dominio: Ruta (str) X listaCarpetas (list) X listaCarpetas (list)
%Meta:  1°:Eliminar una o muchas carpetas de su lista que esten dentro de una carpeta padre
%		2°:Comparar las carpetas, revisando cual de ellos es parte de la carpeta padre mediante su ruta

eliminarSubCarpetas(_, [], []).
eliminarSubCarpetas(Ruta, [[_, _, RutaArchivo]|Cola], NuevaLista) :-
    sub_atom(RutaArchivo, _, _, _, Ruta),
    eliminarSubCarpetas(Ruta, Cola, NuevaLista).
eliminarSubCarpetas(Ruta, [[Nombre, Usuario, RutaArchivo]|Cola], [[Nombre, Usuario, RutaArchivo]|NuevaLista]) :-
    \+ sub_atom(RutaArchivo, _, _, _, Ruta),
    eliminarSubCarpetas(Ruta, Cola, NuevaLista).


%Constructor
%Dominio: Nombre (str) X Ruta (str) X Destino (str) X listaCarpetas (list) X Carpeta (list)
%Meta:  1°: Copiar una carpeta dado su nombre
%		2°: Actualizar la ruta de la carpeta copiada

copiarCarpeta(_, _, _, [], []).
copiarCarpeta(Nombre, Ruta, Destino, [[Nombre, Usuario, Ruta]|_], [Nombre, Usuario, Destino]).
copiarCarpeta(Nombre, Ruta, Destino, [_|Cola], CarpetaSalida):-
	copiarCarpeta(Nombre, Ruta, Destino, Cola, CarpetaSalida).


%Constructor
%Dominio: Ruta (str) X listaCarpetasInicial (list) X listaSubCarpetas (list)
%Meta:  1°: Copiar una/s carpeta/s dada una ruta
%		2°: Verificar si la carpeta forma parte de la carpeta padre

copiarSubCarpetas(_, [], []).
copiarSubCarpetas(Ruta, [[Nombre, Usuario, RutaPadre]|Cola], SubCarpetas):-
	atom_concat(Ruta, _, RutaPadre),
	copiarSubCarpetas(Ruta, Cola, SubCarpetasTemp),
	SubCarpetas = [[Nombre, Usuario, RutaPadre]|SubCarpetasTemp].
copiarSubCarpetas(Ruta, [_|Cola], SubCarpetas):-
	copiarSubCarpetas(Ruta, Cola, SubCarpetas).


%Constructor
%Dominio: Ruta (str) X listaCarpetasInicial (list) X listaSubArchivos (list)
%Meta:  1°: Copiar uno/s archivo/s dada una ruta
%		2°: Verificar si la carpeta forma parte de la carpeta padre

copiarSubArchivos(_, [], []).
copiarSubArchivos(Ruta, [[Nombre, _, _, RutaPadre]|Cola], SubArchivos):-
	atom_concat(Ruta, _, RutaPadre),
	copiarSubArchivos(Ruta, Cola, SubArchivosTemp),
	SubArchivos = [[Nombre, _, _, RutaPadre]|SubArchivosTemp].
copiarSubArchivos(Ruta, [_|Cola], SubArchivos):-
	copiarSubArchivos(Ruta, Cola, SubArchivos).


%Modificador
%Dominio: Carpeta (list) X listaCarpetas (list) X nuevaListaCarpetas (list)
%Meta: 1°: Añadir la carpeta en la cabezera de la lista de carpetas dada

anadirCarpeta(Carpeta, ListaCarpetas, [Carpeta|ListaCarpetas]).