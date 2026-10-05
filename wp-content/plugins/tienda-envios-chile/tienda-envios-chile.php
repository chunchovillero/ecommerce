<?php
/**
 * Plugin Name: WooCommerce Chile — RUT, Comunas y Envíos
 * Description: Localización chilena de checkout con RUT, regiones, comunas, tarifas de despacho y retiro por comuna.
 * Version: 4.0.0
 * Requires at least: 6.4
 * Requires PHP: 7.4
 * Requires Plugins: woocommerce
 * Author: Tienda de Moda
 * Text Domain: tienda-envios-chile
 */

defined( 'ABSPATH' ) || exit;

define( 'TIENDA_ENVIOS_CHILE_VERSION', '4.0.0' );
define( 'TIENDA_ENVIOS_CHILE_FILE', __FILE__ );

require_once plugin_dir_path( __FILE__ ) . 'includes/communes.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/rut.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/checkout.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/rates.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/features.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/chilean-checkout.php';
require_once plugin_dir_path( __FILE__ ) . 'includes/admin.php';

/** Declare compatibility with WooCommerce's current order storage. */
function tienda_envios_chile_declare_compatibility() {
	if ( class_exists( '\Automattic\WooCommerce\Utilities\FeaturesUtil' ) ) {
		\Automattic\WooCommerce\Utilities\FeaturesUtil::declare_compatibility( 'custom_order_tables', TIENDA_ENVIOS_CHILE_FILE, true );
		\Automattic\WooCommerce\Utilities\FeaturesUtil::declare_compatibility( 'cart_checkout_blocks', TIENDA_ENVIOS_CHILE_FILE, true );
	}
}
add_action( 'before_woocommerce_init', 'tienda_envios_chile_declare_compatibility' );

/** Set non-destructive Chilean defaults on first activation. */
function tienda_envios_chile_activate() {
	add_option( 'woocommerce_default_country', 'CL:CL-RM' );
	add_option( 'woocommerce_currency', 'CLP' );
	add_option( 'woocommerce_currency_pos', 'left' );
	add_option( 'woocommerce_price_thousand_sep', '.' );
	add_option( 'woocommerce_price_decimal_sep', ',' );
	add_option( 'woocommerce_price_num_decimals', '0' );
}
register_activation_hook( __FILE__, 'tienda_envios_chile_activate' );

function tienda_envios_chile_admin_notice() {
	if ( current_user_can( 'activate_plugins' ) && ! class_exists( 'WooCommerce' ) ) {
		echo '<div class="notice notice-error"><p>' . esc_html__( 'Envíos por Comuna para Chile requiere WooCommerce activo.', 'tienda-envios-chile' ) . '</p></div>';
	}
}
add_action( 'admin_notices', 'tienda_envios_chile_admin_notice' );

function tienda_envios_chile_enqueue_checkout() {
	if ( ! function_exists( 'is_checkout' ) || ! is_checkout() ) {
		return;
	}
	wp_enqueue_script( 'tienda-envios-chile', plugin_dir_url( __FILE__ ) . 'assets/communes.js', array( 'jquery' ), TIENDA_ENVIOS_CHILE_VERSION, true );
	wp_localize_script( 'tienda-envios-chile', 'tiendaEnviosChile', array(
		'communes' => tienda_envios_chile_communes(),
		'placeholder' => __( 'Selecciona una comuna', 'tienda-envios-chile' ),
		'collectNotice' => get_option( 'tienda_envios_chile_collect_notice', '' ),
	) );
	wp_script_add_data( 'tienda-envios-chile', 'strategy', 'defer' );
}
add_action( 'wp_enqueue_scripts', 'tienda_envios_chile_enqueue_checkout' );
