<?php
/** Configure Rank Math for the local WooCommerce store. */
defined( 'ABSPATH' ) || exit;

$general = (array) get_option( 'rank-math-options-general', array() );
$titles  = (array) get_option( 'rank-math-options-titles', array() );
$sitemap = (array) get_option( 'rank-math-options-sitemap', array() );

$general['setup_mode']               = 'advanced';
$general['attachment_redirect_urls'] = 'on';
$general['attachment_redirect_default'] = home_url( '/' );
$general['wc_remove_generator']      = 'on';
$general['frontend_seo_score']       = 'off';
$general['breadcrumbs']              = 'off'; // The theme already renders WooCommerce breadcrumbs.

$titles['title_separator']              = '-';
$titles['knowledgegraph_type']          = 'company';
$titles['knowledgegraph_name']          = get_bloginfo( 'name' );
$titles['website_name']                 = get_bloginfo( 'name' );
$titles['homepage_title']               = '%sitename% %sep% Moda masculina en Chile';
$titles['homepage_description']         = 'Ropa masculina contemporánea, esenciales versátiles y despacho a todo Chile.';
$titles['noindex_empty_taxonomies']     = 'on';
$titles['noindex_search']               = 'on';
$titles['disable_date_archives']        = 'on';
$titles['author_custom_robots']         = 'on';
$titles['author_robots']                = array( 'noindex' );
$titles['pt_product_title']             = '%title% %sep% %sitename%';
$titles['pt_product_description']       = '%excerpt%';
$titles['pt_product_default_rich_snippet'] = 'product';
$titles['pt_product_custom_robots']     = 'off';
$titles['pt_product_robots']            = array( 'index' );
$titles['tax_product_cat_title']        = '%term% %sep% Ropa de hombre %sep% %sitename%';
$titles['tax_product_cat_description']  = '%term_description%';
$titles['tax_product_cat_custom_robots'] = 'off';
$titles['tax_product_tag_custom_robots'] = 'on';
$titles['tax_product_tag_robots']       = array( 'noindex' );

$sitemap['items_per_page']             = 200;
$sitemap['include_images']             = 'on';
$sitemap['include_featured_image']      = 'on';
$sitemap['pt_product_sitemap']          = 'on';
$sitemap['pt_page_sitemap']             = 'on';
$sitemap['pt_attachment_sitemap']       = 'off';
$sitemap['tax_product_cat_sitemap']     = 'on';
$sitemap['tax_product_tag_sitemap']     = 'off';
$sitemap['authors_sitemap']             = 'off';

$private_pages = array_filter(
	array(
		wc_get_page_id( 'cart' ),
		wc_get_page_id( 'checkout' ),
		wc_get_page_id( 'myaccount' ),
		(int) get_option( 'tienda_moda_wishlist_page_id', 0 ),
	)
);
$sitemap['exclude_posts'] = implode( ',', array_unique( array_map( 'absint', $private_pages ) ) );
foreach ( $private_pages as $page_id ) {
	update_post_meta( $page_id, 'rank_math_robots', array( 'noindex', 'nofollow' ) );
}

update_option( 'rank-math-options-general', $general );
update_option( 'rank-math-options-titles', $titles );
update_option( 'rank-math-options-sitemap', $sitemap );
update_option( 'rank_math_modules', array( 'link-counter', 'seo-analysis', 'sitemap', 'rich-snippet', 'woocommerce' ) );
update_option( 'rank_math_registration_skip', 1 );
update_option( 'rank_math_flush_rewrite', 1 );

flush_rewrite_rules();
WP_CLI::success( 'Rank Math configurado para WooCommerce.' );
