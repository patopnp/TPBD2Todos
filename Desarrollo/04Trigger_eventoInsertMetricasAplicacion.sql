--IF OBJECT_ID(N'eventoInsertMetricasAplicacion', N'TR') IS NOT NULL
--    exec sp_executesql N'DROP TRIGGER eventoInsertMetricasAplicacion';
--GO
CREATE TRIGGER eventoInsertMetricasAplicacion
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

		UPDATE metrica SET estado = 'Inactivo' where valor is not null and valor <> 0

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