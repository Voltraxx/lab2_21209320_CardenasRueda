 %Laboratorio 2 paradigmas: programación lógica
%Nota: en metas, "1°" indica meta primaria, y "2°" indica meta/s secundaria/s

:- use_module(tdaUsuario_21209320_CardenasRueda).
:- use_module(tdaDrives_21209320_CardenasRueda).
:- use_module(tdaCarpeta_21209320_CardenasRueda).
:- use_module(tdaArchivo_21209320_CardenasRueda).
:- use_module(tdaRuta_21209320_CardenasRueda).

%Predicado de "system"
%Constructor de sistema
%Dominio: Nombre del sistema (str) X Sistema (list)
%Meta: 1°: Entregar una lista de 8 para referenciar: nombre, drives, usuarios, log, carpetas, archivos, papelera de carpetas, papelera de archivos.

system(Nombre, [[Nombre,_,_],[],[],[],[],[],[],[]]).

%Predicado de "add-drive"
%Constructor de drives
%Dominio: Sistema (list) X letra del drive (str) X nombre del drive (str) X capacidad del drive (int) X sistema resultante (list)
%Meta:  1°:Añadir un drive de acuerdo a los datos entregados como letra, nombre y capacidad al sistema
%	2°:Verificar si el drive ya se encuentra en el sistema.

systemAddDrive([S,D|Cola], Letra, Nombre, Almacenamiento, [S,[[Letra, Nombre, Almacenamiento]|D]|Cola]):-
	atom_string(Letra, NuevaLetra),
	\+ existeDrive(NuevaLetra, D).
											
%Predicado de "register"
%Constructor de usuarios
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Añadir usuario al sistema.
%	2°:Verificar si el usuario ya se encuentra registrado en el sistema.

systemRegister([N,D,U|Cola], NombreUsuario, [N,D,[NombreUsuario|U]|Cola]):-
	\+ existeUsuario(NombreUsuario, U).

%Predicado de "login"
%Modificador
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Loguear usuario
%	2°:Verificar existencia de usuario

systemLogin([N,D,U,L|Cola], NombreUsuario, [N,D,U,[NombreUsuario,_]|Cola]):-
	existeUsuario(NombreUsuario, U),
	(usuarioLogueado(NombreUsuario, L) ; logVacio(L)).

%Predicado de "logout"
%Modificador
%Dominio: Sistema (list) X sistema (list)
%Meta: 1°:Desloguear al usuario

systemLogout([N,D,U,L|Cola], [N,D,U,[]|Cola]):-
	\+ logVacio(L).

%Predicado de "switch-drive"
%Modificador
%Dominio: Sistema (list) X letra (str) X sistema (list)
%Meta:  1°:Fijar una unidad del sistema para realizar acciones
%	2°:Verificar que haya un usuario logueado
%	   Comrpobar que el drive a moverse exista

systemSwitchDrive([[N,Fecha,_],D,U,[L,_]|Cola], Letra, [[N,Fecha,Raiz],D,U,[L, Raiz]|Cola]):-
	atom_string(Letra, Aux),
	upcase_atom(Aux, NuevaLetra), %Esto solo hace que se muestre el disco como mayúscula en la ruta
	existeDrive(NuevaLetra, D),
	string_concat(NuevaLetra, ":/", Raiz).

%Predicado de "make-dir"
%Constructor
%Dominio: Sistema (list) X carpeta (str) X sistema (list)
%Meta: 1°:Añadir carpeta al sistema

systemMkdir([N,D,U,[L,R],C|Cola], NombreCarpeta, [N,D,U,[L,R],[Carpeta|C]|Cola]):-
	crearCarpeta(NombreCarpeta, L, R, Carpeta),
	\+ existeCarpeta(Carpeta, C).

%Predicado de "change-directory"
%Modificador
%Dominio: Sistema (list) X comando (str) X sistema (list)
%Meta:  1°:Cambiar la dirección actual del sistema
%	2°:Identificar el comando y realizar operaciones de acuerdo a ello

systemCd([[N,F,Raiz],D,U,[L,R],C|Cola], Comando, [[N,F,Raiz],D,U,[L,NuevaRuta],C|Cola]):-
	nuevaDireccion(R, Comando, L, R, C, Raiz, NuevaRuta).
	%Se ingresan a nuevaDireccion los datos de L, R, C y Raiz para poder cambiar la ruta, usandose L, R, C para cambiar a un directorio, y Raiz para el comando "/"


%Predicado de "add-file"
%Constructor
%Dominio: Sistema (list) X archivo (list) X sistema (list)
%Meta:	1°: Añadir un archivo al sistema
%		2°: Transformar el archivo entregado "file" en una lista con sus datos

file(Nombre, Contenido, [Nombre, Contenido]). %Crea un archivo file
archivoActualizado(Nombre, Contenido, Usuario, Ruta, [Nombre, Contenido, Usuario, Ruta]). %Añade usuario y ruta al archivo

systemAddFile([N,D,U,[L,R],C,A|Cola], [Nombre, Contenido], [N,D,U,[L,R],C,NuevosArchivos|Cola]):-
	archivoActualizado(Nombre, Contenido, L, R, NuevoArchivo),
	existeArchivo(NuevoArchivo, A),
	reemplazarArchivo(NuevoArchivo, A, NuevosArchivos).

systemAddFile([N,D,U,[L,R],C,A|Cola], [Nombre, Contenido], [N,D,U,[L,R],C,NuevosArchivos|Cola]):- %Caso para cuando no existe el archivo
	archivoActualizado(Nombre, Contenido, L, R, NuevoArchivo),
	\+ existeArchivo(NuevoArchivo, A),
	anadirArchivo(NuevoArchivo, A, NuevosArchivos).


%Precidado de "del"
%Modificador
%Dominio: Sistema (list) X nombreArchivo (Str) X Sistema (list)
%Meta:	1°: Eliminar un archivo/carpeta del sistema
%		2°: Buscar existencia de elemento a eliminar
%		3°: En caso de eliminar carpeta, eliminar subarchivos y subcarpetas mediante la ruta de la carpeta padre

systemDel([N,D,U,[L,R],C,A|Cola], NombreArchivo, [N,D,U,[L,R],C,NuevosArchivos|Cola]):-
	existeArchivoNom(NombreArchivo, R, A),
	eliminarArchivo(NombreArchivo, A, NuevosArchivos).

systemDel([N,D,U,[L,R],C,A|Cola], NombreCarpeta, [N,D,U,[L,R],NuevasCarpetas,NuevosArchivos|Cola]):-
	existeCarpetaNom(NombreCarpeta, R, C),
	eliminarCarpeta(NombreCarpeta, C, Aux),
	string_concat(R, NombreCarpeta, Aux1),
	string_concat(Aux1, "/", Aux2),
	eliminarSubArchivos(Aux2, A, NuevosArchivos),
	eliminarSubCarpetas(Aux2, Aux, NuevasCarpetas).


%Predicado de "copy"
%Modificador
%Dominio: Sistema (list) X nombre (str) X destino (str) X Sistema (list)
%Meta:	1°: Copiar un archivo/carpeta del sistema
%		2°: buscar existencia del elemento
%		  : seleccionar subelementos en caso de ser una carpeta
%		  : Actualizar ruta de los subelementos

systemCopy([N,D,U,[L,R],C,A|Cola], Nombre, Destino, [N,D,U,[L,R],C,NuevosArchivos|Cola]):-
	existeArchivoNom(Nombre, R, A),
	\+ existeArchivoNom(Nombre, Destino, A), %Esto es para verificar la unicidad por nivel
	copiarArchivo(Nombre, Destino, A, ArchivoCopiado),
	anadirArchivo(ArchivoCopiado, A, NuevosArchivos).

systemCopy([N,D,U,[L,R],C,A|Cola], Nombre, Destino, [N,D,U,[L,R],NuevasCarpetas,NuevosArchivos|Cola]):-
	existeCarpetaNom(Nombre, R, C),
	\+ existeCarpetaNom(Nombre, Destino, C),
	copiarSubCarpetas(R, C, ListaSubCarpetas),
	copiarSubArchivos(R, A, ListaSubArchivos),
	actualizarRuta(ListaSubArchivos, R, Destino, NuevaListaA),
	actualizarRuta(ListaSubCarpetas, R, Destino, NuevaListaC),
	append(NuevaListaA, A, NuevosArchivos),
	append(NuevaListaC, C, NuevasCarpetas).


%Predicado de "move"
%Modificador
%Dominio: Sistema (list) X nombre (str) X destino (str) X sistema (list)
%Meta:	1°: Mover un archivo a una direccion destino
%		2°: Eliminar dicho archivo de la direccion destino
%NOTA: Solo funciona en archivos, no en carpetas

systemMove([N,D,U,[L,R],C,A|Cola], Nombre, Destino, [N,D,U,[L,R],C,NuevosArchivos|Cola]):-
	existeArchivoNom(Nombre, R, A),
	\+ existeArchivoNom(Nombre, Destino, A), %Esto es para verificar la unicidad por nivel
	copiarArchivo(Nombre, Destino, A, ArchivoCopiado),
	eliminarArchivo(Nombre, A, Aux),
	anadirArchivo(ArchivoCopiado, Aux, NuevosArchivos).

systemMove([N,D,U,[L,R],C,A|Cola], Nombre, Destino, [N,D,U,[L,R],NuevasCarpetas,NuevosArchivos|Cola]):-
	existeCarpetaNom(Nombre, R, C),
	\+ existeCarpetaNom(Nombre, Destino, C),
	copiarCarpeta(Nombre, R, Destino, C, CopiaCarpetaAux),
	copiarSubCarpetas(R, C, ListaSubCarpetas),
	copiarSubArchivos(R, A, ListaSubArchivos),
	actualizarRuta(ListaSubArchivos, R, Destino, NuevaListaA),
	actualizarRuta(ListaSubCarpetas, R, Destino, NuevaListaC),
	append(NuevaListaA, A, NuevosArchivosAux),
	append(NuevaListaC, C, NuevasCarpetasAux0),
	eliminarCarpeta(Nombre, NuevasCarpetasAux0, Aux),
	anadirCarpeta(CopiaCarpetaAux, Aux, NuevasCarpetasAux),
	string_concat(R, Nombre, Aux1),
	string_concat(Aux1, "/", Aux2),
	eliminarSubArchivos(Aux2, NuevosArchivosAux, NuevosArchivos),
	eliminarSubCarpetas(Aux2, NuevasCarpetasAux, NuevasCarpetas).


%Predicado de "rename"
%Modificador
%Dominio: Sistema (list) X nombreOld (Str) X nombreNew (Str) X sistema (list)
%Meta:	1°: buscar existencia del elemento
%		2°: Revisar que no exista el nuevo nombre en el nivel actual
%		  : reemplazar el nombre del elemento

systemRen([N,D,U,[L,R],C|Cola], NombreOldC, NombreNewC, [N,D,U,[L,R],NuevasCarpetas|Cola]):- %Trabaja con carpetas directamente visibles
	existeCarpetaNom(NombreOldC, R, C),
	\+ existeCarpetaNom(NombreNewC, R, C), %No debe existir una carpeta con el nuevo nombre
	crearCarpeta(NombreNewC, L, R, CarpetaRen),
	eliminarCarpeta(NombreOldC, C, Aux),
	anadirCarpeta(CarpetaRen, Aux, NuevasCarpetas).

systemRen([N,D,U,[L,R],C,A|Cola], NombreOldA, NombreNewA, [N,D,U,[L,R],C,NuevosArchivos|Cola]):- %Trabaja con archivos directamente visibles
	existeArchivoNom(NombreOldA, R, A),
	\+ existeArchivoNom(NombreNewA, R, A),
	reemplazarArchivoNom(NombreOldA, NombreNewA, A, NuevosArchivos).