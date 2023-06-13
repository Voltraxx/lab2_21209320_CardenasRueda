%TDA archivo
:- module(tdaArchivo_21209320_CardenasRueda, [crearArchivo/4]).

%Predicado de "member"
%Pertenencia
%Dominio: Archivo (list) X listaArchivos (list)
%Meta:  1°:Verificar si el archivo ya existe

%%existeArchivo(_, []):- fail. %Este caso es cuando NO existe el archivo en sistema
%%existeArchivo([N,_,_,R], [[N,_,_,R]|_]):- !. %En este caso, el archivo ya existe (entrega "false")
%%existeArchivo([N,_,_,R], [_|Resto]):- existeArchivo([N,_,_,R], Resto). %Recursivamente busca si la carpeta está en sistema.



%Constructor
%Dominio: Archivo (list) X usuario (str) X ruta (str) X nuevoArchivo (list)
%Meta:  1°:Agregarle a un archivo dado de entrada el usuario creador y su ruta

crearArchivo([Nombre, Contenido], Usuario, Ruta, [Nombre, Contenido, Usuario, Ruta]). %Le agrega al archivo un usuario y la ruta actual



%Modificador
%Dominio: Archivo (list) X listaArchivos (list) X nuevaListaArchivos (list)
%Meta:  1°:Añadir un archivo a la lista de archivos existentes

%%anadirArchivo(ArchivoAnadir, Archivos, [ArchivoAnadir|Archivos]).


%Modificador
%Dominio: Archivo (list) X listaArchivos (list) X nuevaListaArchivos (list)
%Meta:  1°:Reemplazar un archivo por uno ya existente del mismo nombre y ruta
%	2°:Comparar Ruta y Nombre de archivos dentro de la lista Archivos con el archivo a reemplazar


%%reemplazarArchivo([N,C,U,R], [[N,_,_,R]|Resto], [[N, C, U, R]|Resto]):- !.
%%reemplazarArchivo([N, C, U, R], [Archivo|Resto], [Archivo|NuevaLista]):- reemplazarArchivo([N, C, U, R], Resto, NuevaLista).