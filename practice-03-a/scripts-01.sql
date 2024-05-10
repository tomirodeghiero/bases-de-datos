-- Script para crear las tablas
-- Creación de la tabla Cliente
CREATE TABLE Cliente (
    nro_cliente INT PRIMARY KEY,
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- Creación de la tabla Producto
CREATE TABLE Producto (
    cod_producto INT PRIMARY KEY,
    descripcion VARCHAR(100),
    precio DECIMAL(10, 2)
);

-- Creación de la tabla Factura
CREATE TABLE Factura (
    nro_factura INT PRIMARY KEY,
    nro_cliente INT,
    fecha DATE,
    monto DECIMAL(10, 2),
    FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente)
);

-- Creación de la tabla ItemFactura
CREATE TABLE ItemFactura (
    cod_producto INT,
    nro_factura INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    PRIMARY KEY (cod_producto, nro_factura),
    FOREIGN KEY (cod_producto) REFERENCES Producto(cod_producto),
    FOREIGN KEY (nro_factura) REFERENCES Factura(nro_factura)
);


-- Script para insertar datos de ejemplo
-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (nro_cliente, apellido, nombre, direccion, telefono) VALUES
(1, 'Pérez', 'Juan', 'Av. Libertador 1000', '111222333'),
(2, 'López', 'María', 'Calle Falsa 123', '444555666'),
(3, 'González', 'Carlos', 'Av. Siempreviva 321', '777888999');

-- Insertar datos en la tabla Producto
INSERT INTO Producto (cod_producto, descripcion, precio) VALUES
(100, 'Laptop 15" 8GB RAM', 75000.00),
(101, 'Mouse óptico', 1500.00),
(102, 'Teclado mecánico', 4500.00);

-- Insertar datos en la tabla Factura
INSERT INTO Factura (nro_factura, nro_cliente, fecha, monto) VALUES
(1, 1, '2023-05-01', 76500.00),
(2, 2, '2023-05-02', 1500.00),
(3, 1, '2023-05-03', 9000.00);

-- Insertar datos en la tabla ItemFactura
INSERT INTO ItemFactura (cod_producto, nro_factura, cantidad, precio) VALUES
(100, 1, 1, 75000.00),
(101, 2, 1, 1500.00),
(102, 3, 2, 4500.00);

-- a) Consulta de productos con precio superior a $15000.
SELECT *
FROM Producto
WHERE precio > 15000;

-- b) Productos vendidos más de 2 unidades en alguna factura.
SELECT cod_producto, descripción
FROM Producto
WHERE cod_producto IN (
    SELECT cod_producto
    FROM ItemFactura
    GROUP BY cod_producto
    HAVING SUM(cantidad) > 2
);

-- c) Clientes sin ventas asociadas.
SELECT *
FROM Cliente
WHERE nro_cliente NOT IN (
    SELECT DISTINCT nro_cliente
    FROM Factura
);

-- d) Productos que nunca se vendieron.
SELECT *
FROM Producto
WHERE cod_producto NOT IN (
    SELECT DISTINCT cod_producto
    FROM ItemFactura
);

-- e) Clientes con ventas, pero sin detalles en Factura.
SELECT *
FROM Cliente
WHERE nro_cliente IN (
    SELECT nro_cliente
    FROM Factura
    EXCEPT
    SELECT nro_cliente
    FROM ItemFactura
);