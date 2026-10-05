<?php
/** Complete the local WooCommerce menswear demo safely and idempotently. */
defined( 'ABSPATH' ) || exit;

require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$names = array(
	19=>'Zapatilla Urbana Blanca',23=>'Zapato Derby Negro',24=>'Botín Chelsea Café',28=>'Mocasín de Cuero Negro',29=>'Zapatilla Retro Gris',30=>'Sandalia de Cuero Café',31=>'Zapato Oxford Cognac',32=>'Botín Casual Arena',
	33=>'Polera Piqué Azul Marino',37=>'Camisa de Lino Arena',38=>'Polera Esencial Blanca',39=>'Polera Rib Negra',40=>'Polo Tejido Azul',41=>'Camisa Oxford Blanca',42=>'Camisa Bordada Cruda',43=>'Polera Manga Larga Grafito',
	44=>'Jeans Rectos Índigo',48=>'Pantalón Sastrero Carbón',52=>'Pantalón Cargo Verde Oliva',53=>'Jeans Relaxed Azul',54=>'Pantalón de Lino Beige',55=>'Jogger Comfort Negro',
	56=>'Sobrecamisa Azul Marino',60=>'Camisa Popelina Celeste',61=>'Camisa Denim Azul',62=>'Camisa Satén Negra',
	63=>'Chaqueta Denim Índigo',64=>'Blazer Sastrero Carbón',68=>'Abrigo de Lana Camel',69=>'Trench Impermeable Arena',
	70=>'Cardigan Merino Gris',71=>'Sweater Cuello Alto Crudo',75=>'Chaleco Trenzado Arena',76=>'Sweater Liviano Celeste',
	77=>'Billetera de Cuero Café',78=>'Cinturón de Cuero Negro',79=>'Pañuelo Estampado Azul',80=>'Pulsera de Acero',81=>'Bolso Tote de Lona',82=>'Gorro Tejido Grafito',
);

$category_images = array( 16=>91, 17=>90, 18=>88, 19=>87, 20=>85, 21=>89, 22=>86 );
$custom_images   = array( 41=>96, 44=>94, 48=>95, 63=>92, 64=>93, 78=>97 );

foreach ( $names as $id => $name ) {
	$product = wc_get_product( $id );
	if ( ! $product ) { WP_CLI::warning( "Producto {$id} no encontrado" ); continue; }
	$cat_ids = $product->get_category_ids();
	$cat_id  = $cat_ids ? (int) $cat_ids[0] : 0;
	$is_shoe = 16 === $cat_id;
	$is_accessory = 22 === $cat_id;

	$product->set_name( $name );
	$product->set_slug( sanitize_title( $name ) );
	$product->set_short_description( 'Diseño masculino contemporáneo, versátil y fácil de combinar durante toda la temporada.' );
	$product->set_description(
		'<h2>Detalles del producto</h2><p><strong>' . esc_html( $name ) . '</strong> combina líneas limpias, comodidad y una estética atemporal para el uso diario.</p>' .
		'<ul><li>Calce cómodo y contemporáneo.</li><li>Terminaciones reforzadas.</li><li>Diseñado para combinar con prendas esenciales.</li></ul>' .
		'<h2>Material y cuidado</h2><p>Revisa la etiqueta interior antes del lavado. Lavar con colores similares, usar ciclo suave y evitar blanqueadores. Secar a la sombra.</p>' .
		'<h2>Guía de medidas</h2><p>Selecciona tu talla habitual. Si estás entre dos tallas, prefiere la mayor para un calce más relajado.</p>'
	);

	if ( isset( $custom_images[ $id ] ) ) {
		$product->set_image_id( $custom_images[ $id ] );
	} elseif ( isset( $category_images[ $cat_id ] ) ) {
		$product->set_image_id( $category_images[ $cat_id ] );
	}
	if ( isset( $category_images[ $cat_id ] ) && $product->get_image_id() !== $category_images[ $cat_id ] ) {
		$product->set_gallery_image_ids( array( $category_images[ $cat_id ] ) );
	}

	if ( $product->is_type( 'simple' ) ) {
		$attribute = new WC_Product_Attribute();
		$attribute->set_id( 0 );
		$attribute->set_name( $is_accessory ? 'Formato' : 'Talla' );
		$attribute->set_options( $is_accessory ? array( 'Talla única' ) : ( $is_shoe ? array( '40','41','42','43','44' ) : array( 'S','M','L','XL' ) ) );
		$attribute->set_position( 0 );
		$attribute->set_visible( true );
		$attribute->set_variation( false );
		$product->set_attributes( array( $attribute ) );
	}
	$product->save();
}

/* Correct category ownership for shirts that came from the former catalog. */
foreach ( array( 37, 41, 42 ) as $shirt_id ) {
	wp_set_object_terms( $shirt_id, array( 19 ), 'product_cat', false );
}

/* Shoe variations use Chilean numeric sizes instead of inherited apparel sizes. */
foreach ( array( 19, 24 ) as $shoe_id ) {
	$shoe = wc_get_product( $shoe_id );
	if ( ! $shoe || ! $shoe->is_type( 'variable' ) ) continue;
	$size_attribute = new WC_Product_Attribute();
	$size_attribute->set_id( 0 );
	$size_attribute->set_name( 'Talla' );
	$size_attribute->set_options( array( '40', '42', '44' ) );
	$size_attribute->set_position( 0 );
	$size_attribute->set_visible( true );
	$size_attribute->set_variation( true );
	$shoe->set_attributes( array( $size_attribute ) );
	$shoe->save();
	foreach ( array_values( $shoe->get_children() ) as $index=>$variation_id ) {
		$variation = wc_get_product( $variation_id );
		if ( $variation ) { $variation->set_attributes( array( 'talla'=>array( '40','42','44' )[ $index ] ?? '44' ) ); $variation->save(); }
	}
}

/* Import and configure the hero without removing the project source file. */
$hero_source = get_theme_root() . '/tienda-moda/assets/images/hero/menswear-hero-v2.png';
$hero_ids = get_posts( array( 'post_type'=>'attachment', 'post_status'=>'inherit', 'posts_per_page'=>1, 'fields'=>'ids', 'meta_key'=>'_tienda_moda_seed_asset', 'meta_value'=>'menswear-hero-v2' ) );
if ( $hero_ids ) {
	$hero_id = (int) $hero_ids[0];
} else {
	$temp = wp_tempnam( 'menswear-hero-v2.png' );
	copy( $hero_source, $temp );
	$hero_id = media_handle_sideload( array( 'name'=>'menswear-hero-v2.png', 'tmp_name'=>$temp ), 0, 'Colección masculina contemporánea' );
	if ( ! is_wp_error( $hero_id ) ) update_post_meta( $hero_id, '_tienda_moda_seed_asset', 'menswear-hero-v2' );
}
if ( ! is_wp_error( $hero_id ) ) {
	update_post_meta( $hero_id, '_wp_attachment_image_alt', 'Hombre con sobrecamisa azul marino y pantalón sastrero' );
	set_theme_mod( 'tienda_moda_hero_image', $hero_id );
}
set_theme_mod( 'tienda_moda_hero_title', 'Estilo que permanece' );
set_theme_mod( 'tienda_moda_hero_subtitle', 'Esenciales masculinos de líneas limpias, pensados para vestir bien todos los días.' );
set_theme_mod( 'tienda_moda_hero_button', 'Ver colección' );
set_theme_mod( 'tienda_moda_promo_title', 'Sastrería contemporánea' );
set_theme_mod( 'tienda_moda_promo_text', 'Prendas versátiles, materiales honestos y una paleta diseñada para combinar.' );

/* Store, locale and checkout defaults. */
update_option( 'blogname', 'Ecommerce Hombre' );
update_option( 'blogdescription', 'Moda masculina contemporánea en Chile' );
update_option( 'woocommerce_currency', 'CLP' );
update_option( 'woocommerce_default_country', 'CL:RM' );
update_option( 'woocommerce_allowed_countries', 'specific' );
update_option( 'woocommerce_specific_allowed_countries', array( 'CL' ) );
update_option( 'woocommerce_calc_taxes', 'yes' );
update_option( 'woocommerce_enable_guest_checkout', 'yes' );
update_option( 'woocommerce_enable_signup_and_login_from_checkout', 'yes' );
update_option( 'woocommerce_email_from_name', 'Ecommerce Hombre' );
update_option( 'woocommerce_email_from_address', get_option( 'admin_email' ) );

$core_pages = array( 7=>'Tienda', 8=>'Carrito', 9=>'Finalizar compra', 10=>'Mi cuenta' );
foreach ( $core_pages as $page_id=>$title ) wp_update_post( array( 'ID'=>$page_id, 'post_title'=>$title, 'post_name'=>sanitize_title( $title ) ) );

$legal_pages = array(
	'cambios-y-devoluciones' => array( 'Cambios y devoluciones', '<h2>Plazos</h2><p>Puedes solicitar cambios dentro de 30 días desde la recepción, presentando el comprobante de compra y el producto sin uso, con sus etiquetas y embalaje.</p><h2>Productos con falla</h2><p>La garantía legal se aplica conforme a la normativa chilena vigente. Contáctanos indicando tu número de pedido y adjuntando fotografías.</p><h2>Proceso</h2><p>Antes de enviar un producto, solicita instrucciones mediante el canal de atención publicado en el sitio.</p>' ),
	'envios-y-retiros' => array( 'Envíos y retiros', '<h2>Despacho</h2><p>El costo y las modalidades disponibles se calculan en el checkout según región y comuna. Algunas comunas permiten despacho pagado, envío por pagar, retiro o una combinación de estas opciones.</p><h2>Plazos</h2><p>Los plazos informados comienzan una vez confirmado el pago. Recibirás actualizaciones por correo electrónico.</p><h2>Retiro</h2><p>Espera la confirmación “Listo para retirar” antes de dirigirte al punto de entrega. Presenta tu número de pedido y documento de identificación.</p>' ),
	'terminos-y-condiciones' => array( 'Términos y condiciones', '<p>Al comprar declaras que la información proporcionada es correcta y aceptas los precios, modalidades de entrega y condiciones mostradas antes de confirmar el pedido.</p><h2>Precios y disponibilidad</h2><p>Los precios se expresan en pesos chilenos. El pedido queda sujeto a confirmación de pago y disponibilidad de inventario.</p><h2>Contacto</h2><p>Las solicitudes relacionadas con un pedido deben incluir su número identificador.</p>' ),
	'politica-de-privacidad' => array( 'Política de privacidad', '<p>Utilizamos los datos entregados para procesar pedidos, coordinar pagos y entregas, responder solicitudes y mejorar el funcionamiento de la tienda.</p><h2>Datos tratados</h2><p>Podemos tratar identificación, contacto, dirección, historial de pedidos e información técnica necesaria para seguridad.</p><h2>Derechos</h2><p>Puedes solicitar acceso, rectificación o eliminación de tus datos mediante el canal de contacto publicado en el sitio, sujeto a obligaciones legales de conservación.</p>' ),
);
foreach ( $legal_pages as $slug=>$page ) {
	$existing = get_page_by_path( $slug );
	$data = array( 'post_title'=>$page[0], 'post_name'=>$slug, 'post_content'=>$page[1], 'post_status'=>'publish', 'post_type'=>'page' );
	if ( $existing ) { $data['ID']=$existing->ID; wp_update_post( $data ); $page_id=$existing->ID; }
	else { $page_id=wp_insert_post( $data ); }
	if ( 'politica-de-privacidad' === $slug ) update_option( 'wp_page_for_privacy_policy', $page_id );
}

/* Publish a legal footer menu so the policies are always discoverable. */
$legal_menu = wp_get_nav_menu_object( 'Información legal' );
$legal_menu_id = $legal_menu ? (int) $legal_menu->term_id : (int) wp_create_nav_menu( 'Información legal' );
$menu_items = wp_get_nav_menu_items( $legal_menu_id );
$menu_objects = $menu_items ? wp_list_pluck( $menu_items, 'object_id' ) : array();
foreach ( array_keys( $legal_pages ) as $slug ) {
	$page = get_page_by_path( $slug );
	if ( $page && ! in_array( $page->ID, $menu_objects, true ) ) {
		wp_update_nav_menu_item( $legal_menu_id, 0, array( 'menu-item-object-id'=>$page->ID, 'menu-item-object'=>'page', 'menu-item-type'=>'post_type', 'menu-item-status'=>'publish' ) );
	}
}
$locations = get_theme_mod( 'nav_menu_locations', array() );
$locations['legal'] = $legal_menu_id;
set_theme_mod( 'nav_menu_locations', $locations );

/* Enable offline gateways for a working local checkout; no external credentials invented. */
$bacs = get_option( 'woocommerce_bacs_settings', array() );
$bacs['enabled']='yes'; $bacs['title']='Transferencia bancaria'; $bacs['description']='Recibirás los datos e instrucciones para transferir al confirmar el pedido.';
update_option( 'woocommerce_bacs_settings', $bacs );
$cod = get_option( 'woocommerce_cod_settings', array() );
$cod['enabled']='yes'; $cod['title']='Pago al recibir o retirar'; $cod['description']='Disponible cuando la modalidad de entrega seleccionada lo permita.';
update_option( 'woocommerce_cod_settings', $cod );
update_option( 'tienda_envios_chile_unconfigured_collect', 'yes' );
update_option( 'tienda_envios_chile_default_eta', '2 a 5 días hábiles' );
update_option( 'tienda_envios_chile_collect_notice', 'El transporte se paga directamente al transportista al momento de recibir el pedido.' );

delete_transient( 'tienda_moda_home_products_new_8' );
delete_transient( 'tienda_moda_home_products_popular_8' );
wc_delete_product_transients();
flush_rewrite_rules();
WP_CLI::success( 'Catálogo, portada, páginas y checkout completados.' );
