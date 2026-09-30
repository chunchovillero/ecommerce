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
	wp_enqueue_style( 'tienda-moda-layout', get_theme_file_uri( '/assets/css/layout.css' ), array( 'tienda-moda-base' ), $theme_version );
	if ( is_front_page() ) {
		wp_enqueue_style( 'tienda-moda-home', get_theme_file_uri( '/assets/css/home.css' ), array( 'tienda-moda-layout' ), $theme_version );
	}
	if ( function_exists( 'is_shop' ) && ( is_shop() || is_product_taxonomy() ) ) {
		wp_enqueue_style( 'tienda-moda-home', get_theme_file_uri( '/assets/css/home.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-catalog', get_theme_file_uri( '/assets/css/catalog.css' ), array( 'tienda-moda-home' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-catalog', get_theme_file_uri( '/assets/js/catalog.js' ), array(), $theme_version, true );
	}
	if ( function_exists( 'is_product' ) && is_product() ) {
		wp_enqueue_style( 'tienda-moda-home', get_theme_file_uri( '/assets/css/home.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-product', get_theme_file_uri( '/assets/css/product.css' ), array( 'tienda-moda-home' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-product', get_theme_file_uri( '/assets/js/product.js' ), array(), $theme_version, true );
	}
	if ( class_exists( 'WooCommerce' ) ) {
		wp_enqueue_style( 'tienda-moda-cart', get_theme_file_uri( '/assets/css/cart.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-commerce-tools', get_theme_file_uri( '/assets/css/commerce-tools.css' ), array( 'tienda-moda-cart' ), $theme_version );
		wp_enqueue_script( 'wc-cart-fragments' );
		wp_enqueue_script( 'tienda-moda-cart', get_theme_file_uri( '/assets/js/cart.js' ), array( 'jquery', 'wc-cart-fragments' ), $theme_version, true );
		wp_enqueue_script( 'tienda-moda-commerce-tools', get_theme_file_uri( '/assets/js/commerce-tools.js' ), array(), $theme_version, true );
		wp_localize_script( 'tienda-moda-commerce-tools', 'tiendaModaTools', array(
			'ajaxUrl' => admin_url( 'admin-ajax.php' ),
			'nonce' => wp_create_nonce( 'tienda_moda_tools' ),
			'isLoggedIn' => is_user_logged_in(),
			'wishlistIds' => tienda_moda_get_wishlist_ids(),
			'wishlistUrl' => tienda_moda_wishlist_url(),
			'emptyMessage' => __( 'Aún no tienes productos favoritos.', 'tienda-moda' ),
			'errorMessage' => __( 'No fue posible completar la acción. Inténtalo nuevamente.', 'tienda-moda' ),
		) );
	}
	if ( function_exists( 'is_checkout' ) && is_checkout() ) {
		wp_enqueue_style( 'tienda-moda-checkout', get_theme_file_uri( '/assets/css/checkout.css' ), array( 'tienda-moda-cart' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-checkout', get_theme_file_uri( '/assets/js/checkout.js' ), array( 'jquery' ), $theme_version, true );
	}
	if ( function_exists( 'is_account_page' ) && is_account_page() ) {
		wp_enqueue_style( 'tienda-moda-account', get_theme_file_uri( '/assets/css/account.css' ), array( 'tienda-moda-cart' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-account', get_theme_file_uri( '/assets/js/account.js' ), array(), $theme_version, true );
	}
	$responsive_dependencies = class_exists( 'WooCommerce' ) ? array( 'tienda-moda-commerce-tools' ) : array( 'tienda-moda-layout' );
	wp_enqueue_style( 'tienda-moda-responsive', get_theme_file_uri( '/assets/css/responsive.css' ), $responsive_dependencies, $theme_version );
	wp_enqueue_script( 'tienda-moda-navigation', get_theme_file_uri( '/assets/js/navigation.js' ), array(), $theme_version, true );
}
add_action( 'wp_enqueue_scripts', 'tienda_moda_enqueue_assets' );
