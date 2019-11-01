IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.limpiar'))
   EXEC('CREATE PROCEDURE [dbo].[limpiar] AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE limpiar
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