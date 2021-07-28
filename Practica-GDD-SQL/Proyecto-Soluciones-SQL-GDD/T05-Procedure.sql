/*
05. Realizar un procedimiento que complete con los datos existentes en el modelo
provisto la tabla de hechos denominada Fact_table tiene las siguiente definición:
Create table Fact_table
	( 
	anio char(4),
	mes char(2),
	familia char(3),
	rubro char(4),
	zona char(3),
	cliente char(6),
	producto char(8),
	cantidad decimal(12,2),
	monto decimal(12,2)
	)
Alter table Fact_table
Add constraint primary key(anio,mes,familia,rubro,zona,cliente,producto)
*/
USE GESTION2021

ALTER PROCEDURE procedure03
AS
BEGIN

	BEGIN TRY
		Create table Fact_table
			( 
				anio char(4) NOT NULL,
				mes char(2) NOT NULL,
				familia char(3) NOT NULL,
				rubro char(4) NOT NULL,
				--zona char(3),
				cliente char(6) NOT NULL,
				producto char(8) NOT NULL,
				cantidad decimal(12,2),
				monto decimal(12,2)
			)
			ALTER TABLE Fact_table ADD CONSTRAINT PK_PROC_FactTable PRIMARY KEY(anio,mes,familia,rubro,cliente,producto)
			--zona
	END TRY
	BEGIN CATCH
		IF ERROR_NUMBER() = 2714
			PRINT ERROR_message()
		ELSE
			print 'Se ha producido un error inesperado'
	END CATCH
	

	IF (SELECT COUNT(*) FROM Fact_table) > 0
	BEGIN
		PRINT 'YA SE TIENEN REGISTROS EN LA TABLA' 
	END
	ELSE
		BEGIN
			INSERT INTO Fact_table (anio, mes, familia, rubro, cliente, producto, cantidad, monto)
				(SELECT YEAR(fact_fecha), MONTH(fact_fecha), fami_id, rubr_id, fact_cliente, prod_codigo, SUM(item_cantidad), sum(item_cantidad*item_precio)  FROM Factura 
						JOIN Item_Factura
						on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero 
						JOIN Producto
						on item_producto = prod_codigo
						JOIN Envases
						on prod_envase = enva_codigo
						JOIN Rubro 
						on prod_rubro = rubr_id
						JOIN Familia
						on prod_familia = fami_id
						group by  YEAR(fact_fecha), MONTH(fact_fecha),fami_id,rubr_id, fact_cliente, prod_codigo)
		END

END
	

--exec procedure03