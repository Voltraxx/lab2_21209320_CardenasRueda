%TDA usuario
:- module(tdaUsuario_21209320_CardenasRueda,[existeUsuario/2, usuarioLogueado/2, logVacio/1]).

%Predicado de "member"
%Pertenencia
%Dominio: Nombre (str) X usuarios (list)
%Meta: 1°:Buscar si un usuario se encuentra registrado.

existeUsuario(_, []):- fail.
existeUsuario(Usuario, [Usuario|_]).
existeUsuario(Usuario, [_|Cola]):- % Recursión para encontrar al usuario y ver si está registrado
	existeUsuario(Usuario, Cola).

%Pertenencia
%Dominio: Nombre (str) X log (list)
%Meta:  1°:Comprobar si el usuario a loguear ya se encuentra logueado.

usuarioLogueado(Usuario, [Usuario,_]).
usuarioLogueado(_, [_,_]):- fail.

%Otros
%Dominio: Log (list)
%Meta:  1°:Verificar si el log del sistema está vacío o no lo está

logVacio([]).