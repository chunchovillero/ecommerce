<?php

defined( 'ABSPATH' ) || exit;

/**
 * Fetch products for a home section without changing the main query.
 *
 * @param string $group new, popular or sale.
 * @param int    $limit Maximum results.
 * @return array
 */
function tienda_moda_get_home_products( $group, $limit = 8 ) {
	if ( ! function_exists( 'wc_get_products' ) ) {
		return array();
	}

	$limit       = absint( $limit );
	$cache_key   = 'tienda_moda_home_products_' . sanitize_key( $group ) . '_' . $limit;
	$product_ids = get_transient( $cache_key );

	if ( false !== $product_ids ) {
		$products = array_map( 'wc_get_product', $product_ids );
		return array_values( array_filter( $products ) );
	}

	$args = array(
		'status' => 'publish',
		'limit'  => $limit,
		'return' => 'ids',
	);

	if ( 'popular' === $group ) {
		$args['orderby'] = 'popularity';
		$args['order']   = 'DESC';
	} elseif ( 'sale' === $group ) {
		$args['include'] = wc_get_product_ids_on_sale();
		$args['orderby'] = 'date';
		$args['order']   = 'DESC';

		if ( empty( $args['include'] ) ) {
			set_transient( $cache_key, array(), 5 * MINUTE_IN_SECONDS );
			return array();
		}
	} else {
		$args['orderby'] = 'date';
		$args['order']   = 'DESC';
	}

	$product_ids = wc_get_products( $args );
	set_transient( $cache_key, $product_ids, 5 * MINUTE_IN_SECONDS );

	$products = array_map( 'wc_get_product', $product_ids );
	return array_values( array_filter( $products ) );
}

/**
 * Render a reusable product section.
 *
 * @param string $title    Visible heading.
 * @param string $group    Query group.
 * @param string $view_url Optional archive URL.
 */
function tienda_moda_render_product_section( $title, $group, $view_url = '' ) {
	$products = tienda_moda_get_home_products( $group );

	if ( empty( $products ) ) {
		return;
	}
	?>
	<section class="home-section product-section">
		<div class="section-heading">
			<h2><?php echo esc_html( $title ); ?></h2>
			<?php if ( $view_url ) : ?>
				<a href="<?php echo esc_url( $view_url ); ?>"><?php esc_html_e( 'Ver todo', 'tienda-moda' ); ?></a>
			<?php endif; ?>
		</div>
		<div class="product-grid">
			<?php foreach ( $products as $product ) : ?>
				<?php
				set_query_var( 'tienda_moda_product', $product );
				get_template_part( 'template-parts/product', 'card' );
				?>
			<?php endforeach; ?>
		</div>
	</section>
	<?php
}

