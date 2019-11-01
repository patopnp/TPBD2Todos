IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.enviarNoti'))
   EXEC('CREATE PROCEDURE [dbo].[enviarNoti] AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE enviarNoti
AS
BEGIN
    UPDATE Notificacion SET estado = 'Enviadas' 
END
GO
