-- a) Bases de datos sobre Artículos
CREATE TABLE articulos (
    art INTEGER PRIMARY KEY,
    descripcion VARCHAR(255),
    precio NUMERIC CHECK (precio > 0 AND precio < 999999),
    cantidad INTEGER CHECK (cantidad >= 0),
    Stock_Min INTEGER CHECK (Stock_Min >= 0),
    Stock_Max INTEGER CHECK (Stock_Max >= 0 AND Stock_Min <= Stock_Max),
    Mes_Ult_Movim DATE,
    Fecha_Vto DATE
);

-- b) Base de datos sobre Vacunas
CREATE TABLE municipios (
    municipio INTEGER PRIMARY KEY,
    provincia VARCHAR(45)
);

CREATE TABLE vacunas (
    cod_vacuna INTEGER PRIMARY KEY,
    nombre VARCHAR(45) CHECK (nombre IN ('COVID19', 'FIEBRE AMARILLA', 'DENGUE', 'BCG'))
);

CREATE TABLE personas (
    dni INTEGER PRIMARY KEY,
    nombre VARCHAR(45),
    edad INTEGER CHECK (edad >= 21),
    municipio INTEGER,
    FOREIGN KEY (municipio) REFERENCES municipios(municipio)
);

CREATE TABLE contagios (
    dni INTEGER,
    cepa VARCHAR(45),
    FOREIGN KEY (dni) REFERENCES personas(dni)
);

CREATE TABLE vacunados (
    dni INTEGER,
    cod_vacuna INTEGER,
    FOREIGN KEY (dni) REFERENCES personas(dni),
    FOREIGN KEY (cod_vacuna) REFERENCES vacunas(cod_vacuna)
);