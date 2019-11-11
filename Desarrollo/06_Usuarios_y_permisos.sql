
CREATE login adminlogin WITH password ='admin123' 
CREATE login usuarioactualizacionlogin WITH password ='usuarioactualizacion123' 
CREATE login lectorlogin WITH password ='lector123' 

CREATE USER admin FOR login adminlogin 
CREATE USER usuarioactualizacion FOR login usuarioactualizacionlogin 
CREATE USER lector FOR login lectorlogin 


create schema adminSchema authorization admin 
create schema usuarioactualizacionSchema authorization usuarioactualizacion 
create schema lectorSchema authorization lector 

GRANT ALTER ON SCHEMA :: adminSchema TO admin;
GRANT INSERT ON SCHEMA :: usuarioactualizacionSchema TO usuarioactualizacion;
GRANT SELECT ON SCHEMA :: lectorSchema TO lector;

ALTER USER admin WITH DEFAULT_SCHEMA = adminSchema
ALTER USER usuarioactualizacion WITH DEFAULT_SCHEMA = usuarioactualizacionSchema
ALTER USER lector WITH DEFAULT_SCHEMA = lectorSchema