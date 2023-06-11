%Laboratorio 2 paradigmas: programación lógica
%Nota: en metas, "1°" indica meta primaria, y "2°" indica meta/s secundaria/s
:- use_module(tdaUsuario_21209320_CardenasRueda).
:- use_module(tdaDrives_21209320_CardenasRueda).
:- use_module(tdaCarpeta_21209320_CardenasRueda).

%Predicado de "system"
%Constructor de sistema
%Dominio: Nombre del sistema (str) X Sistema (list)
%Meta: 1°: Entregar una lista de 8 para referenciar: nombre, drives, usuarios, log, carpetas, archivos, papelera de carpetas, papelera de archivos.

system(Nombre, [[Nombre],[],[],[],[],[],[],[]]).

%Predicado de "add-drive"
%Constructor de drives
%Dominio: Sistema (list) X letra del drive (str) X nombre del drive (str) X capacidad del drive (int) X sistema resultante (list)
%Meta:  1°:Añadir un drive de acuerdo a los datos entregados como letra, nombre y capacidad al sistema
%	2°:Verificar si el drive ya se encuentra en el sistema.

systemAddDrive([NombreSistema,Drives|Cola], Letra, Nombre, Capacidad, [NombreSistema,[[NuevaLetra,Nombre,Capacidad]|Drives]|Cola]):- atom_string(Letra, NuevaLetra), %Transforma Letra, en caso de ser un carácter, a un string.
																     \+ existeDrive(NuevaLetra, Drives). %Añade el drive solo si no se ha añadido uno con la misma letra anteriormente
											
%Predicado de "register"
%Constructor de usuarios
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Añadir usuario al sistema.
%	2°:Verificar si el usuario ya se encuentra registrado en el sistema.

systemRegister([NombreSistema, Drives, Usuarios|Cola], Usuario, [NombreSistema, Drives, [Usuario|Usuarios]|Cola]):- \+ miembroUsuario(Usuario, Usuarios). %Registra al usuario solo si este aún no ha sido registrado previamente

%Predicado de "login"
%Modificador
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Loguear usuario
%	2°:Verificar existencia de usuario

systemLogin([Nombre, Drives, Usuarios, Log|Cola], Login, [Nombre, Drives, Usuarios, [Login,_]|Cola]):- miembroUsuario(Login, Usuarios),
												       (usuarioLogueado(Login, Log); usuarioVacio(Log)). %Compara primero por ";" y luego por ","
%Predicado de "logout"
%Modificador
%Dominio: Sistema (list) X sistema (list)
%Meta: 1°:Desloguear al usuario

systemLogout([Nombre, Drives, Usuarios, Log|Cola], [Nombre, Drives, Usuarios, []|Cola]):- \+ usuarioVacio(Log). %La condición pregunta por si hay algún usuario actualmente logueado o no. En caso de que no haya se retorna "false"

%Predicado de "switch-drive"
%Modificador
%Dominio: Sistema (list) X letra (str) X sistema (list)
%Meta:  1°:Fijar una unidad del sistema para realizar acciones
%	2°:Verificar que haya un usuario logueado
%	   Comrpobar que el drive a moverse exista

systemSwitchDrive([[NombreSistema|_], Drives, Usuarios, [Login|_]|Cola], Letra, [[NombreSistema, Ruta], Drives, Usuarios, [Login, Ruta]|Cola]):- usuarioLogueado(_, [Login,_]), %En este caso solo verifica que haya algo en la primera posición de "Log"
																               	 existeDrive(Letra, Drives),
																		 string_concat(Letra, ":/", Ruta). %Al cambiar de drive siempre se ubicará en la raiz de este

%Predicado de "make-dir"
%Constructor
%Dominio: Sistema (list) X carpeta (str) X sistema (list)
%Meta: 1°:Añadir carpeta al sistema

systemMkdir([NombreSistema, Drives, Usuarios, [Login,Ruta], Folders|Cola], Carpeta, [NombreSistema, Drives, Usuarios, [Login, Ruta], [NuevaCarpeta|Folders]|Cola]):- nuevaCarpeta(Carpeta, Login, Ruta, NuevaCarpeta),
																				     \+ existeCarpeta(NuevaCarpeta, Folders).

%Predicado de "change-directory"
%Modificador
%Dominio: Sistema (list) X comando (str) X sistema (list)
%Meta:  1°:Cambiar la dirección actual del sistema
%	2°:Identificar el comando y realizar operaciones de acuerdo a ello

subCadenaFinal(Path, NewPath):- sub_string(Path, _, _, Ultimo, "/"),
				sub_string(Path, 0, Ultimo, _, NewPath).

systemCd([[NombreSistema, Raiz], Drives, Usuarios, [Log,_]|Cola], "/", [[NombreSistema, Raiz], Drives, Usuarios, [Log, Raiz]|Cola]).
systemCd([[NombreSistema, Raiz], Drives, Usuarios, [Log, Ruta]|Cola], "..", [[NombreSistema, Raiz], Drives, Usuarios, [Log, NuevaRuta]|Cola]):- subCadenaFinal(Ruta, NuevaRuta).
systemCd([NombreSistema, Drives, Usuarios, [Log, Ruta], Folders|Cola], Carpeta, [NombreSistema, Drives, Usuarios, [Log, NewPath], Folders|Cola]):- existeCarpeta([Carpeta,_,Ruta], Folders),
																	    	   string_concat(Ruta, Carpeta, NewP),
																	     	   string_concat(NewP, "/", NewPath).
%Predicado de "add-file"
%Constructor
%Dominio: Sistema (list) X archivo (list) X sistema (list)
%Meta:	1°: Añadir un archivo al sistema
%	2°: Transformar el archivo entregado "file" en una lista con sus datos
file(Nombre, Contenido, [Nombre, Contenido]).

systemAddFile([N, D, U, L, F, Archivos|Cola], File, [N, D, U, L, F, [File|Archivos]|Cola]).










