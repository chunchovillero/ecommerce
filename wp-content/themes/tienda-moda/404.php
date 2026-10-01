<?php

defined( 'ABSPATH' ) || exit;

get_header();

$shop_url = function_exists( 'wc_get_page_permalink' ) ? wc_get_page_permalink( 'shop' ) : home_url( '/' );
?>
<div class="content-container error-page">
	<p class="error-code" aria-hidden="true">404</p>
	<h1><?php esc_html_e( 'No encontramos esta página', 'tienda-moda' ); ?></h1>
	<p><?php esc_html_e( 'Puede que el enlace haya cambiado o que la página ya no exista.', 'tienda-moda' ); ?></p>
	<div class="error-actions">
		<a class="button-primary" href="<?php echo esc_url( $shop_url ); ?>"><?php esc_html_e( 'Ir a la tienda', 'tienda-moda' ); ?></a>
		<a href="<?php echo esc_url( home_url( '/' ) ); ?>"><?php esc_html_e( 'Volver al inicio', 'tienda-moda' ); ?></a>
	</div>
</div>
<?php get_footer(); ?>
