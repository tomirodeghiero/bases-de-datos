-- Consultas SQL
-- a) Obtener la cantidad de dosis de vacunas colocadas por cada vacuna existente.
SELECT v.nombre, COUNT(*) as cantidad_dosis
FROM vacunados vd
JOIN vacunas v ON vd.cod_vacuna = v.cod_vacuna
GROUP BY v.nombre;

-- b) Obtener la persona que tiene el máximo número de vacunas colocadas.
SELECT p.nombre, COUNT(*) as cantidad_vacunas
FROM vacunados vd
JOIN personas p ON vd.dni = p.dni
GROUP BY p.dni, p.nombre
ORDER BY cantidad_vacunas DESC
LIMIT 1;

-- c) Obtener la cantidad de vacunas colocadas por cada persona.
SELECT p.nombre, COUNT(*) as cantidad_vacunas
FROM vacunados vd
JOIN personas p ON vd.dni = p.dni
GROUP BY p.dni, p.nombre
ORDER BY p.nombre;