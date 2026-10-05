<?php
/**
 * Importa imágenes editoriales y actualiza una selección de productos masculinos.
 * Ejecutar con WP-CLI dentro del contenedor de WordPress.
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$theme_dir = get_theme_root() . '/tienda-moda/assets/images/products/';

$products = array(
	63 => array( 'name' => 'Chaqueta Denim Índigo',       'file' => 'chaqueta-denim-indigo.png' ),
	64 => array( 'name' => 'Blazer Sastrero Carbón',      'file' => 'blazer-sastrero-carbon.png' ),
	44 => array( 'name' => 'Jeans Rectos Índigo',         'file' => 'jeans-rectos-indigo.png' ),
	48 => array( 'name' => 'Pantalón Sastrero Carbón',    'file' => 'pantalon-sastrero-carbon.png' ),
	41 => array( 'name' => 'Camisa Oxford Blanca',        'file' => 'camisa-oxford-blanca.png' ),
	78 => array( 'name' => 'Cinturón de Cuero Negro',     'file' => 'cinturon-cuero-negro.png' ),
);

foreach ( $products as $product_id => $item ) {
	if ( 'product' !== get_post_type( $product_id ) ) {
		WP_CLI::warning( "Producto {$product_id} no encontrado." );
		continue;
	}

	wp_update_post(
		array(
			'ID'         => $product_id,
			'post_title' => $item['name'],
			'post_name'  => sanitize_title( $item['name'] ),
		)
	);

	$source_key = 'menswear-product-' . $product_id;
	$existing   = get_posts(
		array(
			'post_type'      => 'attachment',
			'post_status'    => 'inherit',
			'posts_per_page' => 1,
			'fields'         => 'ids',
			'meta_key'       => '_tienda_moda_seed_asset',
			'meta_value'     => $source_key,
		)
	);

	if ( $existing ) {
		$attachment_id = (int) $existing[0];
	} else {
		$path = $theme_dir . $item['file'];
		if ( ! file_exists( $path ) ) {
			WP_CLI::warning( "Archivo no encontrado: {$path}" );
			continue;
		}

		$temp_file = wp_tempnam( $item['file'] );
		if ( ! $temp_file || ! copy( $path, $temp_file ) ) {
			WP_CLI::warning( "No fue posible preparar {$item['file']} para importar." );
			continue;
		}

		$file = array(
			'name'     => $item['file'],
			'tmp_name' => $temp_file,
		);
		$attachment_id = media_handle_sideload( $file, $product_id, $item['name'] );
		if ( is_wp_error( $attachment_id ) ) {
			WP_CLI::warning( $attachment_id->get_error_message() );
			continue;
		}
		update_post_meta( $attachment_id, '_tienda_moda_seed_asset', $source_key );
	}

	update_post_meta( $attachment_id, '_wp_attachment_image_alt', $item['name'] );
	set_post_thumbnail( $product_id, $attachment_id );
	WP_CLI::log( "{$item['name']} -> imagen #{$attachment_id}" );
}

WP_CLI::success( 'Productos masculinos actualizados.' );
