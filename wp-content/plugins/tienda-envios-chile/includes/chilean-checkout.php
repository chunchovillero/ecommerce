<?php

defined( 'ABSPATH' ) || exit;

/** Add Chilean document and invoicing fields to the classic checkout. */
function tienda_envios_chile_tax_document_fields( $fields ) {
	$fields['billing']['billing_document_type'] = array( 'type' => 'select', 'label' => __( 'Documento tributario', 'tienda-envios-chile' ), 'required' => true, 'options' => array( 'boleta' => __( 'Boleta', 'tienda-envios-chile' ), 'factura' => __( 'Factura', 'tienda-envios-chile' ) ), 'class' => array( 'form-row-wide' ), 'priority' => 46 );
	$invoice = array(
		'billing_business_name' => array( __( 'Razón social', 'tienda-envios-chile' ), 47 ),
		'billing_business_rut' => array( __( 'RUT empresa', 'tienda-envios-chile' ), 48 ),
		'billing_business_activity' => array( __( 'Giro', 'tienda-envios-chile' ), 49 ),
		'billing_business_address' => array( __( 'Dirección tributaria', 'tienda-envios-chile' ), 50 ),
	);
	foreach ( $invoice as $key => $data ) $fields['billing'][ $key ] = array( 'type' => 'text', 'label' => $data[0], 'required' => false, 'class' => array( 'form-row-wide', 'tienda-envios-chile-invoice' ), 'priority' => $data[1] );
	$fields['billing']['billing_phone']['required'] = true;
	$fields['billing']['billing_phone']['placeholder'] = '+56 9 1234 5678';
	return $fields;
}
add_filter( 'woocommerce_checkout_fields', 'tienda_envios_chile_tax_document_fields', 25 );

function tienda_envios_chile_validate_chilean_checkout() {
	$phone = preg_replace( '/\D+/', '', wp_unslash( $_POST['billing_phone'] ?? '' ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	if ( 11 === strlen( $phone ) && 0 === strpos( $phone, '56' ) ) $phone = substr( $phone, 2 );
	if ( ! preg_match( '/^[2-9][0-9]{8}$/', $phone ) ) wc_add_notice( __( 'Ingresa un teléfono chileno válido de 9 dígitos.', 'tienda-envios-chile' ), 'error' );
	if ( 'factura' === sanitize_key( wp_unslash( $_POST['billing_document_type'] ?? '' ) ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		foreach ( array( 'billing_business_name' => 'razón social', 'billing_business_rut' => 'RUT empresa', 'billing_business_activity' => 'giro', 'billing_business_address' => 'dirección tributaria' ) as $key => $label ) {
			if ( empty( $_POST[ $key ] ) ) wc_add_notice( sprintf( __( 'Para solicitar factura, completa: %s.', 'tienda-envios-chile' ), $label ), 'error' ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
		}
		if ( ! empty( $_POST['billing_business_rut'] ) && ! tienda_moda_is_valid_rut( wp_unslash( $_POST['billing_business_rut'] ) ) ) wc_add_notice( __( 'El RUT de empresa no es válido.', 'tienda-envios-chile' ), 'error' ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	}
	$methods = array_map( 'sanitize_text_field', (array) wp_unslash( $_POST['shipping_method'] ?? array() ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	if ( array_filter( $methods, function( $method ) { return false !== strpos( $method, 'collect' ); } ) && empty( $_POST['tienda_envios_chile_collect_accept'] ) ) wc_add_notice( __( 'Debes aceptar las condiciones del envío por pagar.', 'tienda-envios-chile' ), 'error' );
}
add_action( 'woocommerce_checkout_process', 'tienda_envios_chile_validate_chilean_checkout' );

function tienda_envios_chile_save_tax_document( $order ) {
	$keys = array( 'billing_document_type', 'billing_business_name', 'billing_business_rut', 'billing_business_activity', 'billing_business_address' );
	foreach ( $keys as $key ) if ( isset( $_POST[ $key ] ) ) $order->update_meta_data( '_' . $key, sanitize_text_field( wp_unslash( $_POST[ $key ] ) ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	if ( isset( $_POST['billing_phone'] ) ) { $phone = preg_replace( '/\D+/', '', wp_unslash( $_POST['billing_phone'] ) ); if ( 11 === strlen( $phone ) && 0 === strpos( $phone, '56' ) ) $phone = substr( $phone, 2 ); $order->set_billing_phone( '+56' . $phone ); } // phpcs:ignore WordPress.Security.NonceVerification.Missing
	if ( ! empty( $_POST['tienda_envios_chile_collect_accept'] ) ) $order->update_meta_data( '_tienda_envios_chile_collect_accepted', 'yes' ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
}
add_action( 'woocommerce_checkout_create_order', 'tienda_envios_chile_save_tax_document', 25 );

function tienda_envios_chile_collect_acceptance() {
	$notice = get_option( 'tienda_envios_chile_collect_notice', __( 'El transporte se paga directamente al transportista al recibir.', 'tienda-envios-chile' ) );
	echo '<p class="form-row form-row-wide tienda-envios-chile-collect-accept" hidden><label class="woocommerce-form__label woocommerce-form__label-for-checkbox checkbox"><input type="checkbox" name="tienda_envios_chile_collect_accept" value="1"> <span>' . esc_html( sprintf( __( 'Acepto el envío por pagar: %s', 'tienda-envios-chile' ), $notice ) ) . '</span> <abbr class="required" title="required">*</abbr></label></p>';
}
add_action( 'woocommerce_review_order_before_submit', 'tienda_envios_chile_collect_acceptance' );

function tienda_envios_chile_tax_document_email_fields( $fields, $sent_to_admin, $order ) {
	$labels = array( 'billing_document_type' => __( 'Documento', 'tienda-envios-chile' ), 'billing_business_name' => __( 'Razón social', 'tienda-envios-chile' ), 'billing_business_rut' => __( 'RUT empresa', 'tienda-envios-chile' ), 'billing_business_activity' => __( 'Giro', 'tienda-envios-chile' ), 'billing_business_address' => __( 'Dirección tributaria', 'tienda-envios-chile' ) );
	foreach ( $labels as $key => $label ) { $value = $order->get_meta( '_' . $key ); if ( $value ) $fields[ $key ] = array( 'label' => $label, 'value' => $value ); }
	return $fields;
}
add_filter( 'woocommerce_email_order_meta_fields', 'tienda_envios_chile_tax_document_email_fields', 30, 3 );

/** Checkout Block fields for RUT/document data and collect acceptance. */
function tienda_envios_chile_register_extended_block_fields() {
	if ( ! function_exists( 'woocommerce_register_additional_checkout_field' ) ) return;
	$fields = array(
		array( 'id' => 'tienda-envios-chile/documento', 'label' => __( 'Documento tributario', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'select', 'required' => true, 'options' => array( array( 'value' => 'boleta', 'label' => 'Boleta' ), array( 'value' => 'factura', 'label' => 'Factura' ) ) ),
		array( 'id' => 'tienda-envios-chile/razon-social', 'label' => __( 'Razón social (si requiere factura)', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'text', 'required' => false ),
		array( 'id' => 'tienda-envios-chile/rut-empresa', 'label' => __( 'RUT empresa (si requiere factura)', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'text', 'required' => false ),
		array( 'id' => 'tienda-envios-chile/giro', 'label' => __( 'Giro (si requiere factura)', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'text', 'required' => false ),
		array( 'id' => 'tienda-envios-chile/direccion-tributaria', 'label' => __( 'Dirección tributaria (si requiere factura)', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'text', 'required' => false ),
		array( 'id' => 'tienda-envios-chile/acepta-por-pagar', 'label' => __( 'Acepto que el envío por pagar se cancela al recibir', 'tienda-envios-chile' ), 'location' => 'order', 'type' => 'checkbox', 'required' => false ),
	);
	foreach ( $fields as $field ) woocommerce_register_additional_checkout_field( $field );
}
add_action( 'woocommerce_init', 'tienda_envios_chile_register_extended_block_fields', 20 );
