<?php

defined( 'ABSPATH' ) || exit;

/**
 * Return compact product search results.
 */
function tienda_moda_ajax_product_search() {
	check_ajax_referer( 'tienda_moda_tools', 'nonce' );

	$query = isset( $_POST['query'] ) ? sanitize_text_field( wp_unslash( $_POST['query'] ) ) : '';
	if ( mb_strlen( $query ) < 2 ) {
		wp_send_json_success( array( 'html' => '', 'count' => 0 ) );
	}

	$products = wc_get_products(
		array(
			'status'  => 'publish',
			'limit'   => 6,
			'orderby' => 'relevance',
			'search'  => '*' . $query . '*',
			'return'  => 'objects',
		)
	);

	ob_start();
	foreach ( $products as $product ) {
		?>
		<a class="search-result" href="<?php echo esc_url( $product->get_permalink() ); ?>">
			<span class="search-result-image"><?php echo wp_kses_post( $product->get_image( 'woocommerce_thumbnail', array( 'loading' => 'lazy' ) ) ); ?></span>
			<span class="search-result-content">
				<strong><?php echo esc_html( $product->get_name() ); ?></strong>
				<span><?php echo wp_kses_post( $product->get_price_html() ); ?></span>
			</span>
		</a>
		<?php
	}
	$html = ob_get_clean();

	wp_send_json_success(
		array(
			'html'  => $html,
			'count' => count( $products ),
		)
	);
}
add_action( 'wp_ajax_tienda_moda_product_search', 'tienda_moda_ajax_product_search' );
add_action( 'wp_ajax_nopriv_tienda_moda_product_search', 'tienda_moda_ajax_product_search' );
