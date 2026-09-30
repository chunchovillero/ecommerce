<?php

defined( 'ABSPATH' ) || exit;

function tienda_moda_enqueue_assets() {
	$theme_version = wp_get_theme()->get( 'Version' );

	wp_enqueue_style( 'tienda-moda-style', get_stylesheet_uri(), array(), $theme_version );
	wp_enqueue_style(
		'tienda-moda-base',
		get_theme_file_uri( '/assets/css/base.css' ),
		array( 'tienda-moda-style' ),
		$theme_version
	);
}
add_action( 'wp_enqueue_scripts', 'tienda_moda_enqueue_assets' );