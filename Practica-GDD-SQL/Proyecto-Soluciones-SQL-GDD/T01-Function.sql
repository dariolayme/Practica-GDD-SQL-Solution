/*
1. Hacer una funci�n que dado un 
--art�culo 
--y un deposito devuelva 

un string que indique el 
-----estado del dep�sito seg�n el art�culo. 

Si la cantidad almacenada es menor al l�mite 
retornar �OCUPACION DEL DEPOSITO XX %� siendo XX el % de ocupaci�n. 

Si la cantidad almacenada es mayor o igual al l�mite 
retornar �DEPOSITO COMPLETO�.
*/

ALTER FUNCTION funcion01 (@cod_producto char(8),  @cod_deposito char(2))
RETURNS varchar(60)
AS
BEGIN
	DECLARE @cantidadEnDeposito decimal(12,2)
	DECLARE @cantidadMax decimal(12,2)
	DECLARE @RESULTADO varchar(60)

	SELECT @cantidadEnDeposito = stoc_cantidad, @cantidadMax = isnull(stoc_stock_maximo,stoc_cantidad)
	FROM STOCK 
	where stoc_producto = @cod_producto AND stoc_deposito = @cod_deposito
	
	IF(@cantidadEnDeposito < @cantidadMax)
	BEGIN
		DECLARE @porcentaje_ocupacion decimal(12,2)

		SET @porcentaje_ocupacion = 100 * @cantidadEnDeposito / @cantidadMax

		SET @RESULTADO = 'OCUPACION DEL DEPOSITO' + STR(@cantidadEnDeposito, 12,2) + ' ' + STR(@porcentaje_ocupacion, 12,2) + '%'
		
	END
	ELSE
		SET @RESULTADO = 'DEPOSITO COMPLETO'

	RETURN @RESULTADO 
	
END
/*
select stoc_producto, stoc_deposito, dbo.funcion01(stoc_producto,stoc_deposito), stoc_cantidad, stoc_stock_maximo
FROM STOCK
*/