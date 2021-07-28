--EJ T-SQL

/*
Se requiere realizar una verificación de los precios de los COMBOS, 
para ello se solicita que cree el o los objetos necesarios para realizar una operación que establezca que el precio 
de un producto compuesto (COMBO) es el 90% de la suma de los precios de sus componentes por las cantidades que los componen.  
Se debe considerar que un producto compuesto puede estar compuesto por otros productos compuestos.
*/

-- COMO ACTUALMENTE HAY PRODUCTOS QUE NO CUMPLEN ESTA CONDICIÓN SE REALIZA UN STORED PROCEDURE PARA PODER ACTUALIZAR HACIA ATRAS

/*

DROP FUNCTION PARCIAL_PAESANI_PRECIO_COMPUESTO
DROP PROCEDURE PROC_PAESANI_PARCIAL

*/

CREATE FUNCTION PARCIAL_PAESANI_PRECIO_COMPUESTO(@producto char(8))
RETURNS decimal(12,2)
AS
BEGIN
DECLARE @PRECIO DECIMAL(12,2)
IF @producto NOT IN (SELECT DISTINCT comp_producto FROM COMPOSICION)
		SELECT @PRECIO=prod_precio FROM Producto WHERE prod_codigo=@producto
ELSE
	SET  @PRECIO =
					(
					SELECT SUM(comp_cantidad*dbo.EJ15_GETPRECIO(comp_componente)) 
					FROM Composicion WHERE comp_producto=@producto
					)
RETURN @PRECIO
END


/*
SELECT comp_producto,CONVERT(DECIMAL(12,2),0.9*DBO.PARCIAL_PAESANI_PRECIO_COMPUESTO(comp_producto)) FROM Composicion
GROUP BY comp_producto
*/


GO
CREATE PROCEDURE PROC_PAESANI_PARCIAL
AS
BEGIN
IF	--> ME FIJO SI HAY ALGUN PRODUCTO QUE NO CUMPLA CON LA REGLA PARA APLICARLA (ES LO MISMO QUE TENGA 2 RENGLONES POR COMPUESTO PORQUE BUSCO SI HAY ALGUNO NADA MÁS).
	(
		SELECT COUNT(*) FROM Composicion
		JOIN Producto ON prod_codigo=comp_producto
		WHERE prod_precio != CONVERT(DECIMAL(12,2),0.9*DBO.Function03_obtenerPrecioComponenteBIS(comp_producto))
	) > 0		
	BEGIN
	UPDATE Producto
	SET prod_precio = CONVERT(DECIMAL(12,2),0.9*DBO.PARCIAL_PAESANI_PRECIO_COMPUESTO(prod_codigo))
	WHERE prod_codigo IN
							(
								SELECT comp_producto FROM Composicion
								JOIN Producto ON prod_codigo=comp_producto
								WHERE prod_precio !=  CONVERT(DECIMAL(12,2),0.9*DBO.PARCIAL_PAESANI_PRECIO_COMPUESTO(comp_producto))
								GROUP BY comp_producto
							)
	END
END