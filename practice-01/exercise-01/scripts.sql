-- Creación de la tabla Proveedor
CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    pagina_web VARCHAR(255)
);

-- Creación de la tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefonos_contacto VARCHAR(255)
);

-- Creación de la tabla Categoría
CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion TEXT
);

-- Creación de la tabla Producto
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio_actual DECIMAL(10,2),
    stock INT,
    id_categoria INT,
    id_proveedor INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- Creación de la tabla Venta
CREATE TABLE Venta (
    id_venta INT PRIMARY KEY,
    fecha DATE,
    id_cliente INT,
    descuento DECIMAL(10,2),
    monto DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Creación de la tabla intermedia Producto_Venta para manejar la relación N:M entre Producto y Venta
CREATE TABLE Producto_Venta (
    id_venta INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_venta, id_producto),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Insertamos datos en la tabla Proveedor
INSERT INTO Proveedor (id_proveedor, nombre, direccion, telefono, pagina_web) VALUES
(1, 'Proveedor Uno', 'Calle Uno, Ciudad Uno', '123456789', 'http://proveedoruno.com'),
(2, 'Proveedor Dos', 'Calle Dos, Ciudad Dos', '987654321', 'http://proveedordos.com');

-- Insertamos datos en la tabla Cliente
INSERT INTO Cliente (id_cliente, nombre, direccion, telefonos_contacto) VALUES
(1, 'Cliente Uno', 'Avenida Uno, Ciudad Uno', '111222333'),
(2, 'Cliente Dos', 'Avenida Dos, Ciudad Dos', '444555666');

-- Insertamos datos en la tabla Categoría
INSERT INTO Categoria (id_categoria, nombre, descripcion) VALUES
(1, 'Categoría Uno', 'Descripción de Categoría Uno'),
(2, 'Categoría Dos', 'Descripción de Categoría Dos');

-- Insertamos datos en la tabla Producto
INSERT INTO Producto (id_producto, nombre, precio_actual, stock, id_categoria, id_proveedor) VALUES
(1, 'Producto Uno', 10.00, 100, 1, 1),
(2, 'Producto Dos', 20.00, 200, 2, 2);

-- Insertamos datos en la tabla Venta
INSERT INTO Venta (id_venta, fecha, id_cliente, descuento, monto) VALUES
(1, '2024-04-11', 1, 0.00, 100.00),
(2, '2024-04-12', 2, 5.00, 190.00);

-- Insertamos datos en la tabla Producto_Venta
INSERT INTO Producto_Venta (id_venta, id_producto, cantidad) VALUES
(1, 1, 2),
(1, 2, 3),
(2, 1, 1),
(2, 2, 2);

-- Seleccionamos todos los proveedores
SELECT * FROM Proveedor;

-- Seleccionamos todos los clientes
SELECT * FROM Cliente;

-- Seleccionamos todas las categorías
SELECT * FROM Categoria;

-- Seleccionamos todos los productos
SELECT * FROM Producto;

-- Seleccionamos todas las ventas
SELECT * FROM Venta;

-- Seleccionamos todos los detalles de los productos vendidos
SELECT * FROM Producto_Venta;