/*
9. Crear el/los objetos de base de datos que ante alguna modificaci�n de un �tem de
factura de un art�culo con composici�n realice el movimiento de sus
correspondientes componentes.
*/

CREATE TRIGGER

SELECT * from  Composicion,Producto
where prod_codigo = comp_producto

SELECT 

SELECT * from Producto 
JOIN stock
on prod_codigo = stoc_producto
where prod_codigo = '00001104'

