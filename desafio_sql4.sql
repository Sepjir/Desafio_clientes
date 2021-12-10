-- Creando base de datos
DROP DATABASE billjobs;

CREATE DATABASE billjobs;

\c billjobs

-- Cargar el respaldo de la base de datos unidad2.sql

-- psql -U postgres billjobs < unidad2.sql
-- \i 'unidad2.sql'

-- Compra del cliente usuario01 [ Producto 9 x 5, fecha del sistema]

BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) VALUES (1,'2021-12-09');
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (9, 39, 5);
UPDATE producto SET stock = stock - 5 WHERE id = 9;
COMMIT;

-- El cliente usuario02 ha realizado la siguiente compra: [producto1 x 3, producto2 x 3, producto8 x 3], fecha

BEGIN TRANSACTION;
INSERT INTO compra (id, cliente_id, fecha) VALUES (100, 2,'2021-12-09');
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (1, 100, 3);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (2, 100, 3);
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (8, 100, 3);

UPDATE producto SET stock = stock - 3 WHERE id = 1;
UPDATE producto SET stock = stock - 3 WHERE id = 2;

-- Se agregaron productos por que explota

UPDATE producto SET stock = 3 WHERE id = 8;
UPDATE producto SET stock = stock - 3 WHERE id = 8;
COMMIT;

-- Realizar las siguientes consultas

    -- Deshabilitar el AUTOCOMMIT.
    \set AUTOCOMMIT OFF

    -- Insertar un nuevo cliente.
    BEGIN TRANSACTION;
    SAVEPOINT before_new_client;
    INSERT INTO cliente (id, nombre, email) VALUES (11, 'usuario11', 'usuario11@gmail.com');

    -- Confirmar que fue agregado en la tabla cliente.
    SELECT * FROM cliente WHERE id = 11;


    -- Realizar un ROLLBACK.
    ROLLBACK TO before_new_client;
    COMMIT;

    -- Confirmar que se restauró la información, sin considerar la inserción del punto b.
    SELECT * FROM cliente ORDER BY id;
    -- Habilitar de nuevo el AUTOCOMMIT
    COMMIT;
    \set AUTOCOMMIT





