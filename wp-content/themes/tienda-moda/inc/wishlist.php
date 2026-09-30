<?php

defined( 'ABSPATH' ) || exit;

const TIENDA_MODA_WISHLIST_META = '_tienda_moda_wishlist';

/**
 * Keep only existing published products.
 *
 *  array $ids Candidate IDs.
 *  int[]
 */
function tienda_moda_valid_product_ids( $ids ) {
	$ids = array_values( array_unique( array_filter( array_map( 'absint', (array) $ids ) ) ) );
	return array_values( array_filter( $ids, function ( $id ) {
		return 'product' === get_post_type( $id ) && 'publish' === get_post_status( $id );
	} ) );
}

/**
 * Return the current customer's saved product IDs.
 *
 * @return int[]
 */
function tienda_moda_get_wishlist_ids() {
	if ( ! is_user_logged_in() ) {
		return array();
	}

	$ids = get_user_meta( get_current_user_id(), TIENDA_MODA_WISHLIST_META, true );
	return is_array( $ids ) ? tienda_moda_valid_product_ids( $ids ) : array();
}

/**
 * Resolve the favorites page URL.
 *
 * @return string
 */
function tienda_moda_wishlist_url() {
	$page_id = absint( get_option( 'tienda_moda_wishlist_page_id' ) );
	return $page_id && 'publish' === get_post_status( $page_id ) ? get_permalink( $page_id ) : home_url( '/favoritos/' );
}

/**
 * Create the portable favorites page when the theme is activated.
 */
function tienda_moda_create_wishlist_page() {
	$page = get_page_by_path( 'favoritos' );

	if ( ! $page ) {
		$page_id = wp_insert_post(
			array(
				'post_title'   => __( 'Favoritos', 'tienda-moda' ),
				'post_name'    => 'favoritos',
				'post_content' => '[tienda_moda_wishlist]',
				'post_status'  => 'publish',
				'post_type'    => 'page',
			)
		);
	} else {
		$page_id = $page->ID;
	}

	if ( $page_id && ! is_wp_error( $page_id ) ) {
		update_option( 'tienda_moda_wishlist_page_id', absint( $page_id ) );
	}
}
add_action( 'after_switch_theme', 'tienda_moda_create_wishlist_page' );

/**
 * Render an accessible favorite toggle.
 *
 * @param int    $product_id Product ID.
 * @param string $context    Visual context.
 */
function tienda_moda_wishlist_button( $product_id, $context = 'single' ) {
	$product_id = absint( $product_id );
	$is_saved   = in_array( $product_id, tienda_moda_get_wishlist_ids(), true );
	$label      = $is_saved ? __( 'Quitar de favoritos', 'tienda-moda' ) : __( 'Agregar a favoritos', 'tienda-moda' );
	?>
	<button type="button" class="wishlist-button wishlist-button--<?php echo esc_attr( $context ); ?><?php echo $is_saved ? ' is-active' : ''; ?>" data-wishlist-toggle data-product-id="<?php echo esc_attr( $product_id ); ?>" aria-pressed="<?php echo $is_saved ? 'true' : 'false'; ?>" aria-label="<?php echo esc_attr( $label ); ?>">
		<?php echo tienda_moda_icon( 'heart' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
		<span class="wishlist-button-label"><?php echo esc_html( $label ); ?></span>
	</button>
	<?php
}

/**
 * Place the favorite action in the product summary.
 */
function tienda_moda_single_wishlist_button() {
	global $product;

	if ( $product instanceof WC_Product ) {
		tienda_moda_wishlist_button( $product->get_id() );
	}
}
add_action( 'woocommerce_single_product_summary', 'tienda_moda_single_wishlist_button', 31 );

/**
 * Register an account endpoint for favorites.
 */
function tienda_moda_wishlist_endpoint() {
	add_rewrite_endpoint( 'favoritos', EP_ROOT | EP_PAGES );
}
add_action( 'init', 'tienda_moda_wishlist_endpoint' );
add_filter(
	'woocommerce_get_query_vars',
	function ( $vars ) {
		$vars['favoritos'] = 'favoritos';
		return $vars;
	}
);
add_action( 'woocommerce_account_favoritos_endpoint', 'tienda_moda_wishlist_content' );

/**
 * Render the favorites grid shell.
 *
 * @return string
 */
function tienda_moda_wishlist_shortcode() {
	ob_start();
	tienda_moda_wishlist_content();
	return ob_get_clean();
}
add_shortcode( 'tienda_moda_wishlist', 'tienda_moda_wishlist_shortcode' );

function tienda_moda_wishlist_content() {
	$ids = tienda_moda_get_wishlist_ids();
	?>
	<section class="wishlist-page" data-wishlist-page>
		<header class="wishlist-heading">
			<h1><?php esc_html_e( 'Mis favoritos', 'tienda-moda' ); ?></h1>
			<p><?php esc_html_e( 'Guarda aquí las prendas que quieres revisar más tarde.', 'tienda-moda' ); ?></p>
		</header>
		<div class="product-grid wishlist-grid" data-wishlist-grid data-server-ids="<?php echo esc_attr( implode( ',', $ids ) ); ?>">
			<?php tienda_moda_render_wishlist_products( $ids ); ?>
		</div>
		<p class="wishlist-empty"<?php echo $ids ? ' hidden' : ''; ?> data-wishlist-empty><?php esc_html_e( 'Aún no tienes productos favoritos.', 'tienda-moda' ); ?></p>
	</section>
	<?php
}

/**
 * Render reusable product cards for valid IDs.
 *
 * @param int[] $ids Product IDs.
 */
function tienda_moda_render_wishlist_products( $ids ) {
	foreach ( $ids as $product_id ) {
		$product = wc_get_product( $product_id );
		if ( ! $product || ! $product->is_visible() ) {
			continue;
		}
		set_query_var( 'tienda_moda_product', $product );
		get_template_part( 'template-parts/product-card' );
	}
}

/**
 * Toggle a favorite for authenticated customers.
 */
function tienda_moda_ajax_toggle_wishlist() {
	check_ajax_referer( 'tienda_moda_tools', 'nonce' );

	if ( ! is_user_logged_in() ) {
		wp_send_json_error( array( 'message' => __( 'La sesión no está iniciada.', 'tienda-moda' ) ), 401 );
	}

	$product_id = isset( $_POST['product_id'] ) ? absint( wp_unslash( $_POST['product_id'] ) ) : 0;
	if ( ! $product_id || 'product' !== get_post_type( $product_id ) ) {
		wp_send_json_error( array( 'message' => __( 'Producto no válido.', 'tienda-moda' ) ), 400 );
	}

	$ids   = tienda_moda_get_wishlist_ids();
	$saved = ! in_array( $product_id, $ids, true );

	if ( $saved ) {
		$ids[] = $product_id;
	} else {
		$ids = array_values( array_diff( $ids, array( $product_id ) ) );
	}

	update_user_meta( get_current_user_id(), TIENDA_MODA_WISHLIST_META, $ids );
	wp_send_json_success( array( 'saved' => $saved, 'count' => count( $ids ), 'ids' => $ids ) );
}
add_action( 'wp_ajax_tienda_moda_toggle_wishlist', 'tienda_moda_ajax_toggle_wishlist' );

/**
 * Return cards for the guest's browser-stored favorites.
 */
function tienda_moda_ajax_wishlist_products() {
	check_ajax_referer( 'tienda_moda_tools', 'nonce' );

	$raw_ids = isset( $_POST['ids'] ) ? (array) wp_unslash( $_POST['ids'] ) : array();
	$ids     = array_slice( tienda_moda_valid_product_ids( $raw_ids ), 0, 50 );

	ob_start();
	tienda_moda_render_wishlist_products( $ids );
	wp_send_json_success( array( 'html' => ob_get_clean(), 'count' => count( $ids ) ) );
}
add_action( 'wp_ajax_tienda_moda_wishlist_products', 'tienda_moda_ajax_wishlist_products' );
add_action( 'wp_ajax_nopriv_tienda_moda_wishlist_products', 'tienda_moda_ajax_wishlist_products' );
