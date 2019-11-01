

-- Trigger que se desencadenará si una aplicación anda mal porque tiene muy eleveado el contador de métricas
GO
alter TRIGGER unaAppFallando
ON Aplicacion
AFTER UPDATE 
AS
BEGIN
    DECLARE @cont INT
	DECLARE @cont2 INT
    
    SELECT @cont =  (SELECT SUM(countMet) FROM Aplicacion WHERE id_api = 1)
	SELECT @cont2 = (SELECT SUM(countMet) FROM Aplicacion WHERE id_api = 2)

	
	IF(@cont >= 5)
	BEGIN
		PRINT 'Aplicación 1 ANDA MAL, varios de sus dispositivos recibieron métricas por arriba del umbral esperado'

        EXEC crearIncidente 1, @cont 

	END
	
	IF(@cont2 >= 5)
	BEGIN
		PRINT 'Aplicación 2 ANDA MAL, varios de sus dispositivos recibieron métricas por arriba del umbral esperado'

        EXEC crearIncidente 2, @cont2
	END
END
GO


