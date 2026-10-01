<?php

defined( 'ABSPATH' ) || exit;

get_header();
?>
<div class="content-container single-entry-container">
	<?php while ( have_posts() ) : ?>
		<?php the_post(); ?>
		<article <?php post_class( 'single-entry' ); ?> id="post-<?php the_ID(); ?>">
			<header class="single-entry-header">
				<h1><?php the_title(); ?></h1>
				<p class="entry-meta"><time datetime="<?php echo esc_attr( get_the_date( DATE_W3C ) ); ?>"><?php echo esc_html( get_the_date() ); ?></time></p>
			</header>
			<?php if ( has_post_thumbnail() ) : ?>
				<div class="single-entry-image"><?php the_post_thumbnail( 'large' ); ?></div>
			<?php endif; ?>
			<div class="entry-content"><?php the_content(); ?></div>
		</article>
	<?php endwhile; ?>
</div>
<?php get_footer(); ?>
