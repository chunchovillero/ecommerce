<?php

defined( 'ABSPATH' ) || exit;

/**
 * Configure a concise Chile-oriented classic checkout, including RUT.
 *
 * @param array $fields Checkout field groups.
 * @return array
 */
function tienda_moda_checkout_fields( $fields ) {
	unset( $fields['billing']['billing_company'], $fields['billing']['billing_address_2'] );
	unset( $fields['shipping']['shipping_company'], $fields['shipping']['shipping_address_2'] );

	$fields['billing']['billing_first_name']['priority'] = 10;
	$fields['billing']['billing_last_name']['priority']  = 20;
	$fields['billing']['billing_email']['priority']      = 30;
	$fields['billing']['billing_phone']['priority']      = 40;
	$fields['billing']['billing_rut'] = array(
		'type'         => 'text',
		'label'        => __( 'RUT', 'tienda-moda' ),
		'placeholder'  => __( '12.345.678-5', 'tienda-moda' ),
		'required'     => true,
		'class'        => array( 'form-row-wide' ),
		'priority'     => 45,
		'autocomplete' => 'off',
		'custom_attributes' => array(
			'inputmode' => 'text',
			'maxlength' => '12',
		),
	);
	$fields['billing']['billing_country']['priority']  = 50;
	$fields['billing']['billing_address_1']['priority'] = 60;
	$fields['billing']['billing_state']['label']        = __( 'Región', 'tienda-moda' );
	$fields['billing']['billing_state']['priority']     = 70;
	$fields['billing']['billing_city']['label']         = __( 'Comuna', 'tienda-moda' );
	$fields['billing']['billing_city']['priority']      = 80;
	$fields['billing']['billing_postcode']['label']     = __( 'Código postal (opcional)', 'tienda-moda' );
	$fields['billing']['billing_postcode']['required']  = false;
	$fields['billing']['billing_postcode']['priority']  = 90;

	$fields['shipping']['shipping_state']['label']       = __( 'Región', 'tienda-moda' );
	$fields['shipping']['shipping_city']['label']        = __( 'Comuna', 'tienda-moda' );
	$fields['shipping']['shipping_postcode']['label']    = __( 'Código postal (opcional)', 'tienda-moda' );
	$fields['shipping']['shipping_postcode']['required'] = false;

	return $fields;
}
add_filter( 'woocommerce_checkout_fields', 'tienda_moda_checkout_fields' );

add_filter( 'default_checkout_billing_country', function() { return 'CL'; } );
add_filter( 'default_checkout_shipping_country', function() { return 'CL'; } );

/**
 * Normalize a Chilean RUT for storage and display.
 *
 * @param string $rut Raw RUT.
 * @return string
 */
function tienda_moda_format_rut( $rut ) {
	$clean = strtoupper( preg_replace( '/[^0-9K]/i', '', $rut ) );

	if ( strlen( $clean ) < 2 ) {
		return $clean;
	}

	$body = substr( $clean, 0, -1 );
	$dv   = substr( $clean, -1 );
	return number_format( (int) $body, 0, '', '.' ) . '-' . $dv;
}

/**
 * Validate the Chilean modulus-11 check digit.
 *
 * @param string $rut Raw RUT.
 * @return bool
 */
function tienda_moda_is_valid_rut( $rut ) {
	$clean = strtoupper( preg_replace( '/[^0-9K]/i', '', $rut ) );

	if ( ! preg_match( '/^[0-9]{7,8}[0-9K]$/', $clean ) ) {
		return false;
	}

	$body       = substr( $clean, 0, -1 );
	$given      = substr( $clean, -1 );
	$sum        = 0;
	$multiplier = 2;

	for ( $index = strlen( $body ) - 1; $index >= 0; $index-- ) {
		$sum += (int) $body[ $index ] * $multiplier;
		$multiplier = 7 === $multiplier ? 2 : $multiplier + 1;
	}

	$result   = 11 - ( $sum % 11 );
	$expected = 11 === $result ? '0' : ( 10 === $result ? 'K' : (string) $result );
	return hash_equals( $expected, $given );
}

/**
 * Validate RUT during WooCommerce checkout.
 */
function tienda_moda_validate_checkout_rut() {
	$rut = isset( $_POST['billing_rut'] ) ? sanitize_text_field( wp_unslash( $_POST['billing_rut'] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Missing

	if ( ! $rut ) {
		wc_add_notice( __( 'Ingresa tu RUT.', 'tienda-moda' ), 'error' );
	} elseif ( ! tienda_moda_is_valid_rut( $rut ) ) {
		wc_add_notice( __( 'El RUT ingresado no es válido.', 'tienda-moda' ), 'error' );
	}
}
add_action( 'woocommerce_checkout_process', 'tienda_moda_validate_checkout_rut' );

/**
 * Save RUT using the CRUD order API (HPOS compatible).
 *
 * @param WC_Order $order Order object.
 */
function tienda_moda_save_checkout_rut( $order ) {
	if ( isset( $_POST['billing_rut'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$rut = sanitize_text_field( wp_unslash( $_POST['billing_rut'] ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$order->update_meta_data( '_billing_rut', tienda_moda_format_rut( $rut ) );
	}
}
add_action( 'woocommerce_checkout_create_order', 'tienda_moda_save_checkout_rut' );

/**
 * Show RUT to administrators.
 *
 * @param WC_Order $order Order.
 */
function tienda_moda_admin_order_rut( $order ) {
	$rut = $order->get_meta( '_billing_rut' );
	if ( $rut ) {
		echo '<p><strong>' . esc_html__( 'RUT:', 'tienda-moda' ) . '</strong> ' . esc_html( $rut ) . '</p>';
	}
}
add_action( 'woocommerce_admin_order_data_after_billing_address', 'tienda_moda_admin_order_rut' );

/**
 * Include RUT in transactional order emails.
 *
 * @param array    $fields Email fields.
 * @param bool     $sent_to_admin Admin flag.
 * @param WC_Order $order Order.
 * @return array
 */
function tienda_moda_email_order_rut( $fields, $sent_to_admin, $order ) {
	$rut = $order->get_meta( '_billing_rut' );
	if ( $rut ) {
		$fields['billing_rut'] = array(
			'label' => __( 'RUT', 'tienda-moda' ),
			'value' => $rut,
		);
	}
	return $fields;
}
add_filter( 'woocommerce_email_order_meta_fields', 'tienda_moda_email_order_rut', 10, 3 );
