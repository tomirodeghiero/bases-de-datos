-- Creación de la tabla 'Cliente'
CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(255),
  apellido VARCHAR(255)
);

-- Creación de la tabla 'Propietario'
CREATE TABLE Propietario (
  id_prop INT PRIMARY KEY,
  nombre VARCHAR(255),
  apellido VARCHAR(255)
);

-- Creación de la tabla 'Inmueble'
CREATE TABLE Inmueble (
  id_inmueble INT PRIMARY KEY,
  tipo VARCHAR(255),
  id_prop INT,
  FOREIGN KEY (id_prop) REFERENCES Propietario(id_prop)
);

-- Creación de la tabla 'Inquilino' (que asumimos es la relación de alquiler)
CREATE TABLE Inquilino (
  id_inmueble INT,
  id_cliente INT,
  fecha_inicio DATE,
  fecha_fin DATE,
  monto DECIMAL(10, 2),
  PRIMARY KEY (id_inmueble, id_cliente),
  FOREIGN KEY (id_inmueble) REFERENCES Inmueble(id_inmueble),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Inserción de datos en 'Cliente'
INSERT INTO Cliente (id_cliente, nombre, apellido) VALUES
(1, 'Juan', 'Pérez'),
(2, 'Ana', 'González');

-- Inserción de datos en 'Propietario'
INSERT INTO Propietario (id_prop, nombre, apellido) VALUES
(1, 'Carlos', 'Hernández'),
(2, 'Luisa', 'Rodríguez');

-- Inserción de datos en 'Inmueble'
INSERT INTO Inmueble (id_inmueble, tipo, id_prop) VALUES
(1, 'Casa', 1),
(2, 'Apartamento', 2);

-- Inserción de datos en 'Inquilino'
INSERT INTO Inquilino (id_inmueble, id_cliente, fecha_inicio, fecha_fin, monto) VALUES
(1, 1, '2024-01-01', '2024-12-31', 1200.00),
(2, 2, '2024-06-01', '2025-05-31', 800.00);

-- Seleccionar todos los clientes
SELECT * FROM Cliente;

-- Seleccionar todos los propietarios
SELECT * FROM Propietario;

-- Seleccionar todos los inmuebles y su propietario
SELECT Inmueble.id_inmueble, Inmueble.tipo, Propietario.nombre, Propietario.apellido
FROM Inmueble
JOIN Propietario ON Inmueble.id_prop = Propietario.id_prop;

-- Seleccionar todos los inmuebles con su inquilino
SELECT Inmueble.id_inmueble, Inmueble.tipo, Cliente.nombre, Cliente.apellido, Inquilino.fecha_inicio, Inquilino.fecha_fin, Inquilino.monto
FROM Inquilino
JOIN Inmueble ON Inquilino.id_inmueble = Inmueble.id_inmueble
JOIN Cliente ON Inquilino.id_cliente = Cliente.id_cliente;