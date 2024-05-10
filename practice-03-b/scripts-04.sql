-- Primero, se deben eliminar las FK existentes si ya fueron creadas, esto se puede omitir si se está creando de nuevo las tablas
ALTER TABLE vacunados DROP CONSTRAINT IF EXISTS vacunados_cod_vacuna_fkey;
ALTER TABLE vacunados DROP CONSTRAINT IF EXISTS vacunados_dni_fkey;

-- Recreación de las tablas con las nuevas reglas
-- Asegúrate de tener las tablas `personas`, `municipios` y `vacunas` ya creadas como se muestra en ejemplos anteriores

CREATE TABLE IF NOT EXISTS personas (
    dni INTEGER PRIMARY KEY,
    nombre VARCHAR(45),
    edad INTEGER CHECK (edad >= 21),
    municipio INTEGER,
    FOREIGN KEY (municipio) REFERENCES municipios(municipio)
    ON DELETE RESTRICT  -- Asegura que no se pueda borrar un municipio que tiene personas asociadas
);

CREATE TABLE IF NOT EXISTS vacunas (
    cod_vacuna INTEGER PRIMARY KEY,
    nombre VARCHAR(45) CHECK (nombre IN ('COVID19', 'FIEBRE AMARILLA', 'DENGUE', 'BCG'))
);

CREATE TABLE IF NOT EXISTS vacunados (
    dni INTEGER,
    cod_vacuna INTEGER,
    PRIMARY KEY (dni, cod_vacuna),
    FOREIGN KEY (dni) REFERENCES personas(dni)
        ON DELETE RESTRICT,  -- Impide eliminar personas que tengan vacunas aplicadas
    FOREIGN KEY (cod_vacuna) REFERENCES vacunas(cod_vacuna)
        ON DELETE CASCADE   -- Borra todas las entradas de 'vacunados' relacionadas cuando una vacuna es borrada
);