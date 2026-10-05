<?php
/**
 * Plugin Name: Tienda WhatsApp
 * Description: Botón flotante de WhatsApp configurable e integrado con WooCommerce.
 * Version: 1.0.0
 * Author: Tienda
 * Text Domain: tienda-whatsapp
 */

defined( 'ABSPATH' ) || exit;

const TIENDA_WHATSAPP_VERSION = '1.0.0';

function tienda_whatsapp_defaults() {
	return array(
		'enabled'  => 'yes',
		'phone'    => '',
		'message'  => 'Hola, necesito ayuda con mi compra.',
		'label'    => '¿Necesitas ayuda?',
		'position' => 'right',
		'color'    => '#20364a',
	);
}

function tienda_whatsapp_options() {
	return wp_parse_args( get_option( 'tienda_whatsapp_settings', array() ), tienda_whatsapp_defaults() );
}

function tienda_whatsapp_sanitize( $input ) {
	$defaults = tienda_whatsapp_defaults();
	return array(
		'enabled'  => isset( $input['enabled'] ) ? 'yes' : 'no',
		'phone'    => preg_replace( '/\D+/', '', (string) ( $input['phone'] ?? '' ) ),
		'message'  => sanitize_textarea_field( $input['message'] ?? $defaults['message'] ),
		'label'    => sanitize_text_field( $input['label'] ?? $defaults['label'] ),
		'position' => in_array( $input['position'] ?? '', array( 'left', 'right' ), true ) ? $input['position'] : 'right',
		'color'    => sanitize_hex_color( $input['color'] ?? '' ) ?: $defaults['color'],
	);
}

function tienda_whatsapp_admin_menu() {
	add_options_page( 'WhatsApp de la tienda', 'WhatsApp', 'manage_options', 'tienda-whatsapp', 'tienda_whatsapp_settings_page' );
}
add_action( 'admin_menu', 'tienda_whatsapp_admin_menu' );

function tienda_whatsapp_register_settings() {
	register_setting( 'tienda_whatsapp', 'tienda_whatsapp_settings', array( 'sanitize_callback' => 'tienda_whatsapp_sanitize' ) );
}
add_action( 'admin_init', 'tienda_whatsapp_register_settings' );

function tienda_whatsapp_settings_page() {
	if ( ! current_user_can( 'manage_options' ) ) return;
	$options = tienda_whatsapp_options();
	?>
	<div class="wrap">
		<h1>WhatsApp de la tienda</h1>
		<p>Configura el canal de atención que aparecerá como botón flotante en el sitio.</p>
		<form method="post" action="options.php">
			<?php settings_fields( 'tienda_whatsapp' ); ?>
			<table class="form-table" role="presentation">
				<tr><th scope="row">Activar botón</th><td><label><input type="checkbox" name="tienda_whatsapp_settings[enabled]" value="yes" <?php checked( $options['enabled'], 'yes' ); ?>> Mostrar en el sitio</label></td></tr>
				<tr><th scope="row"><label for="tw-phone">Número</label></th><td><input id="tw-phone" class="regular-text" name="tienda_whatsapp_settings[phone]" value="<?php echo esc_attr( $options['phone'] ); ?>" inputmode="numeric" placeholder="56912345678"><p class="description">Incluye código de país y área, solamente números. Ejemplo Chile: 56912345678.</p></td></tr>
				<tr><th scope="row"><label for="tw-message">Mensaje inicial</label></th><td><textarea id="tw-message" class="large-text" rows="3" name="tienda_whatsapp_settings[message]"><?php echo esc_textarea( $options['message'] ); ?></textarea><p class="description">En productos se agregará automáticamente el nombre del artículo.</p></td></tr>
				<tr><th scope="row"><label for="tw-label">Etiqueta</label></th><td><input id="tw-label" class="regular-text" name="tienda_whatsapp_settings[label]" value="<?php echo esc_attr( $options['label'] ); ?>"></td></tr>
				<tr><th scope="row">Posición</th><td><select name="tienda_whatsapp_settings[position]"><option value="right" <?php selected( $options['position'], 'right' ); ?>>Derecha</option><option value="left" <?php selected( $options['position'], 'left' ); ?>>Izquierda</option></select></td></tr>
				<tr><th scope="row"><label for="tw-color">Color</label></th><td><input id="tw-color" type="color" name="tienda_whatsapp_settings[color]" value="<?php echo esc_attr( $options['color'] ); ?>"></td></tr>
			</table>
			<?php submit_button( 'Guardar configuración' ); ?>
		</form>
	</div>
	<?php
}

function tienda_whatsapp_admin_notice() {
	if ( ! current_user_can( 'manage_options' ) || ! empty( tienda_whatsapp_options()['phone'] ) ) return;
	$url = admin_url( 'options-general.php?page=tienda-whatsapp' );
	echo '<div class="notice notice-warning"><p><strong>WhatsApp:</strong> agrega el número de atención para mostrar el botón en la tienda. <a href="' . esc_url( $url ) . '">Configurar ahora</a>.</p></div>';
}
add_action( 'admin_notices', 'tienda_whatsapp_admin_notice' );

function tienda_whatsapp_enqueue_style() {
	$options = tienda_whatsapp_options();
	if ( 'yes' !== $options['enabled'] || empty( $options['phone'] ) ) return;
	wp_enqueue_style( 'tienda-whatsapp', plugin_dir_url( __FILE__ ) . 'assets/whatsapp.css', array(), TIENDA_WHATSAPP_VERSION );
	wp_add_inline_style( 'tienda-whatsapp', '.tienda-whatsapp{--tw-color:' . esc_attr( $options['color'] ) . '}' );
}
add_action( 'wp_enqueue_scripts', 'tienda_whatsapp_enqueue_style' );

function tienda_whatsapp_button() {
	$options = tienda_whatsapp_options();
	if ( 'yes' !== $options['enabled'] || empty( $options['phone'] ) ) return;
	$message = $options['message'];
	if ( function_exists( 'is_product' ) && is_product() ) {
		$message .= ' Producto: ' . get_the_title() . ' — ' . get_permalink();
	} elseif ( function_exists( 'is_cart' ) && is_cart() ) {
		$message .= ' Estoy revisando mi carrito y necesito asistencia.';
	} elseif ( function_exists( 'is_checkout' ) && is_checkout() ) {
		$message .= ' Estoy finalizando mi compra y necesito asistencia.';
	}
	$url = 'https://wa.me/' . $options['phone'] . '?text=' . rawurlencode( $message );
	?>
	<a class="tienda-whatsapp is-<?php echo esc_attr( $options['position'] ); ?>" href="<?php echo esc_url( $url ); ?>" target="_blank" rel="noopener noreferrer" aria-label="<?php echo esc_attr( $options['label'] . ' por WhatsApp' ); ?>">
		<span class="tienda-whatsapp__label"><?php echo esc_html( $options['label'] ); ?></span>
		<span class="tienda-whatsapp__icon" aria-hidden="true"><svg viewBox="0 0 32 32" role="img"><path fill="currentColor" d="M16 3a13 13 0 0 0-11.3 19.4L3 29l6.8-1.8A13 13 0 1 0 16 3Zm0 23.7c-2 0-3.8-.5-5.4-1.5l-.4-.2-4 .9 1.1-3.9-.2-.4A10.7 10.7 0 1 1 16 26.7Zm5.9-8c-.3-.2-1.9-.9-2.2-1-.3-.1-.5-.2-.7.2-.2.3-.8 1-.9 1.2-.2.2-.3.2-.7.1-1.9-.9-3.2-1.7-4.5-3.9-.3-.6.3-.6.9-1.9.1-.2 0-.4 0-.6l-1-2.5c-.3-.6-.6-.5-.9-.5h-.7c-.2 0-.6.1-1 .5-.3.4-1.3 1.3-1.3 3.2s1.4 3.7 1.6 4c.2.3 2.7 4.1 6.5 5.7 2.4 1 3.4 1.1 4.6.9.7-.1 1.9-.8 2.2-1.5.3-.7.3-1.4.2-1.5-.1-.2-.3-.3-.6-.4Z"/></svg></span>
	</a>
	<?php
}
add_action( 'wp_footer', 'tienda_whatsapp_button', 20 );

function tienda_whatsapp_plugin_action_links( $links ) {
	array_unshift( $links, '<a href="' . esc_url( admin_url( 'options-general.php?page=tienda-whatsapp' ) ) . '">Configurar</a>' );
	return $links;
}
add_filter( 'plugin_action_links_' . plugin_basename( __FILE__ ), 'tienda_whatsapp_plugin_action_links' );
