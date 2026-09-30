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

	$args = array(
		'status' => 'publish',
		'limit'  => absint( $limit ),
		'return' => 'objects',
	);

	if ( 'popular' === $group ) {
		$args['orderby'] = 'popularity';
		$args['order']   = 'DESC';
	} elseif ( 'sale' === $group ) {
		$args['include'] = wc_get_product_ids_on_sale();
		$args['orderby'] = 'date';
		$args['order']   = 'DESC';

		if ( empty( $args['include'] ) ) {
			return array();
		}
	} else {
		$args['orderby'] = 'date';
		$args['order']   = 'DESC';
	}

	return wc_get_products( $args );
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

