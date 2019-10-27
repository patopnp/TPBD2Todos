------------ Dispositivo - creación e insert ---------------------

CREATE TABLE Dispositivo
(
    id_disp             INT PRIMARY KEY,
    sonda               VARCHAR(200),
    cant_metCorrectas   INT,
    cant_metIncorrectas INT
)

------------ Aplicacion - creación e insert ---------------------

CREATE TABLE Aplicacion
(
    id_api      INT,
    nombreApi   VARCHAR(300),
    id_disp     INT,
    countMet    INT, --este contador solo incrementará si se suceden las metricas configurables que pueden significar que una aplicación está fallanado por las recepciones de metricas de cada dispositivo perteneciente a una aplicación
)

------------ Metricas - creación ---------------------

CREATE TABLE Metrica
(
    id_metrica  INT PRIMARY KEY IDENTITY(1,1),
    id_disp     INT,
    fecha_hora  DATETIME,
    descrip     VARCHAR(400),
    unidad      VARCHAR(100),
    valor       INT, -- >50 MAL <= 50 BIEN
    estado      VARCHAR(200)
)



------------ Incidentes - creación ---------------------

CREATE TABLE Incidente
(
    id_incidente    INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    id_api          INT,
    estado          VARCHAR(400)
)



------------ Notificacion - creación ---------------------

CREATE TABLE Notificacion
(
    id_noti         INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    id_usuario      INT, --SYSUSER
    id_api          INT,
    tipo_noti       VARCHAR(300), --MAIL 1, SMS 2, LLAMADO3 -> 3 URGENTEES, 2 MASO, 1 NO
    estado          VARCHAR(300)
)