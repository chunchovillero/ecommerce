<?php

defined( 'ABSPATH' ) || exit;

/**
 * Keep only the requested ordering choices with clear labels.
 *
 * @param array $options WooCommerce ordering options.
 * @return array
 */
function tienda_moda_catalog_ordering_options( $options ) {
	$labels = array(
		'date'       => __( 'Más recientes', 'tienda-moda' ),
		'price'      => __( 'Precio menor a mayor', 'tienda-moda' ),
		'price-desc' => __( 'Precio mayor a menor', 'tienda-moda' ),
		'popularity' => __( 'Más vendidos', 'tienda-moda' ),
	);

	return array_intersect_key( $labels, $options );
}
add_filter( 'woocommerce_catalog_orderby', 'tienda_moda_catalog_ordering_options' );
add_filter( 'woocommerce_default_catalog_orderby_options', 'tienda_moda_catalog_ordering_options' );

