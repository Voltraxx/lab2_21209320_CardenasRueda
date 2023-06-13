%TDA usuario
:- module(tdaUsuario_21209320_CardenasRueda,[miembroUsuario/2, usuarioLogueado/2, usuarioVacio/1]).

%Predicado de "member"
%Pertenencia
%Dominio: Nombre (str) X usuarios (list)
%Meta: 1°:Buscar si un usuario se encuentra registrado.

miembroUsuario(_, []):- fail. %El usuario no se encuentra registrado.
miembroUsuario(Nombre, [Nombre|_]). %El usuario ya se encuentra registrado.
miembroUsuario(Nombre, [_|Resto]):- miembroUsuario(Nombre, Resto). %Busca recursivamente si el usuario se encuentra registrado.

%Pertenencia
%Dominio: Nombre (str) X log (list)
%Meta:  1°:Comprobar si el usuario a loguear ya se encuentra logueado.

usuarioLogueado(Nombre, [Nombre,_]). %Comprueba si existe algo en la posición de "usuario logueado" (primera posición de la lista). Si es el mismo usuario entrega el mismo sistema de entrada.
usuarioLogueado(_, [_,_]):- fail.

%Otros
%Dominio: Log (list)
%Meta:  1°:Verificar si el log del sistema está vacío o no

usuarioVacio([]). %Para el caso especial en donde no hay algún usuario logueado.