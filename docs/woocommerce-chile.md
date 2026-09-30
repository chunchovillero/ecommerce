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

## Checkout

El theme muestra el checkout clásico para administrar los campos chilenos mediante las APIs estables de WooCommerce.

Campos principales:

- Nombre y apellido.
- Correo electrónico.
- Teléfono.
- RUT validado con módulo 11.
- Dirección.
- Región, usando los estados de Chile incluidos en WooCommerce.
- Comuna.
- Código postal opcional.

Los métodos de despacho, retiro y pago deben configurarse desde WooCommerce cuando se definan los proveedores reales. No hay pasarelas ni transportistas simulados.

wp-config.php, credenciales, claves de pago y datos de tarjetas no se versionan.
