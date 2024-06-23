# LOGISTICA![Diagrama ER de base de datos logistica](C:\Users\eliza\OneDrive\Documentos\CAMPUSLANDS\SKILLS\BD\logistica\Diagrama ER de base de datos logistica.jpeg)

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

![image-20240622154752145](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240622154752145.png)

#### Actualizar el Estado de un Paquete

![image-20240622160604066](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240622160604066.png)

![image-20240622160652382](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240622160652382.png)

```sql
UPDATE seguimientos SET id_estado = 3 WHERE id_paquete = 1;
```

![image-20240622160803193](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240622160803193.png)

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

![image-20240622234348045](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240622234348045.png)

#### Casos Multitabla

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

![image-20240623001426436](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240623001426436.png)

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

![image-20240623005754083](C:\Users\eliza\AppData\Roaming\Typora\typora-user-images\image-20240623005754083.png)
