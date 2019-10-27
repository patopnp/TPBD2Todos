GO

CREATE PROCEDURE enviarNoti
AS
BEGIN
    UPDATE Notificacion SET estado = 'Enviadas' 
END
GO
 id_noti         INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    id_usuario      INT, --SYSUSER
    id_api          INT,
    tipo_noti       VARCHAR(300), --MAIL 1, SMS 2, LLAMADO3 -> 3 URGENTEES, 2 MASO, 1 NO
    estado          VARCHAR(300)




GO
alter PROCEDURE crearIncidente
(
	@id_api INT,
	@contador INT
)
AS
BEGIN
    SET NOCOUNT ON
--1
	IF(@contador = 0 and @id_api = 1)
	BEGIN 
		INSERT INTO Incidente(id_api, estado) VALUES (1, 'Cerrado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 1, 'MAIL')
        EXEC enviarNoti
	END

	IF(@contador > 1 and @contador < 3 and @id_api = 1)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (1, 'Abierto')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 1, 'SMS')
        EXEC enviarNoti
	END

	IF(@contador >= 3 and @id_api = 1)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (1, 'Escalado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 1, 'LLAMADA')
        EXEC enviarNoti
	END

--2
	IF(@contador = 0 and @id_api = 2)
	BEGIN 
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Cerrado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 2, 'MAIL')
        EXEC enviarNoti
	END

	IF(@contador > 1 and @contador < 3 and @id_api = 2)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Abierto')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 2, 'SMS')
        EXEC enviarNoti
	END

	IF(@contador >= 3 and @id_api = 2)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Escalado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system.USER, 2, 'LLAMADA')
        EXEC enviarNoti
	END
END
GO



CREATE PROCEDURE limpiar
AS
BEGIN

	set nocount on

		DELETE FROM metrica
		DELETE FROM Dispositivo
		DELETE FROM Aplicacion
		DELETE FROM Incidente
		DELETE FROM Notificacion

	
		drop procedure crearIncidente
		drop procedure enviarNoti
		drop trigger eventoInsertMetricasAplicacion
		drop trigger unaAppFallando

		IF (exists(select 1 from metrica where estado = 'Inactivo'))
		BEGIN
			--eNVIAR A UNA TABLA HISTORIAL
		END

END
GO