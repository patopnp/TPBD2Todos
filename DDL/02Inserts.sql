
/*  ### --- INSERTS ---  ### */

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


--Cerrado
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(2, getdate(), 'descrip2', 'entera', 80,'Activa')

--Abierto
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(1, getdate(), 'descrip1', 'entera', 70,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(2, getdate(), 'descrip2', 'entera', 80,'Activa')

--Escalado
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(1, getdate(), 'descrip1', 'entera', 70,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(2, getdate(), 'descrip2', 'entera', 80,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(3, getdate(), 'descrip3', 'entera', 90,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(3, getdate(), 'descrip3', 'entera', 80,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(3, getdate(), 'descrip3', 'entera', 60,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(7, getdate(), 'descrip7', 'entera', 30,'Activa')
INSERT INTO Metrica(id_disp, fecha_hora, descrip, unidad, valor, estado)VALUES(8, getdate(), 'descrip8', 'entera', 20,'Activa')



