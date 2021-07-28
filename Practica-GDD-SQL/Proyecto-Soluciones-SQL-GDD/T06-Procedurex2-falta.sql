/*
6. Realizar un procedimiento que si en alguna factura se facturaron componentes que conforman un combo determinado 
(o sea que juntos componen otro producto de mayor nivel), en cuyo caso deberá reemplazar las filas correspondientes 
a dichos productos por una sola fila con el producto que componen con la cantidad de dicho producto que corresponda.
*/
/*
00001104->00001109
00001104->00001123
00001718->00001475
00001718->00001420
00001707->00001491
00001707->00014003
00006411->00001516
00006411->00005703
00006404->00006408
00006404->00006409
00006402->00006411
00006402->00006404
*/

CREATE PROCEDURE procedure04
AS 
BEGIN
	declare @fact_tipo char(1)
	declare @fact_sucursal char(4)
	declare @fact_numero char(8)

	declare cursor_factura CURSOR for
	--------------------------------------------------------------------------
	SELECT fact_tipo, fact_sucursal, fact_numero from Item_Factura 
	JOIN Factura
	on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
	where fact_numero in (	SELECT fact_numero from Item_Factura 
							JOIN Factura
							on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
							where item_producto in (select comp_componente from Composicion))
	group by fact_tipo, fact_sucursal, fact_numero
	--------------------------------------------------------------------------
	open cursor_factura 
	FETCH NEXT FROM cursor_factura  
	INTO @fact_tipo, @fact_sucursal, @fact_numero

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
	END




END


SELECT * from Item_Factura 
JOIN Factura
on fact_tipo+fact_sucursal+fact_numero = item_tipo+item_sucursal+item_numero
where fact_numero = '00092476'
where item_producto = '00006411' OR item_producto = '00006404'

SELECT * from Factura

SELECT * from Producto C
JOIN Composicion
on prod_codigo = comp_producto
where prod_codigo = '00006402'

select * FROM Producto
WHERE prod_codigo = '00001516' OR prod_codigo = '00005703'