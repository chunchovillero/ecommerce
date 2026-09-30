<?php
defined( 'ABSPATH' ) || exit;

$product = get_query_var( 'tienda_moda_product' );

if ( ! $product instanceof WC_Product ) {
	return;
}

$product_id = $product->get_id();
$image_id   = $product->get_image_id();
$gallery    = $product->get_gallery_image_ids();
$is_new     = $product->get_date_created() && $product->get_date_created()->getTimestamp() >= strtotime( '-30 days' );
$colors     = taxonomy_exists( 'pa_color' ) ? get_the_terms( $product_id, 'pa_color' ) : array();
?>
<article class="product-card">
	<a class="product-card-image" href="<?php echo esc_url( $product->get_permalink() ); ?>">
		<?php if ( $product->is_on_sale() ) : ?>
			<span class="product-badge sale"><?php esc_html_e( 'Oferta', 'tienda-moda' ); ?></span>
		<?php elseif ( $is_new ) : ?>
			<span class="product-badge"><?php esc_html_e( 'Nuevo', 'tienda-moda' ); ?></span>
		<?php endif; ?>
		<?php
		if ( $image_id ) {
			echo wp_get_attachment_image( $image_id, 'woocommerce_thumbnail', false, array( 'class' => 'product-primary-image', 'loading' => 'lazy', 'decoding' => 'async', 'sizes' => '(max-width: 600px) 50vw, (max-width: 900px) 33vw, 25vw' ) );
		} else {
			echo wc_placeholder_img( 'woocommerce_thumbnail', array( 'class' => 'product-primary-image' ) );
		}
		if ( ! empty( $gallery ) ) {
			echo wp_get_attachment_image( $gallery[0], 'woocommerce_thumbnail', false, array( 'class' => 'product-secondary-image', 'loading' => 'lazy', 'decoding' => 'async', 'fetchpriority' => 'low', 'sizes' => '(max-width: 600px) 50vw, (max-width: 900px) 33vw, 25vw' ) );
		}
		?>
	</a>
	<?php tienda_moda_wishlist_button( $product_id, 'card' ); ?>
	<div class="product-card-content">
		<h3><a href="<?php echo esc_url( $product->get_permalink() ); ?>"><?php echo esc_html( $product->get_name() ); ?></a></h3>
		<div class="product-price"><?php echo wp_kses_post( $product->get_price_html() ); ?></div>
		<?php if ( is_array( $colors ) && ! empty( $colors ) ) : ?>
			<p class="product-colors"><?php echo esc_html( sprintf( _n( '%d color', '%d colores', count( $colors ), 'tienda-moda' ), count( $colors ) ) ); ?></p>
		<?php endif; ?>
	</div>
</article>

