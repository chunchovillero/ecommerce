<?php

defined( 'ABSPATH' ) || exit;

/**
 * Register simple global store options using native WordPress APIs.
 *
 * @param WP_Customize_Manager $wp_customize Customizer instance.
 */
function tienda_moda_customize_register( $wp_customize ) {
	$wp_customize->add_section(
		'tienda_moda_store_details',
		array(
			'title'    => __( 'Datos de la tienda', 'tienda-moda' ),
			'priority' => 30,
		)
	);

	$fields = array(
		'tienda_moda_announcement'  => array( 'label' => __( 'Texto de la franja superior', 'tienda-moda' ), 'type' => 'text', 'sanitize' => 'sanitize_text_field' ),
		'tienda_moda_contact_email' => array( 'label' => __( 'Correo de contacto', 'tienda-moda' ), 'type' => 'email', 'sanitize' => 'sanitize_email' ),
		'tienda_moda_contact_phone' => array( 'label' => __( 'Teléfono de contacto', 'tienda-moda' ), 'type' => 'text', 'sanitize' => 'sanitize_text_field' ),
		'tienda_moda_instagram_url' => array( 'label' => __( 'URL de Instagram', 'tienda-moda' ), 'type' => 'url', 'sanitize' => 'esc_url_raw' ),
		'tienda_moda_facebook_url'  => array( 'label' => __( 'URL de Facebook', 'tienda-moda' ), 'type' => 'url', 'sanitize' => 'esc_url_raw' ),
		'tienda_moda_tiktok_url'    => array( 'label' => __( 'URL de TikTok', 'tienda-moda' ), 'type' => 'url', 'sanitize' => 'esc_url_raw' ),
	);

	foreach ( $fields as $setting_id => $field ) {
		$wp_customize->add_setting(
			$setting_id,
			array(
				'default'           => '',
				'sanitize_callback' => $field['sanitize'],
				'transport'         => 'refresh',
			)
		);
		$wp_customize->add_control(
			$setting_id,
			array(
				'label'   => $field['label'],
				'section' => 'tienda_moda_store_details',
				'type'    => $field['type'],
			)
		);
	}
}
add_action( 'customize_register', 'tienda_moda_customize_register' );

