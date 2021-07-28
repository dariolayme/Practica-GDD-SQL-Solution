/*
Implementar el/los objetos necesarios para controlar que la máxima cantidad de empleados por DEPARTAMENTO sea 60.

Nota: Considerar que los datos actuales cumplen dicha restricción.
*/

CREATE TRIGGER DL_Control_Max_Capacidad_Empleados ON Empleado FOR insert
AS
BEGIN
	declare @departamento numeric(6)
	declare cursor_Depto cursor for 

		SELECT empl_departamento from inserted

	open cursor_Depto
	
	fetch next from cursor_Depto into @departamento
	while @@FETCH_STATUS = 0
	begin
		if (
			select count(*) from Empleado
			where empl_departamento = @departamento
			group by (empl_departamento)
			) > 60
		begin
			raiserror('Supera el limite de 60 empleados por Departamento',1,1)
			rollback
		end
	end
close cursor_Depto
deallocate cursor_Depto
END



