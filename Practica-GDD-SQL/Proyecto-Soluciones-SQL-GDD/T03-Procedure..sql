/*
3. Cree el/los objetos de base de datos necesarios para corregir la tabla empleado en caso que sea necesario. 

Se sabe que debería existir un único gerente general (debería ser el único empleado sin jefe). 

Si detecta que hay más de un empleado sin jefe deberá elegir entre ellos el gerente general, 

el cual será seleccionado por mayor salario. 

Si hay más de uno se seleccionara el de mayor antigüedad en la empresa. 

Al finalizar la ejecución del objeto la tabla deberá cumplir con la regla de un único empleado sin jefe (el gerente general) 
y deberá retornar la cantidad de empleados que había sin jefe antes de la ejecución.
*/

ALTER PROCEDURE procedure01(@cantidadEmpleadosSinJefe int OUTPUT)
as
BEGIN
	declare @cod_gerenteGeneral int

	SELECT @cantidadEmpleadosSinJefe = COUNT(*) from Empleado WHERE  empl_jefe IS NULL
	SELECT TOP 1 @cod_gerenteGeneral = empl_codigo from Empleado where empl_jefe IS NULL 
	order by empl_salario desc, empl_ingreso asc
	update Empleado SET empl_jefe = @cod_gerenteGeneral where empl_jefe Is NULL and empl_codigo != @cod_gerenteGeneral
END

/*
declare @cantidad int

EXECUTE procedure01 @cantidad

print @cantidad

INSERT INTO Empleado (empl_codigo,empl_nombre,empl_salario)
	VALUEs(12,'asdd',3500.00),(13,'assddd',35000.00)

	SELECT *from Empleado
*/