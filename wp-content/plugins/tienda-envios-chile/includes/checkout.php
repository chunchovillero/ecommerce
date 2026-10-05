<?php

defined( 'ABSPATH' ) || exit;

function tienda_envios_chile_commune_options( $address_type ) {
	$state_key = $address_type . '_state';
	$state = isset( $_POST[ $state_key ] ) ? sanitize_text_field( wp_unslash( $_POST[ $state_key ] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Missing
	if ( ! $state && function_exists( 'WC' ) && WC()->customer ) {
		$getter = 'get_' . $address_type . '_state';
		$state = is_callable( array( WC()->customer, $getter ) ) ? WC()->customer->{$getter}() : '';
	}
	if ( ! $state ) {
		$default_location = explode( ':', (string) get_option( 'woocommerce_default_country', 'CL:CL-RM' ) );
		$state = isset( $default_location[1] ) ? $default_location[1] : 'CL-RM';
	}
	$groups = tienda_envios_chile_communes();
	$options = array( '' => __( 'Selecciona una comuna', 'tienda-envios-chile' ) );
	foreach ( isset( $groups[ $state ] ) ? $groups[ $state ] : array() as $commune ) {
		$options[ $commune ] = $commune;
	}
	return $options;
}

function tienda_envios_chile_checkout_fields( $fields ) {
	foreach ( array( 'billing', 'shipping' ) as $type ) {
		$state = $type . '_state';
		$city  = $type . '_city';
		if ( ! isset( $fields[ $type ][ $state ], $fields[ $type ][ $city ] ) ) {
			continue;
		}
		$fields[ $type ][ $state ]['label'] = __( 'Región', 'tienda-envios-chile' );
		$fields[ $type ][ $state ]['required'] = true;
		$fields[ $type ][ $state ]['priority'] = 70;
		$fields[ $type ][ $city ]['label'] = __( 'Comuna', 'tienda-envios-chile' );
		$fields[ $type ][ $city ]['type'] = 'select';
		$fields[ $type ][ $city ]['required'] = true;
		$fields[ $type ][ $city ]['priority'] = 80;
		$fields[ $type ][ $city ]['options'] = tienda_envios_chile_commune_options( $type );
		$fields[ $type ][ $city ]['class'] = array( 'form-row-wide', 'address-field', 'update_totals_on_change' );
	}
	return $fields;
}
add_filter( 'woocommerce_checkout_fields', 'tienda_envios_chile_checkout_fields', 20 );

/** Keep the Chilean address order consistent in WooCommerce's frontend updater. */
function tienda_envios_chile_country_locale( $locale ) {
	if ( isset( $locale['CL'] ) ) {
		$locale['CL']['state']['priority'] = 70;
		$locale['CL']['city']['priority'] = 80;
		$locale['CL']['city']['label'] = __( 'Comuna', 'tienda-envios-chile' );
	}
	return $locale;
}
add_filter( 'woocommerce_get_country_locale', 'tienda_envios_chile_country_locale' );

add_filter( 'default_checkout_billing_country', function() { return 'CL'; } );
add_filter( 'default_checkout_shipping_country', function() { return 'CL'; } );

function tienda_envios_chile_validate_communes() {
	$groups = tienda_envios_chile_communes();
	$types = array( 'billing' );
	if ( ! empty( $_POST['ship_to_different_address'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$types[] = 'shipping';
	}
	foreach ( $types as $type ) {
		$state = isset( $_POST[ $type . '_state' ] ) ? sanitize_text_field( wp_unslash( $_POST[ $type . '_state' ] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$city = isset( $_POST[ $type . '_city' ] ) ? sanitize_text_field( wp_unslash( $_POST[ $type . '_city' ] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$country = isset( $_POST[ $type . '_country' ] ) ? sanitize_text_field( wp_unslash( $_POST[ $type . '_country' ] ) ) : 'CL'; // phpcs:ignore WordPress.Security.NonceVerification.Missing
		if ( 'CL' === $country && ( ! isset( $groups[ $state ] ) || ! in_array( $city, $groups[ $state ], true ) ) ) {
			wc_add_notice( 'billing' === $type ? __( 'Selecciona una comuna válida para la región de facturación.', 'tienda-envios-chile' ) : __( 'Selecciona una comuna válida para la región de despacho.', 'tienda-envios-chile' ), 'error' );
		}
	}
}
add_action( 'woocommerce_checkout_process', 'tienda_envios_chile_validate_communes' );

/** Pickup branch selector for the classic checkout. */
function tienda_envios_chile_pickup_checkout_field( $fields ) {
	$locations = function_exists( 'tienda_envios_chile_parse_locations' ) ? tienda_envios_chile_parse_locations() : array();
	if ( $locations ) {
		$options = array( '' => __( 'Selecciona una sucursal', 'tienda-envios-chile' ) );
		foreach ( $locations as $key => $location ) $options[ $key ] = $location['name'] . ( $location['address'] ? ' — ' . $location['address'] : '' );
		$fields['order']['tienda_envios_chile_pickup_location'] = array( 'type' => 'select', 'label' => __( 'Sucursal de retiro', 'tienda-envios-chile' ), 'required' => false, 'options' => $options, 'class' => array( 'form-row-wide', 'tienda-envios-chile-pickup-field' ), 'priority' => 15 );
	}
	return $fields;
}
add_filter( 'woocommerce_checkout_fields', 'tienda_envios_chile_pickup_checkout_field', 30 );

function tienda_envios_chile_validate_pickup_location() {
	$methods = isset( $_POST['shipping_method'] ) ? array_map( 'sanitize_text_field', (array) wp_unslash( $_POST['shipping_method'] ) ) : array(); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	$is_pickup = (bool) array_filter( $methods, function( $method ) { return false !== strpos( $method, 'pickup' ); } );
	if ( $is_pickup && tienda_envios_chile_parse_locations() && empty( $_POST['tienda_envios_chile_pickup_location'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		wc_add_notice( __( 'Selecciona una sucursal de retiro.', 'tienda-envios-chile' ), 'error' );
	}
}
add_action( 'woocommerce_checkout_process', 'tienda_envios_chile_validate_pickup_location' );

function tienda_envios_chile_save_delivery_order_data( $order ) {
	if ( isset( $_POST['tienda_envios_chile_pickup_location'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$key = sanitize_key( wp_unslash( $_POST['tienda_envios_chile_pickup_location'] ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$locations = tienda_envios_chile_parse_locations();
		if ( isset( $locations[ $key ] ) ) $order->update_meta_data( '_tienda_envios_chile_pickup', $locations[ $key ] );
	}
	$state = isset( $_POST['shipping_state'] ) && ! empty( $_POST['ship_to_different_address'] ) ? sanitize_text_field( wp_unslash( $_POST['shipping_state'] ) ) : sanitize_text_field( wp_unslash( $_POST['billing_state'] ?? '' ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	$city = isset( $_POST['shipping_city'] ) && ! empty( $_POST['ship_to_different_address'] ) ? sanitize_text_field( wp_unslash( $_POST['shipping_city'] ) ) : sanitize_text_field( wp_unslash( $_POST['billing_city'] ?? '' ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	$etas = get_option( 'tienda_envios_chile_commune_eta', array() ); $eta = $etas[ $state ][ $city ] ?? get_option( 'tienda_envios_chile_default_eta', '' );
	if ( $eta ) $order->update_meta_data( '_tienda_envios_chile_eta', $eta );
}
add_action( 'woocommerce_checkout_create_order', 'tienda_envios_chile_save_delivery_order_data', 20 );

function tienda_envios_chile_order_delivery_meta( $fields, $sent_to_admin, $order ) {
	$eta = $order->get_meta( '_tienda_envios_chile_eta' ); $pickup = $order->get_meta( '_tienda_envios_chile_pickup' );
	if ( $eta ) $fields['tienda_envios_eta'] = array( 'label' => __( 'Plazo estimado', 'tienda-envios-chile' ), 'value' => $eta );
	if ( is_array( $pickup ) && ! empty( $pickup['name'] ) ) $fields['tienda_envios_pickup'] = array( 'label' => __( 'Sucursal de retiro', 'tienda-envios-chile' ), 'value' => implode( ' — ', array_filter( $pickup ) ) );
	return $fields;
}
add_filter( 'woocommerce_email_order_meta_fields', 'tienda_envios_chile_order_delivery_meta', 20, 3 );

function tienda_envios_chile_admin_delivery_meta( $order ) {
	$fields = tienda_envios_chile_order_delivery_meta( array(), true, $order );
	foreach ( $fields as $field ) echo '<p><strong>' . esc_html( $field['label'] ) . ':</strong> ' . esc_html( $field['value'] ) . '</p>';
}
add_action( 'woocommerce_admin_order_data_after_shipping_address', 'tienda_envios_chile_admin_delivery_meta' );

/** Register RUT in the Checkout Block when the current WooCommerce API is available. */
function tienda_envios_chile_register_block_fields() {
	if ( ! function_exists( 'woocommerce_register_additional_checkout_field' ) ) return;
	woocommerce_register_additional_checkout_field( array( 'id' => 'tienda-envios-chile/rut', 'label' => __( 'RUT', 'tienda-envios-chile' ), 'location' => 'address', 'type' => 'text', 'required' => true, 'sanitize_callback' => 'tienda_moda_format_rut', 'validate_callback' => function( $value ) { return tienda_moda_is_valid_rut( $value ) ? null : new WP_Error( 'invalid_rut', __( 'El RUT ingresado no es válido.', 'tienda-envios-chile' ) ); } ) );
}
add_action( 'woocommerce_init', 'tienda_envios_chile_register_block_fields' );
