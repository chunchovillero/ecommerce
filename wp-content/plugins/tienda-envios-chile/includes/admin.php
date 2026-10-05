<?php
defined( 'ABSPATH' ) || exit;

function tienda_envios_chile_admin_menu() {
	add_submenu_page( 'woocommerce', 'Sucursales de retiro', 'Sucursales de retiro', 'manage_woocommerce', 'tienda-envios-sucursales', 'tienda_envios_chile_locations_page' );
	add_submenu_page( 'woocommerce', 'Reporte de envíos', 'Reporte de envíos', 'manage_woocommerce', 'tienda-envios-reportes', 'tienda_envios_chile_reports_page' );
}
add_action( 'admin_menu', 'tienda_envios_chile_admin_menu' );

function tienda_envios_chile_locations_page() {
	$locations = tienda_envios_chile_parse_locations(); ?>
	<div class="wrap"><h1>Sucursales de retiro</h1><p>Agrega o elimina los puntos que el cliente puede seleccionar en el checkout.</p><form method="post" action="<?php echo esc_url( admin_url( 'admin-post.php' ) ); ?>"><input type="hidden" name="action" value="tienda_envios_chile_save_locations"><?php wp_nonce_field( 'tienda_envios_chile_locations' ); ?><table class="widefat striped" id="tec-locations"><thead><tr><th>Nombre</th><th>Dirección</th><th>Horario</th><th>Instrucciones</th><th></th></tr></thead><tbody>
	<?php foreach ( $locations as $location ) : ?><tr><?php foreach ( array( 'name', 'address', 'hours', 'instructions' ) as $key ) : ?><td><input name="locations[<?php echo esc_attr( $key ); ?>][]" value="<?php echo esc_attr( $location[ $key ] ); ?>"></td><?php endforeach; ?><td><button type="button" class="button tec-remove">Eliminar</button></td></tr><?php endforeach; ?>
	</tbody></table><p><button type="button" class="button" id="tec-add-location">Agregar sucursal</button> <?php submit_button( 'Guardar sucursales', 'primary', 'submit', false ); ?></p></form></div><script>(()=>{const b=document.querySelector('#tec-locations tbody');document.querySelector('#tec-add-location').onclick=()=>{const r=document.createElement('tr');r.innerHTML='<td><input name="locations[name][]"></td><td><input name="locations[address][]"></td><td><input name="locations[hours][]"></td><td><input name="locations[instructions][]"></td><td><button type="button" class="button tec-remove">Eliminar</button></td>';b.append(r)};b.addEventListener('click',e=>{if(e.target.classList.contains('tec-remove'))e.target.closest('tr').remove()})})();</script><?php
}

function tienda_envios_chile_save_locations_page() {
	if ( ! current_user_can( 'manage_woocommerce' ) || ! check_admin_referer( 'tienda_envios_chile_locations' ) ) wp_die( 'Acceso denegado.' );
	$data = isset( $_POST['locations'] ) && is_array( $_POST['locations'] ) ? wp_unslash( $_POST['locations'] ) : array(); $lines = array();
	foreach ( (array) ( $data['name'] ?? array() ) as $i => $name ) { $parts = array( sanitize_text_field( $name ), sanitize_text_field( $data['address'][ $i ] ?? '' ), sanitize_text_field( $data['hours'][ $i ] ?? '' ), sanitize_text_field( $data['instructions'][ $i ] ?? '' ) ); if ( $parts[0] ) $lines[] = implode( ' | ', $parts ); }
	update_option( 'tienda_envios_chile_pickup_locations', implode( "\n", $lines ), false ); wp_safe_redirect( admin_url( 'admin.php?page=tienda-envios-sucursales&updated=1' ) ); exit;
}
add_action( 'admin_post_tienda_envios_chile_save_locations', 'tienda_envios_chile_save_locations_page' );

function tienda_envios_chile_reports_page() {
	$orders = wc_get_orders( array( 'limit' => 500, 'status' => array_keys( wc_get_order_statuses() ), 'orderby' => 'date', 'order' => 'DESC' ) ); $rows = array();
	foreach ( $orders as $order ) { $city = $order->get_shipping_city() ?: $order->get_billing_city(); $names = array(); foreach ( $order->get_shipping_methods() as $item ) $names[] = $item->get_name(); $method = implode( ', ', $names ); $key = $city . '|' . $method; if ( ! isset( $rows[ $key ] ) ) $rows[ $key ] = array( $city ?: '—', $method ?: '—', 0, 0 ); $rows[ $key ][2]++; $rows[ $key ][3] += (float) $order->get_shipping_total(); }
	usort( $rows, function( $a, $b ) { return $b[2] <=> $a[2]; } ); ?>
	<div class="wrap"><h1>Reporte de envíos</h1><p>Resumen de hasta 500 pedidos recientes.</p><table class="widefat striped"><thead><tr><th>Comuna</th><th>Modalidad</th><th>Pedidos</th><th>Total cobrado</th></tr></thead><tbody><?php foreach ( $rows as $row ) : ?><tr><td><?php echo esc_html( $row[0] ); ?></td><td><?php echo esc_html( $row[1] ); ?></td><td><?php echo esc_html( $row[2] ); ?></td><td><?php echo wp_kses_post( wc_price( $row[3] ) ); ?></td></tr><?php endforeach; ?></tbody></table></div><?php
}
