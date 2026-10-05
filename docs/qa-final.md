# QA final

Fecha de última actualización: 5 de octubre de 2026.

## Entorno validado

- WordPress y WooCommerce en Docker con PHP 8.3 y MariaDB 11.4.
- WooCommerce 11.1.2.
- Tema Tienda de Moda 1.4.0.
- `tienda-envios-chile` 4.0.0.
- `tienda-whatsapp` 1.0.0.
- Rank Math SEO 1.0.279.
- Locale `es_CL`, moneda CLP y 40 productos masculinos publicados.

## Validaciones realizadas

- Catálogo sin nombres femeninos heredados.
- Portada, categorías y fichas revisadas mediante navegador headless.
- Productos simples y variables con SKU, stock, precios y atributos.
- Tallas numéricas en calzado y tallas de ropa en productos variables.
- Carrito, checkout, Mi cuenta, Favoritos y búsqueda disponibles.
- RUT validado con módulo 11.
- Plugin chileno con 16 regiones y 346 comunas.
- Despacho, retiro y envío por pagar verificados por prueba de humo.
- Fallback por pagar activo para comunas sin configuración explícita.
- Transferencia bancaria y pago al recibir o retirar activos localmente.
- Políticas publicadas y enlazadas en el menú legal.
- Rank Math activo con Schema, Open Graph, descripción y sitemap.
- Fallback SEO del tema omitido cuando Rank Math está activo.
- WhatsApp activo; el botón se oculta hasta registrar el número real.
- Scripts PHP comprobados sin errores de sintaxis.

## Pruebas específicas

```bash
docker compose run --rm --user 33:33 wpcli wp eval-file /var/www/html/wp-content/plugins/tienda-envios-chile/tests/smoke.php
docker compose run --rm --user 33:33 wpcli wp eval-file /var/www/html/scripts/configure-rank-math.php
```

El sitemap local responde en `http://localhost:8080/?sitemap=1`.

## Pendientes con datos externos

- Instalar y configurar Mercado Pago con credenciales reales de prueba.
- Ejecutar pagos sandbox y una compra real de bajo monto.
- Configurar cuenta bancaria, domicilio y horarios de retiro.
- Registrar el número de WhatsApp.
- Configurar SMTP y validar entregabilidad.
- Publicar dominio y HTTPS.
- Activar indexación, conectar Search Console y analítica.
- Revisar textos legales con asesoría jurídica.
- Validar tarifas y plazos definitivos por comuna.
