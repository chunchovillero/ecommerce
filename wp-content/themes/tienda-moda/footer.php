<?php
defined( 'ABSPATH' ) || exit;

$footer_locations = array(
	'footer-shop' => __( 'Tienda', 'tienda-moda' ),
	'footer-help' => __( 'Ayuda', 'tienda-moda' ),
	'footer-info' => __( 'Información', 'tienda-moda' ),
);
$social_links = array(
	'instagram' => get_theme_mod( 'tienda_moda_instagram_url', '' ),
	'facebook'  => get_theme_mod( 'tienda_moda_facebook_url', '' ),
	'tiktok'    => get_theme_mod( 'tienda_moda_tiktok_url', '' ),
);
?>
</main>
<footer class="site-footer">
	<div class="footer-inner">
		<div class="footer-brand">
			<a class="footer-title" href="<?php echo esc_url( home_url( '/' ) ); ?>">
				<?php echo esc_html( get_bloginfo( 'name' ) ); ?>
			</a>
			<?php if ( get_bloginfo( 'description' ) ) : ?>
				<p><?php echo esc_html( get_bloginfo( 'description' ) ); ?></p>
			<?php endif; ?>
		</div>

		<?php foreach ( $footer_locations as $location => $title ) : ?>
			<div class="footer-column">
				<h2 class="footer-heading"><?php echo esc_html( $title ); ?></h2>
				<?php
				wp_nav_menu(
					array(
						'theme_location' => $location,
						'container'      => false,
						'fallback_cb'    => false,
						'depth'          => 1,
					)
				);
				?>
			</div>
		<?php endforeach; ?>

		<div class="footer-column footer-contact">
			<h2 class="footer-heading"><?php esc_html_e( 'Contacto', 'tienda-moda' ); ?></h2>
			<?php if ( get_theme_mod( 'tienda_moda_contact_email', '' ) ) : ?>
				<a href="<?php echo esc_url( 'mailto:' . sanitize_email( get_theme_mod( 'tienda_moda_contact_email' ) ) ); ?>"><?php echo esc_html( get_theme_mod( 'tienda_moda_contact_email' ) ); ?></a>
			<?php endif; ?>
			<?php if ( get_theme_mod( 'tienda_moda_contact_phone', '' ) ) : ?>
				<a href="<?php echo esc_url( 'tel:' . preg_replace( '/[^0-9+]/', '', get_theme_mod( 'tienda_moda_contact_phone' ) ) ); ?>"><?php echo esc_html( get_theme_mod( 'tienda_moda_contact_phone' ) ); ?></a>
			<?php endif; ?>
			<?php if ( array_filter( $social_links ) ) : ?>
				<nav class="social-links" aria-label="<?php esc_attr_e( 'Redes sociales', 'tienda-moda' ); ?>">
					<?php foreach ( $social_links as $network => $url ) : ?>
						<?php if ( $url ) : ?>
							<a href="<?php echo esc_url( $url ); ?>" target="_blank" rel="noopener noreferrer">
								<?php echo esc_html( ucfirst( $network ) ); ?>
								<span class="screen-reader-text"><?php esc_html_e( '(abre en una pestaña nueva)', 'tienda-moda' ); ?></span>
							</a>
						<?php endif; ?>
					<?php endforeach; ?>
				</nav>
			<?php endif; ?>
		</div>
	</div>

	<div class="footer-bottom">
		<p>&copy; <?php echo esc_html( wp_date( 'Y' ) ); ?> <?php echo esc_html( get_bloginfo( 'name' ) ); ?></p>
		<?php if ( has_nav_menu( 'legal' ) ) : ?>
			<nav aria-label="<?php esc_attr_e( 'Navegación legal', 'tienda-moda' ); ?>">
				<?php wp_nav_menu( array( 'theme_location' => 'legal', 'container' => false, 'depth' => 1 ) ); ?>
			</nav>
		<?php endif; ?>
	</div>
</footer>
<?php wp_footer(); ?>
</body>
</html>
