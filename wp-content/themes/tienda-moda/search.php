<?php

defined( 'ABSPATH' ) || exit;

get_header();
?>
<div class="content-container content-listing">
	<header class="listing-header">
		<h1><?php echo esc_html( sprintf( __( 'Resultados para “%s”', 'tienda-moda' ), get_search_query() ) ); ?></h1>
	</header>
	<?php if ( have_posts() ) : ?>
		<div class="entry-list">
			<?php while ( have_posts() ) : ?>
				<?php the_post(); ?>
				<?php get_template_part( 'template-parts/content', 'summary' ); ?>
			<?php endwhile; ?>
		</div>
		<?php the_posts_pagination( array( 'prev_text' => __( 'Anterior', 'tienda-moda' ), 'next_text' => __( 'Siguiente', 'tienda-moda' ) ) ); ?>
	<?php else : ?>
		<div class="empty-state">
			<p><?php esc_html_e( 'No encontramos resultados. Prueba con otros términos.', 'tienda-moda' ); ?></p>
			<?php get_search_form(); ?>
		</div>
	<?php endif; ?>
</div>
<?php get_footer(); ?>
