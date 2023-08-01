%Script de Pruebas
%NOTA: las líneas marcadas con doble "%" son las líneas de código.
:- consult('tdaSystem_21209320_CardenasRueda').


% Caso que debe retornar true:
% Creando un sistema, con el disco C, dos usuarios: “user1” y “user2”, 
% se hace login con "user1”, se utiliza el disco "C", se crea la carpeta “folder1”, 
% “folder2”, se cambia al directorio actual “folder1", 
% se crea la carpeta "folder11" dentro de "folder1", 
% se hace logout del usuario "user1", se hace login con “user2”, 
% se crea el archivo "foo.txt" dentro de “folder1”, se acceder a la carpeta c:/folder2, 
% se crea el archivo "ejemplo.txt" dentro de c:/folder2

%%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13), systemCd(S13, "/folder2", S14),  file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S14, F2, S15).

% Casos que deben retornar false:
% si se intenta añadir una unidad con una letra que ya existe

%%system("newSystem", S1), systemRegister(S1, "user1", S2), systemAddDrive(S2, "C", "OS", 1000000000, S3), systemAddDrive(S3, "C", "otra etiqueta", 1000000000, S4).

% si se intenta hacer login con otra sesión ya iniciada por este usuario u otro

%%system("newSystem", S1), systemRegister(S1, "user1", S2), systemRegister(S2, "user2", S3), systemLogin(S3, "user1", S4), systemLogin(S4, "user2", S5).

% si se intenta usar una unidad inexistente

%%system("newSystem", S1), systemRegister(S1, "user1", S2), systemLogin(S2, "user1", S3), systemSwitchDrive(S3, "K", S4).



%SCRIPT DE PRUEBAS PROPIO
%NOTA: A las variables de entrada y retorno, se les ha aplicado un nombre de acuerdo al predicado ejecutándose, es decir:
%S: Sistema; D: Add drive; MK: Make directory; etc...


%%system("Sistema de Pruebas", SISTEMAPRUEBA).
%%system("OTRA PRUEBA", SistemaPrueba).

%%system("MiSistema", S1),
%%systemAddDrive(S1, "C", "DriveC", "1234567", D1),
%%systemAddDrive(D1, "D", "DriveD", "1233333", D2),
%%systemAddDrive(D2, "C", "NuevoDriveC", "11111111", D3), %----> No funciona ya que "D" ya está registrado.
%%systemRegister(D2, "PrimerUsuario", U1),
%%systemRegister(U1, "SegundoUsuario", U2),
%%systemRegister(U2, "PrimerUsuario", U3), %-----> No funciona ya que "PrimerUsuario" ya se encuentra registrado.
%%systemLogin(U2, "PrimerUsuario", L1),
%%systemLogin(L1, "PrimerUsuario", L2), %-----> Devuelve el mismo sistema ya que se ingresa a un usuario actualmente logueado
%%systemLogin(L2, "SegundoUsuario", L3), %------> Retorna False ya que hay un usuario ingresado distinto al que se quiere ingresar
%%systemLogout(L2, LO1),
%%systemLogout(LO1, LO2), -----> Retorna False ya que no hay ningún usuario ingresado
%%systemLogout(L02, LO3), -----> Retorna False ya que de por sí, LO2 es falso
%%systemSwitchDrive(L2, "C", SD1),
%%systemSwitchDrive(SD1, "D", SD2),
%%systemSwitchDrive(SD2, "K", SD3), %-----> Retorna False ya que no hay un drive con letra "K"
%%systemMkdir(SD2, "MiPrimeraCarpeta", MK1),
%%systemMkdir(MK1, "2da Carpeta", MK2),
%%systemMkdir(MK2, "Prolog", MK3),
%%file("MiPrimerArchivo", "hola mundo", File1),
%%file("2do archivo", "Cosas para comprar: Atún y arroz", File2),
%%systemAddFile(MK3, File1, AF1),
%%systemAddFile(AF1, File2, AF2),
%%file("Horario", "Lunes: prueba TDC", File3),
%%systemAddFile(AF2, File3, AF3).

%Los predicados siguientes a este no han sido implementados