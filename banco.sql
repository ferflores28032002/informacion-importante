
IF DB_ID ('BANCO') IS NOT NULL
BEGIN
   USE MASTER
   DROP DATABASE BANCO
END
GO

/**** Creamos la base de datos y la usamos para ejecutar consultas
	sobre ella y no la master ****/

CREATE DATABASE BANCO
GO

USE BANCO
GO


/**** Creamos las tablas de la base de datos ****/

CREATE TABLE MONEDA(
	IdMoneda INT PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(60) NOT NULL,
);

CREATE TABLE CLIENTE(
	IdCliente INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	FechaNacimiento DATE,
	Direccion VARCHAR(255) NOT NULL,
);

CREATE TABLE CUENTA (
	NoCuenta VARCHAR(50) PRIMARY KEY,
	IdCliente INT NOT NULL,
	IdMoneda INT NOT NULL,
	FechaCreaciond DATETIME DEFAULT GETDATE(),
	SaldoActual BIGINT NOT NULL,
	FOREIGN KEY (IdCliente) REFERENCES CLIENTE(IdCliente), 
	FOREIGN KEY (IdMoneda) REFERENCES MONEDA(IdMoneda),
);


CREATE TABLE TIPO_MOVIMIENTO(
	IdTipoMovimiento INT PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(60) NOT NULL,
) 
CREATE TABLE MOVIMIENTO (
	IdMovimiento INT PRIMARY KEY IDENTITY(1,1),
	IdTipoMovimiento INT,
	NoCuentaOrigen VARCHAR(50) ,
	NoCuentaDestino VARCHAR(50),
	Monto MONEY NOT NULL,
	FechaHoraMovimiento DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (IdTipoMovimiento) REFERENCES TIPO_MOVIMIENTO(IdTipoMovimiento),
	FOREIGN KEY (NoCuentaOrigen) REFERENCES CUENTA(NoCuenta) ,
	FOREIGN KEY (NoCuentaDestino) REFERENCES CUENTA(NoCuenta) 
);


/******************* TABLA PARA EL MANEJO DE ERRORES *************************/

CREATE TABLE AtrapaErrores (
	ERRORID INT IDENTITY,
	ERRORNUMBER INT,
	ERRORMESSAGE VARCHAR(255),
	ERRORLINE INT,
	ERRORPROCEDURE VARCHAR(100),
	DATETIMEERROR SMALLDATETIME,
	DBNAME VARCHAR(75)
);

/*********************************************************************************/


/****  SP (Procedimientos Almacenados, INNER JOIN para las tablas)  ****/


/**** sp (Mostrar registros de la tabla moneda) ****/

IF OBJECT_ID('sp_mostrar_registros_moneda') IS NOT NULL
BEGIN 
	DROP PROC sp_mostrar_registros_moneda 
END
GO
CREATE PROCEDURE sp_mostrar_registros_moneda AS
	SELECT * FROM MONEDA 
GO


/**** sp (Insertar datos en la tabla moneda) ****/

IF OBJECT_ID('sp_insertar_moneda') IS NOT NULL
BEGIN
	DROP PROC sp_insertar_moneda
END
GO
CREATE PROCEDURE sp_insertar_moneda
	@Descripcion VARCHAR(50)
AS
	BEGIN TRY
		INSERT INTO MONEDA (Descripcion) VALUES (@Descripcion)
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


EXEC sp_insertar_moneda @Descripcion = 'Cordoba'
EXEC sp_insertar_moneda @Descripcion = 'Dolar'


/**** sp (Actualizar datos en la tabla moneda) ****/

IF OBJECT_ID('sp_update_moneda') IS NOT NULL
BEGIN
	DROP PROC sp_update_moneda
END
GO
CREATE PROCEDURE sp_update_moneda
	@Descripcion VARCHAR(50),
	@IdMoneda INT
AS
	BEGIN TRY
		UPDATE MONEDA SET Descripcion=@Descripcion WHERE IdMoneda = @IdMoneda
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

---EXEC sp_update_moneda @Descripcion = 'Cordoba', @IdMoneda = 1



/**** sp (Eliminar columnas de la tabla monedas) ****/

IF OBJECT_ID('sp_delete_moneda') IS NOT NULL
BEGIN
	DROP PROC sp_delete_moneda
END
GO
CREATE PROCEDURE sp_delete_moneda
	@IdMoneda INT
AS	
	BEGIN TRY
		DELETE MONEDA WHERE IdMoneda = @IdMoneda
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

---EXEC sp_delete_moneda @IdMoneda = 2



/**** sp (Mostrar registros de la tabla clientes) ****/

IF OBJECT_ID('sp_mostrar_registros_clientes') IS NOT NULL
BEGIN DROP PROC sp_mostrar_registros_clientes END
GO
CREATE PROCEDURE sp_mostrar_registros_clientes AS
	SELECT * FROM CLIENTE 
GO


/**** sp (insertar registros en la tabla clientes) ****/


IF OBJECT_ID('sp_insertar_clientes') IS NOT NULL
BEGIN
	DROP PROC sp_insertar_clientes
END
GO
CREATE PROCEDURE sp_insertar_clientes
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@FechaNacimiento DATE,
	@Direccion VARCHAR(255)
AS	
	BEGIN TRY
		INSERT INTO CLIENTE(Nombre, Apellido, FechaNacimiento, Direccion) 
			VALUES (@Nombre,@Apellido, @FechaNacimiento, @Direccion)
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

EXEC sp_insertar_clientes 'fernando','jose', '2002-05-07', 'Del Pharaos tres al este'
EXEC sp_insertar_clientes 'jose','mendoza', '2002-04-08', 'Del la punta de plancha tres arriba'

/****  sp (Modificar datos de la tabla clientes) ****/

IF OBJECT_ID('sp_update_clientes') IS NOT NULL
BEGIN
	DROP PROC sp_update_clientes
END
GO
CREATE PROCEDURE sp_update_clientes
	@IdCliente INT,
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@FechaNacimiento DATE,
	@Direccion VARCHAR(255)
AS	
	BEGIN TRY
	UPDATE CLIENTE SET Nombre=@Nombre, Apellido=@Apellido, FechaNacimiento=@FechaNacimiento
						,Direccion=@Direccion WHERE IdCliente = @IdCliente
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


/**** sp (Eliminar columnas de la tabla clientes) ****/

IF OBJECT_ID('sp_delete_clientes') IS NOT NULL
BEGIN
	DROP PROC sp_delete_clientes
END
GO
CREATE PROCEDURE sp_delete_clientes
	@IdCliente INT
AS
	BEGIN TRY
		DELETE CLIENTE WHERE IdCliente = @IdCliente
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

---EXEC sp_delete_clientes @IdCliente = 2


/**** sp (Mostrar registros de la tabla Cuenta) ****/

IF OBJECT_ID('sp_mostrar_registros_cuenta') IS NOT NULL
BEGIN DROP PROC sp_mostrar_registros_cuenta END
GO
CREATE PROCEDURE sp_mostrar_registros_cuenta AS
	SELECT * FROM CUENTA
GO



/**** sp (insertar registros en la tabla cuenta) ****/

IF OBJECT_ID('sp_insertar_cuenta') IS NOT NULL
BEGIN
	DROP PROC sp_insertar_cuenta
END
GO
CREATE PROCEDURE sp_insertar_cuenta
	@NoCuenta VARCHAR(50),
	@IdCliente INT,
	@IdMoneda INT,
	@SaldoActual BIGINT
AS	
	BEGIN TRY
		INSERT INTO CUENTA(NoCuenta,IdCliente, IdMoneda, SaldoActual) 
			VALUES (@NoCuenta,@IdCliente, @IdMoneda, @SaldoActual)
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

EXEC sp_insertar_cuenta @NoCuenta = '000-000-345-678YS',@IdCliente = 1, @IdMoneda = 1, 
						@SaldoActual = 10000.56
EXEC sp_insertar_cuenta @NoCuenta = '000-000-345-1010A',@IdCliente = 2, @IdMoneda = 1, 
						@SaldoActual = 5000

/****  sp (actualizar datos de la cuenta de un cliente) ****/

IF OBJECT_ID('sp_update_cuenta') IS NOT NULL
BEGIN
	DROP PROC sp_update_cuenta
END
GO
CREATE PROCEDURE sp_update_cuenta
	@NoCuenta VARCHAR(50),
	@IdCliente INT,
	@IdMoneda INT,
	@SaldoActual BIGINT
AS
	BEGIN TRY
		UPDATE CUENTA SET IdCliente=@IdCliente, IdMoneda=@IdMoneda, SaldoActual=@SaldoActual
					WHERE NoCuenta=@NoCuenta
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

EXEC sp_update_cuenta @NoCuenta = '000-000-345-678YS',@IdCliente = 1, @IdMoneda = 1, 
						@SaldoActual = 5000.56


/**** sp (Eliminar columnas de la tabla cuentas) ****/

IF OBJECT_ID('sp_delete_cuenta') IS NOT NULL
BEGIN
	DROP PROC sp_delete_cuenta
END
GO
CREATE PROCEDURE sp_delete_cuenta
	@NoCuenta VARCHAR(50)
AS
	BEGIN TRY
		DELETE CUENTA WHERE NoCuenta = @NoCuenta
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


---EXEC sp_delete_cuenta @NoCuenta = '000-000-345-678YS'


/**** sp (mostrar datos de la tabla tipo-movimiento) ****/

IF OBJECT_ID('sp_mostrar_registros_movimiento') IS NOT NULL
BEGIN DROP PROC sp_mostrar_registros_movimiento END
GO
CREATE PROCEDURE sp_mostrar_registros_movimiento AS
	SELECT * FROM TIPO_MOVIMIENTO
GO


/**** sp (Insertar datos en la tabla Movimiento) ****/

IF OBJECT_ID('sp_insertar_movimiento') IS NOT NULL
BEGIN
	DROP PROC sp_insertar_movimiento
END
GO
CREATE PROCEDURE sp_insertar_movimiento
	@Descripcion VARCHAR(50)
AS
	BEGIN TRY
		INSERT INTO TIPO_MOVIMIENTO(Descripcion) VALUES (@Descripcion)
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

EXEC sp_insertar_movimiento @Descripcion = 'Deposito'
EXEC sp_insertar_movimiento @Descripcion = 'Retiro'
EXEC sp_insertar_movimiento @Descripcion = 'Transferencia'


/**** sp (Actualizar datos en la tabla tipo-movimiento) ****/

IF OBJECT_ID('sp_update_tipoMovimiento') IS NOT NULL
BEGIN
	DROP PROC sp_update_tipoMovimiento
END
GO
CREATE PROCEDURE sp_update_tipoMovimiento
	@Descripcion VARCHAR(50),
	@IdTipoMovimiento INT
AS
	BEGIN TRY
		UPDATE TIPO_MOVIMIENTO SET Descripcion=@Descripcion WHERE IdTipoMovimiento = @IdTipoMovimiento
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

---EXEC sp_update_tipoMovimiento @Descripcion = 'reestablecer NoCuenta', @IdTipoMovimiento = 1



/**** sp (Eliminar columnas de la tabla tipo-movimiento) ****/

IF OBJECT_ID('sp_delete_tipoMovimiento') IS NOT NULL
BEGIN
	DROP PROC sp_delete_tipoMovimiento
END
GO
CREATE PROCEDURE sp_delete_tipoMovimiento
	@IdTipoMovimiento INT
AS
	BEGIN TRY
		DELETE TIPO_MOVIMIENTO WHERE IdTipoMovimiento = @IdTipoMovimiento
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO

---EXEC sp_delete_tipoMovimiento @IdTipoMovimiento = 1




/**** sp (insertar un movimiento) ****/

IF OBJECT_ID('sp_mostrar_registros_movimientos') IS NOT NULL
BEGIN DROP PROC sp_mostrar_registros_movimientos END
GO
CREATE PROCEDURE sp_mostrar_registros_movimientos AS
	SELECT * FROM MOVIMIENTO
GO


/**** sp (Depositar dinero ala cuenta) ****/

IF OBJECT_ID('sp_depositar') IS NOT NULL
BEGIN
	DROP PROC sp_depositar
END
GO
CREATE PROCEDURE sp_depositar
	@IdTipoMovimiento INT,
	@NoCuentaOrigen VARCHAR(50),
	@Monto MONEY
AS
	BEGIN TRY
		INSERT INTO MOVIMIENTO(IdTipoMovimiento, NoCuentaOrigen, Monto)
				VALUES (@IdTipoMovimiento,@NoCuentaOrigen, @Monto)
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
	UPDATE CUENTA SET SaldoActual=(SaldoActual+@Monto) WHERE NoCuenta = @NoCuentaOrigen
GO



/**** sp (Retirar dinero de una cuenta) ****/

IF OBJECT_ID('sp_retirar') IS NOT NULL
BEGIN
	DROP PROC sp_retirar
END
GO
CREATE PROCEDURE sp_retirar
	@IdTipoMovimiento INT,
	@NoCuentaOrigen VARCHAR(50),
	@Monto MONEY
AS
	BEGIN TRY
		INSERT INTO MOVIMIENTO(IdTipoMovimiento, NoCuentaOrigen, Monto)
				VALUES (@IdTipoMovimiento,@NoCuentaOrigen, @Monto)

		UPDATE CUENTA SET SaldoActual=(SaldoActual-@Monto) WHERE NoCuenta = @NoCuentaOrigen
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


/************** Unimos la tabla MOVIMIENTO y TIPO-MOVIMIENTO ***************************/

IF OBJECT_ID('sp_movimientos_a_mas_detalles') IS NOT NULL
BEGIN
	DROP PROC sp_movimientos_a_mas_detalles 
END
GO
CREATE PROCEDURE sp_movimientos_a_mas_detalles 
AS
	BEGIN TRY
		SELECT  C.Descripcion, p.NoCuentaOrigen,p.NoCuentaDestino, p.Monto, p.FechaHoraMovimiento
		from MOVIMIENTO p INNER JOIN TIPO_MOVIMIENTO c
		on p.IdTipoMovimiento=c.IdTipoMovimiento
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


/********** Unimos la tabla CLIENTE, CUENTA y MONEDA ***************************/

IF OBJECT_ID('sp_detalles_cuenta') IS NOT NULL
BEGIN
	DROP PROC sp_detalles_cuenta 
END
GO
CREATE PROCEDURE sp_detalles_cuenta 
AS
	BEGIN TRY
		SELECT  cli.Nombre AS 'Cliente', cuen.NoCuenta,cuen.FechaCreaciond,cuen.SaldoActual, mon.Descripcion AS 'Tipo de Moneda'
		FROM CLIENTE cli INNER JOIN CUENTA cuen
		ON cli.IdCliente=cuen.IdCliente
		INNER JOIN MONEDA mon ON
		cuen.IdMoneda = mon.IdMoneda
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO


/**********************************************************************/


IF OBJECT_ID('sp_transferir') IS NOT NULL
BEGIN
	DROP PROC sp_transferir
END
GO
CREATE PROCEDURE sp_transferir
	@IdTipoMovimiento INT,
	@NoCuentaOrigen VARCHAR(50),
	@NoCuentaDestino VARCHAR(50),
	@Monto MONEY
AS
	BEGIN TRY
		INSERT INTO MOVIMIENTO(IdTipoMovimiento, NoCuentaOrigen, Monto, NoCuentaDestino)
				VALUES (@IdTipoMovimiento,@NoCuentaOrigen, @Monto, @NoCuentaDestino)

		UPDATE CUENTA SET SaldoActual=(SaldoActual + @Monto) WHERE NoCuenta = @NoCuentaDestino 
	END TRY
	BEGIN CATCH
		INSERT INTO AtrapaErrores(ERRORNUMBER, ERRORMESSAGE, ERRORLINE, ERRORPROCEDURE, DATETIMEERROR, DBNAME)
			SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(),ERROR_PROCEDURE(), GETDATE(), DB_NAME()
	END CATCH
GO



/******************************************************/

EXEC sp_mostrar_registros_moneda
EXEC sp_mostrar_registros_clientes
EXEC sp_mostrar_registros_movimiento

/****************** MOVIMIENTOS ***************************/

EXEC sp_detalles_cuenta

EXEC sp_depositar @IdTipoMovimiento = 1, @NoCuentaOrigen = '000-000-345-678YS',
	@Monto = 6000

EXEC sp_detalles_cuenta

EXEC sp_retirar @IdTipoMovimiento = 2, @NoCuentaOrigen = '000-000-345-678YS',
	@Monto = 2000

EXEC sp_transferir @Monto = 1200, @NoCuentaOrigen = '000-000-345-678YS',
			@NoCuentaDestino ='000-000-345-1010A', @IdTipoMovimiento = 3

/**********************************************/


EXEC sp_detalles_cuenta


/****** Mostramos a detalles todos los movimientos ********************/

EXEC sp_movimientos_a_mas_detalles


/**************************************************************************/

SELECT * FROM AtrapaErrores


/************ FIN DEL PROYECTO *******************************************/
