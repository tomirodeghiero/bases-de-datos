-- a) Base de datos sobre VACUNAS con MySQL
-- Creación de las tablas
CREATE TABLE municipios (
    municipio INT UNSIGNED PRIMARY KEY,
    provincia VARCHAR(45)
);

CREATE TABLE vacunas (
    cod_vacuna INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(45)
);

CREATE TABLE personas (
    dni INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(45),
    edad INT UNSIGNED CHECK (edad >= 21),
    municipio INT UNSIGNED,
    FOREIGN KEY (municipio) REFERENCES municipios(municipio)
);

CREATE TABLE contagios (
    dni INT UNSIGNED,
    cepa VARCHAR(45),
    PRIMARY KEY (dni, cepa),
    FOREIGN KEY (dni) REFERENCES personas(dni)
);

CREATE TABLE vacunados (
    dni INT UNSIGNED,
    cod_vacuna INT UNSIGNED,
    PRIMARY KEY (dni, cod_vacuna),
    FOREIGN KEY (dni) REFERENCES personas(dni),
    FOREIGN KEY (cod_vacuna) REFERENCES vacunas(cod_vacuna)
);

-- Inserción de datos
-- Municipios
INSERT INTO municipios VALUES (1, 'Buenos Aires'), (2, 'Córdoba'), (3, 'Santa Fe');

-- Vacunas
INSERT INTO vacunas VALUES (101, 'COVID19'), (102, 'FIEBRE AMARILLA'), (103, 'DENGUE'), (104, 'BCG');

-- Personas
INSERT INTO personas VALUES (12345678, 'Juan Pérez', 30, 1), (87654321, 'Laura García', 35, 2), (45678912, 'Carlos Ruiz', 28, 3);

-- Contagios
INSERT INTO contagios VALUES (12345678, 'COVID19'), (87654321, 'DENGUE');

-- Vacunados
INSERT INTO vacunados VALUES (12345678, 101), (87654321, 103), (45678912, 104);

-- b) Base de datos sobre ARTÍCULOS con MySQL
-- Creación de la tabla
CREATE TABLE articulos (
    art INT UNSIGNED PRIMARY KEY,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2) CHECK (precio > 0),
    cantidad INT UNSIGNED CHECK (cantidad >= 0),
    Stock_Min INT UNSIGNED CHECK (Stock_Min >= 0),
    Stock_Max INT UNSIGNED CHECK (Stock_Max >= 0 AND Stock_Min <= Stock_Max),
    Mes_Ult_Movim DATE,
    Fecha_Vto DATE
);

-- Inserción de datos
INSERT INTO articulos (art, descripcion, precio, cantidad, Stock_Min, Stock_Max, Mes_Ult_Movim, Fecha_Vto)
VALUES 
(1, 'Paracetamol 500 mg', 3.50, 100, 20, 200, '2024-05-01', '2025-12-31'),
(2, 'Amoxicilina 250 mg', 5.00, 150, 30, 300, '2024-04-15', '2025-11-30'),
(3, 'Ibuprofeno 400 mg', 4.75, 200, 50, 400, '2024-05-20', '2026-01-15');