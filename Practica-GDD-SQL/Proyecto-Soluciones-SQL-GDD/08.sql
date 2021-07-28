/*8. Mostrar para el o los art�culos que tengan stock en todos los dep�sitos, 
- nombre del art�culo
- stock del dep�sito que m�s stock tiene.*/
USE GESTION2021
go
--Muestra los productos que tienen stock en todos los depositos.
SELECT prod_detalle,MAX(stoc_cantidad) FROM Producto
JOIN Stock
ON prod_codigo = stoc_producto
GROUP BY prod_detalle
HAVING COUNT(stoc_deposito) = (SELECT COUNT(*) FROM DEPOSITO)
order by COUNT(stoc_deposito)

--SELECT * FROM DEPOSITO

---Muestra los productos que tienen stock en todos los depositos donde esta presente.
SELECT prod_detalle,MAX(stoc_cantidad),MIN(stoc_cantidad) FROM Producto
JOIN Stock
ON prod_codigo = stoc_producto
GROUP BY prod_detalle
HAVING MIN(stoc_cantidad) > 0
order by prod_detalle

SELECT * FROM Producto
JOIN Stock
ON prod_codigo = stoc_producto
order by prod_detalle