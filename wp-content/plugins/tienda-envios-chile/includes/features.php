<?php

defined( 'ABSPATH' ) || exit;

/** Extra operational settings shown above the commune table. */
function tienda_envios_chile_operational_settings() {
	if ( ! isset( $_GET['section'] ) || 'commune_rates' !== sanitize_key( wp_unslash( $_GET['section'] ) ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Recommended
		return;
	}
	$export_url = wp_nonce_url( admin_url( 'admin-post.php?action=tienda_envios_chile_export' ), 'tienda_envios_chile_export' );
	$enabled_gateways = array_filter( WC()->payment_gateways()->payment_gateways(), function( $gateway ) { return 'yes' === $gateway->enabled; } );
	$configured_count = 0; foreach ( get_option( 'tienda_moda_commune_shipping_rates', array() ) as $items ) $configured_count += count( $items );
	?>
	<div class="notice <?php echo $enabled_gateways ? 'notice-info' : 'notice-warning'; ?> inline"><p><strong><?php esc_html_e( 'Diagnóstico:', 'tienda-envios-chile' ); ?></strong> <?php echo esc_html( sprintf( __( '%1$d comunas con tarifa y %2$d medios de pago activos.', 'tienda-envios-chile' ), $configured_count, count( $enabled_gateways ) ) ); ?><?php if ( ! $enabled_gateways ) : ?> <strong><?php esc_html_e( 'Activa al menos un medio de pago para recibir pedidos.', 'tienda-envios-chile' ); ?></strong><?php endif; ?></p></div>
	<div class="postbox" style="max-width:1000px;padding:18px;margin-top:20px">
		<h2 style="margin-top:0"><?php esc_html_e( 'Configuración general de entregas', 'tienda-envios-chile' ); ?></h2>
		<table class="form-table"><tbody>
		<tr><th><label for="tec_eta"><?php esc_html_e( 'Plazo predeterminado', 'tienda-envios-chile' ); ?></label></th><td><input id="tec_eta" class="regular-text" name="tienda_envios_chile_default_eta" value="<?php echo esc_attr( get_option( 'tienda_envios_chile_default_eta', '' ) ); ?>" placeholder="2 a 4 días hábiles"></td></tr>
		<tr><th><label for="tec_free"><?php esc_html_e( 'Envío gratis desde', 'tienda-envios-chile' ); ?></label></th><td><input id="tec_free" type="number" min="0" step="1" name="tienda_envios_chile_free_from" value="<?php echo esc_attr( get_option( 'tienda_envios_chile_free_from', '' ) ); ?>"><p class="description"><?php esc_html_e( 'Déjalo vacío para desactivar el envío gratis automático.', 'tienda-envios-chile' ); ?></p></td></tr>
		<tr><th><label for="tec_collect"><?php esc_html_e( 'Condiciones del envío por pagar', 'tienda-envios-chile' ); ?></label></th><td><textarea id="tec_collect" class="large-text" rows="3" name="tienda_envios_chile_collect_notice"><?php echo esc_textarea( get_option( 'tienda_envios_chile_collect_notice', 'El transporte se paga directamente al transportista al momento de recibir el pedido.' ) ); ?></textarea></td></tr>
		<tr><th><label for="tec_pickups"><?php esc_html_e( 'Sucursales de retiro', 'tienda-envios-chile' ); ?></label></th><td><textarea id="tec_pickups" class="large-text code" rows="5" name="tienda_envios_chile_pickup_locations"><?php echo esc_textarea( get_option( 'tienda_envios_chile_pickup_locations', '' ) ); ?></textarea><p class="description"><?php esc_html_e( 'Una por línea: Nombre | Dirección | Horario | Instrucciones', 'tienda-envios-chile' ); ?></p></td></tr>
		<tr><th><?php esc_html_e( 'Importar / exportar CSV', 'tienda-envios-chile' ); ?></th><td><a class="button" href="<?php echo esc_url( $export_url ); ?>"><?php esc_html_e( 'Descargar CSV', 'tienda-envios-chile' ); ?></a><textarea class="large-text code" rows="4" name="tienda_envios_chile_csv" placeholder="region,comuna,precio,modalidad,plazo,envio_gratis_desde"></textarea><p class="description"><?php esc_html_e( 'Pega un CSV exportado para actualizar configuraciones. La primera fila puede contener encabezados.', 'tienda-envios-chile' ); ?></p></td></tr>
		</tbody></table>
		<?php wp_nonce_field( 'tienda_envios_chile_features', 'tienda_envios_chile_features_nonce' ); ?>
	</div>
	<?php
}
add_action( 'woocommerce_settings_shipping', 'tienda_envios_chile_operational_settings', 5 );

function tienda_envios_chile_parse_locations() {
	$locations = array();
	foreach ( preg_split( '/\R/', (string) get_option( 'tienda_envios_chile_pickup_locations', '' ) ) as $line ) {
		$parts = array_map( 'trim', explode( '|', $line ) );
		if ( ! empty( $parts[0] ) ) {
			$locations[ sanitize_title( $parts[0] ) ] = array( 'name' => $parts[0], 'address' => $parts[1] ?? '', 'hours' => $parts[2] ?? '', 'instructions' => $parts[3] ?? '' );
		}
	}
	return $locations;
}

function tienda_envios_chile_save_features() {
	if ( ! isset( $_GET['section'] ) || 'commune_rates' !== sanitize_key( wp_unslash( $_GET['section'] ) ) || ! isset( $_POST['tienda_envios_chile_features_nonce'] ) || ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['tienda_envios_chile_features_nonce'] ) ), 'tienda_envios_chile_features' ) ) {
		return;
	}
	update_option( 'tienda_envios_chile_default_eta', isset( $_POST['tienda_envios_chile_default_eta'] ) ? sanitize_text_field( wp_unslash( $_POST['tienda_envios_chile_default_eta'] ) ) : '', false );
	update_option( 'tienda_envios_chile_free_from', isset( $_POST['tienda_envios_chile_free_from'] ) ? wc_format_decimal( wp_unslash( $_POST['tienda_envios_chile_free_from'] ) ) : '', false );
	update_option( 'tienda_envios_chile_collect_notice', isset( $_POST['tienda_envios_chile_collect_notice'] ) ? sanitize_textarea_field( wp_unslash( $_POST['tienda_envios_chile_collect_notice'] ) ) : '', false );
	update_option( 'tienda_envios_chile_pickup_locations', isset( $_POST['tienda_envios_chile_pickup_locations'] ) ? sanitize_textarea_field( wp_unslash( $_POST['tienda_envios_chile_pickup_locations'] ) ) : '', false );
	if ( ! empty( $_POST['tienda_envios_chile_csv'] ) ) {
		tienda_envios_chile_import_csv( wp_unslash( $_POST['tienda_envios_chile_csv'] ) );
	}
}
add_action( 'woocommerce_update_options_shipping', 'tienda_envios_chile_save_features', 20 );

function tienda_envios_chile_import_csv( $csv ) {
	$valid = tienda_envios_chile_communes();
	$rates = get_option( 'tienda_moda_commune_shipping_rates', array() );
	$modes = get_option( 'tienda_envios_chile_commune_modes', array() );
	$etas  = get_option( 'tienda_envios_chile_commune_eta', array() );
	$free  = get_option( 'tienda_envios_chile_commune_free_from', array() );
	foreach ( preg_split( '/\R/', trim( $csv ) ) as $index => $line ) {
		$row = str_getcsv( $line );
		if ( $index === 0 && isset( $row[0] ) && 'region' === strtolower( trim( $row[0] ) ) ) continue;
		$state = sanitize_text_field( $row[0] ?? '' ); $city = sanitize_text_field( $row[1] ?? '' );
		if ( ! isset( $valid[ $state ] ) || ! in_array( $city, $valid[ $state ], true ) ) continue;
		if ( isset( $row[2] ) && '' !== trim( $row[2] ) ) $rates[ $state ][ $city ] = wc_format_decimal( $row[2] );
		if ( ! empty( $row[3] ) ) $modes[ $state ][ $city ] = sanitize_key( $row[3] );
		if ( ! empty( $row[4] ) ) $etas[ $state ][ $city ] = sanitize_text_field( $row[4] );
		if ( isset( $row[5] ) && '' !== trim( $row[5] ) ) $free[ $state ][ $city ] = wc_format_decimal( $row[5] );
	}
	update_option( 'tienda_moda_commune_shipping_rates', $rates, false ); update_option( 'tienda_envios_chile_commune_modes', $modes, false ); update_option( 'tienda_envios_chile_commune_eta', $etas, false ); update_option( 'tienda_envios_chile_commune_free_from', $free, false );
}

function tienda_envios_chile_export_csv() {
	if ( ! current_user_can( 'manage_woocommerce' ) || ! check_admin_referer( 'tienda_envios_chile_export' ) ) wp_die( esc_html__( 'Acceso denegado.', 'tienda-envios-chile' ) );
	$rates = get_option( 'tienda_moda_commune_shipping_rates', array() ); $modes = get_option( 'tienda_envios_chile_commune_modes', array() ); $etas = get_option( 'tienda_envios_chile_commune_eta', array() ); $free = get_option( 'tienda_envios_chile_commune_free_from', array() );
	header( 'Content-Type: text/csv; charset=utf-8' ); header( 'Content-Disposition: attachment; filename=tarifas-comunas-chile.csv' );
	$out = fopen( 'php://output', 'w' ); fputcsv( $out, array( 'region', 'comuna', 'precio', 'modalidad', 'plazo', 'envio_gratis_desde' ) );
	foreach ( tienda_envios_chile_communes() as $state => $cities ) foreach ( $cities as $city ) fputcsv( $out, array( $state, $city, $rates[ $state ][ $city ] ?? '', $modes[ $state ][ $city ] ?? 'delivery', $etas[ $state ][ $city ] ?? '', $free[ $state ][ $city ] ?? '' ) );
	fclose( $out ); exit;
}
add_action( 'admin_post_tienda_envios_chile_export', 'tienda_envios_chile_export_csv' );

/** Add delivery promises and free-shipping thresholds. */
function tienda_envios_chile_enrich_rates( $rates, $package ) {
	$state = $package['destination']['state'] ?? ''; $city = $package['destination']['city'] ?? '';
	$etas = get_option( 'tienda_envios_chile_commune_eta', array() ); $free_map = get_option( 'tienda_envios_chile_commune_free_from', array() );
	$eta = $etas[ $state ][ $city ] ?? get_option( 'tienda_envios_chile_default_eta', '' );
	$threshold = $free_map[ $state ][ $city ] ?? get_option( 'tienda_envios_chile_free_from', '' );
	$subtotal = WC()->cart ? (float) WC()->cart->get_displayed_subtotal() : 0;
	foreach ( $rates as $rate ) {
		if ( $eta && ! in_array( $rate->get_method_id(), array( 'local_pickup', 'tienda_envios_chile_collect' ), true ) ) $rate->set_label( $rate->get_label() . ' — ' . $eta );
		if ( '' !== $threshold && $subtotal >= (float) $threshold && ! in_array( $rate->get_method_id(), array( 'local_pickup', 'tienda_envios_chile_collect' ), true ) ) { $rate->set_cost( 0 ); $rate->set_taxes( array() ); }
	}
	return $rates;
}
add_filter( 'woocommerce_package_rates', 'tienda_envios_chile_enrich_rates', 30, 2 );

function tienda_envios_chile_shipping_rate_details( $rate ) {
	if ( 'tienda_envios_chile_collect' === $rate->get_method_id() ) {
		$notice = get_option( 'tienda_envios_chile_collect_notice', '' );
		if ( $notice ) echo '<p class="tienda-envios-chile-rate-note"><small>' . esc_html( $notice ) . '</small></p>';
	}
}
add_action( 'woocommerce_after_shipping_rate', 'tienda_envios_chile_shipping_rate_details' );
