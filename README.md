# Tienda de Moda

Proyecto WordPress completo preparado para evolucionar como tienda propia con WooCommerce. Incluye el core y el theme personalizado; no incluye credenciales, productos ni configuraciones de producción.

## Instalación local de WordPress

El entorno usa WordPress con PHP 8.3 y MariaDB 11.4. El core, `wp-content` y el theme forman parte de este repositorio; la base de datos vive en un volumen de Docker. El theme está en `wp-content/themes/tienda-moda`. `.env` y `.git` quedan ocultos dentro del contenedor web.

1. Ejecutar `docker compose up -d`.
2. Abrir `http://localhost:8080` y completar el instalador de WordPress.
3. Activar **Tienda de Moda** desde Apariencia > Temas.

Comprobaciones útiles:

```bash
docker compose ps
docker compose logs wordpress
docker compose --profile tools run --rm wpcli core version
```

Para detener el entorno, usar `docker compose down`. No agregar `--volumes` si se desea conservar el sitio y la base de datos.

## Requisitos y estado

- Entorno de desarrollo inspeccionado: PHP 8.5.4, Git 2.53.0, Node.js 24.21.0 y Composer disponibles.
- WordPress 7.1.2 y WooCommerce 11.1.2 funcionan localmente en Docker con PHP 8.3.
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
- WooCommerce se mantiene como plugin separado; el tema integra catálogo, producto, carrito, checkout chileno, cuenta, favoritos y búsqueda AJAX mediante sus APIs.
- Se priorizarán hooks y filtros de WooCommerce; no se copiarán plantillas del plugin sin una necesidad demostrada.
- Las opciones editables se implementarán primero con Customizer, Settings API y biblioteca de medios nativos de WordPress. ACF no es requisito; una página global de opciones de ACF requiere ACF Pro.
- Instalar solo un plugin SEO (Yoast SEO o Rank Math). Las pasarelas y empresas de despacho se decidirán con proveedores reales. La wishlist ligera está implementada en el tema sin plugin adicional.
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

Las fases 1 a 10 están implementadas. La página `Favoritos` se crea al activar el tema y guarda datos en la cuenta del cliente o en el navegador para visitantes.
