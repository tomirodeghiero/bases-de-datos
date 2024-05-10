-- Script para crear las tablas y insertar datos
-- Creación de la tabla Alumno
CREATE TABLE Alumno (
    nro_alumno INT PRIMARY KEY,
    dni VARCHAR(10),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    sexo CHAR(1)
);

-- Creación de la tabla Taller
CREATE TABLE Taller (
    codigo_taller INT PRIMARY KEY,
    nombre VARCHAR(100),
    duracion INT  -- Duración en horas
);

-- Creación de la tabla Realiza
CREATE TABLE Realiza (
    nro_alumno INT,
    codigo_taller INT,
    PRIMARY KEY (nro_alumno, codigo_taller),
    FOREIGN KEY (nro_alumno) REFERENCES Alumno(nro_alumno),
    FOREIGN KEY (codigo_taller) REFERENCES Taller(codigo_taller)
);

-- Insertar datos en la tabla Alumno
INSERT INTO Alumno (nro_alumno, dni, nombre, apellido, sexo) VALUES
(1, '12345678', 'Ana', 'Gomez', 'F'),
(2, '87654321', 'Luis', 'Perez', 'M'),
(3, '45678912', 'Maria', 'Lopez', 'F');

-- Insertar datos en la tabla Taller
INSERT INTO Taller (codigo_taller, nombre, duracion) VALUES
(101, 'Fotografía', 20),
(102, 'Programación', 30),
(103, 'Robótica', 25);

-- Insertar datos en la tabla Realiza
INSERT INTO Realiza (nro_alumno, codigo_taller) VALUES
(1, 101),
(2, 102),
(1, 102),
(3, 103);

-- Consultas propuestas (Álgebra Relacional y SQL)
-- a) Listar todos los alumnos que no están inscritos en talleres.

-- **Álgebra Relacional:**
-- \[ \pi_{nro\_alumno, nombre} (Alumno) - \pi_{nro\_alumno, nombre} (Alumno \bowtie Realiza) \]

-- **SQL:**
SELECT nro_alumno, nombre
FROM Alumno
WHERE nro_alumno NOT IN (SELECT nro_alumno FROM Realiza);

-- b) Listar los nombres de todos los talleres junto con los nombres de los alumnos inscritos. Incluir talleres sin alumnos.

-- **Álgebra Relacional:**
-- \[ Taller \leftouterjoin Realiza \bowtie Alumno \]

-- **SQL:**
SELECT T.nombre, A.nombre AS alumno_nombre
FROM Taller T
LEFT JOIN Realiza R ON T.codigo_taller = R.codigo_taller
LEFT JOIN Alumno A ON R.nro_alumno = A.nro_alumno;

-- c) Listar todos los talleres y los alumnos que no participan en cada taller.

-- **Álgebra Relacional:**
-- \[ Taller \times Alumno - \pi_{codigo\_taller, nro\_alumno} (Realiza) \]

-- **SQL:**
SELECT T.codigo_taller, T.nombre, A.nro_alumno, A.nombre
FROM Taller T
CROSS JOIN Alumno A
WHERE NOT EXISTS (
    SELECT 1 FROM Realiza R
    WHERE R.codigo_taller = T.codigo_taller AND R.nro_alumno = A.nro_alumno
);