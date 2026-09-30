<?php

defined( 'ABSPATH' ) || exit;

/**
 * Return a small accessible decorative icon.
 *
 * @param string $name Icon identifier.
 * @return string
 */
function tienda_moda_icon( $name ) {
	$paths = array(
		'menu'   => '<path d="M4 7h16M4 12h16M4 17h16"/>',
		'close'  => '<path d="m6 6 12 12M18 6 6 18"/>',
		'search' => '<circle cx="11" cy="11" r="6.5"/><path d="m16 16 4 4"/>',
		'user'   => '<circle cx="12" cy="8" r="3.5"/><path d="M5.5 20c.6-4 3-6 6.5-6s5.9 2 6.5 6"/>',
		'bag'    => '<path d="M5 8h14l-1 12H6L5 8Z"/><path d="M9 9V6a3 3 0 0 1 6 0v3"/>',
	);

	if ( ! isset( $paths[ $name ] ) ) {
		return '';
	}

	return '<svg class="icon" aria-hidden="true" focusable="false" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">' . $paths[ $name ] . '</svg>';
}

/**
 * Provide a useful menu before an administrator assigns one.
 */
function tienda_moda_primary_menu_fallback() {
	$shop_url = function_exists( 'wc_get_page_permalink' ) ? wc_get_page_permalink( 'shop' ) : home_url( '/' );

	echo '<ul class="menu">';
	echo '<li><a href="' . esc_url( home_url( '/' ) ) . '">' . esc_html__( 'Inicio', 'tienda-moda' ) . '</a></li>';
	echo '<li><a href="' . esc_url( $shop_url ) . '">' . esc_html__( 'Tienda', 'tienda-moda' ) . '</a></li>';
	echo '</ul>';
}

/**
 * Read the cart count safely when WooCommerce is available.
 *
 * @return int
 */
function tienda_moda_cart_count() {
	return function_exists( 'WC' ) && WC()->cart ? WC()->cart->get_cart_contents_count() : 0;
}

/**
 * Refresh the cart badge after WooCommerce AJAX add-to-cart actions.
 *
 * @param array $fragments Existing fragments.
 * @return array
 */
function tienda_moda_cart_count_fragment( $fragments ) {
	ob_start();
	?>
	<span class="cart-count" aria-label="<?php echo esc_attr( sprintf( _n( '%d producto', '%d productos', tienda_moda_cart_count(), 'tienda-moda' ), tienda_moda_cart_count() ) ); ?>"><?php echo esc_html( tienda_moda_cart_count() ); ?></span>
	<?php
	$fragments['.header-cart .cart-count'] = ob_get_clean();

	return $fragments;
}
add_filter( 'woocommerce_add_to_cart_fragments', 'tienda_moda_cart_count_fragment' );

