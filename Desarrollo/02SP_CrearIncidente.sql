IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.crearIncidente'))
   EXEC('CREATE PROCEDURE [dbo].[crearIncidente] AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE crearIncidente
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
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 1, 'MAIL')
        EXEC enviarNoti
	END

	IF(@contador > 1 and @contador < 3 and @id_api = 1)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (1, 'Abierto')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 1, 'SMS')
        EXEC enviarNoti
	END

	IF(@contador >= 3 and @id_api = 1)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (1, 'Escalado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 1, 'LLAMADA')
        EXEC enviarNoti
	END

--2
	IF(@contador = 0 and @id_api = 2)
	BEGIN 
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Cerrado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 2, 'MAIL')
        EXEC enviarNoti
	END

	IF(@contador > 1 and @contador < 3 and @id_api = 2)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Abierto')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 2, 'SMS')
        EXEC enviarNoti
	END

	IF(@contador >= 3 and @id_api = 2)
	BEGIN
		INSERT INTO Incidente(id_api, estado) VALUES (2, 'Escalado')
        INSERT INTO Notificacion(usuario, id_api, tipo_noti)VALUES(system_user, 2, 'LLAMADA')
        EXEC enviarNoti
	END
END
GO
