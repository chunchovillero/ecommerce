<?php
defined( 'ABSPATH' ) || exit;

get_header();
?>
<div class="page-container">
	<?php while ( have_posts() ) : ?>
		<?php the_post(); ?>
		<article <?php post_class( 'page-entry' ); ?> id="post-<?php the_ID(); ?>">
			<header class="page-header">
				<h1><?php echo esc_html( get_the_title() ); ?></h1>
			</header>
			<div class="page-content"><?php the_content(); ?></div>
		</article>
	<?php endwhile; ?>
</div>
<?php
get_footer();

