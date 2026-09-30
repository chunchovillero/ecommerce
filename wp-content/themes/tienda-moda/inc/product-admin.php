<?php

defined( 'ABSPATH' ) || exit;

/**
 * Add the product-specific size guide editor.
 */
function tienda_moda_add_product_meta_box() {
	add_meta_box(
		'tienda-moda-size-guide',
		__( 'Guía de tallas', 'tienda-moda' ),
		'tienda_moda_size_guide_meta_box',
		'product',
		'normal',
		'default'
	);
}
add_action( 'add_meta_boxes_product', 'tienda_moda_add_product_meta_box' );

function tienda_moda_size_guide_meta_box( $post ) {
	wp_nonce_field( 'tienda_moda_save_size_guide', 'tienda_moda_size_guide_nonce' );
	$value = get_post_meta( $post->ID, '_tienda_moda_size_guide', true );
	?>
	<p><?php esc_html_e( 'Escribe una fila por línea y separa las columnas con |. La primera fila será el encabezado.', 'tienda-moda' ); ?></p>
	<p><code><?php esc_html_e( 'TALLA | PECHO | LARGO', 'tienda-moda' ); ?></code></p>
	<textarea class="widefat" rows="8" name="tienda_moda_size_guide"><?php echo esc_textarea( $value ); ?></textarea>
	<?php
}

/**
 * Save the guide with capability and nonce checks.
 *
 * @param int $post_id Product ID.
 */
function tienda_moda_save_size_guide( $post_id ) {
	if ( ! isset( $_POST['tienda_moda_size_guide_nonce'] ) || ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['tienda_moda_size_guide_nonce'] ) ), 'tienda_moda_save_size_guide' ) ) {
		return;
	}
	if ( ! current_user_can( 'edit_post', $post_id ) || wp_is_post_autosave( $post_id ) || wp_is_post_revision( $post_id ) ) {
		return;
	}

	$value = isset( $_POST['tienda_moda_size_guide'] ) ? sanitize_textarea_field( wp_unslash( $_POST['tienda_moda_size_guide'] ) ) : '';
	if ( $value ) {
		update_post_meta( $post_id, '_tienda_moda_size_guide', $value );
	} else {
		delete_post_meta( $post_id, '_tienda_moda_size_guide' );
	}
}
add_action( 'save_post_product', 'tienda_moda_save_size_guide' );

