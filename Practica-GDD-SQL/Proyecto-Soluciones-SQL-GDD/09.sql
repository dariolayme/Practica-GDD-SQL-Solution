/*9. Mostrar el 
-código del jefe
-código del empleado que lo tiene como jefe
-nombre del mismo 
-la cantidad de depósitos que ambos tienen asignados.*/

SELECT 
E.empl_jefe, E.empl_codigo, E.empl_nombre, COUNT(*)
FROM Empleado E
left join Empleado J
ON E.empl_codigo = J.empl_jefe 
JOIN DEPOSITO
ON E.empl_codigo = depo_encargado
GROUP by E.empl_jefe, E.empl_codigo, E.empl_nombre
--Order by E.empl_jefe

SELECT * FROM Empleado
JOIN DEPOSITO
ON empl_codigo = depo_encargado
ORDER BY empl_jefe
