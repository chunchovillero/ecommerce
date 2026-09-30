<?php
/**
 * Product card inside catalog loops.
 *
 * This override replaces WooCommerce's legacy loop markup with the reusable
 * card owned by this theme.
 *
 * @package WooCommerce\Templates
 * @version 9.4.0
 */

defined( 'ABSPATH' ) || exit;

global $product;

if ( ! $product || ! $product->is_visible() ) {
	return;
}

set_query_var( 'tienda_moda_product', $product );
get_template_part( 'template-parts/product', 'card' );

