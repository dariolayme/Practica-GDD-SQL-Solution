/*
Realizar una consulta que muestre código de producto, nombre de producto y el stock
total, sin importar en que deposito se encuentre, los datos deben ser ordenados por
nombre del artículo de menor a mayor.
*/

USE GESTION2021

SELECT *
FROM Producto JOIN STOCK
on prod_codigo = stoc_producto
WHERE prod_codigo = '00010167' --and stoc_cantidad < 0


SELECT prod_codigo, prod_detalle, sum(CASE WHEN stoc_cantidad < 0 THEN 0 ELSE stoc_cantidad END) --xq se tienen stocks negativos
FROM Producto JOIN STOCK
on prod_codigo = stoc_producto
group by prod_codigo, prod_detalle
order by sum(CASE WHEN stoc_cantidad < 0 THEN 0 ELSE stoc_cantidad END) 
--having prod_codigo= '00010167'
