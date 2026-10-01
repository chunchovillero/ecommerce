<?php

defined( 'ABSPATH' ) || exit;

/**
 * Detect SEO plugins that already own metadata.
 *
 * @return bool
 */
function tienda_moda_has_seo_plugin() {
	return defined( 'WPSEO_VERSION' )
		|| defined( 'RANK_MATH_VERSION' )
		|| defined( 'AIOSEO_VERSION' )
		|| defined( 'SEOPRESS_VERSION' )
		|| class_exists( 'WPSEO_Frontend' )
		|| class_exists( 'RankMath' );
}

/**
 * Build a concise fallback description for the current view.
 *
 * @return string
 */
function tienda_moda_meta_description() {
	if ( is_front_page() ) {
		return (string) get_bloginfo( 'description' );
	}

	if ( is_singular() ) {
		$post = get_queried_object();
		if ( $post instanceof WP_Post ) {
			$description = has_excerpt( $post ) ? $post->post_excerpt : $post->post_content;
			return wp_trim_words( wp_strip_all_tags( strip_shortcodes( $description ) ), 28, '…' );
		}
	}

	if ( is_tax() || is_category() || is_tag() ) {
		return wp_trim_words( wp_strip_all_tags( term_description() ), 28, '…' );
	}

	if ( is_search() ) {
		return sprintf( __( 'Resultados de búsqueda para %s.', 'tienda-moda' ), get_search_query() );
	}

	if ( is_archive() ) {
		return wp_trim_words( wp_strip_all_tags( get_the_archive_description() ), 28, '…' );
	}

	return (string) get_bloginfo( 'description' );
}

/**
 * Resolve the share URL without duplicating WordPress canonical links.
 *
 * @return string
 */
function tienda_moda_social_url() {
	if ( function_exists( 'is_shop' ) && is_shop() ) {
		return wc_get_page_permalink( 'shop' );
	}
	if ( is_singular() ) {
		return get_permalink();
	}
	if ( is_search() ) {
		return get_search_link( get_search_query() );
	}
	if ( is_archive() ) {
		$object = get_queried_object();
		if ( $object instanceof WP_Term ) {
			$url = get_term_link( $object );
			return is_wp_error( $url ) ? home_url( '/' ) : $url;
		}
		if ( $object instanceof WP_Post_Type ) {
			$url = get_post_type_archive_link( $object->name );
			return $url ?: home_url( '/' );
		}
	}
	return home_url( '/' );
}

/**
 * Output minimal social metadata only when a dedicated SEO plugin is absent.
 */
function tienda_moda_fallback_metadata() {
	if ( tienda_moda_has_seo_plugin() ) {
		return;
	}

	$title       = wp_get_document_title();
	$description = tienda_moda_meta_description();
	$url         = tienda_moda_social_url();
	$image       = '';

	if ( is_singular() && has_post_thumbnail() ) {
		$image = get_the_post_thumbnail_url( get_queried_object_id(), 'large' );
	} elseif ( has_custom_logo() ) {
		$image = wp_get_attachment_image_url( get_theme_mod( 'custom_logo' ), 'full' );
	}

	if ( $description ) {
		echo '<meta name="description" content="' . esc_attr( $description ) . '">' . "\n";
	}
	echo '<meta property="og:locale" content="' . esc_attr( get_locale() ) . '">' . "\n";
	echo '<meta property="og:type" content="' . esc_attr( is_singular( 'product' ) ? 'product' : ( is_singular() ? 'article' : 'website' ) ) . '">' . "\n";
	echo '<meta property="og:title" content="' . esc_attr( $title ) . '">' . "\n";
	echo '<meta property="og:url" content="' . esc_url( $url ) . '">' . "\n";
	echo '<meta property="og:site_name" content="' . esc_attr( get_bloginfo( 'name' ) ) . '">' . "\n";
	if ( $description ) {
		echo '<meta property="og:description" content="' . esc_attr( $description ) . '">' . "\n";
	}
	if ( $image ) {
		echo '<meta property="og:image" content="' . esc_url( $image ) . '">' . "\n";
	}
	echo '<meta name="twitter:card" content="' . ( $image ? 'summary_large_image' : 'summary' ) . '">' . "\n";
}
add_action( 'wp_head', 'tienda_moda_fallback_metadata', 2 );

/**
 * Keep attachment pages from creating thin indexable content.
 */
function tienda_moda_attachment_robots( $robots ) {
	if ( is_attachment() ) {
		$robots['noindex'] = true;
	}
	return $robots;
}
add_filter( 'wp_robots', 'tienda_moda_attachment_robots' );
