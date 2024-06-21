-------------------CONSULTAS----------------
SELECT 
    e.id,
    e.fecha,
    c.id AS id_cliente,
    c.nombre AS nombre_cliente,
    p.contenido AS contenido_paquete,
    r.descripcion AS descripcion_ruta,
    s.nombre AS nombre_sucursal_origen,
    d.calle AS calle_destino
FROM 
    envios e
    JOIN clientes c ON e.id_cliente = c.id
    JOIN paquetes p ON e.id_paquete = p.id
    JOIN rutas r ON e.id_ruta = r.id
    JOIN sucursales s ON e.id_sucursal = s.id
    JOIN destinos d ON e.id_destino = d.id
WHERE 
    e.id_cliente = 'CLI001';