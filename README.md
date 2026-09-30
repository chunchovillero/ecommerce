# Tienda de Moda

Tema clásico de WordPress preparado para evolucionar como tienda propia con WooCommerce. No incluye WordPress, WooCommerce, credenciales, productos ni configuraciones de producción.

## Requisitos y estado

- Entorno de desarrollo inspeccionado: PHP 8.5.4, Git 2.53.0, Node.js 24.21.0 y Composer disponibles.
- WordPress, WooCommerce y WP-CLI no están instalados o disponibles en el workspace; sus versiones y plugins activos no se pudieron comprobar.
- Requisito declarado por el tema: PHP 7.4 o posterior. La compatibilidad real con una instalación se debe validar en su entorno WordPress/WooCommerce.

## Estructura prevista

- `assets/css`, `assets/js`, `assets/images`, `assets/fonts`: recursos del tema.
- `inc`: configuración, opciones, utilidades e integración con WooCommerce.
- `template-parts`: fragmentos reutilizables de plantillas.
- `woocommerce`: solo sobrescrituras justificadas cuando los hooks no basten.
- Plantillas raíz: `header.php`, `footer.php`, `front-page.php`, `index.php`, `page.php`, `single.php`, `archive.php`, `404.php` y `search.php`.

La Fase 1 crea el scaffold mínimo con `style.css`, `functions.php`, `header.php`, `footer.php`, `index.php`, `inc` y `assets/css`. Las demás carpetas y plantillas se añadirán al implementar sus fases, evitando mantener directorios vacíos o archivos de plantilla sin comportamiento.

## Decisiones técnicas

- Tema clásico basado en plantillas PHP; sin constructor visual ni framework CSS por defecto.
- WooCommerce será un plugin separado y requerido para vender. Este scaffold declara sus soportes; no prueba una tienda hasta instalarlo.
- Se priorizarán hooks y filtros de WooCommerce; no se copiarán plantillas del plugin sin una necesidad demostrada.
- Las opciones editables se implementarán primero con Customizer, Settings API y biblioteca de medios nativos de WordPress. ACF no es requisito; una página global de opciones de ACF requiere ACF Pro.
- Instalar solo un plugin SEO (Yoast SEO o Rank Math). Pasarelas, despacho y wishlist se decidirán cuando se conozcan las necesidades y proveedores reales.
- No se incluyen integraciones de pago o despacho simuladas ni se almacenarán datos de tarjetas.

## Fases

1. Preparar entorno y tema base.
2. Header y footer.
3. Home administrable.
4. Catálogo y filtros.
5. Ficha de producto y variaciones.
6. Carrito y mini carrito.
7. Checkout para Chile.
8. Mi cuenta.
9. Wishlist y búsqueda.
10. Responsive y experiencia móvil.
11. Rendimiento.
12. SEO y accesibilidad.
13. QA en WordPress y WooCommerce reales.