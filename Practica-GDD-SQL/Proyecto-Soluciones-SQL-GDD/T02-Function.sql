/*
2. Realizar una función que dado 
-un artículo 
-y una fecha, 

retorne el stock que existía a esa fecha
*/

alteR FUNCTION function02 (@cod_producto char(8), @date date)
RETURNS decimal(12,2)
AS
BEGIN
	DECLARE @TotalVendidos decimal(12,2)
	DECLARE @TotalEnStock decimal(12,2)

	SELECT @TotalEnStock = SUM(stoc_Cantidad) FROM Stock 
	where stoc_producto = @cod_producto

	SELECT @TotalVendidos = SUM(item_cantidad) FROM Item_Factura
	JOIN Factura 
	ON item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero
	WHERE item_producto = @cod_producto AND fact_fecha < @date

	RETURN ISNULL(@TotalVendidos + @TotalEnStock,0)
	   	 
END

--SELECT prod_codigo, dbo.function02(prod_codigo, '2018-01-02') FROM Producto
