<?php

defined( 'ABSPATH' ) || exit;

/**
 * Replace WooCommerce wrappers with the catalog layout.
 */
function tienda_moda_catalog_hooks() {
	if ( ! function_exists( 'is_shop' ) || ( ! is_shop() && ! is_product_taxonomy() ) ) {
		return;
	}

	remove_action( 'woocommerce_before_main_content', 'woocommerce_output_content_wrapper', 10 );
	remove_action( 'woocommerce_after_main_content', 'woocommerce_output_content_wrapper_end', 10 );
	remove_action( 'woocommerce_sidebar', 'woocommerce_get_sidebar', 10 );
	remove_action( 'woocommerce_shop_loop_header', 'woocommerce_product_taxonomy_archive_header', 10 );
	remove_action( 'woocommerce_before_shop_loop', 'woocommerce_catalog_ordering', 30 );
	remove_action( 'woocommerce_before_shop_loop', 'woocommerce_result_count', 20 );

	add_action( 'woocommerce_before_main_content', 'tienda_moda_catalog_open', 10 );
	add_action( 'woocommerce_after_main_content', 'tienda_moda_catalog_close', 10 );
	add_action( 'woocommerce_before_shop_loop', 'tienda_moda_catalog_toolbar', 20 );
}
add_action( 'wp', 'tienda_moda_catalog_hooks' );

/**
 * Open the archive shell and render filters.
 */
function tienda_moda_catalog_open() {
	?>
	<div class="catalog-container">
		<?php woocommerce_breadcrumb(); ?>
		<div class="catalog-heading">
			<h1><?php woocommerce_page_title(); ?></h1>
			<?php do_action( 'woocommerce_archive_description' ); ?>
		</div>
		<div class="catalog-layout">
			<div class="filter-overlay" data-filter-close hidden></div>
			<aside id="catalog-filters" class="catalog-filters" aria-labelledby="catalog-filters-title">
				<div class="filter-drawer-header">
					<h2 id="catalog-filters-title"><?php esc_html_e( 'Filtrar', 'tienda-moda' ); ?></h2>
					<button type="button" class="filter-close" data-filter-close aria-label="<?php esc_attr_e( 'Cerrar filtros', 'tienda-moda' ); ?>">
						<?php echo tienda_moda_icon( 'close' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
					</button>
				</div>
				<?php tienda_moda_catalog_filter_form(); ?>
			</aside>
			<div class="catalog-products">
	<?php
}

/**
 * Close the archive shell.
 */
function tienda_moda_catalog_close() {
	?>
			</div>
		</div>
	</div>
	<?php
}

/**
 * Safely read a scalar catalog query parameter.
 *
 * @param string $key Parameter key.
 * @return string
 */
function tienda_moda_catalog_param( $key ) {
	if ( ! isset( $_GET[ $key ] ) || ! is_scalar( $_GET[ $key ] ) ) {
		return '';
	}

	return sanitize_text_field( wp_unslash( $_GET[ $key ] ) );
}

/**
 * Render filter controls based on real catalog taxonomies.
 */
function tienda_moda_catalog_filter_form() {
	$action     = home_url( '/' );
	$categories = get_terms( array( 'taxonomy' => 'product_cat', 'hide_empty' => true ) );
	$taxonomies = array(
		'catalog_size'  => array( 'taxonomy' => 'pa_size', 'label' => __( 'Talla', 'tienda-moda' ) ),
		'catalog_color' => array( 'taxonomy' => 'pa_color', 'label' => __( 'Color', 'tienda-moda' ) ),
	);
	?>
	<form class="catalog-filter-form" action="<?php echo esc_url( $action ); ?>" method="get">
		<input type="hidden" name="post_type" value="product">
		<?php if ( ! is_wp_error( $categories ) && $categories ) : ?>
			<fieldset>
				<legend><?php esc_html_e( 'Categoría', 'tienda-moda' ); ?></legend>
				<select name="catalog_category" aria-label="<?php esc_attr_e( 'Categoría', 'tienda-moda' ); ?>">
					<option value=""><?php esc_html_e( 'Todas', 'tienda-moda' ); ?></option>
					<?php foreach ( $categories as $category ) : ?>
						<option value="<?php echo esc_attr( $category->slug ); ?>" <?php selected( tienda_moda_catalog_param( 'catalog_category' ), $category->slug ); ?>>
							<?php echo esc_html( $category->name ); ?>
						</option>
					<?php endforeach; ?>
				</select>
			</fieldset>
		<?php endif; ?>

		<fieldset>
			<legend><?php esc_html_e( 'Precio', 'tienda-moda' ); ?></legend>
			<div class="price-fields">
				<label><span><?php esc_html_e( 'Mínimo', 'tienda-moda' ); ?></span><input type="number" min="0" step="1" name="min_price" value="<?php echo esc_attr( tienda_moda_catalog_param( 'min_price' ) ); ?>"></label>
				<label><span><?php esc_html_e( 'Máximo', 'tienda-moda' ); ?></span><input type="number" min="0" step="1" name="max_price" value="<?php echo esc_attr( tienda_moda_catalog_param( 'max_price' ) ); ?>"></label>
			</div>
		</fieldset>

		<?php foreach ( $taxonomies as $name => $config ) : ?>
			<?php if ( taxonomy_exists( $config['taxonomy'] ) ) : ?>
				<?php $terms = get_terms( array( 'taxonomy' => $config['taxonomy'], 'hide_empty' => true ) ); ?>
				<?php if ( ! is_wp_error( $terms ) && $terms ) : ?>
					<fieldset>
						<legend><?php echo esc_html( $config['label'] ); ?></legend>
						<select name="<?php echo esc_attr( $name ); ?>" aria-label="<?php echo esc_attr( $config['label'] ); ?>">
							<option value=""><?php esc_html_e( 'Todos', 'tienda-moda' ); ?></option>
							<?php foreach ( $terms as $term ) : ?>
								<option value="<?php echo esc_attr( $term->slug ); ?>" <?php selected( tienda_moda_catalog_param( $name ), $term->slug ); ?>><?php echo esc_html( $term->name ); ?></option>
							<?php endforeach; ?>
						</select>
					</fieldset>
				<?php endif; ?>
			<?php endif; ?>
		<?php endforeach; ?>

		<fieldset class="filter-checks">
			<legend><?php esc_html_e( 'Disponibilidad', 'tienda-moda' ); ?></legend>
			<label><input type="checkbox" name="catalog_in_stock" value="1" <?php checked( tienda_moda_catalog_param( 'catalog_in_stock' ), '1' ); ?>> <?php esc_html_e( 'Solo con stock', 'tienda-moda' ); ?></label>
			<label><input type="checkbox" name="catalog_sale" value="1" <?php checked( tienda_moda_catalog_param( 'catalog_sale' ), '1' ); ?>> <?php esc_html_e( 'Solo ofertas', 'tienda-moda' ); ?></label>
		</fieldset>

		<?php
		foreach ( array( 'orderby', 'columns' ) as $preserved ) {
			$value = tienda_moda_catalog_param( $preserved );
			if ( $value ) {
				printf( '<input type="hidden" name="%1$s" value="%2$s">', esc_attr( $preserved ), esc_attr( $value ) );
			}
		}
		?>
		<button class="button-primary" type="submit"><?php esc_html_e( 'Aplicar filtros', 'tienda-moda' ); ?></button>
		<a class="filter-reset" href="<?php echo esc_url( $action ); ?>"><?php esc_html_e( 'Limpiar', 'tienda-moda' ); ?></a>
	</form>
	<?php
}

/**
 * Catalog toolbar with ordering and a column switcher.
 */
function tienda_moda_catalog_toolbar() {
	$current_columns = tienda_moda_catalog_columns();
	?>
	<div class="catalog-toolbar">
		<button class="filter-toggle" type="button" aria-controls="catalog-filters" aria-expanded="false">
			<?php esc_html_e( 'Filtrar', 'tienda-moda' ); ?>
		</button>
		<?php woocommerce_result_count(); ?>
		<div class="toolbar-end">
			<?php woocommerce_catalog_ordering(); ?>
			<div class="column-switcher" aria-label="<?php esc_attr_e( 'Columnas de productos', 'tienda-moda' ); ?>">
				<?php foreach ( array( 2, 3, 4 ) as $columns ) : ?>
					<a class="<?php echo $columns === $current_columns ? 'active' : ''; ?>" href="<?php echo esc_url( add_query_arg( 'columns', $columns ) ); ?>" aria-label="<?php echo esc_attr( sprintf( __( '%d columnas', 'tienda-moda' ), $columns ) ); ?>" <?php echo $columns === $current_columns ? 'aria-current="true"' : ''; ?>><?php echo esc_html( $columns ); ?></a>
				<?php endforeach; ?>
			</div>
		</div>
	</div>
	<?php
}

/**
 * Get and validate the requested grid size.
 *
 * @return int
 */
function tienda_moda_catalog_columns() {
	$columns = absint( tienda_moda_catalog_param( 'columns' ) );
	return in_array( $columns, array( 2, 3, 4 ), true ) ? $columns : 3;
}
add_filter( 'loop_shop_columns', 'tienda_moda_catalog_columns' );

/**
 * Apply catalog filters to WooCommerce's main product query.
 *
 * @param WC_Query $query WooCommerce query wrapper.
 */
function tienda_moda_apply_catalog_filters( $query ) {
	$tax_query = $query->get( 'tax_query' );
	$meta_query = $query->get( 'meta_query' );

	$requested_taxonomies = array(
		'catalog_category' => 'product_cat',
		'catalog_size'     => 'pa_size',
		'catalog_color'    => 'pa_color',
	);

	foreach ( $requested_taxonomies as $parameter => $taxonomy ) {
		$value = sanitize_title( tienda_moda_catalog_param( $parameter ) );
		if ( $value && taxonomy_exists( $taxonomy ) ) {
			$tax_query[] = array(
				'taxonomy' => $taxonomy,
				'field'    => 'slug',
				'terms'    => array( $value ),
			);
		}
	}

	if ( '1' === tienda_moda_catalog_param( 'catalog_in_stock' ) ) {
		$meta_query[] = array(
			'key'   => '_stock_status',
			'value' => 'instock',
		);
	}

	if ( '1' === tienda_moda_catalog_param( 'catalog_sale' ) ) {
		$sale_ids = wc_get_product_ids_on_sale();
		$query->set( 'post__in', $sale_ids ? $sale_ids : array( 0 ) );
	}

	$query->set( 'tax_query', $tax_query );
	$query->set( 'meta_query', $meta_query );
}
add_action( 'woocommerce_product_query', 'tienda_moda_apply_catalog_filters' );

