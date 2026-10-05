<?php
/** Run with: wp eval-file wp-content/plugins/tienda-envios-chile/tests/smoke.php */

$failures = array();
$groups = tienda_envios_chile_communes();
if ( 16 !== count( $groups ) || 346 !== array_sum( array_map( 'count', $groups ) ) ) $failures[] = 'El catálogo no contiene 16 regiones y 346 comunas.';
if ( ! tienda_moda_is_valid_rut( '12.345.678-5' ) || tienda_moda_is_valid_rut( '12.345.678-9' ) ) $failures[] = 'La validación de RUT falló.';
$fields = apply_filters( 'woocommerce_checkout_fields', WC()->checkout()->get_checkout_fields() );
foreach ( array( 'billing_rut', 'billing_document_type', 'billing_city', 'billing_state' ) as $field ) if ( ! isset( $fields['billing'][ $field ] ) ) $failures[] = 'Falta el campo ' . $field;
add_filter( 'pre_option_tienda_moda_commune_shipping_rates', function() { return array( 'CL-AP' => array( 'Arica' => 3500 ) ); } );
add_filter( 'pre_option_tienda_envios_chile_commune_modes', function() { return array( 'CL-AP' => array( 'Arica' => 'delivery_pickup_collect' ) ); } );
$result = tienda_envios_chile_apply_commune_shipping_rate( array(), array( 'destination' => array( 'country' => 'CL', 'state' => 'CL-AP', 'city' => 'Arica' ) ) );
if ( 3 !== count( $result ) ) $failures[] = 'No se generaron despacho, retiro y envío por pagar.';
if ( $failures ) WP_CLI::error( implode( "\n", $failures ) );
WP_CLI::success( 'Plugin Chile: pruebas de humo correctas.' );
