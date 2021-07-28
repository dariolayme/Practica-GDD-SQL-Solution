/*
Se requiere realizar una verificación de los precios de los COMBOS, 
para ello se solicita que cree el o los objetos necesarios para realizar

una operación que establezca que el precio de un producto compuesto (COMBO) 
es el 90% de la suma de los precios de sus componentes por las cantidades que los componen.  

Se debe considerar que un producto compuesto puede estar compuesto por otros productos compuestos.
*/

---producto	laSumaEsEl90%

---Crear una funcion que nos devuelva Treu o False si un producto es el 90% de la suma de sus precios.
---ProductoCombo va a tener un precio menor que la suma de sus partes.

CREATE FUNCTION el_precio_de_la_suma_de_los_producto_es_el_90(@cod_producto char(8))
RETURNS bit
AS
BEGIN
	declare @esEl90 bit

	IF @cod_producto not in (SELECT comp_producto FROM Composicion where comp_producto = @cod_producto)
		SET @esEl90 = 1
	ELSE
		BEGIN
			SET @esEl90 = (SELECT (dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo) - (prod_precio* 0.9) ) From Producto
							where prod_codigo = @cod_producto)
		END

	RETURN @esEl90
END

----------------------------------------------------------------------------------------------
SELECT	prod_codigo, 
		prod_precio,
		dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo) as sumaDeLosPrecios,
		CASE 
			When dbo.el_precio_de_la_suma_de_los_producto_es_el_90(prod_codigo) = 0 then 'SI%'
			Else 'NO' end as laSumaDelosPreciosEs90,
		(100 * prod_precio / (dbo.Function03_obtenerPrecioComponenteBIS(prod_codigo)) )
FROM Producto
where prod_codigo in (SELECT distinct comp_producto from Composicion)
----------------------------------------------------------------------------------------------

JOIN Composicion
ON prod_codigo = comp_producto
where prod_precio != 0
	
select prod_precio FROM Producto 
JOIN Composicion 
ON prod_codigo = comp_producto
where prod_codigo = '00001104'

	123.....100
	23......X
	
	LEFT JOIN Composicion
	ON prod_codigo = comp_componente


declare @esEl90 bit
set @esEl90 = 0
print @esEl90

SELECT prod_precio, COUNT(*) from Producto
group by prod_precio

100 
90
