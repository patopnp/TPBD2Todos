CREATE TABLE Usuario 
(
	id_usuario INT,
	id_app INT,
)

CREATE TABLE Dispositivo
(
	id_disp INT PRIMARY KEY,
	nombre VARCHAR(300),
	tipo VARCHAR(300),
	id_metrica INT
)	

CREATE TABLE Metrica
(
	id_met INT PRIMARY KEY NOT NULL,
	id_disp INT CONSTRAINT FK_Dispositivo FOREIGN KEY (id_disp)REFERENCES Dispositivo(id_disp),
	fechaHora DATETIME,
	descr VARCHAR(500),
	unidad VARCHAR(400),
	valor INT
)	

CREATE TABLE Aplicacion
(
	id_app INT PRIMARY KEY IDENTITY(1,1),
	id_disp INT,
	id_metrica INT,
	nombre VARCHAR(200),
)

CREATE TABLE Incidente
(
	id INT IDENTITY(1,1),
	id_app INT  CONSTRAINT Aplicacion FOREIGN KEY (id_app)REFERENCES Aplicacion(id_app),
	incidente VARCHAR(300)
)

CREATE TABLE Notificacion
(
	id_not INT IDENTITY(1,1),
	id_usuario INT,
	id_incidente INT,
	TipoNotifiacion VARCHAR(400)
)