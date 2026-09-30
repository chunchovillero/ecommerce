<?php

defined( 'ABSPATH' ) || exit;

function tienda_moda_setup() {
	load_theme_textdomain( 'tienda-moda', get_template_directory() . '/languages' );

	add_theme_support( 'title-tag' );
	add_theme_support( 'post-thumbnails' );
	add_theme_support( 'custom-logo', array(
		'height'      => 120,
		'width'       => 320,
		'flex-height' => true,
		'flex-width'  => true,
	) );
	add_theme_support( 'html5', array(
		'comment-form',
		'comment-list',
		'gallery',
		'caption',
		'search-form',
		'script',
		'style',
	) );
	add_theme_support( 'responsive-embeds' );
	add_theme_support( 'woocommerce' );
	add_theme_support( 'wc-product-gallery-zoom' );
	add_theme_support( 'wc-product-gallery-lightbox' );
	add_theme_support( 'wc-product-gallery-slider' );

	register_nav_menus( array(
		'primary' => __( 'Menú principal', 'tienda-moda' ),
		'footer'  => __( 'Menú del pie de página', 'tienda-moda' ),
		'footer-shop' => __( 'Menú Tienda del pie', 'tienda-moda' ),
		'footer-help' => __( 'Menú Ayuda del pie', 'tienda-moda' ),
		'footer-info' => __( 'Menú Información del pie', 'tienda-moda' ),
		'legal'       => __( 'Menú legal', 'tienda-moda' ),
	) );
}
add_action( 'after_setup_theme', 'tienda_moda_setup' );