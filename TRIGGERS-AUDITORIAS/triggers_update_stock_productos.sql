


IF DB_ID ('triggers_update_stock') IS NOT NULL
BEGIN USE MASTER DROP DATABASE triggers_update_stock END

/* luego la secuencia sigue y creamos la base de datos */

CREATE DATABASE triggers_update_stock
GO

--Usamos la base de datos creada
USE triggers_update_stock
GO



CREATE TABLE Productos(
   Id_Producto INT PRIMARY KEY IDENTITY(1,1),
   Codigo_producto VARCHAR(10) CHECK(Codigo_producto LIKE '[A-Z][A-Z]-[0-9][0-9]') NOT NULL, ---APLICAMOS UNA VALIDACION DE CODIGO A CADA PRODUCTO EJEMPLO (FF-34)
   Nombre_Producto VARCHAR(50) not null UNIQUE,
   Stock_Cantidad INT not null,  --EL STOCK ES LA CANTIDAD DE PRODUCTOS QUE HAY ALA VENTA
   Fecha_De_Registro DATETIME DEFAULT GETDATE() not null,
   CONSTRAINT [El valor del stock debe ser mayor a 0] CHECK(Stock_Cantidad>=0),
);

-----------------------------------------------------------------------------------

--TABLA VENTAS

CREATE TABLE Ventas(
   Id_Venta INT PRIMARY KEY IDENTITY(1,1),
   Fecha_Venta DATETIME DEFAULT GETDATE() not null,
   Monto_Total DECIMAL(10,2) not null,
   Id_Producto INT,
   Cantidad_producto INT,
   CONSTRAINT ['EL MONTO TOTAL DEBE SER MAYOR A 0'] CHECK(Monto_Total>0),
   FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto)
);
Go


/********* APLICAREMOS UN TRIGGERS QUE ACTUALICE EL STOCK DEL PRODUCTO QUE SE VENDIO Y LO DISMINUYA *****************************/

 CREATE TRIGGER tr_modificar_monto_total_venta
 ON Ventas
 FOR INSERT	
AS	
	--OBTENEMOS EL ID DEL PRODUCTO QUE SE VENDIO DESDE LA TABLA VENTAS GRACIAS ALA PROPIEDAD (INSERTED)
	DECLARE @Id_Producto INT = (SELECT Id_Producto FROM inserted) 

	--OBTENEMOS LA Cantidad_producto DEL PRODUCTO QUE SE VENDIO DESDE LA TABLA VENTAS GRACIAS ALA PROPIEDAD (INSERTED)
	DECLARE @Cantidad_producto INT = (SELECT Cantidad_producto FROM inserted)

	--ACTUALIZAMOS EL STOCK DEL PRODUCTO QUE SE VENDIO Y SE LO DISMINUIMOS

	IF(@Cantidad_producto < (SELECT Stock_Cantidad FROM Productos WHERE Id_Producto = @Id_Producto))
	BEGIN
		UPDATE Productos SET Stock_Cantidad = (Stock_Cantidad - @Cantidad_producto) WHERE Id_Producto = @Id_Producto
	END
	ELSE
		BEGIN
		PRINT 'NO PODEMOS HACER LA VENTA, EL PRODUCTO YA NO CONTIENE STOCK SUFICIENTE PARA LA VENTA'
		END
	GO
GO

/* *********** CREAMOS EL PROCEMIENTO ALMACENADO PARA VALIDAR CAMPOS Y VER SI SE HACE LA VENTA O NO ***********/

CREATE PROCEDURE sp_realizar_venta
   @Monto_Total DECIMAL(10,2) ,
   @Id_Producto INT,
   @Cantidad_producto INT
AS
	
	IF(@Cantidad_producto < (SELECT Stock_Cantidad FROM Productos WHERE Id_Producto = @Id_Producto))
	BEGIN	
		INSERT INTO Ventas(Monto_Total,Id_Producto,Cantidad_producto) 
			VALUES (@Monto_Total,@Id_Producto,@Cantidad_producto)
	END
	ELSE
		BEGIN
		PRINT 'NO PODEMOS HACER LA VENTA, EL PRODUCTO YA NO CONTIENE STOCK SUFICIENTE PARA LA VENTA'
		END
	GO

GO

/*************************************************************************************************/


INSERT INTO Productos(Codigo_producto,Nombre_Producto, Stock_Cantidad)	
	VALUES ('GA-12', 'GALLETAS-VAINILLA', 100) --STOCK INICIAL ES 100 Y SE LE DISMINUIRA AUTOMATICAMENTE AL HACER UNA VENTA

/* ***MOSTRAMOS EL PRODUCTO ANTES DE HACER LA VENTA **********/

SELECT * FROM Productos
/***** HACEMOS LA VENTA *******/

EXEC sp_realizar_venta 500,1, 40


/**********************************************************************

	[OJO]: PUEDEN HACER LA PRUEBA DE MARDARLE UN NUMERO MAS ARRIBA DEL STOCK DEL PRODUCTO Y LA VENTA NO SE HARA, EN CONSOLA EN 
	(MESSAGES) SE MOSTRARA EL PRINT QUE MANDE EN LOS PROCEDIMIENTOS ALMACENADOS
							
	EXEC sp_realizar_venta 500,1, 500

**********************************************************************************/

/* ***MOSTRAMOS EL PRODUCTO LUEGO DE HACER LA VENTA **********/

SELECT * FROM Productos
SELECT * FROM Ventas



----NOTA: PUEDEN HACER UNA TABLA DE AUDITORIAS PARA REGISTRAR CADA TRANSACCION QUE SE ESTA HACIENDO