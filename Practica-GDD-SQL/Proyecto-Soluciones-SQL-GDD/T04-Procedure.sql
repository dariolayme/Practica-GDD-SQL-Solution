/*
4. Cree el/los objetos de base de datos necesarios para 
actualizar la columna de empleado 

empl_comision con la sumatoria del total de lo vendido por ese empleado a lo largo del último año. 

Se deberá retornar el código del vendedor que más vendió (en monto) a lo largo del último año
*/

CREATE PROCEDURE procedure02(@cod_empleadoTop decimal(6,0) output)
AS
BEGIN
	declare @empleado numeric(6,0)
	UPDATE Empleado set empl_comision = (SELECT SUM(fact_total) FROM Factura where fact_vendedor = empl_codigo and YEAR(fact_fecha) = '2012')
	
	SET @cod_empleadoTop = (SELECT top 1 empl_codigo FROM Empleado order by empl_comision)
	
	SET @empleado = (SELECT top 1 empl_codigo FROM Empleado order by empl_comision desc)

	print convert(varchar(6),@empleado)
END

declare @num decimal(6,0)
EXEC procedure03 @num

SELECT * FROM Empleado
order by empl_comision desc

SELECT fact_vendedor, SUM(fact_total) FROM Factura
WHERE YEAR(fact_fecha) = '2012'
group by fact_vendedor
order by SUM(fact_total) desc