/*
Realizar un procedimiento que complete la tabla Diferencias de precios, para los
productos facturados que tengan composición y en los cuales el precio de
facturación sea diferente al precio del cálculo de los precios unitarios por
cantidad de sus componentes, se aclara que un producto que compone a otro,
también puede estar compuesto por otros y así sucesivamente, la tabla se debe
crear y está formada por las siguientes columnas:
*/

ALTER FUNCTION Function03_obtenerPrecioComponente(@cod_producto char(8))
RETURNs decimal(12,2)
as
BEGIN
	
	declare @costo decimal(12,2)

		IF @cod_producto not in (SELECT comp_producto from Composicion)
		BEGIN 
			SET @costo = (SELECT ISNULL(prod_precio,0) FROM Producto where @cod_producto = prod_codigo)
			RETURN @costo
		END;

	DECLARE @componente char(8)
	DECLARE @cantidad decimal(12,2)

	SET @costo = 0;

		DECLARE cursor_producto_composicion CURSOR FOR

			SELECT comp_componente, comp_cantidad
			from Composicion 
			where comp_producto = @cod_producto

		OPEN cursor_producto_composicion
		FETCH NEXT FROM cursor_producto_composicion INTO @componente, @cantidad

		WHILE @@FETCH_STATUS = 0
		BEGIN 
			SET @costo = @costo + (dbo.Function03_obtenerPrecioComponente(@componente) * @cantidad)
			FETCH NEXT FROM cursor_producto_composicion INTO @componente, @cantidad
		END

		CLOSE cursor_producto_composicion
		DEALLOCATE cursor_producto_composicion

		RETURN @costo
			
END

CREATE FUNCTION Function03_obtenerPrecioComponenteBIS(@cod_producto char(8))
RETURNs decimal(12,2)
as
BEGIN
	
	declare @costo decimal(12,2)

		IF @cod_producto not in (SELECT comp_producto from Composicion)
		BEGIN 
			SET @costo = (SELECT ISNULL(prod_precio,0) FROM Producto where @cod_producto = prod_codigo)
			RETURN @costo
		END;

	DECLARE @componente char(8)
	DECLARE @cantidad decimal(12,2)

	SET @costo = 0;

		SET @costo = @costo + (	SELECT SUM(comp_cantidad* dbo.Function03_obtenerPrecioComponenteBIS(comp_componente)) FROM Composicion
								JOIN Producto
								on comp_componente = prod_codigo

								WHERE comp_producto = @cod_producto)
			/*
			SELECT * FROM Composicion
			JOIN Producto
			on comp_componente = prod_codigo

			WHERE comp_producto = '00006411'
		*/

		RETURN @costo
			
END
/*
SELECT prod_codigo, prod_detalle, dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo) FROM Producto
where prod_codigo = '00006411' 7.32

SELECT prod_codigo, prod_detalle, dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo) FROM Producto
where prod_codigo = '00006404' 78.70

  86.02
00006402

SELECT comp_componente, comp_cantidad
			from Composicion 
			where comp_producto = '00006402'
*/

CREATE TABLE Diferencias(
	dif_codigo char(8) NOT NULL,
	dif_detalle char(55),
	dif_cantidad decimal(12,2),
	dif_precio_generado decimal(12,2),
	dif_precio_facturado decimal(12,2)
)

CREATE PROC cargarTablaDiferencias
as
BEGIN
	
	SELECT item_precio,prod_precio,dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo), prod_detalle, count(*) FROM Producto
	JOIN Item_Factura
	ON prod_codigo = item_producto
	
	group by item_precio,prod_precio,dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo), prod_detalle

END

