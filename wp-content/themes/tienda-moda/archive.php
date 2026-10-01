<?php

defined( 'ABSPATH' ) || exit;

get_header();
?>
<div class="content-container content-listing">
	<header class="listing-header">
		<h1><?php the_archive_title(); ?></h1>
		<?php the_archive_description( '<div class="archive-description">', '</div>' ); ?>
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
		<p class="empty-state"><?php esc_html_e( 'No encontramos contenido en esta sección.', 'tienda-moda' ); ?></p>
	<?php endif; ?>
</div>
<?php get_footer(); ?>
