------------ Dispositivo - creación e insert ---------------------

CREATE TABLE Dispositivo
(
    id_disp             INT PRIMARY KEY,
    sonda               VARCHAR(200),
    cant_metCorrectas   INT,
    cant_metIncorrectas INT
)

INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(1, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(2, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(3, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(4, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(5, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(6, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(7, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(8, 'activa', 0, 0)


------------ Aplicacion - creación e insert ---------------------

CREATE TABLE Aplicacion
(
    id_api      INT,
    nombreApi   VARCHAR(300),
    id_disp     INT,
    countMet    INT, --este contador solo incrementará si se suceden las metricas configurables que pueden significar que una aplicación está fallanado por las recepciones de metricas de cada dispositivo perteneciente a una aplicación
)

INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 1, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 2, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 3, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 4, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 5, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 6, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 7, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 8, 0)



------------ Metricas - creación ---------------------

CREATE TABLE Metrica
(
    id_metrica  INT PRIMARY KEY IDENTITY(1,1),
    id_disp     INT,
    fecha_hora  DATETIME,
    descrip     VARCHAR(400),
    unidad      VARCHAR(100),
    valor       INT
)








GO
alter TRIGGER eventoInsertMetricasAplicacion
    ON Metrica
    AFTER INSERT 
AS
BEGIN
	SET NOCOUNT ON

    DECLARE @countOk			INT
    DECLARE @countNoOkDisp1		INT
	DECLARE @countNoOkDisp2		INT
	DECLARE @countNoOkDisp3		INT
	DECLARE @countNoOkDisp4		INT
	DECLARE @countNoOkDisp5		INT
	DECLARE @countNoOkDisp6		INT
	DECLARE @countNoOkDisp7		INT
	DECLARE @countNoOkDisp8		INT
	DECLARE @api1CONT			INT
	DECLARE @api2CONT			INT

    --Malas
    IF ((SELECT valor FROM inserted) > 50) -- ok 
    BEGIN
		SELECT @countNoOkDisp1 = (SELECT count(*) from Metrica WHERE id_disp = 1)
		SELECT @countNoOkDisp2 = (SELECT count(*) from Metrica WHERE id_disp = 2)
		SELECT @countNoOkDisp3 = (SELECT count(*) from Metrica WHERE id_disp = 3)
		SELECT @countNoOkDisp4 = (SELECT count(*) from Metrica WHERE id_disp = 4)
		SELECT @countNoOkDisp5 = (SELECT count(*) from Metrica WHERE id_disp = 5)
		SELECT @countNoOkDisp6 = (SELECT count(*) from Metrica WHERE id_disp = 6)
		SELECT @countNoOkDisp7 = (SELECT count(*) from Metrica WHERE id_disp = 7)
		SELECT @countNoOkDisp8 = (SELECT count(*) from Metrica WHERE id_disp = 8)

		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp1 WHERE id_disp = 1
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp2 WHERE id_disp = 2
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp3 WHERE id_disp = 3
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp4 WHERE id_disp = 4
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp5 WHERE id_disp = 5
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp6 WHERE id_disp = 6
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp7 WHERE id_disp = 7
		UPDATE Dispositivo SET cant_metIncorrectas = @countNoOkDisp8 WHERE id_disp = 8

		SELECT @api1CONT = @countNoOkDisp1 + @countNoOkDisp2 + @countNoOkDisp3 + @countNoOkDisp4
		SELECT @api2CONT = @countNoOkDisp5 + @countNoOkDisp6 + @countNoOkDisp7 + @countNoOkDisp8

		IF ((@api1CONT) >= 3)
		BEGIN
            UPDATE Aplicacion SET countMet = @api1CONT WHERE id_api = 1
		END
		
		IF((@api2CONT) >= 3)
		BEGIN
            UPDATE Aplicacion SET countMet = @api2CONT WHERE id_api = 2
		END	
    END
END
GO


-- Trigger que se desencadenará si una aplicación anda mal porque tiene muy eleveado el contador de métricas
GO
alter TRIGGER unaAppFallando
ON Aplicacion
AFTER UPDATE 
AS
BEGIN
    DECLARE @cont INT
	DECLARE @cont2 INT
    
    SELECT @cont =  (SELECT COUNT(countMet) FROM Aplicacion WHERE id_api = 1)
	SELECT @cont2 = (SELECT COUNT(countMet) FROM Aplicacion WHERE id_api = 2)

	IF(@cont >= 3)
	BEGIN
		PRINT 'Aplicación 1 ANDA MAL, varios de sus dispositivos recibieron métricas por arriba del umbral esperado'
	END

	IF(@cont2 >= 3)
	BEGIN
		PRINT 'Aplicación 2 ANDA MAL, varios de sus dispositivos recibieron métricas por arriba del umbral esperado'
	END
    
END
GO



set nocount on

 
------------------ ## EXPLICACIÖN ## ------------------
--TEST TRIGGER GENERA EVENTOS Y CONTADORES DE METRICAS BUENAS Y MALAS -> RESULTADO: deberia mostrar que la API 1 anda mal y la cantidad de metricas malas en 
--cada dispositivo

--- Metricas con valores de  50 =< OK
--- Metricas con valores de 50 > FAIL

DELETE FROM metrica
DELETE FROM Dispositivo
DELETE FROM Aplicacion

INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 1, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 2, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 3, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(1, 'Aplicación 1', 4, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 5, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 6, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 7, 0)
INSERT INTO Aplicacion(id_Api, nombreApi, id_disp, countMet)VALUES(2, 'Aplicación 2', 8, 0)


INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(1, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(2, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(3, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(4, 'SNMP', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(5, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(6, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(7, 'activa', 0, 0)
INSERT INTO Dispositivo(id_disp, sonda, cant_metCorrectas, cant_metIncorrectas)VALUES(8, 'activa', 0, 0)

INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(1, getdate(), 'descrip1', 'entera', 70)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(2, getdate(), 'descrip2', 'entera', 80)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(3, getdate(), 'descrip3', 'entera', 90)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(3, getdate(), 'descrip3', 'entera', 80)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(3, getdate(), 'descrip3', 'entera', 60)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(7, getdate(), 'descrip7', 'entera', 30)
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor)VALUES(8, getdate(), 'descrip8', 'entera', 20)

SELECT * FROM metrica
SELECT * FROM Dispositivo
SELECT * FROM Aplicacion
