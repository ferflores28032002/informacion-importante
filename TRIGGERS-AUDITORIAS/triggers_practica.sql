

IF DB_ID ('triggers_practica') IS NOT NULL
BEGIN USE MASTER DROP DATABASE triggers_practica END

/* luego la secuencia sigue y creamos la base de datos */

CREATE DATABASE triggers_practica
GO

--Usamos la base de datos creada
USE triggers_practica
GO


/* ****************** TRIGGERS ************************************ */

/* **** EJERCICIO, CADA VES QUE ACTUALIZAMOS EL TOTAL DE UN DETALLE DE VENTA, SE ACTUALIZARA EL MONTO TOTAL DE LA VENTA *****/

CREATE TABLE Venta(
	Id_Venta INT PRIMARY KEY IDENTITY(1,1),
	Fecha_Venta DATETIME DEFAULT GETDATE() not null,
	Monto_Total DECIMAL(8,2) not null
);
GO

INSERT INTO Venta (Monto_Total) VALUES (300)
GO

CREATE TABLE Detalle_Venta(
   Id_Detalle_Venta INT PRIMARY KEY IDENTITY(1,1),
   Fecha_Venta DATETIME DEFAULT GETDATE() not null,
   Total DECIMAL(10,2) not null,
   Id_Venta INT,
   descripcion VARCHAR(255) NOT NULL,
   CONSTRAINT ['EL MONTO TOTAL DEBE SER MAYOR A 0'] CHECK(Total>0),
   FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta)
);
GO

INSERT INTO Detalle_Venta (Total, Id_Venta, descripcion)	
	VALUES (100.45, 1, 'Gaseosa'), (785, 1, 'leche'), (100.45, 1, 'Galletas oreo')
GO



 CREATE TRIGGER tr_modificar_monto_total_venta
 ON Detalle_Venta
 FOR UPDATE	
AS	
	DECLARE @Id_Detalle_Venta INT = (SELECT Id_Detalle_Venta FROM inserted)
	UPDATE Venta SET Monto_Total = (SELECT SUM(Total) FROM Detalle_Venta WHERE Id_Venta = @Id_Detalle_Venta)
		WHERE Id_Venta = @Id_Detalle_Venta
GO

UPDATE Detalle_Venta SET Total = 50 WHERE Id_Detalle_Venta = 1

SELECT * FROM Venta
SELECT * FROM Detalle_Venta