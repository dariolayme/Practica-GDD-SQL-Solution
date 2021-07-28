/*
3. Cree el/los objetos de base de datos necesarios para corregir la tabla empleado en caso que sea necesario. 

Se sabe que deber�a existir un �nico gerente general (deber�a ser el �nico empleado sin jefe). 

Si detecta que hay m�s de un empleado sin jefe deber� elegir entre ellos el gerente general, 

el cual ser� seleccionado por mayor salario. 

Si hay m�s de uno se seleccionara el de mayor antig�edad en la empresa. 

Al finalizar la ejecuci�n del objeto la tabla deber� cumplir con la regla de un �nico empleado sin jefe (el gerente general) 
y deber� retornar la cantidad de empleados que hab�a sin jefe antes de la ejecuci�n.
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