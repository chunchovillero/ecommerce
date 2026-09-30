<?php

defined( 'ABSPATH' ) || exit;

/**
 * Translate and order the account navigation.
 *
 * @param array $items Existing endpoints.
 * @return array
 */
function tienda_moda_account_menu_items( $items ) {
	$labels = array(
		'dashboard'       => __( 'Mi cuenta', 'tienda-moda' ),
		'orders'          => __( 'Mis pedidos', 'tienda-moda' ),
		'downloads'       => __( 'Descargas', 'tienda-moda' ),
		'edit-address'    => __( 'Direcciones', 'tienda-moda' ),
		'edit-account'    => __( 'Datos personales', 'tienda-moda' ),
		'favoritos'       => __( 'Favoritos', 'tienda-moda' ),
		'customer-logout' => __( 'Cerrar sesión', 'tienda-moda' ),
	);

	foreach ( $items as $endpoint => $label ) {
		if ( isset( $labels[ $endpoint ] ) ) {
			$items[ $endpoint ] = $labels[ $endpoint ];
		}
	}

	$logout = $items['customer-logout'] ?? $labels['customer-logout'];
	unset( $items['customer-logout'] );
	$items['favoritos']       = $labels['favoritos'];
	$items['customer-logout'] = $logout;

	return $items;
}
add_filter( 'woocommerce_account_menu_items', 'tienda_moda_account_menu_items' );

/**
 * Add Chilean personal fields to account details.
 */
function tienda_moda_account_personal_fields() {
	$user_id = get_current_user_id();
	$rut     = get_user_meta( $user_id, 'billing_rut', true );
	$phone   = get_user_meta( $user_id, 'billing_phone', true );
	?>
	<fieldset class="account-extra-fields">
		<legend><?php esc_html_e( 'Información de contacto', 'tienda-moda' ); ?></legend>
		<p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
			<label for="account_phone"><?php esc_html_e( 'Teléfono', 'tienda-moda' ); ?></label>
			<input type="tel" class="woocommerce-Input woocommerce-Input--text input-text" name="account_phone" id="account_phone" autocomplete="tel" value="<?php echo esc_attr( $phone ); ?>">
		</p>
		<p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
			<label for="account_rut"><?php esc_html_e( 'RUT', 'tienda-moda' ); ?></label>
			<input type="text" class="woocommerce-Input woocommerce-Input--text input-text" name="account_rut" id="account_rut" inputmode="text" maxlength="12" value="<?php echo esc_attr( $rut ); ?>">
		</p>
	</fieldset>
	<?php
}
add_action( 'woocommerce_edit_account_form', 'tienda_moda_account_personal_fields' );

/**
 * Validate RUT before WooCommerce saves account details.
 *
 * @param WP_Error $errors Validation errors.
 */
function tienda_moda_validate_account_details( $errors ) {
	$rut = isset( $_POST['account_rut'] ) ? sanitize_text_field( wp_unslash( $_POST['account_rut'] ) ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Missing

	if ( $rut && ! tienda_moda_is_valid_rut( $rut ) ) {
		$errors->add( 'account_rut_error', __( 'El RUT ingresado no es válido.', 'tienda-moda' ) );
	}
}
add_action( 'woocommerce_save_account_details_errors', 'tienda_moda_validate_account_details' );

/**
 * Save extra fields after WooCommerce verifies its account nonce.
 *
 * @param int $user_id Customer ID.
 */
function tienda_moda_save_account_details( $user_id ) {
	if ( isset( $_POST['account_phone'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		update_user_meta( $user_id, 'billing_phone', sanitize_text_field( wp_unslash( $_POST['account_phone'] ) ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
	}
	if ( isset( $_POST['account_rut'] ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Missing
		$rut = sanitize_text_field( wp_unslash( $_POST['account_rut'] ) ); // phpcs:ignore WordPress.Security.NonceVerification.Missing
		if ( $rut ) {
			update_user_meta( $user_id, 'billing_rut', tienda_moda_format_rut( $rut ) );
		} else {
			delete_user_meta( $user_id, 'billing_rut' );
		}
	}
}
add_action( 'woocommerce_save_account_details', 'tienda_moda_save_account_details' );

/**
 * Use clear address titles.
 *
 * @param string $title Address title.
 * @param string $type  Address type.
 * @return string
 */
function tienda_moda_address_title( $title, $type ) {
	return 'billing' === $type ? __( 'Dirección de facturación', 'tienda-moda' ) : __( 'Dirección de despacho', 'tienda-moda' );
}
add_filter( 'woocommerce_my_account_my_address_title', 'tienda_moda_address_title', 10, 2 );
