<?php
defined( 'ABSPATH' ) || exit;

$account_url = function_exists( 'wc_get_page_permalink' ) ? wc_get_page_permalink( 'myaccount' ) : wp_login_url();
$cart_url    = function_exists( 'wc_get_cart_url' ) ? wc_get_cart_url() : home_url( '/' );
$shop_url    = function_exists( 'wc_get_page_permalink' ) ? wc_get_page_permalink( 'shop' ) : home_url( '/' );
$notice      = get_theme_mod( 'tienda_moda_announcement', '' );
?><!doctype html>
<html <?php language_attributes(); ?>>
<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>
<a class="skip-link" href="#site-content"><?php esc_html_e( 'Saltar al contenido', 'tienda-moda' ); ?></a>

<?php if ( $notice ) : ?>
	<div class="announcement-bar" role="region" aria-label="<?php esc_attr_e( 'Aviso de la tienda', 'tienda-moda' ); ?>">
		<p><?php echo esc_html( $notice ); ?></p>
	</div>
<?php endif; ?>

<header class="site-header">
	<div class="header-inner">
		<button class="header-action menu-toggle" type="button" aria-controls="mobile-navigation" aria-expanded="false">
			<?php echo tienda_moda_icon( 'menu' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			<span class="screen-reader-text"><?php esc_html_e( 'Abrir menú', 'tienda-moda' ); ?></span>
		</button>

		<div class="site-branding">
			<?php if ( has_custom_logo() ) : ?>
				<?php the_custom_logo(); ?>
			<?php else : ?>
				<a class="site-title" href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home">
					<?php echo esc_html( get_bloginfo( 'name' ) ); ?>
				</a>
			<?php endif; ?>
		</div>

		<nav class="primary-navigation" aria-label="<?php esc_attr_e( 'Navegación principal', 'tienda-moda' ); ?>">
			<?php
			wp_nav_menu(
				array(
					'theme_location' => 'primary',
					'container'      => false,
					'fallback_cb'    => 'tienda_moda_primary_menu_fallback',
					'depth'          => 2,
				)
			);
			?>
		</nav>

		<div class="header-actions">
			<a class="header-action header-search" href="<?php echo esc_url( add_query_arg( array( 's' => '', 'post_type' => 'product' ), home_url( '/' ) ) ); ?>">
				<?php echo tienda_moda_icon( 'search' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span class="action-label"><?php esc_html_e( 'Buscar', 'tienda-moda' ); ?></span>
			</a>
			<a class="header-action header-account" href="<?php echo esc_url( $account_url ); ?>">
				<?php echo tienda_moda_icon( 'user' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span class="action-label"><?php esc_html_e( 'Mi cuenta', 'tienda-moda' ); ?></span>
			</a>
			<a class="header-action header-cart" href="<?php echo esc_url( $cart_url ); ?>">
				<?php echo tienda_moda_icon( 'bag' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span class="action-label"><?php esc_html_e( 'Carrito', 'tienda-moda' ); ?></span>
				<span class="cart-count" aria-label="<?php echo esc_attr( sprintf( _n( '%d producto', '%d productos', tienda_moda_cart_count(), 'tienda-moda' ), tienda_moda_cart_count() ) ); ?>"><?php echo esc_html( tienda_moda_cart_count() ); ?></span>
			</a>
		</div>
	</div>
</header>

<div class="drawer-overlay" data-drawer-close hidden></div>
<aside id="mobile-navigation" class="mobile-drawer" aria-hidden="true" aria-label="<?php esc_attr_e( 'Menú móvil', 'tienda-moda' ); ?>">
	<div class="drawer-header">
		<span class="drawer-title"><?php esc_html_e( 'Menú', 'tienda-moda' ); ?></span>
		<button class="header-action drawer-close" type="button" data-drawer-close>
			<?php echo tienda_moda_icon( 'close' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			<span class="screen-reader-text"><?php esc_html_e( 'Cerrar menú', 'tienda-moda' ); ?></span>
		</button>
	</div>
	<nav class="mobile-navigation" aria-label="<?php esc_attr_e( 'Navegación móvil', 'tienda-moda' ); ?>">
		<?php
		wp_nav_menu(
			array(
				'theme_location' => 'primary',
				'container'      => false,
				'fallback_cb'    => 'tienda_moda_primary_menu_fallback',
				'depth'          => 2,
			)
		);
		?>
	</nav>
	<a class="drawer-shop-link" href="<?php echo esc_url( $shop_url ); ?>"><?php esc_html_e( 'Ver toda la tienda', 'tienda-moda' ); ?></a>
</aside>

<main id="site-content" class="site-content">
