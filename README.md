# LOGISTICA

#### Generar un Reporte de Envíos por Cliente

```sql
SELECT 
    e.id,
    e.fecha,
    c.id AS id_cliente,
    c.nombre AS nombre_cliente,
    p.contenido AS contenido_paquete,
    r.descripcion AS descripcion_ruta,
    s.nombre AS nombre_sucursal_origen,
    ci.nombre AS ciudad_destino
FROM 
    envios e
    JOIN clientes c ON e.id_cliente = c.id
    JOIN paquetes p ON e.id_paquete = p.id
    JOIN rutas r ON e.id_ruta = r.id
    JOIN sucursales s ON e.id_sucursal = s.id
    JOIN destinos d ON e.id_destino = d.id
    JOIN ciudades ci ON d.id_ciudad = ci.id
WHERE 
    e.id_cliente = 'CLI001';
```



#### Actualizar el Estado de un Paquete

```sql
UPDATE seguimientos SET id_estado = 3 WHERE id_paquete = 1;
```

Se ha actualizado el estado del paquete con id = 1

#### Rastrear la Ubicación Actual de un Paquete

```sql
SELECT s.id,
    s.fecha,
    p.contenido AS contenido_paquete,
    e.nombre AS estado_paquete,
    c.nombre AS ciudad_actual,
    u.calle,
    u.carrera

FROM seguimientos s
    JOIN paquetes p ON s.id_paquete = p.id
    JOIN estados e ON s.id_estado = e.id
    JOIN ciudades c ON s.id_ciudad = c.id
    JOIN ubicaciones_paquetes u ON s.id = u.id_seguimiento
WHERE
    s.id_paquete = 2;

```



## Casos Multitabla

###### Caso de Uso 1: Obtener Información Completa de Envíos

Descripción: Un administrador desea obtener la información completa de todos los envíos,
incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal.

```sql
SELECT 
    en.id,
    en.fecha,
    cli.id AS id_cliente,
    cli.nombre AS nombre_cliente,
    p.contenido AS contenido_paquete,
    r.descripcion AS ruta,
    s.nombre AS nombre_sucursal,
    ci_suc.nombre AS ubicacion_sucursal,
    ci_dest.nombre AS ciudad_destino,
    con.id AS id_conductor,
    con.nombre AS nombre_conductor
FROM 
    envios en
    JOIN clientes cli ON en.id_cliente = cli.id
    JOIN paquetes p ON en.id_paquete = p.id
    JOIN rutas r ON en.id_ruta = r.id
    JOIN sucursales s ON en.id_sucursal = s.id
    JOIN ciudades ci_suc ON s.id_ciudad = ci_suc.id
    JOIN destinos des ON en.id_destino = des.id
    JOIN ciudades ci_dest ON des.id_ciudad = ci_dest.id
    JOIN conductores_rutas cr ON en.id_ruta = cr.id_ruta AND en.id_jornada = cr.id_jornada
    JOIN conductores con ON cr.id_conductor = con.id;

```

##### Caso de Uso 2: Obtener Historial de Envíos de un Cliente

Descripción: Un administrador desea obtener el historial completo de envíos de un cliente
específico, incluyendo detalles de los paquetes y los eventos de seguimiento.

```sql
SELECT en.id,
	en.fecha,
	cli.id AS id_cliente,
	cli.nombre AS nombre_cliente,
	p.id AS id_paquete,
	p.contenido AS contenido_paquete,
	p.peso AS peso_paquete,
	p.dimensiones,
	p.valor_declarado,
	r.descripcion AS ruta,
    s.nombre AS nombre_sucursal,
    seg.id AS id_seguimiento,
    seg.fecha AS fecha_Seguimiento,
    e.nombre AS estado,
    c.nombre AS ciudad_actual
  FROM envios en
  	JOIN clientes cli ON en.id_cliente = cli.id
  	JOIN paquetes p ON en.id_paquete = p.id
  	JOIN rutas r ON en.id_ruta = r.id
    JOIN sucursales s ON en.id_sucursal = s.id
    JOIN seguimientos seg ON en.id_paquete = seg.id_paquete
    JOIN estados e ON seg.id_estado = e.id
    JOIN ciudades c ON s.id_ciudad = c.id
   WHERE
   		en.id_cliente = 'CLI001';
    
```



##### Caso de Uso 3: Listar Conductores y sus Rutas Asignadas

Descripción: Un administrador desea obtener una lista de todos los conductores y las rutas a las
que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente.

```sql
SELECT cr.id_conductor,
	cd.nombre,
	tc.numero AS telefono,
	cr.id_ruta,
	r.descripcion AS descripcion_ruta,
	jor.horario,
	s.nombre AS nombre_sucursal,
	cr.id_vehiculo,
	ve.placa,
	ve.cap_carga,
	mo.nombre AS modelo,
    ma.nombre AS marca
FROM conductores_rutas cr
	JOIN conductores cd ON cr.id_conductor= cd.id
	LEFT JOIN telefonos_conductores tc ON cr.id_conductor =tc.id_conductor
	JOIN rutas r ON cr.id_ruta = r.id
	JOIN jornadas jor ON cr.id_jornada = jor.id
	JOIN sucursales s ON cr.id_sucursal = s.id
	JOIN vehiculos ve ON cr.id_vehiculo = ve.id
	JOIN modelos mo ON ve.id_modelo = mo.id
	JOIN marcas ma ON mo.id_marca = ma.id;
	
```



##### Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados

Descripción: Un administrador desea obtener detalles de todas las rutas, incluyendo los
auxiliares asignados a cada ruta.

```sql
SELECT r.id AS id_ruta,
	r.descripcion AS ruta,
	raux.id_auxiliar,
	aux.nombre,
	aux.telefono
FROM rutas r
	JOIN rutas_auxiliar raux ON r.id = raux.id_ruta
	JOIN auxiliares aux ON raux.id_auxiliar = aux.id;
```



##### Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado

Descripción: Un administrador desea generar un reporte de todos los paquetes agrupados por
sucursal y estado.

```sql
SELECT p.id AS id_paquete,
	p.peso,
	p.dimenciones,
	p.contenido,
	p.valor_declarado,
	s.nombre AS sucursal,
	c.nombre AS ciudad,
	p.nombre AS pais,
	e.nombre AS estado
FROM paquetes p
	JOIN 
	
```



##### Caso de Uso 6: Obtener Información Completa de un Paquete y su Historial de Seguimiento

Descripción: Un administrador desea obtener la información completa de un paquete específico
y su historial de seguimiento.

```sql
SELECT p.id,
	p.peso,
	p.dimensiones,
	p.contenido,
	p.valor_declarado,
	t.nombre AS tipo_Servicio,
	cd.nombre AS ciudad_destino,
	d.calle AS calle_destino,
	d.carrera AS carera_destino,
	s.id AS id_seguimiento,
	s.fecha AS fecha_seguimiento,
	e.nombre AS estado_paquete,
	c.nombre AS ciudad,
	u.calle,
	u.carrera
FROM paquetes p
	JOIN tipos_servicios t ON p.id_tipo_servicio= t.id
	JOIN envios env ON p.id = env.id_paquete
	JOIN destinos d ON env.id_destino = d.id
	JOIN ciudades cd ON d.id_ciudad = cd.id
	JOIN seguimientos s On p.id = s.id_paquete
	JOIN estados e ON s.id_estado = e.id
	JOIN ciudades c ON s.id_ciudad = c.id
	JOIN ubicaciones_paquetes u ON s.id = u.id_seguimiento
WHERE p.id= 1;

```

## Casos de uso Between, In y Not In



##### Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los paquetes que fueron enviados dentro de
un rango de fechas específico.

```sql
SELECT p.id,
	p.contenido,
	p.peso,
	p.dimensiones,
	p.valor_declarado,
	t.nombre AS tipo_servicio,
	en.fecha AS fecha_envio
FROM paquetes p
	JOIN tipos_servicios t ON p.id_tipo_servicio = t.id
	JOIN envios en ON p.id = en.id_paquete 
WHERE en.fecha BETWEEN '2024-06-20' AND ' 2024-06-22';
	
```



##### Caso de Uso 2: Obtener Paquetes con Ciertos Estadons

Descripción: Un administrador desea obtener todos los paquetes que tienen ciertos estados
específicos (por ejemplo, 'en tránsito' o 'entregado').



```sql
SELECT 
    p.id AS id_paquete,
    p.contenido,
    p.peso,
    p.dimensiones,
    p.valor_declarado,
    t.nombre AS tipo_servicio,
    e.nombre AS estado,
    s.fecha AS fecha_seguimiento,
    en.fecha AS fecha_envio
FROM 
    paquetes p
    JOIN tipos_servicios t ON p.id_tipo_servicio = t.id
    JOIN seguimientos s ON p.id = s.id_paquete
    JOIN estados e ON s.id_estado = e.id
    JOIN envios en ON p.id = en.id_paquete 
WHERE 
    en.fecha = '2024-06-20'
    AND e.nombre IN ("En oficina","en camino");

```

##### Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados

Descripción: Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen
ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana').

```sql
SELECT 
    p.id AS id_paquete,
    p.contenido,
    p.peso,
    p.dimensiones,
    p.valor_declarado,
    t.nombre AS tipo_servicio,
    e.nombre AS estado,
    s.fecha AS fecha_seguimiento,
    en.fecha AS fecha_envio
FROM 
    paquetes p
    JOIN tipos_servicios t ON p.id_tipo_servicio = t.id
    JOIN seguimientos s ON p.id = s.id_paquete
    JOIN estados e ON s.id_estado = e.id
    JOIN envios en ON p.id = en.id_paquete 
WHERE 
    en.fecha = '2024-06-22'
    AND e.nombre NOT IN ("En oficina","en camino");
```

##### Caso de Uso 4: Obtener Clientes con Envíos RealizadosDentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los clientes que realizaron envíos dentro de
un rango de fechas específico.

```sql
SELECT 
    c.id AS id_cliente,
    c.nombre AS nombre_cliente,
    c.email AS email_cliente,
    t.numero AS telefono_cliente,
    en.fecha AS fecha_envio
FROM 
    clientes c
    JOIN envios en ON c.id = en.id_cliente
    LEFT JOIN telefonos_clientes t ON c.id = t.id_cliente
WHERE 
    en.fecha BETWEEN '2024-06-01' AND '2024-06-30';

```

##### Caso de Uso 5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas

Descripción: Un administrador desea obtener todos los conductores que no están asignados a
ciertas rutas específicas.

```sql
SELECT 
    c.id AS id_conductor,
    c.nombre AS nombre_conductor
FROM 
    conductores c
WHERE 
    c.id NOT IN (
        SELECT 
            cr.id_conductor
        FROM 
            conductores_rutas cr
        WHERE 
            cr.id_ruta IN (1, 2, 3,4)  
    );
```



##### Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico

Descripción: Un administrador desea obtener todos los paquetes cuyo valor declarado está
dentro de un rango específico.

```sql
SELECT id,
    contenido,
    peso,
    dimensiones,
    valor_declarado
FROM paquetes 
WHERE valor_declarado BETWEEN 10 AND 100;
```



##### Caso de Uso 7: Obtener Auxiliares Asignados a Rutas Específicas

Descripción: Un administrador desea obtener todos los auxiliares de reparto que están
asignados a ciertas rutas específicas.

```sql
SELECT a.id,
	a.nombre,
	a.telefono,
	raux.id_ruta AS id_ruta,
	r.descripcion
FROM auxiliares a
	JOIN rutas_auxiliar raux ON a.id = raux.id_auxiliar
	JOIN rutas r ON raux.id_ruta = r.id
WHERE r.id IN (1,2);
```



##### Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades

Descripción: Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas
ciudades específicas.

```sql
SELECT e.id,
       e.fecha,
       e.id_cliente,
       c.nombre AS nombre_cliente,
       e.id_paquete,
       p.contenido,
       e.id_ruta,
       r.descripcion AS descripcion_ruta,
       e.id_sucursal,
       s.nombre AS nombre_sucursal,
       e.id_destino,
       d.calle,
       d.carrera,
       d.id_ciudad,
       ciu.nombre AS nombre_ciudad
FROM envios e
JOIN clientes c ON e.id_cliente = c.id
JOIN paquetes p ON e.id_paquete = p.id
JOIN rutas r ON e.id_ruta = r.id
JOIN sucursales s ON e.id_sucursal = s.id
JOIN destinos d ON e.id_destino = d.id
JOIN ciudades ciu ON d.id_ciudad = ciu.id
WHERE d.id_ciudad NOT IN (1, 2, 3);
```



##### Caso de Uso 9: Obtener Seguimientos de Paquetes en un Rango de Fechas

Descripción: Un administrador desea obtener todos los eventos de seguimiento de paquetes que
ocurrieron dentro de un rango de fechas específico.

```sql

SELECT s.id AS id_seguimiento,
       s.fecha,
       s.id_paquete,
       p.contenido,
       e.nombre AS estado,
       c.nombre AS ciudad
FROM seguimientos s
JOIN paquetes p ON s.id_paquete = p.id
JOIN estados e ON s.id_estado = e.id
JOIN ciudades c ON s.id_ciudad = c.id
WHERE s.fecha BETWEEN '2024-06-20' AND '2024-06-25'
ORDER BY s.fecha;
```



##### Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes

Descripción: Un administrador desea obtener todos los clientes que tienen paquetes de ciertos
tipos específicos (por ejemplo, 'nacional' o 'internacional').

```sql
SELECT c.id,
       c.nombre,
       c.email,
       c.id_ciudad,
       ciu.nombre AS nombre_ciudad,
       ts.nombre AS tipo_servicio,
       p.id AS id_paquete,
       p.contenido,
       p.peso,
       p.dimensiones,
       p.valor_declarado
FROM clientes c
JOIN envios e ON c.id = e.id_cliente
JOIN paquetes p ON e.id_paquete = p.id
JOIN tipos_servicios ts ON p.id_tipo_servicio = ts.id
JOIN ciudades ciu ON c.id_ciudad = ciu.id
WHERE ts.nombre IN (' Estandar', 'economico'); 

```

