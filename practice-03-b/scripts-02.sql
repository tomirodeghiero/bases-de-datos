-- a) Inserción de datos en la base de datos de Artículos
INSERT INTO articulos (art, descripcion, precio, cantidad, Stock_Min, Stock_Max, Mes_Ult_Movim, Fecha_Vto)
VALUES 
(1, 'Paracetamol 500 mg', 3.50, 100, 20, 200, '2024-05-01', '2025-12-31'),
(2, 'Amoxicilina 250 mg', 5.00, 150, 30, 300, '2024-04-15', '2025-11-30'),
(3, 'Ibuprofeno 400 mg', 4.75, 200, 50, 400, '2024-05-20', '2026-01-15');

-- b) Inserción de datos en la base de datos de vacunas
-- municipios
INSERT INTO municipios (municipio, provincia)
VALUES 
(1, 'Buenos Aires'),
(2, 'Córdoba'),
(3, 'Santa Fe');

-- vacunas
INSERT INTO vacunas (cod_vacuna, nombre)
VALUES 
(101, 'COVID19'),
(102, 'FIEBRE AMARILLA'),
(103, 'DENGUE'),
(104, 'BCG');

-- personas
INSERT INTO personas (dni, nombre, edad, municipio)
VALUES 
(12345678, 'Juan Pérez', 30, 1),
(87654321, 'Laura García', 35, 2),
(45678912, 'Carlos Ruiz', 28, 3);

-- contagios
INSERT INTO contagios (dni, cepa)
VALUES 
(12345678, 'COVID19'),
(87654321, 'DENGUE');

-- vacunados
INSERT INTO vacunados (dni, cod_vacuna)
VALUES 
(12345678, 101),  -- Juan Pérez vacunado contra COVID19
(87654321, 103),  -- Laura García vacunada contra DENGUE
(45678912, 104);  -- Carlos Ruiz vacunado con BCG