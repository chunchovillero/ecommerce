<?php

defined( 'ABSPATH' ) || exit;

function tienda_moda_enqueue_assets() {
	$theme_version = wp_get_theme()->get( 'Version' );

	wp_enqueue_style( 'tienda-moda-style', get_stylesheet_uri(), array(), $theme_version );
	wp_enqueue_style( 'tienda-moda-base', get_theme_file_uri( '/assets/css/base.css' ), array( 'tienda-moda-style' ), $theme_version );
	wp_enqueue_style( 'tienda-moda-layout', get_theme_file_uri( '/assets/css/layout.css' ), array( 'tienda-moda-base' ), $theme_version );
	wp_add_inline_style( 'tienda-moda-layout', tienda_moda_customizer_css() );

	if ( is_front_page() ) {
		wp_enqueue_style( 'tienda-moda-product-card', get_theme_file_uri( '/assets/css/product-card.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-home', get_theme_file_uri( '/assets/css/home.css' ), array( 'tienda-moda-product-card' ), $theme_version );
	}
	if ( function_exists( 'is_shop' ) && ( is_shop() || is_product_taxonomy() ) ) {
		wp_enqueue_style( 'tienda-moda-product-card', get_theme_file_uri( '/assets/css/product-card.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-catalog', get_theme_file_uri( '/assets/css/catalog.css' ), array( 'tienda-moda-product-card' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-catalog', get_theme_file_uri( '/assets/js/catalog.js' ), array(), $theme_version, true );
	}
	if ( function_exists( 'is_product' ) && is_product() ) {
		wp_enqueue_style( 'tienda-moda-product-card', get_theme_file_uri( '/assets/css/product-card.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-product', get_theme_file_uri( '/assets/css/product.css' ), array( 'tienda-moda-product-card' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-product', get_theme_file_uri( '/assets/js/product.js' ), array(), $theme_version, true );
	}
	if ( function_exists( 'tienda_moda_is_wishlist_context' ) && tienda_moda_is_wishlist_context() ) {
		wp_enqueue_style( 'tienda-moda-product-card', get_theme_file_uri( '/assets/css/product-card.css' ), array( 'tienda-moda-layout' ), $theme_version );
	}

	if ( class_exists( 'WooCommerce' ) ) {
		wp_enqueue_style( 'tienda-moda-mini-cart', get_theme_file_uri( '/assets/css/mini-cart.css' ), array( 'tienda-moda-layout' ), $theme_version );
		wp_enqueue_style( 'tienda-moda-commerce-tools', get_theme_file_uri( '/assets/css/commerce-tools.css' ), array( 'tienda-moda-mini-cart' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-cart', get_theme_file_uri( '/assets/js/cart.js' ), array(), $theme_version, true );
		wp_enqueue_script( 'tienda-moda-commerce-tools', get_theme_file_uri( '/assets/js/commerce-tools.js' ), array(), $theme_version, true );
		wp_localize_script(
			'tienda-moda-commerce-tools',
			'tiendaModaTools',
			array(
				'ajaxUrl'      => admin_url( 'admin-ajax.php' ),
				'nonce'        => wp_create_nonce( 'tienda_moda_tools' ),
				'isLoggedIn'   => is_user_logged_in(),
				'wishlistIds'  => tienda_moda_get_wishlist_ids(),
				'wishlistUrl'  => tienda_moda_wishlist_url(),
				'emptyMessage' => __( 'Aún no tienes productos favoritos.', 'tienda-moda' ),
				'errorMessage' => __( 'No fue posible completar la acción. Inténtalo nuevamente.', 'tienda-moda' ),
			)
		);
	}
	if ( function_exists( 'is_cart' ) && is_cart() ) {
		wp_enqueue_style( 'tienda-moda-cart', get_theme_file_uri( '/assets/css/cart.css' ), array( 'tienda-moda-mini-cart' ), $theme_version );
	}
	if ( function_exists( 'is_checkout' ) && is_checkout() ) {
		wp_enqueue_style( 'tienda-moda-checkout', get_theme_file_uri( '/assets/css/checkout.css' ), array( 'tienda-moda-mini-cart' ), $theme_version );
	}
	if ( function_exists( 'is_account_page' ) && is_account_page() ) {
		wp_enqueue_style( 'tienda-moda-account', get_theme_file_uri( '/assets/css/account.css' ), array( 'tienda-moda-mini-cart' ), $theme_version );
		wp_enqueue_script( 'tienda-moda-account', get_theme_file_uri( '/assets/js/account.js' ), array(), $theme_version, true );
	}

	$responsive_dependencies = class_exists( 'WooCommerce' ) ? array( 'tienda-moda-commerce-tools' ) : array( 'tienda-moda-layout' );
	wp_enqueue_style( 'tienda-moda-responsive', get_theme_file_uri( '/assets/css/responsive.css' ), $responsive_dependencies, $theme_version );
	wp_enqueue_style( 'tienda-moda-accessibility', get_theme_file_uri( '/assets/css/accessibility.css' ), array( 'tienda-moda-responsive' ), $theme_version );
	wp_enqueue_script( 'tienda-moda-navigation', get_theme_file_uri( '/assets/js/navigation.js' ), array(), $theme_version, true );

	foreach ( array( 'tienda-moda-navigation', 'tienda-moda-cart', 'tienda-moda-commerce-tools', 'tienda-moda-catalog', 'tienda-moda-product', 'tienda-moda-checkout', 'tienda-moda-account' ) as $handle ) {
		wp_script_add_data( $handle, 'strategy', 'defer' );
	}
}
add_action( 'wp_enqueue_scripts', 'tienda_moda_enqueue_assets' );
