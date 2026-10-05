<?php

defined( 'ABSPATH' ) || exit;

/** Add the commune rates subsection to WooCommerce shipping settings. */
function tienda_envios_chile_shipping_sections( $sections ) {
	$sections['commune_rates'] = __( 'Tarifas por comuna', 'tienda-moda' );
	return $sections;
}
add_filter( 'woocommerce_get_sections_shipping', 'tienda_envios_chile_shipping_sections' );

/** Render the commune rate editor. */
function tienda_envios_chile_commune_rates_settings() {
	if ( ! isset( $_GET['section'] ) || 'commune_rates' !== sanitize_key( wp_unslash( $_GET['section'] ) ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Recommended
		return;
	}

	$communes = tienda_envios_chile_communes();
	$rates    = get_option( 'tienda_moda_commune_shipping_rates', array() );
	$modes    = get_option( 'tienda_envios_chile_commune_modes', array() );
	$fallback_collect = 'yes' === get_option( 'tienda_envios_chile_unconfigured_collect', 'no' );
	$states   = WC()->countries->get_states( 'CL' );
	?>
	<h2><?php esc_html_e( 'Tarifas de envío por comuna', 'tienda-moda' ); ?></h2>
	<p><?php esc_html_e( 'Define el precio y la modalidad de cada comuna. Una tarifa configurada crea su opción de envío aunque la región no tenga una zona propia en WooCommerce. Un campo vacío utiliza los métodos de la zona, si existen.', 'tienda-moda' ); ?></p>
	<p><label><input type="checkbox" name="tienda_envios_chile_unconfigured_collect" value="yes" <?php checked( $fallback_collect ); ?>> <strong><?php esc_html_e( 'Asignar envío por pagar a todas las comunas que no se hayan configurado', 'tienda-envios-chile' ); ?></strong></label><br><span class="description"><?php esc_html_e( 'Una comuna se considera configurada cuando tiene un precio o una modalidad seleccionada distinta de “Solo despacho”.', 'tienda-envios-chile' ); ?></span></p>
	<div class="tienda-moda-commune-toolbar">
		<label for="tienda-moda-region"><strong><?php esc_html_e( 'Región', 'tienda-moda' ); ?></strong></label>
		<select id="tienda-moda-region">
			<?php foreach ( $communes as $state_code => $items ) : ?>
				<option value="<?php echo esc_attr( $state_code ); ?>"><?php echo esc_html( isset( $states[ $state_code ] ) ? $states[ $state_code ] : $state_code ); ?></option>
			<?php endforeach; ?>
		</select>
		<label for="tienda-moda-bulk-rate"><strong><?php esc_html_e( 'Aplicar a toda la región', 'tienda-moda' ); ?></strong></label>
		<input id="tienda-moda-bulk-rate" type="number" min="0" step="1" placeholder="0">
		<select id="tienda-moda-bulk-mode"><option value=""><?php esc_html_e( 'No cambiar modalidad', 'tienda-envios-chile' ); ?></option><option value="delivery"><?php esc_html_e( 'Solo despacho', 'tienda-envios-chile' ); ?></option><option value="delivery_and_pickup"><?php esc_html_e( 'Despacho y retiro', 'tienda-envios-chile' ); ?></option><option value="delivery_and_collect"><?php esc_html_e( 'Despacho y por pagar', 'tienda-envios-chile' ); ?></option><option value="delivery_pickup_collect"><?php esc_html_e( 'Las tres opciones', 'tienda-envios-chile' ); ?></option><option value="pickup_only"><?php esc_html_e( 'Solo retiro', 'tienda-envios-chile' ); ?></option><option value="collect_only"><?php esc_html_e( 'Solo por pagar', 'tienda-envios-chile' ); ?></option><option value="unavailable"><?php esc_html_e( 'Sin cobertura', 'tienda-envios-chile' ); ?></option></select>
		<button type="button" class="button" id="tienda-moda-apply-bulk"><?php esc_html_e( 'Aplicar', 'tienda-moda' ); ?></button>
	</div>
	<?php wp_nonce_field( 'tienda_moda_save_commune_rates', 'tienda_moda_commune_rates_nonce' ); ?>
	<div class="tienda-moda-commune-regions">
		<?php foreach ( $communes as $state_code => $items ) : ?>
			<section class="tienda-moda-commune-region" data-region="<?php echo esc_attr( $state_code ); ?>">
				<h3><?php echo esc_html( isset( $states[ $state_code ] ) ? $states[ $state_code ] : $state_code ); ?></h3>
				<table class="widefat striped"><thead><tr><th><?php esc_html_e( 'Comuna', 'tienda-moda' ); ?></th><th><?php esc_html_e( 'Modalidad', 'tienda-moda' ); ?></th><th><?php esc_html_e( 'Precio de envío', 'tienda-moda' ); ?></th></tr></thead><tbody>
				<?php foreach ( $items as $commune ) : ?>
					<?php $mode = isset( $modes[ $state_code ][ $commune ] ) ? $modes[ $state_code ][ $commune ] : 'delivery'; ?>
					<tr><td><?php echo esc_html( $commune ); ?></td><td><select class="tienda-moda-mode" name="tienda_envios_chile_commune_modes[<?php echo esc_attr( $state_code ); ?>][<?php echo esc_attr( $commune ); ?>]"><option value="delivery" <?php selected( $mode, 'delivery' ); ?>><?php esc_html_e( 'Solo despacho', 'tienda-moda' ); ?></option><option value="delivery_and_pickup" <?php selected( $mode, 'delivery_and_pickup' ); ?>><?php esc_html_e( 'Despacho y retiro', 'tienda-moda' ); ?></option><option value="delivery_and_collect" <?php selected( $mode, 'delivery_and_collect' ); ?>><?php esc_html_e( 'Despacho y por pagar', 'tienda-moda' ); ?></option><option value="delivery_pickup_collect" <?php selected( $mode, 'delivery_pickup_collect' ); ?>><?php esc_html_e( 'Despacho, retiro y por pagar', 'tienda-moda' ); ?></option><option value="pickup_and_collect" <?php selected( $mode, 'pickup_and_collect' ); ?>><?php esc_html_e( 'Retiro y por pagar', 'tienda-moda' ); ?></option><option value="pickup_only" <?php selected( $mode, 'pickup_only' ); ?>><?php esc_html_e( 'Solo retiro', 'tienda-moda' ); ?></option><option value="collect_only" <?php selected( $mode, 'collect_only' ); ?>><?php esc_html_e( 'Solo envío por pagar', 'tienda-moda' ); ?></option><option value="unavailable" <?php selected( $mode, 'unavailable' ); ?>><?php esc_html_e( 'Sin cobertura', 'tienda-envios-chile' ); ?></option></select></td><td><input class="tienda-moda-rate" type="number" min="0" step="1" name="tienda_moda_commune_rates[<?php echo esc_attr( $state_code ); ?>][<?php echo esc_attr( $commune ); ?>]" value="<?php echo esc_attr( isset( $rates[ $state_code ][ $commune ] ) ? $rates[ $state_code ][ $commune ] : '' ); ?>" placeholder="<?php esc_attr_e( 'Usar precio de la zona', 'tienda-moda' ); ?>"></td></tr>
				<?php endforeach; ?>
				</tbody></table>
			</section>
		<?php endforeach; ?>
	</div>
	<style>.tienda-moda-commune-toolbar{display:flex;align-items:center;gap:10px;flex-wrap:wrap;margin:20px 0;padding:16px;background:#fff;border:1px solid #c3c4c7}.tienda-moda-commune-toolbar select{min-width:320px}.tienda-moda-commune-region{display:none;max-width:1000px}.tienda-moda-commune-region.is-active{display:block}.tienda-moda-commune-region table th:nth-child(2),.tienda-moda-commune-region table th:last-child{width:240px}.tienda-moda-rate{width:180px}</style>
	<script>
	(() => { const region = document.querySelector('#tienda-moda-region'); if (!region) return; const show = () => document.querySelectorAll('.tienda-moda-commune-region').forEach((item) => item.classList.toggle('is-active', item.dataset.region === region.value)); region.addEventListener('change', show); document.querySelector('#tienda-moda-apply-bulk').addEventListener('click', () => { const value = document.querySelector('#tienda-moda-bulk-rate').value; const mode = document.querySelector('#tienda-moda-bulk-mode').value; if (value !== '') document.querySelectorAll('.tienda-moda-commune-region.is-active .tienda-moda-rate').forEach((input) => { input.value = value; }); if (mode) document.querySelectorAll('.tienda-moda-commune-region.is-active .tienda-moda-mode').forEach((input) => { input.value = mode; }); }); show(); })();
	</script>
	<?php
}
add_action( 'woocommerce_settings_shipping', 'tienda_envios_chile_commune_rates_settings' );

/** Save rates from the WooCommerce settings form. */
function tienda_envios_chile_save_commune_rates() {
	if ( ! isset( $_GET['section'] ) || 'commune_rates' !== sanitize_key( wp_unslash( $_GET['section'] ) ) ) { // phpcs:ignore WordPress.Security.NonceVerification.Recommended
		return;
	}
	if ( ! isset( $_POST['tienda_moda_commune_rates_nonce'] ) || ! wp_verify_nonce( sanitize_text_field( wp_unslash( $_POST['tienda_moda_commune_rates_nonce'] ) ), 'tienda_moda_save_commune_rates' ) ) {
		return;
	}

	$submitted = isset( $_POST['tienda_moda_commune_rates'] ) && is_array( $_POST['tienda_moda_commune_rates'] ) ? wp_unslash( $_POST['tienda_moda_commune_rates'] ) : array();
	$submitted_modes = isset( $_POST['tienda_envios_chile_commune_modes'] ) && is_array( $_POST['tienda_envios_chile_commune_modes'] ) ? wp_unslash( $_POST['tienda_envios_chile_commune_modes'] ) : array();
	$valid     = tienda_envios_chile_communes();
	$clean     = array();
	$clean_modes = array();
	foreach ( $valid as $state_code => $communes ) {
		foreach ( $communes as $commune ) {
			$value = isset( $submitted[ $state_code ][ $commune ] ) ? wc_format_decimal( $submitted[ $state_code ][ $commune ] ) : '';
			if ( '' !== $value && is_numeric( $value ) && (float) $value >= 0 ) {
				$clean[ $state_code ][ $commune ] = $value;
			}
			$mode = isset( $submitted_modes[ $state_code ][ $commune ] ) ? sanitize_key( $submitted_modes[ $state_code ][ $commune ] ) : 'delivery';
			if ( in_array( $mode, array( 'pickup_only', 'delivery_and_pickup', 'delivery_and_collect', 'delivery_pickup_collect', 'pickup_and_collect', 'collect_only', 'unavailable' ), true ) ) {
				$clean_modes[ $state_code ][ $commune ] = $mode;
			}
		}
	}
	update_option( 'tienda_moda_commune_shipping_rates', $clean, false );
	update_option( 'tienda_envios_chile_commune_modes', $clean_modes, false );
	update_option( 'tienda_envios_chile_unconfigured_collect', isset( $_POST['tienda_envios_chile_unconfigured_collect'] ) ? 'yes' : 'no', false );
}
add_action( 'woocommerce_update_options_shipping', 'tienda_envios_chile_save_commune_rates' );

/** Apply configured delivery, pickup and collect-on-delivery alternatives. */
function tienda_envios_chile_apply_commune_shipping_rate( $shipping_rates, $package ) {
	$state   = isset( $package['destination']['state'] ) ? $package['destination']['state'] : '';
	$commune = isset( $package['destination']['city'] ) ? $package['destination']['city'] : '';
	$country = isset( $package['destination']['country'] ) ? $package['destination']['country'] : '';
	$rates   = get_option( 'tienda_moda_commune_shipping_rates', array() );
	$modes   = get_option( 'tienda_envios_chile_commune_modes', array() );
	$mode    = isset( $modes[ $state ][ $commune ] ) ? $modes[ $state ][ $commune ] : 'delivery';
	$is_configured = isset( $rates[ $state ][ $commune ] ) || isset( $modes[ $state ][ $commune ] );
	if ( ! $is_configured && 'yes' === get_option( 'tienda_envios_chile_unconfigured_collect', 'no' ) ) {
		$mode = 'collect_only';
	}

	if ( 'CL' !== $country ) {
		return $shipping_rates;
	}
	if ( 'unavailable' === $mode ) {
		return array();
	}

	$delivery_modes = array( 'delivery', 'delivery_and_pickup', 'delivery_and_collect', 'delivery_pickup_collect' );
	$pickup_modes   = array( 'pickup_only', 'delivery_and_pickup', 'delivery_pickup_collect', 'pickup_and_collect' );
	$collect_modes  = array( 'collect_only', 'delivery_and_collect', 'delivery_pickup_collect', 'pickup_and_collect' );
	$allows_delivery = in_array( $mode, $delivery_modes, true );
	$allows_pickup   = in_array( $mode, $pickup_modes, true );
	$allows_collect  = in_array( $mode, $collect_modes, true );

	if ( ! $allows_delivery ) {
		$shipping_rates = array();
	} elseif ( isset( $rates[ $state ][ $commune ] ) ) {
		$cost = (float) $rates[ $state ][ $commune ];
		$found_flat_rate = false;
		foreach ( $shipping_rates as $rate ) {
			if ( 'flat_rate' !== $rate->get_method_id() ) {
				continue;
			}
			$found_flat_rate = true;
			$rate->set_cost( $cost );
			$rate->set_taxes( wc_tax_enabled() && $rate->get_taxes() ? WC_Tax::calc_shipping_tax( $cost, WC_Tax::get_shipping_tax_rates() ) : array() );
		}
		if ( ! $found_flat_rate ) {
			$taxes = wc_tax_enabled() ? WC_Tax::calc_shipping_tax( $cost, WC_Tax::get_shipping_tax_rates() ) : array();
			$rate_id = 'tienda_envios_chile_' . sanitize_title( $state . '_' . $commune );
			$shipping_rates[ $rate_id ] = new WC_Shipping_Rate( $rate_id, sprintf( __( 'Envío a %s', 'tienda-envios-chile' ), $commune ), $cost, $taxes, 'tienda_envios_chile' );
		}
	}

	if ( $allows_pickup ) {
		$shipping_rates['tienda_envios_chile_pickup'] = new WC_Shipping_Rate( 'tienda_envios_chile_pickup', __( 'Retiro en local', 'tienda-envios-chile' ), 0, array(), 'local_pickup' );
	}
	if ( $allows_collect ) {
		$shipping_rates['tienda_envios_chile_collect'] = new WC_Shipping_Rate( 'tienda_envios_chile_collect', __( 'Envío por pagar (pagas al recibir)', 'tienda-envios-chile' ), 0, array(), 'tienda_envios_chile_collect' );
	}
	return $shipping_rates;
}
add_filter( 'woocommerce_package_rates', 'tienda_envios_chile_apply_commune_shipping_rate', 20, 2 );
