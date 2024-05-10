-- Script para crear las tablas y insertar datos
-- Creación de la tabla Deporte
CREATE TABLE Deporte (
    codigo_deporte INT PRIMARY KEY,
    denominacion VARCHAR(100)
);

-- Creación de la tabla Competidor
CREATE TABLE Competidor (
    nro_competidor INT PRIMARY KEY,
    pais VARCHAR(50),
    anio INT,
    nombre VARCHAR(100),
    codigo_deporte INT,
    FOREIGN KEY (codigo_deporte) REFERENCES Deporte(codigo_deporte)
);

-- Creación de la tabla Competencia
CREATE TABLE Competencia (
    pais VARCHAR(50),
    codigo_deporte INT,
    anio INT,
    PRIMARY KEY (pais, codigo_deporte, anio),
    FOREIGN KEY (codigo_deporte) REFERENCES Deporte(codigo_deporte)
);

-- Creación de la tabla Medalla
CREATE TABLE Medalla (
    pais VARCHAR(50),
    tipo_medalla VARCHAR(50),
    anio INT,
    cantidad INT,
    PRIMARY KEY (pais, tipo_medalla, anio)
);

-- Insertar datos de ejemplo en Deporte
INSERT INTO Deporte (codigo_deporte, denominacion) VALUES
(1, 'FUTBOL'),
(2, 'BASKETBALL');

-- a) Competidores del deporte “FUTBOL”.

-- **Álgebra Relacional:**
-- \[ \pi_{nombre} (\sigma_{denominacion='FUTBOL'} (Deporte) \bowtie Competidor) \]

SELECT Competidor.nombre
FROM Competidor
JOIN Deporte ON Competidor.codigo_deporte = Deporte.codigo_deporte
WHERE Deporte.denominacion = 'FUTBOL';

-- b) Países que han competido y no ganaron ninguna medalla.

-- **Álgebra Relacional:**
-- \[ \pi_{pais} (Competencia) - \pi_{pais} (Medalla) \]

SELECT DISTINCT pais
FROM Competencia
WHERE pais NOT IN (SELECT DISTINCT pais FROM Medalla);