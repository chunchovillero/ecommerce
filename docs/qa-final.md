# QA final

Fecha: 1 de octubre de 2026.

## Entorno validado

- WordPress 7.1.2.
- WooCommerce 11.1.2.
- PHP 8.3 y MariaDB 11.4 mediante Docker.
- Tema Tienda de Moda 0.3.0.
- Locale de WordPress y WooCommerce: `es_CL`.
- Moneda: CLP sin decimales, separador de miles con punto.

## Pruebas superadas

- Portada, tienda, ficha de producto, carrito, checkout, cuenta, favoritos, búsqueda y 404 responden correctamente.
- Producto simple con precio normal, oferta, stock, cantidad y carrito.
- Producto variable con stock independiente: combinación disponible aceptada y combinación agotada rechazada.
- Carrito con dos unidades y subtotal CLP correcto.
- Checkout con nombre, apellido, correo, teléfono, RUT, país, dirección, región, comuna y código postal opcional.
- RUT inválido genera error; RUT válido es aceptado y se almacena formateado.
- Pedido temporal creado mediante las APIs CRUD de WooCommerce con total `29980 CLP` y RUT, y eliminado después de la prueba.
- Búsqueda AJAX devuelve productos por nombre.
- Favoritos AJAX devuelve tarjetas válidas.
- Menú, filtros, mini carrito, buscador y diálogos incluyen estados accesibles.
- Exactamente un `h1` en las vistas principales.
- Open Graph, descripción de respaldo, sitemap y página 404 validados.
- Renderizado headless comprobado en 390 px y 1440 px.
- PHP, JavaScript y estructura CSS validados sin errores.
- Logs de WordPress sin errores fatales.
- Checksums del core y WooCommerce verificados; `wp-config-docker.php` es el archivo adicional esperado del entorno Docker.
- Integridad de todas las tablas de la base de datos confirmada.

## Condiciones pendientes de producción

No se completó un cobro real porque no existe una pasarela configurada. Esto es intencional: se debe instalar y configurar el plugin oficial del proveedor elegido, por ejemplo Webpay/Transbank, Mercado Pago o Flow.

Tampoco se simuló una empresa de despacho. Antes del lanzamiento deben configurarse zonas, tarifas y el proveedor real de envíos o retiro.

Los productos y el pedido usados durante QA fueron temporales y se eliminaron al finalizar.
