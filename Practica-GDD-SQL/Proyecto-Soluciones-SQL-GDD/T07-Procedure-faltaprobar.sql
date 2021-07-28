/*
7. Hacer un procedimiento que dadas dos fechas complete la tabla Ventas. Debe
insertar una línea por cada artículo con los movimientos de stock generados por
las ventas entre esas fechas. La tabla se encuentra creada y vacía.
*/

SELECT * from STOCK
order by stoc_producto, stoc_deposito

CREATE TABLE Ventas
(
	vent_producto int IDENTITY(1,1)  NOT NULL,
	vent_detalle varchar(50) NULL,
	vent_cantidadMovimientos varchar(50) NOT NULL,
	bi_sucu_telefono decimal(18, 0) NULL,
	bi_sucu_ciudad varchar(50) NULL
);


CREATE Procedure procedure05(@fechaInicio date, @fechaFin date)
as
BEGIN
	/*
	Códigodelarticulo
	Detalledelarticulo
	Cantidad de movimientos de ventas (Itemfactura)		(count de item factura)
	Preciopromedio deventa		sum(precio)/(count de item factura) --> AVG
	Nro. de línea dela tabla	identity
	Precio de Venta– Cantidad *Costo Actual (sum(item_precio) - SUM(canitadad * costo actual producto))
	*/
	declare @item_producto char(8),
	declare @prod_detalle char(50),
	declare @cant_movimientos int,
	declare @precio_promedio_venta decimal(12,2),
	declare @ganancia decimal(12,2)

	declare cursor_factura CURSOR FOR

	select item_producto, prod_detalle, COUNT(item_producto), AVG(item_precio), SUM(item_cantidad*item_precio) - SUM(item_cantidad*prod_precio) from  Factura
	JOIN Item_Factura
	on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
	JOIN Producto
	on item_producto = prod_codigo
	where fact_fecha > @fechaInicio AND fact_fecha < @fechaFin
	group by item_producto, prod_detalle
	order by item_producto

	OPEN cursor_factura
	FETCH NEXT FROM cursor_factura INTO @item_producto,@prod_detalle,@cant_movimientos,@precio_promedio_venta@fact_sucursal,@fact_numero

	while @@FETCH_STATUS = 0
	BEGIN
		insert into Ventas(vent_producto, vent_detalle, vent_cantidadMovimientos, vent_precioPromedioVenta, vent_ganancia)
		VALUE (@item_producto,@prod_detalle,@cant_movimientos,@precio_promedio_venta@fact_sucursal,@fact_numero)
			
		FETCH NEXT FROM cursor_factura INTO @item_producto,@prod_detalle,@cant_movimientos,@precio_promedio_venta@fact_sucursal,@fact_numero

	END


END

SELECT * from Item_Factura