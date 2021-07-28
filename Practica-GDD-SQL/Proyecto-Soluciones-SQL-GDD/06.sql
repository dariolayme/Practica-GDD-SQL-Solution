/*Mostrar para todos los rubros de art�culos 
-c�digo
-detalle
-cantidad de art�culos de ese rubro 
-stock total de ese rubro de art�culos. 

Solo tener en cuenta aquellos art�culos que
tengan un stock mayor al del art�culo �00000000� en el dep�sito �00�.*/

USE GESTION2021

SELECT
rubr_id, rubr_detalle, COUNT(distinct prod_codigo), sum(stoc_cantidad)
FROM Rubro
JOIN Producto
ON prod_rubro = rubr_id
JOIN STOCK
ON prod_codigo = stoc_producto
WHERE (SELECT SUM(stoc_cantidad) FROM STOCK WHERE prod_codigo = stoc_producto) > (
						SELECT stoc_cantidad FROM STOCK
						WHERE stoc_producto = '00000000' AND stoc_deposito = '00'
						)
group by rubr_id, rubr_detalle


/*Rubros de composicion*/
--0012 0011
/*
00001104
00001718
00001707
00006411
00006404
00006402
*/