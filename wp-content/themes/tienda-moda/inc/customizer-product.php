<?php

defined( 'ABSPATH' ) || exit;

/**
 * Product page global content.
 *
 * @param WP_Customize_Manager $wp_customize Customizer instance.
 */
function tienda_moda_product_customize_register( $wp_customize ) {
	$wp_customize->add_section(
		'tienda_moda_product_options',
		array(
			'title'    => __( 'Ficha de producto', 'tienda-moda' ),
			'priority' => 32,
		)
	);

	$wp_customize->add_setting(
		'tienda_moda_product_shipping',
		array( 'default' => '', 'sanitize_callback' => 'sanitize_text_field' )
	);
	$wp_customize->add_control(
		'tienda_moda_product_shipping',
		array( 'label' => __( 'Información de despacho', 'tienda-moda' ), 'section' => 'tienda_moda_product_options', 'type' => 'text' )
	);

	$wp_customize->add_setting(
		'tienda_moda_product_returns',
		array( 'default' => '', 'sanitize_callback' => 'wp_kses_post' )
	);
	$wp_customize->add_control(
		'tienda_moda_product_returns',
		array( 'label' => __( 'Texto de cambios y devoluciones', 'tienda-moda' ), 'section' => 'tienda_moda_product_options', 'type' => 'textarea' )
	);
}
add_action( 'customize_register', 'tienda_moda_product_customize_register' );

