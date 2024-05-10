-- a) Trigger para guardar la descripción del artículo en mayúsculas
CREATE OR REPLACE FUNCTION uppercase_description() RETURNS trigger AS $$
BEGIN
    NEW.descripcion := UPPER(NEW.descripcion);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_uppercase_description
BEFORE INSERT ON articulos
FOR EACH ROW EXECUTE FUNCTION uppercase_description();

-- b) Trigger para auditoría de cambios en las cantidades de artículos
CREATE TABLE auditoriaArticulo (
    nrarticulo INT,
    movimiento INT,
    fecha_actualizacion TIMESTAMP
);

CREATE OR REPLACE FUNCTION audit_article_changes() RETURNS trigger AS $$
BEGIN
    INSERT INTO auditoriaArticulo(nrarticulo, movimiento, fecha_actualizacion)
    VALUES (NEW.art, NEW.cantidad - OLD.cantidad, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_audit_article_changes
AFTER UPDATE ON articulos
FOR EACH ROW EXECUTE FUNCTION audit_article_changes();

-- c) Modificación del esquema de la tabla de vacunas para autoincrementar el código de vacuna
-- Primero, si la tabla ya existe y tiene datos, necesitamos ajustar la columna adecuadamente o recrear la tabla.
DROP TABLE IF EXISTS vacunas;

CREATE TABLE vacunas (
    cod_vacuna SERIAL PRIMARY KEY,
    nombre VARCHAR(45) CHECK (nombre IN ('COVID19', 'FIEBRE AMARILLA', 'DENGUE', 'BCG'))
);