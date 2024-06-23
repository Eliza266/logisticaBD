INSERT INTO paises (id, nombre) VALUES 
('ARG', 'Argentina'),
('BRA', 'Brasil'),
('CAN', 'Canadá'),
('CHL', 'Chile'),
('CHN', 'China'),
('COL', 'Colombia'),
('DEU', 'Alemania'),
('ESP', 'España'),
('FRA', 'Francia'),
('GBR', 'Reino Unido');

INSERT INTO jornadas (id, horario) VALUES
('MAN', '06:00:00'),
('TAR', '12:00:00'),
('NOC', '17:00:00');

INSERT INTO ciudades (nombre, id_pais) VALUES 
('Buenos Aires', 'ARG'),
('São Paulo', 'BRA'),
('Toronto', 'CAN'),
('Santiago', 'CHL'),
('Beijing', 'CHN'),
('Bogotá', 'COL'),
('Berlín', 'DEU'),
('Madrid', 'ESP'),
('París', 'FRA'),
('Londres', 'GBR');

INSERT INTO sucursales (nombre, id_ciudad) VALUES 
('Sucursal Centro', 1),
('Sucursal Norte', 2),
('Sucursal Sur', 3),
('Sucursal Este', 4),
('Sucursal Oeste', 5),
('Sucursal Central', 6),
('Sucursal Metropolitana', 7),
('Sucursal Costera', 8),
('Sucursal Montaña', 9),
('Sucursal Frontera', 10);

INSERT INTO ubicaciones_sucursales (calle, carrera, id_sucursal) VALUES 
('A1', 'B1', 1),
('A2', 'B2', 2),
('A3', 'B3', 3),
('A4', 'B4', 4),
('A5', 'B5', 5),
('A6', 'B6', 6),
('A7', 'B7', 7),
('A8', 'B8', 8),
('A9', 'B9', 9),
('A10', 'B10', 10);

INSERT INTO clientes (id, nombre, email, id_ciudad) VALUES 
('CLI001', 'Juan Pérez', 'juan.perez@example.com', 1),
('CLI002', 'María García', 'maria.garcia@example.com', 2),
('CLI003', 'Carlos Rodríguez', 'carlos.rodriguez@example.com', 3),
('CLI004', 'Luisa Fernández', 'luisa.fernandez@example.com', 4),
('CLI005', 'Ana Gómez', 'ana.gomez@example.com', 5);

INSERT INTO telefonos_clientes (numero, id_cliente) VALUES
('123456789', 'CLI001'),  
('987654321', 'CLI001'),   
('111222333', 'CLI002'),   
('444555666', 'CLI003'),   
('777888999', 'CLI004'); 

INSERT INTO tipos_servicios (nombre) VALUES
('Express'),
('Estándar'),
('Económico');

INSERT INTO paquetes (peso, dimensiones, contenido, valor_declarado, id_tipo_servicio) VALUES
(5.25, '30x20x10 cm', 'Libros', '50 USD', 1),   
(8.75, '40x30x15 cm', 'Electrónicos', '100 USD', 2),  
(3.50, '25x15x8 cm', 'Ropa', '30 USD', 3),  
(12.00, '50x40x20 cm', 'Juguetes', '80 USD', 1),  
(7.80, '35x25x12 cm', 'Cosméticos', '70 USD', 2);  

INSERT INTO destinos (calle, carrera, id_ciudad) VALUES 
('100', '200', 1),
('110', '210', 2),
('120', '220', 3),
('130', '230', 4),
('140', '240', 5),
('150', '250', 6),
('160', '260', 7),
('170', '270', 8),
('180', '280', 9),
('190', '290', 10);
     
INSERT INTO rutas (descripcion) VALUES 
('Norte de Colombia'),
('Sur de Colombia'),
('Este de Colombia'),
('Oeste de Colombia');

INSERT INTO envios (fecha, id_cliente, id_paquete, id_ruta, id_sucursal, id_destino, id_jornada) VALUES
('2024-06-20', 'CLI001', 1, 1, 1, 2, 'MAN'),
('2024-06-21', 'CLI002', 2, 2, 2, 3, 'TAR'),
('2024-06-22', 'CLI003', 3, 3, 3, 4, 'NOC');

INSERT INTO marcas (nombre) VALUES
('Toyota'),
('Ford'),
('Chevrolet'),
('Honda'),
('Nissan');

INSERT INTO modelos (nombre, id_marca) VALUES
('Corolla', 1),
('Mustang', 2),
('Camaro', 3),
('Civic', 4),
('Altima', 5);

INSERT INTO vehiculos (placa, cap_carga, id_modelo) VALUES
('AAA111', 1000.50, 1),
('BBB222', 1200.75, 2),
('CCC333', 1100.00, 3),
('DDD444', 900.25, 4),
('EEE555', 1050.60, 5);

INSERT INTO conductores (id, nombre) VALUES
('COND001', 'Juan Pérez'),
('COND002', 'María González'),
('COND003', 'Carlos López'),
('COND004', 'Ana Martínez'),
('COND005', 'Pedro Ramírez');

INSERT INTO telefonos_conductores (numero, id_conductor) VALUES
('123456789', 'COND001'),
('987654321', 'COND002'),
('456789123', 'COND003'),
('321654987', 'COND004'),
('111222333', 'COND005');

INSERT INTO conductores_rutas (id_conductor, id_ruta, id_vehiculo, id_sucursal, id_jornada) VALUES
('COND001', 1, 1, 1, 'MAN'),
('COND002', 2, 2, 2, 'TAR'),
('COND003', 3, 3, 3, 'NOC'),
('COND004', 1, 4, 4, 'TAR'),  
('COND005', 2, 5, 5, 'NOC');  

INSERT INTO auxiliares (id, nombre, telefono) VALUES
('AUX001', 'Pedro Pérez', '123456789'),
('AUX002', 'María López', '987654321'),
('AUX003', 'Juan Rodríguez', '456789123');

INSERT INTO rutas_auxiliar (id_ruta, id_auxiliar) VALUES
(1, 'AUX001'),
(2, 'AUX002'),
(3, 'AUX003');

INSERT INTO estados (nombre) VALUES
('En Oficina'),
('En Camino'),
('Entregado');

INSERT INTO seguimientos (fecha, id_paquete, id_estado, id_ciudad) VALUES
('2024-06-17', 1, 2, 1);
('2024-06-17', 5, 1, 6),
('2024-06-20', 1, 1, 1),
('2024-06-21', 2, 2, 2),
('2024-06-22', 3, 3, 3),

INSERT INTO ubicaciones_paquetes (calle, carrera, id_seguimiento) VALUES 
('A1', 'B1', 1),
('A2', 'B2', 2),
('A3', 'B3', 3);

INSERT INTO seguimientos (fecha, id_paquete, id_estado, id_ciudad)
VALUES;

-- Para el paquete 5
INSERT INTO seguimientos (fecha, id_paquete, id_estado, id_ciudad)
VALUES ;