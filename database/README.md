# Base de datos de demostración

`demo.sql` contiene el estado portable de la tienda local, incluidos los 40
productos de prueba. El respaldo conserva la estructura de todas las tablas,
pero no incluye datos de usuarios, sesiones, comentarios ni pedidos. Los
correos personales encontrados durante la exportación fueron anonimizados.

## Restauración local

Con los contenedores activos, importar el respaldo y crear un administrador:

```bash
docker compose exec -T db sh -c 'mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE"' < database/demo.sql
docker compose --profile tools run --rm wpcli user create admin admin@example.test --role=administrator --user_pass='CAMBIAR-ESTA-CLAVE'
docker compose --profile tools run --rm wpcli cache flush
```

Cambiar inmediatamente el correo y la contraseña de ejemplo. Para otro dominio,
seguir el procedimiento de búsqueda y reemplazo de `docs/deployment.md`.

## Actualización del respaldo

El archivo se generó el 2 de octubre de 2026. No sustituirlo por un volcado de
producción: este archivo está pensado solo como datos de demostración seguros
para desarrollo.
