<?php

defined( 'ABSPATH' ) || exit;
?>
<article <?php post_class( 'entry-card' ); ?> id="post-<?php the_ID(); ?>">
	<?php if ( has_post_thumbnail() ) : ?>
		<a class="entry-card-image" href="<?php the_permalink(); ?>" tabindex="-1" aria-hidden="true"><?php the_post_thumbnail( 'medium_large', array( 'loading' => 'lazy' ) ); ?></a>
	<?php endif; ?>
	<div class="entry-card-content">
		<h2><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
		<p class="entry-meta"><time datetime="<?php echo esc_attr( get_the_date( DATE_W3C ) ); ?>"><?php echo esc_html( get_the_date() ); ?></time></p>
		<div class="entry-summary"><?php the_excerpt(); ?></div>
		<a class="entry-more" href="<?php the_permalink(); ?>"><?php esc_html_e( 'Leer más', 'tienda-moda' ); ?><span class="screen-reader-text">: <?php the_title(); ?></span></a>
	</div>
</article>
