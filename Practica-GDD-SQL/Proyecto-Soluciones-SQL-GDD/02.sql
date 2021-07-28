/*
Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por
cantidad vendida.
*/

--USE GESTION2021
/*
	SELECT prod_codigo, prod_detalle, COUNT(*) as Cantidad_Vendida
	FROM Producto JOIN Item_Factura
	ON prod_codigo = item_producto
	JOIN Factura
	ON item_numero = fact_numero AND DATEPART(YYYY, fact_fecha) = '2012'
	group by prod_codigo, prod_detalle
	Order by COUNT(*) desc
*/
USE GESTION2021

SELECT prod_codigo, prod_detalle, SUM(item_cantidad) as Cantidad_Vendida
FROM Producto JOIN Item_Factura
ON prod_codigo = item_producto
JOIN Factura
ON fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
where year(fact_fecha) = 2012
group by prod_codigo, prod_detalle
Order by SUM(item_cantidad) desc