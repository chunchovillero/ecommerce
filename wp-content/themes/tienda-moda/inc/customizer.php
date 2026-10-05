<?php

defined( 'ABSPATH' ) || exit;

function tienda_moda_sanitize_checkbox( $value ) {
	return (bool) $value;
}

function tienda_moda_sanitize_select( $value, $setting ) {
	$control = $setting->manager->get_control( $setting->id );
	return $control && isset( $control->choices[ $value ] ) ? $value : $setting->default;
}

/** Register the complete store configuration panel. */
function tienda_moda_customize_register( $wp_customize ) {
	$wp_customize->add_panel( 'tienda_moda_settings', array(
		'title' => __( 'Configuración de la tienda', 'tienda-moda' ),
		'description' => __( 'Personaliza la identidad, apariencia, cabecera, contacto, portada y productos desde un solo lugar.', 'tienda-moda' ),
		'priority' => 20,
	) );

	foreach ( array( 'title_tagline' => 10, 'nav_menus' => 70, 'static_front_page' => 80 ) as $section_id => $priority ) {
		$section = $wp_customize->get_section( $section_id );
		if ( $section ) {
			$section->panel = 'tienda_moda_settings';
			$section->priority = $priority;
		}
	}

	$wp_customize->add_section( 'tienda_moda_appearance', array(
		'title' => __( 'Colores y estilo', 'tienda-moda' ),
		'description' => __( 'La paleta se aplica globalmente a la tienda, botones, enlaces, cabecera y pie.', 'tienda-moda' ),
		'panel' => 'tienda_moda_settings', 'priority' => 20,
	) );
	$colors = array(
		'tienda_moda_color_background'  => array( __( 'Fondo general', 'tienda-moda' ), '#f4f2ed' ),
		'tienda_moda_color_text'        => array( __( 'Texto principal', 'tienda-moda' ), '#171a1f' ),
		'tienda_moda_color_muted'       => array( __( 'Texto secundario', 'tienda-moda' ), '#646861' ),
		'tienda_moda_color_surface'     => array( __( 'Fondos suaves y tarjetas', 'tienda-moda' ), '#e7e4dc' ),
		'tienda_moda_color_accent'      => array( __( 'Color de marca y botones', 'tienda-moda' ), '#20364a' ),
		'tienda_moda_color_on_accent'   => array( __( 'Texto sobre color de marca', 'tienda-moda' ), '#f7f5ef' ),
		'tienda_moda_color_header'      => array( __( 'Fondo de cabecera', 'tienda-moda' ), '#f7f5ef' ),
		'tienda_moda_color_footer'      => array( __( 'Fondo del pie', 'tienda-moda' ), '#121b24' ),
		'tienda_moda_color_footer_text' => array( __( 'Texto del pie', 'tienda-moda' ), '#f2efe8' ),
		'tienda_moda_color_sale'        => array( __( 'Ofertas y alertas', 'tienda-moda' ), '#8a3f32' ),
	);
	foreach ( $colors as $setting_id => $field ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => $field[1], 'sanitize_callback' => 'sanitize_hex_color', 'transport' => 'refresh' ) );
		$wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, $setting_id, array( 'label' => $field[0], 'section' => 'tienda_moda_appearance' ) ) );
	}

	$wp_customize->add_setting( 'tienda_moda_font_family', array( 'default' => 'system', 'sanitize_callback' => 'tienda_moda_sanitize_select' ) );
	$wp_customize->add_control( 'tienda_moda_font_family', array(
		'label' => __( 'Tipografía', 'tienda-moda' ), 'section' => 'tienda_moda_appearance', 'type' => 'select',
		'choices' => array( 'system' => __( 'Moderna (sistema)', 'tienda-moda' ), 'editorial' => __( 'Editorial (serif)', 'tienda-moda' ), 'rounded' => __( 'Amable (redondeada)', 'tienda-moda' ) ),
	) );
	$ranges = array(
		'tienda_moda_content_width' => array( __( 'Ancho máximo del contenido', 'tienda-moda' ), 1440, 1080, 1680, 20 ),
		'tienda_moda_border_radius' => array( __( 'Redondeado de botones y campos', 'tienda-moda' ), 0, 0, 24, 1 ),
		'tienda_moda_logo_width' => array( __( 'Ancho máximo del logo', 'tienda-moda' ), 190, 100, 320, 5 ),
	);
	foreach ( $ranges as $setting_id => $field ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => $field[1], 'sanitize_callback' => 'absint' ) );
		$wp_customize->add_control( $setting_id, array( 'label' => $field[0], 'section' => 'tienda_moda_appearance', 'type' => 'range', 'input_attrs' => array( 'min' => $field[2], 'max' => $field[3], 'step' => $field[4] ) ) );
	}

	$wp_customize->add_section( 'tienda_moda_header', array( 'title' => __( 'Cabecera y franja superior', 'tienda-moda' ), 'panel' => 'tienda_moda_settings', 'priority' => 30 ) );
	$checks = array( 'tienda_moda_show_announcement' => array( __( 'Mostrar franja superior', 'tienda-moda' ), true ), 'tienda_moda_sticky_header' => array( __( 'Mantener cabecera visible al bajar', 'tienda-moda' ), false ) );
	foreach ( $checks as $setting_id => $field ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => $field[1], 'sanitize_callback' => 'tienda_moda_sanitize_checkbox' ) );
		$wp_customize->add_control( $setting_id, array( 'label' => $field[0], 'section' => 'tienda_moda_header', 'type' => 'checkbox' ) );
	}
	$wp_customize->add_setting( 'tienda_moda_announcement', array( 'default' => '', 'sanitize_callback' => 'sanitize_text_field' ) );
	$wp_customize->add_control( 'tienda_moda_announcement', array( 'label' => __( 'Texto de la franja', 'tienda-moda' ), 'section' => 'tienda_moda_header', 'type' => 'text' ) );
	$wp_customize->add_setting( 'tienda_moda_announcement_url', array( 'default' => '', 'sanitize_callback' => 'esc_url_raw' ) );
	$wp_customize->add_control( 'tienda_moda_announcement_url', array( 'label' => __( 'Enlace de la franja (opcional)', 'tienda-moda' ), 'section' => 'tienda_moda_header', 'type' => 'url' ) );

	$wp_customize->add_section( 'tienda_moda_store_details', array( 'title' => __( 'Contacto y redes sociales', 'tienda-moda' ), 'panel' => 'tienda_moda_settings', 'priority' => 40 ) );
	$fields = array(
		'tienda_moda_contact_email' => array( __( 'Correo de contacto', 'tienda-moda' ), 'email', 'sanitize_email' ),
		'tienda_moda_contact_phone' => array( __( 'Teléfono de contacto', 'tienda-moda' ), 'text', 'sanitize_text_field' ),
		'tienda_moda_contact_address' => array( __( 'Dirección o ubicación', 'tienda-moda' ), 'text', 'sanitize_text_field' ),
		'tienda_moda_whatsapp_url' => array( __( 'Enlace de WhatsApp', 'tienda-moda' ), 'url', 'esc_url_raw' ),
		'tienda_moda_instagram_url' => array( __( 'URL de Instagram', 'tienda-moda' ), 'url', 'esc_url_raw' ),
		'tienda_moda_facebook_url' => array( __( 'URL de Facebook', 'tienda-moda' ), 'url', 'esc_url_raw' ),
		'tienda_moda_tiktok_url' => array( __( 'URL de TikTok', 'tienda-moda' ), 'url', 'esc_url_raw' ),
	);
	foreach ( $fields as $setting_id => $field ) {
		$wp_customize->add_setting( $setting_id, array( 'default' => '', 'sanitize_callback' => $field[2] ) );
		$wp_customize->add_control( $setting_id, array( 'label' => $field[0], 'section' => 'tienda_moda_store_details', 'type' => $field[1] ) );
	}

	$wp_customize->add_section( 'tienda_moda_footer', array( 'title' => __( 'Pie de página', 'tienda-moda' ), 'panel' => 'tienda_moda_settings', 'priority' => 60 ) );
	$wp_customize->add_setting( 'tienda_moda_footer_text', array( 'default' => '', 'sanitize_callback' => 'sanitize_textarea_field' ) );
	$wp_customize->add_control( 'tienda_moda_footer_text', array( 'label' => __( 'Descripción de la marca', 'tienda-moda' ), 'description' => __( 'Si se deja vacío, se usa la descripción del sitio.', 'tienda-moda' ), 'section' => 'tienda_moda_footer', 'type' => 'textarea' ) );
	$wp_customize->add_setting( 'tienda_moda_copyright', array( 'default' => '', 'sanitize_callback' => 'sanitize_text_field' ) );
	$wp_customize->add_control( 'tienda_moda_copyright', array( 'label' => __( 'Texto de copyright', 'tienda-moda' ), 'description' => __( 'Vacío: año y nombre del sitio automáticamente.', 'tienda-moda' ), 'section' => 'tienda_moda_footer', 'type' => 'text' ) );
}
add_action( 'customize_register', 'tienda_moda_customize_register' );

function tienda_moda_font_stack() {
	$fonts = array( 'system' => '"Helvetica Neue",Helvetica,Arial,sans-serif', 'editorial' => 'Georgia,"Times New Roman",serif', 'rounded' => 'ui-rounded,"Arial Rounded MT Bold",Arial,sans-serif' );
	$choice = get_theme_mod( 'tienda_moda_font_family', 'system' );
	return isset( $fonts[ $choice ] ) ? $fonts[ $choice ] : $fonts['system'];
}

/** Generate global CSS design tokens selected by the store manager. */
function tienda_moda_customizer_css() {
	$defaults = array( 'background' => '#f4f2ed', 'text' => '#171a1f', 'muted' => '#646861', 'surface' => '#e7e4dc', 'accent' => '#20364a', 'on_accent' => '#f7f5ef', 'header' => '#f7f5ef', 'footer' => '#121b24', 'footer_text' => '#f2efe8', 'sale' => '#8a3f32' );
	$colors = array();
	foreach ( $defaults as $name => $default ) {
		$colors[ $name ] = sanitize_hex_color( get_theme_mod( 'tienda_moda_color_' . $name, $default ) ) ?: $default;
	}
	$width = min( 1680, max( 1080, absint( get_theme_mod( 'tienda_moda_content_width', 1440 ) ) ) );
	$radius = min( 24, absint( get_theme_mod( 'tienda_moda_border_radius', 0 ) ) );
	$logo = min( 320, max( 100, absint( get_theme_mod( 'tienda_moda_logo_width', 190 ) ) ) );
	$sticky = get_theme_mod( 'tienda_moda_sticky_header', false ) ? '.site-header{position:sticky;top:0}' : '';
	return sprintf( ':root{--color-background:%1$s;--color-text:%2$s;--color-muted:%3$s;--color-surface:%4$s;--color-accent:%5$s;--color-on-accent:%6$s;--color-header:%7$s;--color-footer:%8$s;--color-footer-text:%9$s;--color-sale:%10$s;--content-width:%11$dpx;--border-radius:%12$dpx;--font-body:%13$s;--logo-width:%14$dpx}body{font-family:var(--font-body);background:var(--color-background);color:var(--color-text)}.site-header{background:var(--color-header)}.custom-logo{max-width:var(--logo-width)}.site-footer{background:var(--color-footer);color:var(--color-footer-text)}.button,.button-primary,button,input,select,textarea,.woocommerce a.button,.woocommerce button.button{border-radius:var(--border-radius)}.button-primary,.woocommerce a.button.alt,.woocommerce button.button.alt,.woocommerce input.button.alt{background:var(--color-accent)!important;color:var(--color-on-accent)!important}.price ins,.onsale,.woocommerce-error{color:var(--color-sale)}%15$s', $colors['background'], $colors['text'], $colors['muted'], $colors['surface'], $colors['accent'], $colors['on_accent'], $colors['header'], $colors['footer'], $colors['footer_text'], $colors['sale'], $width, $radius, tienda_moda_font_stack(), $logo, $sticky );
}
