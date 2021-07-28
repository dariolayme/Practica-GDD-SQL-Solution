--Realizar una consulta que muestre c�digo de art�culo, detalle y cantidad de egresos de
--stock que se realizaron para ese art�culo en el a�o 2012 (egresan los productos que
--fueron vendidos). Mostrar solo aquellos que hayan tenido m�s egresos que en el 2011.


select prod_codigo, prod_detalle, sum(item_cantidad) from Producto join Item_Factura on prod_codigo = item_producto join Factura 
on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
where year(fact_fecha) = '2012'
group by prod_codigo, prod_detalle
having sum(item_cantidad) > (select sum(item_cantidad) from Item_Factura 
							join Factura 
							on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
							where year(fact_fecha) = '2011' and item_producto = prod_codigo
							group by item_producto)
							order by prod_codigo