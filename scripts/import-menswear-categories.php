<?php
/**
 * Import the generated menswear category images and assign them to WooCommerce terms.
 * Run with: wp eval-file scripts/import-menswear-categories.php
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit( 1 );
}

require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$categories = array(
	20 => array( 'name' => 'Chaquetas y Abrigos', 'slug' => 'chaquetas-abrigos', 'file' => 'chaquetas-abrigos.png', 'alt' => 'Moda masculina de chaquetas y abrigos' ),
	22 => array( 'name' => 'Accesorios', 'slug' => 'accesorios-hombre', 'file' => 'accesorios.png', 'alt' => 'Accesorios masculinos de cuero y reloj' ),
	19 => array( 'name' => 'Camisas', 'slug' => 'camisas-hombre', 'file' => 'camisas.png', 'alt' => 'Camisa masculina blanca de estilo contemporáneo' ),
	18 => array( 'name' => 'Pantalones', 'slug' => 'pantalones-hombre', 'file' => 'pantalones.png', 'alt' => 'Pantalones masculinos de vestir color carbón' ),
	21 => array( 'name' => 'Sweaters y Tejidos', 'slug' => 'sweaters-tejidos-hombre', 'file' => 'sweaters-tejidos.png', 'alt' => 'Sweater masculino tejido color azul marino' ),
	17 => array( 'name' => 'Poleras', 'slug' => 'poleras-hombre', 'file' => 'poleras.png', 'alt' => 'Polera masculina premium color carbón' ),
	16 => array( 'name' => 'Calzado', 'slug' => 'calzado-hombre', 'file' => 'calzado.png', 'alt' => 'Calzado masculino de cuero' ),
);

$source_dir = get_theme_file_path( '/assets/images/categories/' );

foreach ( $categories as $term_id => $category ) {
	$term = get_term( $term_id, 'product_cat' );
	if ( ! $term || is_wp_error( $term ) ) {
		WP_CLI::warning( 'No existe la categoría #' . $term_id );
		continue;
	}

	wp_update_term( $term_id, 'product_cat', array( 'name' => $category['name'], 'slug' => $category['slug'] ) );
	$existing = get_posts( array( 'post_type' => 'attachment', 'post_status' => 'inherit', 'meta_key' => '_tienda_moda_seed_asset', 'meta_value' => $category['file'], 'fields' => 'ids', 'posts_per_page' => 1 ) );
	$attachment_id = $existing ? (int) $existing[0] : 0;

	if ( ! $attachment_id ) {
		$source = $source_dir . $category['file'];
		$temp = wp_tempnam( $category['file'] );
		if ( ! $temp || ! copy( $source, $temp ) ) {
			WP_CLI::warning( 'No se pudo preparar ' . $category['file'] );
			continue;
		}
		$attachment_id = media_handle_sideload( array( 'name' => $category['file'], 'tmp_name' => $temp ), 0, $category['name'] );
		if ( is_wp_error( $attachment_id ) ) {
			WP_CLI::warning( $attachment_id->get_error_message() );
			continue;
		}
		update_post_meta( $attachment_id, '_tienda_moda_seed_asset', $category['file'] );
		update_post_meta( $attachment_id, '_wp_attachment_image_alt', $category['alt'] );
	}

	update_term_meta( $term_id, 'thumbnail_id', $attachment_id );
	WP_CLI::log( sprintf( '%s -> imagen #%d', $category['name'], $attachment_id ) );
}

WP_CLI::success( 'Categorías masculinas e imágenes actualizadas.' );
