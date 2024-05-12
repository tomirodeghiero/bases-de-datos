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
-- a, b) 1. Listar todos los alumnos y los talleres que realizan. Si un alumno no realiza ningún taller, debe aparecer sin taller asociado.

-- **Álgebra Relacional:**
-- π nombre,apellido,nombre_taller (Alumno ⋈ Realiza ⋈ Taller)

-- **SQL:**
SELECT alumno.nombre, alumno.apellido, taller.nombre as nombre_taller
FROM ejercicio3.alumno
LEFT JOIN ejercicio3.realiza ON alumno.nro_alumno = realiza.nro_alumno
LEFT JOIN ejercicio3.taller ON realiza.codigo_taller = taller.codigo_taller;

-- 2. Listar los nombres de los alumnos que están inscriptos en el taller 'Cocina' pero no en el taller 'Reparacion de PC'.

-- **Álgebra Relacional:**
-- \[\pi_{nombre}((Alumno \bowtie \sigma_{nombre\_taller='Cocina'}(Realiza \bowtie Taller)) - (Alumno \bowtie \sigma_{nombre\_taller='Reparacion de PC'}(Realiza \bowtie Taller)))\]

-- **SQL:**
SELECT DISTINCT alumno.nombre
FROM ejercicio3.alumno
JOIN ejercicio3.realiza ON alumno.nro_alumno = realiza.nro_alumno
JOIN ejercicio3.taller ON realiza.codigo_taller = taller.codigo_taller
WHERE taller.nombre = 'Cocina'
AND alumno.nro_alumno NOT IN (
    SELECT alumno.nro_alumno
    FROM ejercicio3.alumno
    JOIN ejercicio3.realiza ON alumno.nro_alumno = realiza.nro_alumno
    JOIN ejercicio3.taller ON realiza.codigo_taller = taller.codigo_taller
    WHERE taller.nombre = 'Reparacion de PC'
);

-- 3. Listar la cantidad de talleres por alumno.

-- **Álgebra Relacional:**
-- \[ Taller \times Alumno - \pi_{codigo\_taller, nro\_alumno} (Realiza) \]

-- **SQL:**
SELECT alumno.nro_alumno, alumno.nombre, alumno.apellido, alumno.dni, alumno.sexo, COUNT(realiza.codigo_taller) AS num_talleres
FROM ejercicio3.alumno
JOIN ejercicio3.realiza ON alumno.nro_alumno = realiza.nro_alumno
GROUP BY alumno.nro_alumno, alumno.nombre, alumno.apellido, alumno.dni, alumno.sexo;