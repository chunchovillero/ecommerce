<?php

defined( 'ABSPATH' ) || exit;

/**
 * Register editable home page content.
 *
 * @param WP_Customize_Manager $wp_customize Customizer instance.
 */
function tienda_moda_home_customize_register( $wp_customize ) {
	$wp_customize->add_section(
		'tienda_moda_home',
		array(
			'title'       => __( 'Portada de la tienda', 'tienda-moda' ),
			'description' => __( 'Configura el hero, promoción, beneficios e imágenes sociales.', 'tienda-moda' ),
			'panel'       => 'tienda_moda_settings',
			'priority'    => 50,
		)
	);

	$text_fields = array(
		'tienda_moda_hero_title'       => array( __( 'Hero: título', 'tienda-moda' ), '' ),
		'tienda_moda_hero_subtitle'    => array( __( 'Hero: subtítulo', 'tienda-moda' ), '' ),
		'tienda_moda_hero_button'      => array( __( 'Hero: texto del botón', 'tienda-moda' ), __( 'Ver colección', 'tienda-moda' ) ),
		'tienda_moda_promo_title'      => array( __( 'Promoción: título', 'tienda-moda' ), '' ),
		'tienda_moda_promo_text'       => array( __( 'Promoción: texto', 'tienda-moda' ), '' ),
		'tienda_moda_promo_button'     => array( __( 'Promoción: texto del botón', 'tienda-moda' ), __( 'Comprar ahora', 'tienda-moda' ) ),
		'tienda_moda_benefit_1'        => array( __( 'Beneficio 1', 'tienda-moda' ), __( 'Envíos a todo Chile', 'tienda-moda' ) ),
		'tienda_moda_benefit_2'        => array( __( 'Beneficio 2', 'tienda-moda' ), __( 'Pago seguro', 'tienda-moda' ) ),
		'tienda_moda_benefit_3'        => array( __( 'Beneficio 3', 'tienda-moda' ), __( 'Cambios y devoluciones', 'tienda-moda' ) ),
		'tienda_moda_benefit_4'        => array( __( 'Beneficio 4', 'tienda-moda' ), __( 'Atención personalizada', 'tienda-moda' ) ),
	);

	foreach ( $text_fields as $setting_id => $field ) {
		$wp_customize->add_setting(
			$setting_id,
			array(
				'default'           => $field[1],
				'sanitize_callback' => 'sanitize_text_field',
			)
		);
		$wp_customize->add_control(
			$setting_id,
			array(
				'label'   => $field[0],
				'section' => 'tienda_moda_home',
				'type'    => 'text',
			)
		);
	}

	$url_fields = array(
		'tienda_moda_hero_url'  => __( 'Hero: enlace del botón', 'tienda-moda' ),
		'tienda_moda_promo_url' => __( 'Promoción: enlace del botón', 'tienda-moda' ),
	);

	foreach ( $url_fields as $setting_id => $label ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => '', 'sanitize_callback' => 'esc_url_raw' ) );
		$wp_customize->add_control( $setting_id, array( 'label' => $label, 'section' => 'tienda_moda_home', 'type' => 'url' ) );
	}

	$image_fields = array(
		'tienda_moda_hero_image'  => __( 'Hero: imagen', 'tienda-moda' ),
		'tienda_moda_promo_image' => __( 'Promoción: imagen', 'tienda-moda' ),
	);

	for ( $index = 1; $index <= 6; $index++ ) {
		$image_fields[ 'tienda_moda_social_image_' . $index ] = sprintf( __( 'Imagen social %d', 'tienda-moda' ), $index );
	}

	foreach ( $image_fields as $setting_id => $label ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => 0, 'sanitize_callback' => 'absint' ) );
		$wp_customize->add_control(
			new WP_Customize_Media_Control(
				$wp_customize,
				$setting_id,
				array(
					'label'     => $label,
					'section'   => 'tienda_moda_home',
					'mime_type' => 'image',
				)
			)
		);
	}
}
add_action( 'customize_register', 'tienda_moda_home_customize_register' );
