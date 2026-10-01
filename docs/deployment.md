# Despliegue a servidor

El sitio completo requiere dos partes inseparables:

1. Los archivos de WordPress de este repositorio.
2. Una exportación de la base de datos.

El directorio `wp-content/uploads` está ignorado por Git y debe copiarse por separado si contiene imágenes reales.

## Requisitos recomendados

- PHP 8.2 o 8.3 con extensiones requeridas por WordPress y WooCommerce.
- MySQL 8 o MariaDB 10.6 o posterior.
- HTTPS activo.
- Memoria PHP mínima de 256 MB.
- Tareas cron disponibles.
- Copias de seguridad de archivos y base de datos.

## Preparación

1. Crear una base de datos y un usuario exclusivos para el sitio.
2. Subir WordPress, `wp-content` y el tema al directorio público.
3. No subir `.git`, `.env`, copias SQL ni archivos de desarrollo.
4. Crear el `wp-config.php` de producción con las credenciales reales.
5. Generar claves y salts nuevos desde el servicio oficial de WordPress.
6. Importar la base de datos.
7. Copiar `wp-content/uploads` por un canal seguro.

## Cambio de dominio

Después de importar la base de datos, ejecutar WP-CLI desde la instalación de producción:

```bash
wp search-replace 'http://localhost:8080' 'https://tienda.example' --all-tables-with-prefix --precise --dry-run
wp search-replace 'http://localhost:8080' 'https://tienda.example' --all-tables-with-prefix --precise
wp rewrite flush
wp cache flush
```

Cambiar `https://tienda.example` por el dominio definitivo. No reemplazar URLs directamente con SQL, porque WordPress contiene datos serializados.

## Permisos y seguridad

- Directorios: normalmente `755`.
- Archivos: normalmente `644`.
- `wp-config.php`: restringido según el hosting.
- Desactivar edición de archivos desde el administrador con `DISALLOW_FILE_EDIT`.
- Forzar HTTPS en WordPress y en el servidor.
- Proteger backups y archivos SQL fuera del directorio público.
- Configurar backups automáticos y probar una restauración.

## Configuración comercial previa al lanzamiento

- Instalar y configurar una sola pasarela oficial.
- Configurar zonas, tarifas y métodos reales de despacho o retiro.
- Crear productos, categorías, tallas, colores, stock, SKU e imágenes.
- Configurar páginas legales, contacto y políticas.
- Configurar correo transaccional con SMTP o un proveedor de email.
- Ejecutar una compra real de bajo monto en el ambiente definitivo.
- Verificar correos, estados de pedido, descuentos, impuestos y reembolsos.
- Instalar un solo plugin SEO, como Yoast SEO o Rank Math; el fallback del tema se desactiva automáticamente.
- Conectar analítica y consentimiento de cookies según corresponda.

## Verificación final

```bash
wp core verify-checksums
wp plugin verify-checksums woocommerce
wp core version
wp plugin status woocommerce
```

Comprobar después la portada, tienda, producto variable, carrito, checkout, cuenta, favoritos, buscador, 404, sitemap y visualización en móvil.
