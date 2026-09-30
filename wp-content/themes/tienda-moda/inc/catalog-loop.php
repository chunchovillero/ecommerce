<?php

defined( 'ABSPATH' ) || exit;

/**
 * Use a div grid because the custom product card is an article.
 *
 * @param string $markup Original markup.
 * @return string
 */
function tienda_moda_product_loop_start( $markup ) {
	if ( function_exists( 'is_shop' ) && ( is_shop() || is_product_taxonomy() ) ) {
		return '<div class="products product-grid columns-' . esc_attr( tienda_moda_catalog_columns() ) . '">';
	}
	if ( function_exists( 'is_product' ) && is_product() ) {
		return '<div class="products product-grid columns-' . esc_attr( wc_get_loop_prop( 'columns', 4 ) ) . '">';
	}
	return $markup;
}
add_filter( 'woocommerce_product_loop_start', 'tienda_moda_product_loop_start' );

/**
 * Close the matching product grid wrapper.
 *
 * @param string $markup Original markup.
 * @return string
 */
function tienda_moda_product_loop_end( $markup ) {
	if ( function_exists( 'is_shop' ) && ( is_shop() || is_product_taxonomy() ) ) {
		return '</div>';
	}
	if ( function_exists( 'is_product' ) && is_product() ) {
		return '</div>';
	}
	return $markup;
}
add_filter( 'woocommerce_product_loop_end', 'tienda_moda_product_loop_end' );

