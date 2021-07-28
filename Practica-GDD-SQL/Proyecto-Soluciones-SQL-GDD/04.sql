/*
Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de
artículos que lo componen. Mostrar solo aquellos artículos para los cuales el stock
promedio por depósito sea mayor a 100.
*/
use GESTION2021

SELECT  prod_codigo, prod_detalle,   --count( Isnull(comp_producto,1))
FROM Producto LEFT JOIN Composicion
ON comp_producto = prod_codigo
JOIN STOCK
on prod_codigo = stoc_producto
group by prod_codigo, prod_detalle
Having AVG(stoc_cantidad) > 100


SELECT *--prod_codigo, prod_detalle, count( Isnull(comp_producto,1))
FROM Producto LEFT JOIN Composicion
ON comp_producto = prod_codigo
JOIN STOCK
on prod_codigo = stoc_producto
group by prod_codigo
where prod_codigo = '00000302'


SELECT prod_codigo, prod_detalle, AVG(Isnull(comp_cantidad,1))
FROM Producto JOIN STOCK
on prod_codigo = stoc_producto
left JOIN Composicion
ON comp_producto = prod_codigo
group by prod_codigo, prod_detalle
having AVG(stoc_cantidad) > 100

select * from Producto
JOIN STOCK
on prod_codigo = stoc_producto
where stoc_producto = '00001707'

/*
LEFT JOIN STOCK
on prod_codigo = stoc_producto


group by prod_codigo, prod_detalle

having AVG(stoc_cantidad) > 100

JOIN STOCK
on prod_codigo = stoc_producto
group by prod_codigo, prod_detalle

Order by count( Isnull(comp_producto,1)) desc

select distinct(prod_codigo) from Producto
where prod_codigo = '00001475' or prod_codigo = '00001420'

select * from Composicion
where comp_producto = '00001718'

select * from Producto
where prod_codigo = '00000000'
--WHERE prod_codigo = '00001104'

select * FROM Composicion

select * FROM Producto 
join stock
ON prod_codigo = stoc_producto
where prod_codigo = '00001109'

join STOCK
ON prod_codigo = stoc_producto
join DEPOSITO
on stoc_deposito = depo_codigo
WHERE prod_codigo = '00001104' OR prod_codigo = '00001109'

*/

/*
1.00	00001104	00001109
2.00	00001104	00001123
1.00	00001718	00001475
4.00	00001718	00001420
1.00	00001707	00001491
2.00	00001707	00014003
2.00	00006411	00005703
2.00	00006411	00001516
10.00	00006404	00006408
10.00	00006404	00006409
1.00	00006402	00006411
1.00	00006402	00006404
*/