/*
Armar un almacenado que actualice todos los precios donde se vendiö una composiciön y 
la sumatoria de los productos con los componentes, no da el precio unitario de la venta 
realizada. 

Ademas, debera actualizar todas las tablas correspondientes del modelo para 
que quede la lögica consistente. 

La diferencia actualizada, deberä acumularse en una nueva
tabla que aun no existe llamada diferencias, donde se debe registrar cliente, ano, diferencias acumuladas.
*/
--********************************************
actualizar precios de una factura donde 
-se vendio una composicion 
En la que el producto 
-la sum de lo componente != precio del producto combo

Actualizar tablas q correspondan

Detallar las diferencias de las facturas 
--********************************************


select * from Cliente

SELECT * from Factura
105,73-100
18,33-X   -->17,34

SELECT fact_total, fact_total_impuestos, SUM(item_cantidad*item_precio) FROM Item_Factura
JOIN Factura
ON item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero

--where item_tipo = 'A' AND item_sucursal = '0003' AND item_numero = '00068710'
group by fact_total, fact_total_impuestos

SELECT * FROM Item_Factura 
JOIN Producto
on item_producto = prod_codigo
JOIN Factura
ON item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero

where item_producto in (select distinct comp_producto from Composicion)

select distinct comp_producto from Composicion
-----------------------------------------------------------------------------------------------------------------
CURSOR PROCEDURE ActualizarPreciosYTablas
AS
BEGIN

	Declare @num_factura char(8)
	Declare @num_cliente char(6)
	
	Declare cursor_facturas_composicion_dist_sum_compon CURSOR FOR

	SELECT  fact_numero, fact_cliente, item_producto FROM Composicion
	JOIN Item_Factura
	on comp_producto = item_producto
	JOIN Factura
	ON item_tipo+item_sucursal+item_numero = fact_tipo+fact_sucursal+fact_numero
	where dbo.Function03_obtenerPrecioComponenteBIS(item_producto) != item_precio

	open cursor_facturas_composicion_dist_sum_compon
	FETCH NEXT FROM cursor_facturas_composicion_dist_sum_compon INTO @num_factura, @num_cliente

	while @@FETCH_STATUS = 0
	BEGIN
		declare @item_precio_nuevo decimal(12,2)
		declare @item_numero char(8)
		
		declare cursor_items_Factura CURSOR FOR

		SELECT * FROM Item_Factura
		Where item_numero = @num_factura AND item
		SELECT 



	END

SELECT fact_numero, COUNT(*) FROM Factura
JOIN Cliente
on fact_cliente = clie_codigo
group by fact_numero
order by 1

END