<?php

defined( 'ABSPATH' ) || exit;

/**
 * Whether WooCommerce's complete frontend bundle is needed.
 *
 * @return bool
 */
function tienda_moda_is_commerce_screen() {
	return ( function_exists( 'is_woocommerce' ) && is_woocommerce() )
		|| ( function_exists( 'is_cart' ) && is_cart() )
		|| ( function_exists( 'is_checkout' ) && is_checkout() )
		|| ( function_exists( 'is_account_page' ) && is_account_page() );
}

/**
 * Avoid WooCommerce's generic CSS on pages rendered entirely by the theme.
 *
 * @param array $styles Registered WooCommerce styles.
 * @return array
 */
function tienda_moda_limit_woocommerce_styles( $styles ) {
	return tienda_moda_is_commerce_screen() ? $styles : array();
}
add_filter( 'woocommerce_enqueue_styles', 'tienda_moda_limit_woocommerce_styles' );

/**
 * Remove interaction bundles where there are no WooCommerce forms or buttons.
 */
function tienda_moda_limit_woocommerce_scripts() {
	if ( tienda_moda_is_commerce_screen() ) {
		return;
	}

	foreach ( array( 'wc-cart-fragments', 'wc-add-to-cart', 'woocommerce', 'wc-jquery-blockui', 'wc-js-cookie' ) as $handle ) {
		wp_dequeue_script( $handle );
	}
}
add_action( 'wp_enqueue_scripts', 'tienda_moda_limit_woocommerce_scripts', 100 );

/**
 * Cache home product IDs briefly and clear them when catalog data changes.
 */
function tienda_moda_clear_home_product_cache() {
	foreach ( array( 'new', 'popular', 'sale' ) as $group ) {
		delete_transient( 'tienda_moda_home_products_' . $group . '_8' );
	}
}
add_action( 'save_post_product', 'tienda_moda_clear_home_product_cache' );
add_action( 'woocommerce_order_status_changed', 'tienda_moda_clear_home_product_cache' );
add_action( 'woocommerce_product_set_stock', 'tienda_moda_clear_home_product_cache' );
