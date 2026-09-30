<?php
defined( 'ABSPATH' ) || exit;

get_header();
?>
<div class="content-container">
	<?php if ( have_posts() ) : ?>
		<?php while ( have_posts() ) : ?>
			<?php
			the_post();
			?>
			<article <?php post_class( 'entry' ); ?> id="post-<?php the_ID(); ?>">
				<h1 class="entry-title">
					<a href="<?php echo esc_url( get_permalink() ); ?>">
						<?php echo esc_html( get_the_title() ); ?>
					</a>
				</h1>
				<div class="entry-content"><?php the_content(); ?></div>
			</article>
		<?php endwhile; ?>
	<?php else : ?>
		<p><?php esc_html_e( 'Todavía no hay contenido.', 'tienda-moda' ); ?></p>
	<?php endif; ?>
</div>
<?php
get_footer();