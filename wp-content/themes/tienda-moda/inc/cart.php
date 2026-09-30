<?php

defined( 'ABSPATH' ) || exit;

/**
 * Render the global mini-cart drawer.
 */
function tienda_moda_mini_cart_drawer() {
	if ( ! function_exists( 'woocommerce_mini_cart' ) || is_cart() || is_checkout() ) {
		return;
	}
	?>
	<div class="mini-cart-overlay" data-mini-cart-close hidden></div>
	<aside id="mini-cart-drawer" class="mini-cart-drawer" aria-hidden="true" aria-labelledby="mini-cart-title">
		<div class="mini-cart-header">
			<h2 id="mini-cart-title"><?php esc_html_e( 'Tu carrito', 'tienda-moda' ); ?></h2>
			<button type="button" class="mini-cart-close" data-mini-cart-close aria-label="<?php esc_attr_e( 'Cerrar carrito', 'tienda-moda' ); ?>">
				<?php echo tienda_moda_icon( 'close' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			</button>
		</div>
		<p class="mini-cart-notice" role="status" aria-live="polite"></p>
		<div class="mini-cart-content">
			<?php woocommerce_mini_cart(); ?>
		</div>
	</aside>
	<?php
}
add_action( 'wp_footer', 'tienda_moda_mini_cart_drawer', 5 );

/**
 * Refresh the drawer content whenever WooCommerce refreshes cart fragments.
 *
 * @param array $fragments Existing fragments.
 * @return array
 */
function tienda_moda_mini_cart_fragment( $fragments ) {
	ob_start();
	?>
	<div class="mini-cart-content">
		<?php woocommerce_mini_cart(); ?>
	</div>
	<?php
	$fragments['.mini-cart-content'] = ob_get_clean();
	return $fragments;
}
add_filter( 'woocommerce_add_to_cart_fragments', 'tienda_moda_mini_cart_fragment' );

/**
 * Add a cart-specific body class for both block and shortcode carts.
 *
 * @param array $classes Body classes.
 * @return array
 */
function tienda_moda_cart_body_classes( $classes ) {
	if ( function_exists( 'is_cart' ) && is_cart() ) {
		$classes[] = 'tienda-moda-cart-page';
	}
	return $classes;
}
add_filter( 'body_class', 'tienda_moda_cart_body_classes' );

