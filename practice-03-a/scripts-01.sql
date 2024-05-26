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
FROM ejercicio1.producto
WHERE precio > 1500;

-- b) Productos vendidos más de 2 unidades en alguna factura ordenadas por descripción.
SELECT cod_producto, descripcion
FROM ejercicio1.producto
WHERE cod_producto IN (
    SELECT cod_producto
    FROM ejercicio1.itemfactura
    GROUP BY cod_producto, nro_factura
    HAVING SUM(cantidad) > 2
)
ORDER BY descripcion;

-- c) Clientes sin ventas asociadas ordenadas por apellido y nombre.
SELECT *
FROM ejercicio1.cliente
WHERE nro_cliente NOT IN (
    SELECT DISTINCT nro_cliente
    FROM ejercicio1.factura
)
ORDER BY apellido DESC, nombre DESC;

-- d) Productos que nunca se vendieron.
SELECT *
FROM ejercicio1.producto
WHERE cod_producto NOT IN (
    SELECT DISTINCT cod_producto
    FROM ejercicio1.itemfactura
);

-- e) Clientes con ventas, pero sin detalles en Factura.
SELECT 
    c.NRO_CLIENTE, 
    c.APELLIDO, 
    c.NOMBRE, 
    c.DIRECCION,
    c.TELEFONO,
    f.NRO_FACTURA, 
    f.FECHA, 
    f.MONTO
FROM ejercicio1.cliente c
LEFT JOIN ejercicio1.factura f ON c.NRO_CLIENTE = f.NRO_CLIENTE
ORDER BY c.NRO_CLIENTE;