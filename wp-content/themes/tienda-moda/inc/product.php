<?php

defined( 'ABSPATH' ) || exit;

/**
 * Configure the single-product hooks without copying WooCommerce templates.
 */
function tienda_moda_product_hooks() {
	if ( ! function_exists( 'is_product' ) || ! is_product() ) {
		return;
	}

	remove_action( 'woocommerce_sidebar', 'woocommerce_get_sidebar', 10 );
	add_action( 'woocommerce_single_product_summary', 'tienda_moda_product_discount', 11 );
	add_action( 'woocommerce_single_product_summary', 'tienda_moda_size_guide_trigger', 29 );
	add_action( 'woocommerce_single_product_summary', 'tienda_moda_product_service_info', 35 );
	add_action( 'woocommerce_after_single_product_summary', 'tienda_moda_size_guide_dialog', 8 );
}
add_action( 'wp', 'tienda_moda_product_hooks' );

/**
 * Display the largest applicable discount.
 */
function tienda_moda_product_discount() {
	global $product;

	if ( ! $product || ! $product->is_on_sale() ) {
		return;
	}

	if ( $product->is_type( 'variable' ) ) {
		$regular = (float) $product->get_variation_regular_price( 'min', true );
		$sale    = (float) $product->get_variation_sale_price( 'min', true );
	} else {
		$regular = (float) $product->get_regular_price();
		$sale    = (float) $product->get_sale_price();
	}

	if ( $regular <= 0 || $sale >= $regular ) {
		return;
	}

	$percentage = (int) round( ( ( $regular - $sale ) / $regular ) * 100 );
	echo '<p class="single-discount">' . esc_html( sprintf( __( '%d%% de descuento', 'tienda-moda' ), $percentage ) ) . '</p>';
}

/**
 * Add the buy-now action beside WooCommerce's cart button.
 */
function tienda_moda_buy_now_button() {
	echo '<button type="submit" class="button buy-now-button" name="tienda_moda_buy_now" value="1">' . esc_html__( 'Comprar ahora', 'tienda-moda' ) . '</button>';
}
add_action( 'woocommerce_after_add_to_cart_button', 'tienda_moda_buy_now_button' );

/**
 * Send a successful buy-now action directly to checkout.
 *
 * @param string $url Default redirect.
 * @return string
 */
function tienda_moda_buy_now_redirect( $url ) {
	$buy_now = isset( $_REQUEST['tienda_moda_buy_now'] ) ? sanitize_text_field( wp_unslash( $_REQUEST['tienda_moda_buy_now'] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Recommended
	return '1' === $buy_now ? wc_get_checkout_url() : $url;
}
add_filter( 'woocommerce_add_to_cart_redirect', 'tienda_moda_buy_now_redirect' );

/**
 * Display configured shipping information.
 */
function tienda_moda_product_service_info() {
	$shipping = get_theme_mod( 'tienda_moda_product_shipping', '' );

	if ( ! $shipping ) {
		return;
	}
	?>
	<div class="product-service-info">
		<?php echo tienda_moda_icon( 'truck' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
		<p><?php echo esc_html( $shipping ); ?></p>
	</div>
	<?php
}

/**
 * Get the size guide stored for the current product.
 *
 * @param int $product_id Product ID.
 * @return string
 */
function tienda_moda_get_size_guide( $product_id = 0 ) {
	$product_id = $product_id ?: get_the_ID();
	return (string) get_post_meta( $product_id, '_tienda_moda_size_guide', true );
}

/**
 * Render a size guide table from pipe-separated rows.
 *
 * @param string $guide Raw guide.
 */
function tienda_moda_render_size_guide( $guide ) {
	$rows = array_values( array_filter( array_map( 'trim', preg_split( '/\R/', $guide ) ) ) );

	if ( ! $rows ) {
		return;
	}

	$headings = array_map( 'trim', explode( '|', array_shift( $rows ) ) );

	echo '<div class="size-table-wrap"><table class="size-table"><thead><tr>';
	foreach ( $headings as $heading ) {
		echo '<th>' . esc_html( $heading ) . '</th>';
	}
	echo '</tr></thead>';

	if ( $rows ) {
		echo '<tbody>';
		foreach ( $rows as $row ) {
			$cells = array_map( 'trim', explode( '|', $row ) );
			echo '<tr>';
			foreach ( $cells as $cell ) {
				echo '<td>' . esc_html( $cell ) . '</td>';
			}
			echo '</tr>';
		}
		echo '</tbody>';
	}

	echo '</table></div>';
}

/**
 * Show the guide trigger only when this product has guide data.
 */
function tienda_moda_size_guide_trigger() {
	if ( ! tienda_moda_get_size_guide() ) {
		return;
	}
	?>
	<button type="button" class="size-guide-trigger" data-size-guide-open>
		<?php esc_html_e( 'Guía de tallas', 'tienda-moda' ); ?>
	</button>
	<?php
}

/**
 * Render an accessible native dialog for the size guide.
 */
function tienda_moda_size_guide_dialog() {
	$guide = tienda_moda_get_size_guide();

	if ( ! $guide ) {
		return;
	}
	?>
	<dialog class="size-guide-dialog" id="size-guide-dialog" aria-labelledby="size-guide-title">
		<div class="dialog-header">
			<h2 id="size-guide-title"><?php esc_html_e( 'Guía de tallas', 'tienda-moda' ); ?></h2>
			<button type="button" data-size-guide-close aria-label="<?php esc_attr_e( 'Cerrar guía de tallas', 'tienda-moda' ); ?>">
				<?php echo tienda_moda_icon( 'close' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			</button>
		</div>
		<?php tienda_moda_render_size_guide( $guide ); ?>
	</dialog>
	<?php
}

/**
 * Add product information tabs owned by the store.
 *
 * @param array $tabs Existing tabs.
 * @return array
 */
function tienda_moda_product_tabs( $tabs ) {
	$guide  = tienda_moda_get_size_guide();
	$returns = get_theme_mod( 'tienda_moda_product_returns', '' );

	if ( isset( $tabs['additional_information'] ) ) {
		$tabs['additional_information']['title'] = __( 'Características', 'tienda-moda' );
	}

	if ( $guide ) {
		$tabs['size_guide'] = array(
			'title'    => __( 'Guía de tallas', 'tienda-moda' ),
			'priority' => 25,
			'callback' => 'tienda_moda_size_guide_tab',
		);
	}

	if ( $returns ) {
		$tabs['returns'] = array(
			'title'    => __( 'Cambios y devoluciones', 'tienda-moda' ),
			'priority' => 30,
			'callback' => 'tienda_moda_returns_tab',
		);
	}

	return $tabs;
}
add_filter( 'woocommerce_product_tabs', 'tienda_moda_product_tabs' );

function tienda_moda_size_guide_tab() {
	tienda_moda_render_size_guide( tienda_moda_get_size_guide() );
}

function tienda_moda_returns_tab() {
	echo wp_kses_post( wpautop( get_theme_mod( 'tienda_moda_product_returns', '' ) ) );
}

/**
 * Keep related products aligned with the theme grid.
 *
 * @param array $args Related arguments.
 * @return array
 */
function tienda_moda_related_products_args( $args ) {
	$args['posts_per_page'] = 4;
	$args['columns']        = 4;
	return $args;
}
add_filter( 'woocommerce_output_related_products_args', 'tienda_moda_related_products_args' );

