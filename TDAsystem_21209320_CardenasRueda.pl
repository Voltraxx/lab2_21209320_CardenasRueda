%Laboratorio 2 paradigmas: programación lógica



%HECHOS


%CLAUSULAS

%Predicado de "system"
%Constructor de sistema
%Dominio: nombre del sistema X lista resultante añadiendo el nombre de sistema (sistema)
%Meta: 1°: Entregar una lista de 8 para referenciar: nombre, drives, usuarios, log, carpetas, archivos, papelera de carpetas, papelera de archivos.

system(Nombre, [[Nombre],[],[],[],[],[],[],[]]).

%Predicado de "add-drive"
%Constructor de drives
%Dominio: Sistema X letra del drive X nombre del drive X capacidad del drive X sistema resultante
%Meta:  1°:Añadir un drive de acuerdo a los datos entregados como letra, nombre y capacidad al sistema
%	2°:Verificar si el drive ya se encuentra en el sistema.

%Reglas (posiblemente se agregue al TDA a futuro)
existeDrive(_, []):-fail. %Este caso es cuando NO existe el drive en sistema
existeDrive(Letra, [[Letra|_]|_]). %En este caso, el drive ya existe (entrega "false")
existeDrive(Letra,[_|Resto]):- existeDrive(Letra, Resto). %Recursivamente busca si el drive está en sistema.

systemAddDrive([NombreSistema,Drives|Cola], Letra, Nombre, Capacidad, [NombreSistema,[[Letra,Nombre,Capacidad]|Drives]|Cola]):- \+ existeDrive(Letra, Drives).