IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.limpiar'))
   EXEC('CREATE PROCEDURE [dbo].[limpiar] AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE limpiar
AS
BEGIN

	set nocount on


		IF (exists(select 1 from metrica where estado = 'Inactivo'))
		BEGIN
			--eNVIAR A UNA TABLA HISTORIAL
			SELECT id_disp, fecha_hora, descrip, unidad, valor, estado
			INTO #Tabla_Historial
			FROM metrica WHERE estado = 'Inactivo'
		END

	
		DELETE FROM metrica WHERE estado = 'Inactivo'
END
GO

