%Laboratorio 2 paradigmas: programación lógica
%Nota: en metas, "1°" indica meta primaria, y "2°" indica meta/s secundaria/s

%HECHOS


%CLAUSULAS

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

%Reglas (posiblemente se agregue al TDA a futuro)
existeDrive(_, []):- fail. %Este caso es cuando NO existe el drive en sistema
existeDrive(Letra, [[Letra|_]|_]). %En este caso, el drive ya existe (entrega "false")
existeDrive(Letra, [_|Resto]):- existeDrive(Letra, Resto). %Recursivamente busca si el drive está en sistema.

systemAddDrive([NombreSistema,Drives|Cola], Letra, Nombre, Capacidad, [NombreSistema,[[Letra,Nombre,Capacidad]|Drives]|Cola]):- \+ existeDrive(Letra, Drives).
											
%Predicado de "register"
%Constructor de usuarios
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Añadir usuario al sistema.
%	2°:Verificar si el usuario ya se encuentra registrado en el sistema.

existeUsuario(_, []):- fail. %El usuario NO existe en los usuarios registrados
existeUsuario(Nombre, [Nombre|_]). %El usuario ya se encuentra registrado
existeUsuario(Nombre, [_|Resto]):- existeUsuario(Nombre, Resto). %Busca por recursión si el usuario ya se encuentra registrado.

systemRegister([NombreSistema, Drives, Usuarios|Cola], Usuario, [NombreSistema, Drives, [Usuario|Usuarios]|Cola]):- \+ existeUsuario(Usuario, Usuarios).

%Predicado de "login"
%Modificador
%Dominio: Sistema (list) X nombre usuario (str) X sistema (list)
%Meta:  1°:Loguear usuario
%	2°:Verificar existencia de usuario
usuarioVacio([]).
usuarioLogueado(Nombre, [Nombre,_]). %Comprueba si existe algo en la posición de "usuario logueado" (primera posición de la lista)
usuarioLogueado(_, [_,_]):- fail.

systemLogin([Nombre, Drives, Usuarios, Log|Cola], Login, [Nombre, Drives, Usuarios, [Login,_]|Cola]):- existeUsuario(Login, Usuarios),
												       usuarioLogueado(Login, Log);
												       usuarioVacio(Log).
%Predicado de "logout"
%Modificador
%Dominio: Sistema (list) X sistema (list)
%Meta: 1°:Desloguear al usuario

systemLogout([Nombre, Drives, Usuarios, Log|Cola], [Nombre, Drives, Usuarios, []|Cola]):- \+ usuarioVacio(Log).

%Predicado de "switch-drive"
%Modificador
%Dominio: Sistema (list) X letra (str) X sistema (list)
%Meta:  1°:Fijar una unidad del sistema para realizar acciones
%	2°:Verificar que haya un usuario logueado
%	   Comrpobar que el drive a moverse exista

systemSwitchDrive([[NombreSistema|_], Drives, Usuarios, [Login|_]|Cola], Letra, [[NombreSistema, Letra], Drives, Usuarios, [Login, Ruta]|Cola]):- usuarioLogueado(_, [Login,_]), %En este caso solo verifica que haya algo en la primera posición de "Log"
																               	  existeDrive(Letra, Drives),
																		  string_concat(Letra, ":/", Ruta).


%Predicado de "make-dir"
%Constructor
%Dominio: Sistema (list) X carpeta (str) X sistema (list)
%Meta: 1°:Añadir carpeta al sistema

systemMkdir([NombreSistema, Drives, Usuarios, [Login,Ruta], Folders|Cola], Carpeta, [NombreSistema, Drives, Usuarios, [Login, Ruta], [[Carpeta, Login, Ruta]|Folders]|Cola]).









