# Puesta en producción

El sitio local queda funcional para catálogo, carrito, checkout, SEO, WhatsApp y logística chilena. Antes de publicar en Internet se requieren credenciales y datos reales del comercio:

- Instalar el plugin oficial de Mercado Pago, conectar primero credenciales de prueba y ejecutar una compra completa en sandbox.
- Informar razón social, RUT, domicilio comercial, correo y teléfono reales.
- Definir las cuentas bancarias de la transferencia.
- Registrar las direcciones y horarios reales de retiro.
- Revisar las tarifas, plazos y cobertura de cada comuna.
- Configurar dominio, certificado HTTPS y correo SMTP transaccional.
- Habilitar la indexación, comprobar `robots.txt` y registrar el sitemap definitivo de Rank Math en Search Console.
- Conectar Search Console y la propiedad real de analítica; completar el consentimiento de cookies si corresponde.
- Configurar el número real en **Ajustes > WhatsApp**, con código de país y solo dígitos.
- Revisar los textos legales con asesoría jurídica antes de publicarlos como condiciones definitivas.
- Programar `scripts/backup-wordpress.sh` fuera del horario de mayor tráfico y copiar los respaldos a almacenamiento externo.

Nunca deben almacenarse claves de producción dentro del repositorio.

## Estado local de pagos

Están activos **Transferencia bancaria** y **Pago al recibir o retirar** para las pruebas. Antes del lanzamiento se deben completar los datos bancarios, limitar el pago contra entrega a modalidades válidas y decidir si ambos métodos permanecerán disponibles junto con Mercado Pago.

## Imágenes y archivos subidos

Las fuentes editoriales viven en `wp-content/themes/tienda-moda/assets/images`. WordPress crea sus copias en `wp-content/uploads`, carpeta que debe respaldarse y desplegarse por separado porque no forma parte del repositorio.
