-- Script para crear las tablas y insertar datos de ejemplo
-- Creación de la tabla Competencia
CREATE TABLE Competencia (
    id_competencia INT PRIMARY KEY,
    descripcion VARCHAR(255),
    categoria INT
);

-- Creación de la tabla Club
CREATE TABLE Club (
    id_club INT PRIMARY KEY,
    nombre_club VARCHAR(100),
    presupuesto DECIMAL(10, 2)
);

-- Creación de la tabla Participacion
CREATE TABLE Participacion (
    id_club INT,
    id_competencia INT,
    puesto INT,
    PRIMARY KEY (id_club, id_competencia),
    FOREIGN KEY (id_club) REFERENCES Club(id_club),
    FOREIGN KEY (id_competencia) REFERENCES Competencia(id_competencia)
);

-- Insertar datos en la tabla Competencia
INSERT INTO Competencia (id_competencia, descripcion, categoria) VALUES
(1, 'Torneo Nacional', 3),
(2, 'Torneo Regional', 2),
(3, 'Torneo Local', 1);

-- Insertar datos en la tabla Club
INSERT INTO Club (id_club, nombre_club, presupuesto) VALUES
(1, 'Club Alfa', 500000.00),
(2, 'Club Beta', 300000.00),
(3, 'Club Gamma', 450000.00);

-- Insertar datos en la tabla Participacion
INSERT INTO Participacion (id_club, id_competencia, puesto) VALUES
(1, 1, 1),
(2, 1, 2),
(1, 2, 1),
(3, 2, 3);

-- a) Listar las competencias cuya categoría es mayor a 2.
SELECT *
FROM competencia
WHERE "CATEGORIA" > 2;

-- b) Listar clubes que participaron en las competencias cuya categoría es 2.
SELECT DISTINCT 
    c."NRO_CLUB", 
    c."NOMBRE_CLUB"
FROM ejercicio2.club c
JOIN ejercicio2.participacion p ON c."NRO_CLUB" = p."NRO_CLUB"
JOIN ejercicio2.competencia co ON p."NRO_COMPETENCIA" = co."NRO_COMPETENCIA"
WHERE co."CATEGORIA" = 2;

-- c) Listar los nombres de los clubes que participaron en competencias cuya categoría es 2.
SELECT DISTINCT Club.nombre_club
FROM Club
JOIN Participacion ON Club.id_club = Participacion.id_club
JOIN Competencia ON Participacion.id_competencia = Competencia.id_competencia
WHERE Competencia.categoria = 2;