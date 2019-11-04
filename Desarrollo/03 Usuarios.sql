-- Creamos el esquema y otorgamos los permisos
CREATE SCHEMA Monitoreo;
GRANT ALTER ON OBJECT::Monitoreo.Parametros TO admin;
GRANT INSERT ON OBJECT::Monitoreo.Metrica TO usuarioActualizacion;
GRANT SELECT ON SCHEMA::Monitoreo TO lector;


CREATE LOGIN adminLogin WITH PASSWORD = 'admin1234';
CREATE USER admin FOR LOGIN adminLogin WITH DEFAULT_SCHEMA = Monitoreo;


CREATE LOGIN usuarioActualizacionLogin WITH PASSWORD = 'usuario1234';
CREATE USER usuarioActualizacion FOR LOGIN usuarioActualizacionLogin WITH DEFAULT_SCHEMA = Monitoreo;


CREATE LOGIN lectorLogin WITH PASSWORD = 'lector1234';
CREATE USER lector FOR LOGIN lectorLogin WITH DEFAULT_SCHEMA = Monitoreo;
