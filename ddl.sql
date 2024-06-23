CREATE DATABASE logistica;
USE logistica;

CREATE TABLE paises(
    id VARCHAR(4),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_paises PRIMARY KEY(id)
);

CREATE TABLE jornadas(
    id VARCHAR(3),
    horario TIME,
    CONSTRAINT pk_id_jornadas PRIMARY KEY(id)
);

CREATE TABLE estados(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_estados PRIMARY KEY(id)
);

CREATE TABLE marcas(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_marcas PRIMARY KEY(id)
);

CREATE TABLE conductores(
    id VARCHAR(15),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_conductores PRIMARY KEY(id)
);

CREATE TABLE rutas(
    id INT AUTO_INCREMENT,
    descripcion TEXT,
    CONSTRAINT pk_id_rutas PRIMARY KEY(id)
);

CREATE TABLE tipos_servicios(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tiposServicios PRIMARY KEY(id)
);

CREATE TABLE ciudades(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_pais VARCHAR(4),
    CONSTRAINT pk_id_ciudades PRIMARY KEY(id),
    CONSTRAINT fk_idpais_ciudades FOREIGN KEY(id_pais)
    REFERENCES paises(id)
);

CREATE TABLE auxiliares(
    id VARCHAR(15),
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    CONSTRAINT pk_id_auxiliares PRIMARY KEY(id)
);

CREATE TABLE rutas_auxiliar(
    id_ruta INT,
    id_auxiliar VARCHAR(15),
    CONSTRAINT pk_id_rutas_auxiliar PRIMARY KEY(id_ruta, id_auxiliar),
    CONSTRAINT fk_idruta_rutas_auxiliar FOREIGN KEY(id_ruta)
    REFERENCES rutas(id),
    CONSTRAINT fk_idaux_rutas_auxiliar FOREIGN KEY(id_auxiliar)
    REFERENCES auxiliares(id)
);

CREATE TABLE modelos(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    id_marca INT,
    CONSTRAINT pk_id_modelos PRIMARY KEY(id),
    CONSTRAINT fk_idmarca_modelos FOREIGN KEY(id_marca)
    REFERENCES marcas(id)
);

CREATE TABLE clientes(
    id VARCHAR(15),
    nombre VARCHAR(30) NOT NULL,
    email VARCHAR(100),
    id_ciudad INT,
    CONSTRAINT pk_id_clientes PRIMARY KEY(id),
    CONSTRAINT fk_idciudad_clientes FOREIGN KEY(id_ciudad)
    REFERENCES ciudades(id)
);

CREATE TABLE sucursales(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_ciudad INT,
    CONSTRAINT pk_id_sucursales PRIMARY KEY(id),
    CONSTRAINT fk_idciudad_sucursales FOREIGN KEY(id_ciudad)
    REFERENCES ciudades(id)
);

CREATE TABLE telefonos_conductores(
    id INT AUTO_INCREMENT,
    numero VARCHAR(15) NOT NULL,
    id_conductor VARCHAR(15),
    CONSTRAINT pk_id_telefonosconductores PRIMARY KEY(id),
    CONSTRAINT fk_idconductor_telefonosconductores FOREIGN KEY(id_conductor)
    REFERENCES conductores(id)
);

CREATE TABLE telefonos_clientes(
    id INT AUTO_INCREMENT,
    numero VARCHAR(15) NOT NULL,
    id_cliente VARCHAR(15),
    CONSTRAINT pk_id_telefonosclientes PRIMARY KEY(id),
    CONSTRAINT fk_idcliente_telefonosclientes FOREIGN KEY(id_cliente)
    REFERENCES clientes(id)
);

CREATE TABLE telefonos_auxiliares(
    id INT AUTO_INCREMENT,
    numero VARCHAR(15) NOT NULL,
    id_auxiliar VARCHAR(15),
    CONSTRAINT pk_id_telefonosauxiliares PRIMARY KEY(id),
    CONSTRAINT fk_idauxiliar_telefonosauxiliares FOREIGN KEY(id_auxiliar)
    REFERENCES auxiliares(id)
);

CREATE TABLE ubicaciones_clientes(
    id INT AUTO_INCREMENT,
    calle VARCHAR(3),
    carrera VARCHAR(3),
    id_cliente VARCHAR(15),
    CONSTRAINT pk_id_ubicacionesclientes PRIMARY KEY(id),
    CONSTRAINT fk_idcliente_ubicacionesclientes FOREIGN KEY(id_cliente)
    REFERENCES clientes(id)
);

CREATE TABLE paquetes(
    id INT AUTO_INCREMENT,
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TEXT,
    valor_declarado VARCHAR(15),
    id_tipo_servicio INT,
    CONSTRAINT pk_id_paquetes PRIMARY KEY(id),
    CONSTRAINT fk_idtiposerv_paquetes FOREIGN KEY(id_tipo_servicio)
    REFERENCES tipos_servicios(id)
);

CREATE TABLE vehiculos(
    id INT AUTO_INCREMENT,
    placa VARCHAR(20),
    cap_carga DECIMAL(10,2),
    id_modelo INT,
    CONSTRAINT pk_id_vehiculos PRIMARY KEY(id),
    CONSTRAINT fk_idmodelo_vehiculos FOREIGN KEY(id_modelo)
    REFERENCES modelos(id)
);

CREATE TABLE conductores_rutas(
    id_conductor VARCHAR(15),
    id_ruta INT,
    id_vehiculo INT,
    id_sucursal INT,
    id_jornada VARCHAR(3),
    CONSTRAINT pk_id_conductoresrutas PRIMARY KEY(id_conductor, id_ruta),
    CONSTRAINT fk_idconductor_conductoresrutas FOREIGN KEY(id_conductor)
    REFERENCES conductores(id),
    CONSTRAINT fk_idruta_conductoresrutas FOREIGN KEY(id_ruta)
    REFERENCES rutas(id),
    CONSTRAINT fk_idvehiculo_conductoresrutas FOREIGN KEY(id_vehiculo)
    REFERENCES vehiculos(id),
    CONSTRAINT fk_idsucursal_conductoresrutas FOREIGN KEY(id_sucursal)
    REFERENCES sucursales(id),
    CONSTRAINT fk_idjornada_conductoresrutas FOREIGN KEY(id_jornada)
    REFERENCES jornadas(id),
    CONSTRAINT unique_ruta_jornada UNIQUE (id_ruta, id_jornada)

);

CREATE TABLE destinos(
    id INT AUTO_INCREMENT,
    calle VARCHAR(3),
    carrera VARCHAR(3),
    id_ciudad INT,
    CONSTRAINT pk_id_destinos PRIMARY KEY(id),
    CONSTRAINT fk_idciudad_destinos FOREIGN KEY(id_ciudad)
    REFERENCES ciudades(id)
);

CREATE TABLE ubicaciones_sucursales(
    id INT AUTO_INCREMENT,
    calle VARCHAR(3),
    carrera VARCHAR(3),
    id_sucursal INT,
    CONSTRAINT pk_id_ubicacionessucursales PRIMARY KEY(id),
    CONSTRAINT fk_idsucursal_ubicacionessucursales FOREIGN KEY(id_sucursal)
    REFERENCES sucursales(id)
);

CREATE TABLE seguimientos(
    id INT AUTO_INCREMENT,
    fecha DATE,
    id_paquete INT,
    id_estado INT,
    id_ciudad INT,
    CONSTRAINT pk_id_seguimientos PRIMARY KEY(id),
    CONSTRAINT fk_idpaquete_seguimientos FOREIGN KEY(id_paquete)
    REFERENCES paquetes(id),
    CONSTRAINT fk_idestado_seguimientos FOREIGN KEY(id_estado)
    REFERENCES estados(id),
    CONSTRAINT fk_idciudad_seguimientos FOREIGN KEY(id_ciudad)
    REFERENCES ciudades(id)
);

CREATE TABLE envios(
    id INT AUTO_INCREMENT,
    fecha DATE,
    id_cliente VARCHAR(15),
    id_paquete INT,
    id_ruta INT,
    id_sucursal INT,
    id_destino INT,
    id_jornada VARCHAR(3),
    CONSTRAINT pk_id_envios PRIMARY KEY(id),
    CONSTRAINT fk_idcliente_envios FOREIGN KEY(id_cliente)
    REFERENCES clientes(id),
    CONSTRAINT fk_idpaquete_envios FOREIGN KEY(id_paquete)
    REFERENCES paquetes(id),
    CONSTRAINT fk_idruta_envios FOREIGN KEY(id_ruta)
    REFERENCES rutas(id),
    CONSTRAINT fk_idsucursal_envios FOREIGN KEY(id_sucursal)
    REFERENCES sucursales(id),
    CONSTRAINT fk_iddestino_envios FOREIGN KEY(id_destino)
    REFERENCES destinos(id),
    CONSTRAINT fk_idjornada_envios FOREIGN KEY(id_jornada)
    REFERENCES jornadas(id)
);

CREATE TABLE ubicaciones_paquetes(
    id INT AUTO_INCREMENT,
    calle VARCHAR(3),
    carrera VARCHAR(3),
    id_seguimiento INT,
    CONSTRAINT pk_id_ubicacionespaquetes PRIMARY KEY(id),
    CONSTRAINT fk_idseguimiento_ubicacionespaquetes FOREIGN KEY(id_seguimiento)
    REFERENCES seguimientos(id)
);







