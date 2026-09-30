<?php
defined( 'ABSPATH' ) || exit;

get_header();

$shop_url       = function_exists( 'wc_get_page_permalink' ) ? wc_get_page_permalink( 'shop' ) : home_url( '/' );
$hero_image_id  = absint( get_theme_mod( 'tienda_moda_hero_image', 0 ) );
$hero_title     = get_theme_mod( 'tienda_moda_hero_title', '' );
$hero_subtitle  = get_theme_mod( 'tienda_moda_hero_subtitle', '' );
$hero_button    = get_theme_mod( 'tienda_moda_hero_button', __( 'Ver colección', 'tienda-moda' ) );
$hero_url       = get_theme_mod( 'tienda_moda_hero_url', '' ) ?: $shop_url;
?>
<section class="home-hero<?php echo $hero_image_id ? ' has-image' : ''; ?>">
	<?php if ( $hero_image_id ) : ?>
		<div class="hero-media" aria-hidden="true"><?php echo wp_get_attachment_image( $hero_image_id, 'full', false, array( 'class' => 'hero-image', 'loading' => 'eager', 'fetchpriority' => 'high', 'sizes' => '100vw' ) ); ?></div>
	<?php endif; ?>
	<div class="hero-content">
		<h1><?php echo esc_html( $hero_title ?: get_bloginfo( 'name' ) ); ?></h1>
		<?php if ( $hero_subtitle ?: get_bloginfo( 'description' ) ) : ?>
			<p><?php echo esc_html( $hero_subtitle ?: get_bloginfo( 'description' ) ); ?></p>
		<?php endif; ?>
		<?php if ( $hero_button ) : ?>
			<a class="button-primary" href="<?php echo esc_url( $hero_url ); ?>"><?php echo esc_html( $hero_button ); ?></a>
		<?php endif; ?>
	</div>
</section>

<?php if ( taxonomy_exists( 'product_cat' ) ) : ?>
	<?php $categories = get_terms( array( 'taxonomy' => 'product_cat', 'hide_empty' => true, 'number' => 6, 'orderby' => 'menu_order' ) ); ?>
	<?php if ( ! is_wp_error( $categories ) && $categories ) : ?>
		<section class="home-section category-section">
			<div class="section-heading"><h2><?php esc_html_e( 'Categorías', 'tienda-moda' ); ?></h2></div>
			<div class="category-grid">
				<?php foreach ( $categories as $category ) : ?>
					<?php $thumbnail_id = absint( get_term_meta( $category->term_id, 'thumbnail_id', true ) ); ?>
					<a class="category-card" href="<?php echo esc_url( get_term_link( $category ) ); ?>">
						<?php if ( $thumbnail_id ) : ?>
							<?php echo wp_get_attachment_image( $thumbnail_id, 'large', false, array( 'loading' => 'lazy' ) ); ?>
						<?php else : ?>
							<span class="category-placeholder" aria-hidden="true"></span>
						<?php endif; ?>
						<span><?php echo esc_html( $category->name ); ?></span>
					</a>
				<?php endforeach; ?>
			</div>
		</section>
	<?php endif; ?>
<?php endif; ?>

<?php tienda_moda_render_product_section( __( 'Nueva colección', 'tienda-moda' ), 'new', $shop_url ); ?>

<?php
$promo_title = get_theme_mod( 'tienda_moda_promo_title', '' );
$promo_text  = get_theme_mod( 'tienda_moda_promo_text', '' );
$promo_image = absint( get_theme_mod( 'tienda_moda_promo_image', 0 ) );
?>
<?php if ( $promo_title || $promo_text || $promo_image ) : ?>
	<section class="home-promo<?php echo $promo_image ? ' has-image' : ''; ?>">
		<?php if ( $promo_image ) : ?>
			<div class="promo-media" aria-hidden="true"><?php echo wp_get_attachment_image( $promo_image, 'full', false, array( 'class' => 'promo-image', 'loading' => 'lazy', 'sizes' => '100vw' ) ); ?></div>
		<?php endif; ?>
		<div class="promo-content">
			<?php if ( $promo_title ) : ?><h2><?php echo esc_html( $promo_title ); ?></h2><?php endif; ?>
			<?php if ( $promo_text ) : ?><p><?php echo esc_html( $promo_text ); ?></p><?php endif; ?>
			<?php if ( get_theme_mod( 'tienda_moda_promo_button', __( 'Comprar ahora', 'tienda-moda' ) ) ) : ?>
				<a class="button-primary light" href="<?php echo esc_url( get_theme_mod( 'tienda_moda_promo_url', '' ) ?: $shop_url ); ?>"><?php echo esc_html( get_theme_mod( 'tienda_moda_promo_button', __( 'Comprar ahora', 'tienda-moda' ) ) ); ?></a>
			<?php endif; ?>
		</div>
	</section>
<?php endif; ?>

<?php tienda_moda_render_product_section( __( 'Más vendidos', 'tienda-moda' ), 'popular', $shop_url ); ?>
<?php tienda_moda_render_product_section( __( 'Ofertas', 'tienda-moda' ), 'sale', $shop_url ); ?>

<section class="benefits-section" aria-label="<?php esc_attr_e( 'Beneficios de la tienda', 'tienda-moda' ); ?>">
	<?php
	$benefits = array(
		array( 'truck', get_theme_mod( 'tienda_moda_benefit_1', __( 'Envíos a todo Chile', 'tienda-moda' ) ) ),
		array( 'shield', get_theme_mod( 'tienda_moda_benefit_2', __( 'Pago seguro', 'tienda-moda' ) ) ),
		array( 'refresh', get_theme_mod( 'tienda_moda_benefit_3', __( 'Cambios y devoluciones', 'tienda-moda' ) ) ),
		array( 'chat', get_theme_mod( 'tienda_moda_benefit_4', __( 'Atención personalizada', 'tienda-moda' ) ) ),
	);
	foreach ( $benefits as $benefit ) :
		?>
		<div class="benefit"><?php echo tienda_moda_icon( $benefit[0] ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?><h2><?php echo esc_html( $benefit[1] ); ?></h2></div>
	<?php endforeach; ?>
</section>

<?php
$social_images = array_filter(
	array_map(
		'absint',
		array(
			get_theme_mod( 'tienda_moda_social_image_1', 0 ),
			get_theme_mod( 'tienda_moda_social_image_2', 0 ),
			get_theme_mod( 'tienda_moda_social_image_3', 0 ),
			get_theme_mod( 'tienda_moda_social_image_4', 0 ),
			get_theme_mod( 'tienda_moda_social_image_5', 0 ),
			get_theme_mod( 'tienda_moda_social_image_6', 0 ),
		)
	)
);
?>
<?php if ( $social_images ) : ?>
	<section class="social-section">
		<div class="section-heading"><h2><?php esc_html_e( 'Síguenos', 'tienda-moda' ); ?></h2></div>
		<div class="social-grid">
			<?php foreach ( $social_images as $image_id ) : ?>
				<?php echo wp_get_attachment_image( $image_id, 'large', false, array( 'loading' => 'lazy' ) ); ?>
			<?php endforeach; ?>
		</div>
	</section>
<?php endif; ?>

<?php get_footer(); ?>
