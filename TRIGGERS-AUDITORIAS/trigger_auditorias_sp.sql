/*
 -Con esta condición decimos que si la base de datos que nosotros queremos 
  crear con el nombre que deseamos existe, si existe, con el mismo nombre, pues 
  que la elimine con la sentencia (drop database) y que use la base de datos por
  defecto que es la (master)
*/
 
IF DB_ID ('auditoria_trigger_sp') IS NOT NULL
BEGIN USE MASTER DROP DATABASE auditoria_trigger_sp END

/* luego la secuencia sigue y creamos la base de datos */

CREATE DATABASE auditoria_trigger_sp
GO

--Usamos la base de datos creada
USE auditoria_trigger_sp
GO


/* *********************** TABLAS ************************************ */


CREATE TABLE Empleados(
	Id_empleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100),
	Telefono CHAR (8) constraint [ el telefono no cumple con los requisitos ] CHECK (Telefono like '[5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
	Cedula VARCHAR (16) constraint [ el numero de cedula no cumple con los requisitos validos ]  CHECK (CEDULA LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]') NOT NULL,
)
GO

/* ****TABLA AUDITORIA REFERENTE ALA TABLA EMPLEADOS 
	[OJO] : EL CONSTRAINT DE LAS VALIDACIONES LOS PODEMOS PONER,PERO SE DEBE MODIFICAR EL NOMBRE, YA QUE HABRIA CONFLICTOS DE DUPLICACION
	[EJEMPLO] : constraint [ el telefono no cumple con los requisitos ] en la tabla empleado, se debe modificar en la tabla Auditoria_Empleados, por ejemplo
	[ el telefono no cumple con los requisitos en la tabla auditoria_empleados ]

*/
CREATE TABLE Auditoria_Empleados(
	Id_empleado INT NOT NULL, ---[OJO: NO es identity porque el id lo recibimos del empleado YA EXISTENTE]
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100),
	Telefono CHAR (8),
	Cedula VARCHAR (16),
	/* Nuevos campos */
	fecha_registro DATETIME ,
	tipo_accion  VARCHAR(255), --- INSERT, UPDATE, DELETE ,
	usuario_cuenta_accion VARCHAR(255) ---El usuario o cuenta que se logueo e hizo la transaccion, puede ser el usuario [sa] u otro
)
GO


/* *********************** TRIGGERS PARA LA TABLA AUDITORIA DE LOS CAMPOS DE LA TABLA EMPLEADO **************** */

/* ¿Qué saber antes de aplicar los trigger? 
	inserted:  palabra reservada que obtiene del registo que se inserto de dicha tabla
	deleted: palabra reservada que obtiene el registro que se elimino de dicha tabla

	¿Que son las auditorias?
	Son respaldos y registro de las transacciones que se hace en cada tabla, si se elimino, inserto o actualizo. Las auditorias se hacen
	por cada tabla, es un clon de la tabla principal que se le suele agregar mas columnas, ejemplo, la fecha de actualizacion, el tipo de 
	accion que se hizo...y el usuario o la cuenta que hizo la transacion.

	Las auditorias usan lo que llamamos tablas temporales, como sucede esto?... Por ejemplo, al eliminar un registro, si, se elimina de la tabla
	principal, pero se guarda en una tabla respaldo para tener seguridad de cada cosa que se hizo. ahora, ¿y los backup, los log de transacciones?
	si, los backup se programan automaticamente en cada database, hay 3 tipos de backup, pero nesesitamos respaldos del TIPO DE TRANSACCION QUE SE HACE 
	Y EL USUARIO QUE HIZO LA TRANSACCION, FECHA Y HORA, cosa que un backup no da.

*/

CREATE TRIGGER tr_empleados_delete
ON Empleados --- El nombre de la tabla que se observara si se hacen transacciones
AFTER DELETE 
AS BEGIN
	SET NOCOUNT ON; ---SE UTILIZA PARA EVITAR VER EL MENSAJE <(1 row affected)> AL DISPARARSE EL TRIIGERS
	INSERT INTO Auditoria_Empleados
	SELECT *, GETDATE(), 'SE ELIMINO', SYSTEM_USER FROM deleted
END
GO

 
CREATE TRIGGER tr_empleados_Update 
ON Empleados
AFTER UPDATE
AS
     BEGIN
         SET NOCOUNT ON;
         INSERT INTO Auditoria_Empleados
                SELECT *, 
                       GETDATE(),
                       'ANTES DE LA ACTUALIZACION',
					   SYSTEM_USER
                FROM deleted;
         INSERT INTO Auditoria_Empleados
                SELECT *, 
                       GETDATE(),
                       'DESPUES DE LA ACTUALIZACION',
					   SYSTEM_USER
                FROM inserted;
     END
GO


CREATE TRIGGER tr_empleados_insert
 ON Empleados
AFTER INSERT
AS
     BEGIN
         SET NOCOUNT ON;
         INSERT INTO Auditoria_Empleados
                SELECT *, GETDATE(), 'SE AGREGO', SYSTEM_USER FROM inserted;
     END
GO

/* ****PROCEDIMIENTOS ALMACENADOS PARA CRUD DE LA TABLA ---> QUE ES CRUD? VER, INSERTAR, ACTUALIZAR Y ELIMINAR registros de una tabla */

CREATE PROCEDURE sp_insert_empleados
	@nombres VARCHAR(100) ,
	@apellidos VARCHAR(100),
	@Telefono CHAR(8), 
	@Cedula VARCHAR(16)
as
    INSERT INTO Empleados(nombres, apellidos, Telefono,Cedula)
    VALUES (@nombres, @apellidos, @Telefono, @Cedula)
go


CREATE PROCEDURE sp_update_empleados
	@id_empleado INT,
	@nombres VARCHAR(100) ,
	@apellidos VARCHAR(100),
	@Telefono CHAR(8), 
	@Cedula VARCHAR(16)
as
  IF EXISTS (SELECT Id_empleado FROM Empleados WHERE @id_empleado=Id_empleado)
  BEGIN
	   UPDATE Empleados SET nombres=@nombres, apellidos=@apellidos, Telefono=@Telefono, Cedula=@Cedula 
				WHERE @id_empleado=Id_empleado
  END
	 ELSE 
		BEGIN
	PRINT 'NO EXISTE UN EMPLEADO CON ESE ID'
		END
    
go

CREATE PROCEDURE sp_delete_empleados
	@id_empleado INT
as
     IF EXISTS (SELECT Id_empleado FROM Empleados WHERE @id_empleado=Id_empleado)
  BEGIN
	DELETE Empleados WHERE Id_empleado = @id_empleado
  END
	 ELSE 
		BEGIN
	PRINT 'NO EXISTE UN EMPLEADO CON ESE ID'
		END
go

CREATE PROCEDURE sp_get_empleados
as
     SELECT * FROM Empleados
go


/* ******************* PROBEMOS LOS PROCEDIMIENTOS ALMACENADOS Y LA FUNCIONALIDAD DE LOS TRIGGER Y EL USO DE LAS AUDITORIAS *********************    */

/**** CREAMOS DOS EMPLEADO ****/
EXEC sp_insert_empleados 'Fernando', 'Flores', '88250074', '001-280302-1003C'
EXEC sp_insert_empleados 'ingeniero fernando', 'mendoza', '77897645', '004-098755-5003C'

/**** ACTUALIZAMOS EL EMPLEADO CON EL ID 1 ****/
EXEC sp_update_empleados 1, 'chicas...', 'chicas...actualizadas', '88888888', '000-000000-0000r'

/**** ELIMINAMOS EL EMPLEADO CON EL ID 1 ****/
EXEC sp_delete_empleados 1

/**** VISUALIZAMOS LOS EMPLEADOS ****/
EXEC sp_get_empleados



/*************** AUDITORIAS ****************************/
select * from Auditoria_Empleados