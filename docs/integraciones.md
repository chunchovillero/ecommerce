# Integraciones

Estado verificado el 5 de octubre de 2026.

## Rank Math SEO

- Plugin: `seo-by-rank-math` 1.0.279, activo.
- Configuración reproducible: `scripts/configure-rank-math.php`.
- Schema predeterminado: Product de WooCommerce.
- Sitemap de productos, páginas y categorías con imágenes destacadas.
- Fuera del índice: carrito, checkout, Mi cuenta, Favoritos, búsquedas internas, etiquetas, autores y archivos por fecha.
- El tema detecta Rank Math y omite su fallback de descripción y Open Graph.
- Analytics y Content AI permanecen desactivados hasta disponer de cuentas y consentimiento reales.

Con enlaces permanentes simples, el sitemap local está en `http://localhost:8080/?sitemap=1`. En producción se debe habilitar la indexación, configurar enlaces permanentes y registrar el sitemap definitivo en Search Console.

## WhatsApp

- Plugin propio: `tienda-whatsapp` 1.0.0, activo.
- Configuración: **Ajustes > WhatsApp**.
- No muestra el botón mientras el número esté vacío.
- El número debe incluir código de país y solo dígitos; por ejemplo `56912345678`.
- Permite editar estado, mensaje, etiqueta, color y posición.
- En productos agrega nombre y URL; en carrito y checkout agrega contexto al mensaje.

## Mercado Pago

Se utilizará el plugin oficial **Mercado Pago payments for WooCommerce**, slug `woocommerce-mercadopago`. No está instalado todavía y no se deben activar cobros sin credenciales reales.

1. Crear o verificar la cuenta vendedora de Mercado Pago Chile.
2. Instalar y activar el plugin oficial.
3. Ingresar credenciales de prueba.
4. Configurar Checkout Pro o el checkout de tarjetas requerido.
5. Ejecutar pagos aprobados, rechazados y pendientes en sandbox.
6. Comprobar webhooks, pedidos, correos y cambios de estado.
7. Configurar HTTPS y cambiar a credenciales de producción.
8. Ejecutar una compra real de bajo monto y probar el reembolso.

Las credenciales nunca deben escribirse en Markdown, scripts, SQL ni control de versiones.

## Logística chilena

- Plugin propio: `tienda-envios-chile` 4.0.0.
- Contiene 16 regiones y 346 comunas.
- Soporta despacho, retiro, envío por pagar, combinaciones, sin cobertura, plazos y envío gratis.
- Administración: **WooCommerce > Ajustes > Envío > Tarifas por comuna**.
- Prueba: `wp-content/plugins/tienda-envios-chile/tests/smoke.php`.

## Correos

WooCommerce utiliza el nombre de la tienda como remitente. El entorno local no posee SMTP y no entrega correos. En producción se debe conectar un proveedor SMTP o transaccional, configurar SPF, DKIM y DMARC, y probar los correos de pedido.
