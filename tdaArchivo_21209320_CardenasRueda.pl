%TDA archivos
:- module(tdaArchivo_21209320_CardenasRueda, [existeArchivo/2, existeArchivoNom/3, anadirArchivo/3, reemplazarArchivo/3, eliminarArchivo/3, copiarArchivo/4, obtenerArchivo/4, reemplazarArchivoNom/4]).

%Predicado de "member"
%Pertenencia
%Dominio: Archivo (list) X listaArchivos (list)
%Meta:  1°:Verificar si el archivo ya existe

existeArchivo([_, _, _, _], []):- fail.
existeArchivo([Nombre, _, _, Ruta], [[Nombre, _, _, Ruta]|_]).
existeArchivo([Nombre, Contenido, _, Ruta], [_|Cola]):-
	existeArchivo([Nombre, Contenido, _, Ruta], Cola).

%Predicado de "member"
%Pertenencia
%Dominio: Nombre (str) X Ruta(str) X listaArchivos(list)
%Meta: 1°:Verificar si el archivo existe
%A diferencia de existeArchivo/2, este predicado de pertenencia utiliza el nombre del archivo y no un archivo como tal 

existeArchivoNom(_, _,[]):- fail.
existeArchivoNom(Nombre, Ruta, [[Nombre,_,_,Ruta]|_]).
existeArchivoNom(Nombre, Ruta, [_|Cola]):-
	existeArchivoNom(Nombre, Ruta, Cola).

%Constructor
%Dominio: Archivo (list) X listaArchivos (list) X listaModificada (list)
%Meta:  1°:Agregar un archivo a la lista de archivos

anadirArchivo(Archivo, ListaArchivos, [Archivo|ListaArchivos]).


%Modificador
%Dominio: Archivo (list) X listaArchivos (list) X nuevaListaArchivos (list)
%Meta:  1°:En caso de una existencia anterior de un archivo de mismo nombre, busca reemplazar dicho archivo por uno nuevo, cambiando su contenido

reemplazarArchivo([_, _, _, _], [], []).
reemplazarArchivo([Nombre, Contenido, Usuario, Ruta], [[Nombre, _, _, Ruta]|Cola], [[Nombre, Contenido, Usuario, Ruta]|Cola]). % Añade el contenido sin importar que contenido tuviese el anterior archivo
reemplazarArchivo([Nombre, Contenido, Usuario, Ruta], [PrimElemento|Cola], [PrimElemento|NuevaCola]):-
	reemplazarArchivo([Nombre, Contenido, Usuario, Ruta], Cola, NuevaCola).




%Modificador
%Dominio: Nombre (str) X listaArchivos (list) X nuevaListaArchivos (list)
%Meta:  1°: Generar una lista con los archivos deseados eliminados, dado su nombre.

eliminarArchivo(_, [], []).
eliminarArchivo(Nombre, [[Nombre, _, _, _]|Cola], NuevosArchivos):-
	eliminarArchivo(Nombre, Cola, NuevosArchivos).
eliminarArchivo(Nombre, [[OtroNombre, Contenido, Usuario, Ruta]|Cola], [[OtroNombre, Contenido, Usuario, Ruta]|NuevosArchivos]):-
	Nombre \= OtroNombre, % Asegura que los nombres de los archivos no sean iguales
	eliminarArchivo(Nombre, Cola, NuevosArchivos).


%Constructor
%Dominio: Nombre (str) X Destino (str) X listaArchivos (list) X Archivo (list)
%Meta:  1°: Generar una copia de un archivo con una nueva ruta
%		2°: Buscar un archivo "x" dado su nombre y extraer (copiar) sus datos
%			Actualizar la ruta del archivo copiado

copiarArchivo(_, _, [], []).
copiarArchivo(Nombre, Destino, [[Nombre, Contenido, Usuario, _]|_], [Nombre, Contenido, Usuario, Destino]). %Actualiza la ruta de la copia
copiarArchivo(Nombre, Destino, [_|Cola], ArchivoSalida):-
	copiarArchivo(Nombre, Destino, Cola, ArchivoSalida).


%Selector
%Dominio: Nombre (str) X Ruta (str) X listaArchivos (list) X Archivo (list)
%Meta:  1°: Obtener los datos de un archivo
%		2°: Comprobar la existencia del archivo

obtenerArchivo(_, _, [], []):- fail. %Esto comprueba que el archivo no existe
obtenerArchivo(Nombre, Ruta, [[Nombre, Contenido, Usuario, Ruta]|_], [Nombre, Contenido, Usuario, Ruta]).
obtenerArchivo(Nombre, Ruta, [_|Cola], _):-
	obtenerArchivo(Nombre, Ruta, Cola, _).


%Modificador
%Dominio: Nombre (str) X Nombre (str) X listaArchivos (str) X listaArchivos (list)
%Meta: 1°: Modificar el nombre de un archivo "x"

reemplazarArchivoNom(_, _, [], []).
reemplazarArchivoNom(OldName, NewName, [[OldName, Contenido, Usuario, Ruta]|Cola], [[NewName, Contenido, Usuario, Ruta]|Cola]).
reemplazarArchivoNom(OldName, NewName, [PrimElemento|Cola], [PrimElemento|NuevaCola]):-
	reemplazarArchivoNom(OldName, NewName, Cola, NuevaCola).