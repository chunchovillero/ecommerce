# Configuración de WooCommerce para Chile

Estas opciones viven en la base de datos y deben verificarse después de importar o instalar el proyecto en otro servidor.

## General

- Moneda: peso chileno (CLP).
- Posición de moneda: izquierda.
- Separador de miles: punto.
- Separador decimal: coma.
- Número de decimales: cero.
- País predeterminado: Chile.

El formato esperado para 19990 es $19.990.

## Plugin de localización chilena

La funcionalidad está encapsulada en **WooCommerce Chile — RUT, Comunas y Envíos**, dentro de `wp-content/plugins/tienda-envios-chile`. El tema solo define la presentación visual.

## Checkout

El theme muestra el checkout clásico para administrar los campos chilenos mediante las APIs estables de WooCommerce.

Campos principales:

- Nombre y apellido.
- Correo electrónico.
- Teléfono.
- RUT validado con módulo 11.
- Dirección.
- Región, usando los estados de Chile incluidos en WooCommerce.
- Comuna, como selector dependiente de la región (las combinaciones también se validan en el servidor).
- Código postal opcional.

Los métodos de despacho, retiro y envío por pagar se calculan mediante el plugin. Las comunas sin configuración explícita pueden recibir automáticamente **Envío por pagar**. El plazo general local es de 2 a 5 días hábiles.

Las tarifas individuales se administran en **WooCommerce > Ajustes > Envío > Tarifas por comuna**. Un valor configurado reemplaza el costo del método **Precio fijo** de la zona correspondiente; un campo vacío conserva el precio de la zona y `0` ofrece envío gratuito.

El plugin también permite configurar cobertura, retiro, envío por pagar, plazo estimado, umbral de envío gratis y sucursales. La configuración puede respaldarse o cargarse mediante CSV con las columnas `region`, `comuna`, `precio`, `modalidad`, `plazo` y `envio_gratis_desde`. Los datos relevantes se guardan en el pedido y se muestran en administración y correos.

wp-config.php, credenciales, claves de pago y datos de tarjetas no se versionan.

## Pagos locales

Para desarrollo están activos **Transferencia bancaria** y **Pago al recibir o retirar**. El plugin oficial de Mercado Pago está seleccionado como pasarela online, pero debe instalarse y conectarse con credenciales aportadas por el comercio.
