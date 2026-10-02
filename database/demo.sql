/*M!999999\- enable the sandbox mode */
-- MariaDB dump 10.19-11.4.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: wordpress
-- ------------------------------------------------------
-- Server version	11.4.13-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `wp_actionscheduler_actions`
--

DROP TABLE IF EXISTS `wp_actionscheduler_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_actions` (
  `action_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hook` varchar(191) NOT NULL,
  `status` varchar(20) NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `args` varchar(191) DEFAULT NULL,
  `schedule` longtext DEFAULT NULL,
  `group_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `extended_args` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`),
  KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  KEY `args` (`args`),
  KEY `group_id` (`group_id`),
  KEY `last_attempt_gmt` (`last_attempt_gmt`),
  KEY `claim_id_status_priority_scheduled_date_gmt` (`claim_id`,`status`,`priority`,`scheduled_date_gmt`),
  KEY `status_last_attempt_gmt` (`status`,`last_attempt_gmt`),
  KEY `status_claim_id` (`status`,`claim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_claims`
--

DROP TABLE IF EXISTS `wp_actionscheduler_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_claims` (
  `claim_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`claim_id`),
  KEY `date_created_gmt` (`date_created_gmt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_groups`
--

DROP TABLE IF EXISTS `wp_actionscheduler_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_groups` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_logs`
--

DROP TABLE IF EXISTS `wp_actionscheduler_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_logs` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` bigint(20) unsigned NOT NULL,
  `message` text NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`),
  KEY `action_id` (`action_id`),
  KEY `log_date_gmt` (`log_date_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT 0,
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10)),
  KEY `woo_idx_comment_type` (`comment_type`),
  KEY `woo_idx_comment_date_type` (`comment_date_gmt`,`comment_type`,`comment_approved`,`comment_post_ID`),
  KEY `woo_idx_comment_approved_type` (`comment_approved`,`comment_type`,`comment_post_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT 1,
  `link_rating` int(11) NOT NULL DEFAULT 0,
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=1349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT 0,
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(255) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `type_status_author` (`post_type`,`post_status`,`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `term_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `count` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(255) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT 0,
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_admin_note_actions`
--

DROP TABLE IF EXISTS `wp_wc_admin_note_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_admin_note_actions` (
  `action_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `note_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `actioned_text` varchar(255) NOT NULL,
  `nonce_action` varchar(255) DEFAULT NULL,
  `nonce_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `note_id` (`note_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_admin_notes`
--

DROP TABLE IF EXISTS `wp_wc_admin_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_admin_notes` (
  `note_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `locale` varchar(20) NOT NULL,
  `title` longtext NOT NULL,
  `content` longtext NOT NULL,
  `content_data` longtext DEFAULT NULL,
  `status` varchar(200) NOT NULL,
  `source` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_reminder` datetime DEFAULT NULL,
  `is_snoozable` tinyint(1) NOT NULL DEFAULT 0,
  `layout` varchar(20) NOT NULL DEFAULT '',
  `image` varchar(200) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(200) NOT NULL DEFAULT 'info',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_category_lookup`
--

DROP TABLE IF EXISTS `wp_wc_category_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_category_lookup` (
  `category_tree_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`category_tree_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_customer_lookup`
--

DROP TABLE IF EXISTS `wp_wc_customer_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_customer_lookup` (
  `customer_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `username` varchar(60) NOT NULL DEFAULT '',
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `date_last_active` timestamp NULL DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT NULL,
  `country` char(2) NOT NULL DEFAULT '',
  `postcode` varchar(20) NOT NULL DEFAULT '',
  `city` varchar(100) NOT NULL DEFAULT '',
  `state` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_download_log`
--

DROP TABLE IF EXISTS `wp_wc_download_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_download_log` (
  `download_log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `user_ip_address` varchar(100) DEFAULT '',
  PRIMARY KEY (`download_log_id`),
  KEY `permission_id` (`permission_id`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_email_unsubscribes`
--

DROP TABLE IF EXISTS `wp_wc_email_unsubscribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_email_unsubscribes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_hash` char(64) NOT NULL,
  `email_kind` varchar(64) NOT NULL,
  `action` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_hash_kind` (`email_hash`,`email_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_addresses`
--

DROP TABLE IF EXISTS `wp_wc_order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `address_type` varchar(20) DEFAULT NULL,
  `first_name` text DEFAULT NULL,
  `last_name` text DEFAULT NULL,
  `company` text DEFAULT NULL,
  `address_1` text DEFAULT NULL,
  `address_2` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state` text DEFAULT NULL,
  `postcode` text DEFAULT NULL,
  `country` text DEFAULT NULL,
  `email` varchar(320) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_type_order_id` (`address_type`,`order_id`),
  KEY `order_id` (`order_id`),
  KEY `email` (`email`(191)),
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_coupon_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_coupon_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_coupon_lookup` (
  `order_id` bigint(20) unsigned NOT NULL,
  `coupon_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `discount_amount` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`,`coupon_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_operational_data`
--

DROP TABLE IF EXISTS `wp_wc_order_operational_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_operational_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `created_via` varchar(100) DEFAULT NULL,
  `woocommerce_version` varchar(20) DEFAULT NULL,
  `prices_include_tax` tinyint(1) DEFAULT NULL,
  `coupon_usages_are_counted` tinyint(1) DEFAULT NULL,
  `download_permission_granted` tinyint(1) DEFAULT NULL,
  `cart_hash` varchar(100) DEFAULT NULL,
  `new_order_email_sent` tinyint(1) DEFAULT NULL,
  `order_key` varchar(100) DEFAULT NULL,
  `order_stock_reduced` tinyint(1) DEFAULT NULL,
  `date_paid_gmt` datetime DEFAULT NULL,
  `date_completed_gmt` datetime DEFAULT NULL,
  `shipping_tax_amount` decimal(26,8) DEFAULT NULL,
  `shipping_total_amount` decimal(26,8) DEFAULT NULL,
  `discount_tax_amount` decimal(26,8) DEFAULT NULL,
  `discount_total_amount` decimal(26,8) DEFAULT NULL,
  `recorded_sales` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `order_key` (`order_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_product_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_product_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_product_lookup` (
  `order_item_id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `variation_id` bigint(20) unsigned NOT NULL,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `product_qty` int(11) NOT NULL,
  `product_net_revenue` double NOT NULL DEFAULT 0,
  `product_gross_revenue` double NOT NULL DEFAULT 0,
  `coupon_amount` double NOT NULL DEFAULT 0,
  `tax_amount` double NOT NULL DEFAULT 0,
  `shipping_amount` double NOT NULL DEFAULT 0,
  `shipping_tax_amount` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_item_id`,`order_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `customer_id` (`customer_id`),
  KEY `date_created` (`date_created`),
  KEY `customer_product_date` (`customer_id`,`product_id`,`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_stats`
--

DROP TABLE IF EXISTS `wp_wc_order_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_stats` (
  `order_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_paid` datetime DEFAULT '0000-00-00 00:00:00',
  `date_completed` datetime DEFAULT '0000-00-00 00:00:00',
  `num_items_sold` int(11) NOT NULL DEFAULT 0,
  `total_sales` double NOT NULL DEFAULT 0,
  `tax_total` double NOT NULL DEFAULT 0,
  `shipping_total` double NOT NULL DEFAULT 0,
  `net_total` double NOT NULL DEFAULT 0,
  `returning_customer` tinyint(1) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `date_created` (`date_created`),
  KEY `customer_id` (`customer_id`),
  KEY `status` (`status`),
  KEY `idx_date_paid_status_parent` (`date_paid`,`status`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_order_tax_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_tax_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_tax_lookup` (
  `order_id` bigint(20) unsigned NOT NULL,
  `tax_rate_id` bigint(20) unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `shipping_tax` double NOT NULL DEFAULT 0,
  `order_tax` double NOT NULL DEFAULT 0,
  `total_tax` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`,`tax_rate_id`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_orders`
--

DROP TABLE IF EXISTS `wp_wc_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_orders` (
  `id` bigint(20) unsigned NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `tax_amount` decimal(26,8) DEFAULT NULL,
  `total_amount` decimal(26,8) DEFAULT NULL,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `billing_email` varchar(320) DEFAULT NULL,
  `date_created_gmt` datetime DEFAULT NULL,
  `date_updated_gmt` datetime DEFAULT NULL,
  `parent_order_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `payment_method_title` text DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `customer_note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `date_created` (`date_created_gmt`),
  KEY `customer_id_billing_email` (`customer_id`,`billing_email`(171)),
  KEY `customer_id_status` (`customer_id`,`status`),
  KEY `billing_email` (`billing_email`(191)),
  KEY `transaction_id` (`transaction_id`(20)),
  KEY `type_status_date` (`type`,`status`,`date_created_gmt`),
  KEY `parent_order_id` (`parent_order_id`),
  KEY `date_updated` (`date_updated_gmt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_orders_meta`
--

DROP TABLE IF EXISTS `wp_wc_orders_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_orders_meta` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_key_value` (`meta_key`(50),`meta_value`(20)),
  KEY `order_id_meta_key_meta_value` (`order_id`,`meta_key`(100),`meta_value`(82))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_product_attributes_lookup`
--

DROP TABLE IF EXISTS `wp_wc_product_attributes_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_attributes_lookup` (
  `product_id` bigint(20) NOT NULL,
  `product_or_parent_id` bigint(20) NOT NULL,
  `taxonomy` varchar(32) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `is_variation_attribute` tinyint(1) NOT NULL,
  `in_stock` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_or_parent_id`,`term_id`,`product_id`,`taxonomy`),
  KEY `is_variation_attribute_term_id` (`is_variation_attribute`,`term_id`),
  KEY `taxonomy_term_id_in_stock_product_or_parent_id` (`taxonomy`,`term_id`,`in_stock`,`product_or_parent_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_product_download_directories`
--

DROP TABLE IF EXISTS `wp_wc_product_download_directories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_download_directories` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(256) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`url_id`),
  KEY `url` (`url`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_product_meta_lookup`
--

DROP TABLE IF EXISTS `wp_wc_product_meta_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_meta_lookup` (
  `product_id` bigint(20) NOT NULL,
  `sku` varchar(100) DEFAULT '',
  `global_unique_id` varchar(100) DEFAULT '',
  `virtual` tinyint(1) DEFAULT 0,
  `downloadable` tinyint(1) DEFAULT 0,
  `min_price` decimal(19,4) DEFAULT NULL,
  `max_price` decimal(19,4) DEFAULT NULL,
  `onsale` tinyint(1) DEFAULT 0,
  `stock_quantity` double DEFAULT NULL,
  `stock_status` varchar(100) DEFAULT 'instock',
  `rating_count` bigint(20) DEFAULT 0,
  `average_rating` decimal(3,2) DEFAULT 0.00,
  `total_sales` bigint(20) DEFAULT 0,
  `tax_status` varchar(100) DEFAULT 'taxable',
  `tax_class` varchar(100) DEFAULT '',
  PRIMARY KEY (`product_id`),
  KEY `virtual` (`virtual`),
  KEY `downloadable` (`downloadable`),
  KEY `stock_status` (`stock_status`),
  KEY `stock_quantity` (`stock_quantity`),
  KEY `onsale` (`onsale`),
  KEY `min_max_price` (`min_price`,`max_price`),
  KEY `sku` (`sku`(50))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_rate_limits`
--

DROP TABLE IF EXISTS `wp_wc_rate_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_rate_limits` (
  `rate_limit_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rate_limit_key` varchar(200) NOT NULL,
  `rate_limit_expiry` bigint(20) unsigned NOT NULL,
  `rate_limit_remaining` smallint(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rate_limit_id`),
  UNIQUE KEY `rate_limit_key` (`rate_limit_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_reserved_stock`
--

DROP TABLE IF EXISTS `wp_wc_reserved_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_reserved_stock` (
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `stock_quantity` double NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id_expires` (`product_id`,`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_tax_rate_classes`
--

DROP TABLE IF EXISTS `wp_wc_tax_rate_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_tax_rate_classes` (
  `tax_rate_class_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_class_id`),
  UNIQUE KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wc_webhooks`
--

DROP TABLE IF EXISTS `wp_wc_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_webhooks` (
  `webhook_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(200) NOT NULL,
  `name` text NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `delivery_url` text NOT NULL,
  `secret` text NOT NULL,
  `topic` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` smallint(4) NOT NULL,
  `failure_count` smallint(10) NOT NULL DEFAULT 0,
  `pending_delivery` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`webhook_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_api_keys`
--

DROP TABLE IF EXISTS `wp_woocommerce_api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_api_keys` (
  `key_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `permissions` varchar(10) NOT NULL,
  `consumer_key` char(64) NOT NULL,
  `consumer_secret` char(43) NOT NULL,
  `nonces` longtext DEFAULT NULL,
  `truncated_key` char(7) NOT NULL,
  `last_access` datetime DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  KEY `consumer_key` (`consumer_key`),
  KEY `consumer_secret` (`consumer_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_attribute_taxonomies`
--

DROP TABLE IF EXISTS `wp_woocommerce_attribute_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(200) NOT NULL,
  `attribute_label` varchar(200) DEFAULT NULL,
  `attribute_type` varchar(20) NOT NULL,
  `attribute_orderby` varchar(20) NOT NULL,
  `attribute_public` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`attribute_id`),
  KEY `attribute_name` (`attribute_name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_downloadable_product_permissions`
--

DROP TABLE IF EXISTS `wp_woocommerce_downloadable_product_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `download_id` varchar(36) NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `order_key` varchar(200) NOT NULL,
  `user_email` varchar(200) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `downloads_remaining` varchar(9) DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`permission_id`),
  KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(16),`download_id`),
  KEY `download_order_product` (`download_id`,`order_id`,`product_id`),
  KEY `order_id` (`order_id`),
  KEY `user_order_remaining_expires` (`user_id`,`order_id`,`downloads_remaining`,`access_expires`),
  KEY `idx_user_email` (`user_email`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_log`
--

DROP TABLE IF EXISTS `wp_woocommerce_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_log` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `level` smallint(4) NOT NULL,
  `source` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `context` longtext DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_order_itemmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_itemmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_item_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_order_items`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_order_items` (
  `order_item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_item_name` text NOT NULL,
  `order_item_type` varchar(200) NOT NULL DEFAULT '',
  `order_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_payment_tokenmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokenmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_payment_tokenmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payment_token_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `payment_token_id` (`payment_token_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_payment_tokens`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_payment_tokens` (
  `token_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_id` varchar(200) NOT NULL,
  `token` text NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` varchar(200) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`token_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_sessions`
--

DROP TABLE IF EXISTS `wp_woocommerce_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_sessions` (
  `session_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(32) NOT NULL,
  `session_value` longtext NOT NULL,
  `session_expiry` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_key` (`session_key`),
  KEY `session_expiry` (`session_expiry`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_shipping_zone_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zone_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` bigint(20) unsigned NOT NULL,
  `location_code` varchar(200) NOT NULL,
  `location_type` varchar(40) NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `zone_id` (`zone_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_shipping_zone_methods`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zone_methods` (
  `zone_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `method_id` varchar(200) NOT NULL,
  `method_order` bigint(20) unsigned NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`instance_id`),
  KEY `zone_id` (`zone_id`),
  KEY `method_id` (`method_id`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_shipping_zones`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zones` (
  `zone_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `zone_name` varchar(200) NOT NULL,
  `zone_order` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`zone_id`),
  KEY `zone_order_id` (`zone_order`,`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_tax_rate_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rate_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_tax_rate_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_code` varchar(200) NOT NULL,
  `tax_rate_id` bigint(20) unsigned NOT NULL,
  `location_type` varchar(40) NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_woocommerce_tax_rates`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_tax_rates` (
  `tax_rate_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tax_rate_country` varchar(2) NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) NOT NULL DEFAULT '',
  `tax_rate` varchar(8) NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) NOT NULL DEFAULT '',
  `tax_rate_priority` bigint(20) unsigned NOT NULL,
  `tax_rate_compound` int(1) NOT NULL DEFAULT 0,
  `tax_rate_shipping` int(1) NOT NULL DEFAULT 1,
  `tax_rate_order` bigint(20) unsigned NOT NULL,
  `tax_rate_class` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_id`),
  KEY `tax_rate_country` (`tax_rate_country`),
  KEY `tax_rate_state` (`tax_rate_state`(2)),
  KEY `tax_rate_class` (`tax_rate_class`(10)),
  KEY `tax_rate_priority` (`tax_rate_priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-10-02 13:21:34
/*M!999999\- enable the sandbox mode */
-- MariaDB dump 10.19-11.4.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: wordpress
-- ------------------------------------------------------
-- Server version	11.4.13-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Dumping data for table `wp_actionscheduler_actions`
--

LOCK TABLES `wp_actionscheduler_actions` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_actions` DISABLE KEYS */;
INSERT INTO `wp_actionscheduler_actions` VALUES
(7,'woocommerce_run_update_callback','pending','2026-09-30 17:40:29','2026-09-30 17:40:29',10,'{\"update_callback\":[\"Automattic\\\\WooCommerce\\\\Internal\\\\VariationGallery\\\\Migration\",\"run\"]}','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790790029;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790790029;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(8,'action_scheduler/migration_hook','pending','2026-09-30 17:41:29','2026-09-30 17:41:29',10,'[]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790790089;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790790089;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(9,'wc-admin_process_pending_orders_batch','pending','2026-09-30 17:40:29','2026-09-30 17:40:29',10,'[]','O:32:\"ActionScheduler_IntervalSchedule\":5:{s:22:\"\0*\0scheduled_timestamp\";i:1790790029;s:18:\"\0*\0first_timestamp\";i:1790790029;s:13:\"\0*\0recurrence\";i:43200;s:49:\"\0ActionScheduler_IntervalSchedule\0start_timestamp\";i:1790790029;s:53:\"\0ActionScheduler_IntervalSchedule\0interval_in_seconds\";i:43200;}',3,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(10,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:07:32','2026-10-01 13:07:32',10,'[14,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860052;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860052;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(11,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:07:48','2026-10-01 13:07:48',10,'[15,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860068;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860068;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(12,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:08:05','2026-10-01 13:08:05',10,'[16,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860085;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860085;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(13,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:08:05','2026-10-01 13:08:05',10,'[15,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860085;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860085;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(14,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:08:27','2026-10-01 13:08:27',10,'[17,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860107;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860107;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(15,'woocommerce_delete_legacy_report_transients','pending','2026-10-01 13:14:58','2026-10-01 13:14:58',10,'[18,false]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860498;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860498;}',4,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(16,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:16:06','2026-10-01 13:16:06',10,'[14,3]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860566;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860566;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(17,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:16:11','2026-10-01 13:16:11',10,'[16,3]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860571;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860571;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(18,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:16:11','2026-10-01 13:16:11',10,'[17,3]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860571;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860571;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(19,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-01 13:16:11','2026-10-01 13:16:11',10,'[15,3]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790860571;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790860571;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(20,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:06','2026-10-02 13:11:06',10,'[19,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946666;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946666;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(21,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:06','2026-10-02 13:11:06',10,'[20,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946666;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946666;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(22,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[21,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(23,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[22,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(24,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[19,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(25,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[23,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(26,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[24,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(27,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[25,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(28,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[26,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(29,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[27,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(30,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:07','2026-10-02 13:11:07',10,'[24,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946667;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946667;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(31,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[28,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(32,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[29,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(33,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[30,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(34,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[31,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(35,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[32,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(36,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[33,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(37,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[34,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(38,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:08','2026-10-02 13:11:08',10,'[35,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946668;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946668;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(39,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[36,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(40,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[33,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(41,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[37,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(42,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[38,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(43,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[39,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(44,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[40,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(45,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[41,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(46,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:09','2026-10-02 13:11:09',10,'[42,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946669;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946669;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(47,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[43,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(48,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[44,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(49,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[45,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(50,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[46,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(51,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[47,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(52,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[44,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(53,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[48,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(54,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:10','2026-10-02 13:11:10',10,'[49,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946670;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946670;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(55,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[50,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(56,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[51,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(57,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[48,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(58,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[52,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(59,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[53,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(60,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[54,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(61,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[55,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(62,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[56,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(63,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:11','2026-10-02 13:11:11',10,'[57,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946671;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946671;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(64,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[58,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(65,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[59,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(66,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[56,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(67,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[60,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(68,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[61,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(69,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[62,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(70,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[63,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(71,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:12','2026-10-02 13:11:12',10,'[64,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946672;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946672;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(72,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[65,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(73,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[66,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(74,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[67,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(75,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[64,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(76,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[68,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(77,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[69,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(78,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[70,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(79,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:13','2026-10-02 13:11:13',10,'[71,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946673;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946673;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(80,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[72,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(81,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[73,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(82,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[74,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(83,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[71,2]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(84,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[75,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(85,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[76,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(86,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[77,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(87,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[78,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(88,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:14','2026-10-02 13:11:14',10,'[79,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946674;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946674;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(89,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:15','2026-10-02 13:11:15',10,'[80,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946675;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946675;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(90,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:15','2026-10-02 13:11:15',10,'[81,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946675;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946675;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(91,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-10-02 13:11:15','2026-10-02 13:11:15',10,'[82,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1790946675;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1790946675;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL);
/*!40000 ALTER TABLE `wp_actionscheduler_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_actionscheduler_claims`
--

LOCK TABLES `wp_actionscheduler_claims` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_actionscheduler_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_actionscheduler_groups`
--

LOCK TABLES `wp_actionscheduler_groups` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_groups` DISABLE KEYS */;
INSERT INTO `wp_actionscheduler_groups` VALUES
(1,'woocommerce-db-updates'),
(2,'action-scheduler-migration'),
(3,'wc-admin-data'),
(4,'woocommerce');
/*!40000 ALTER TABLE `wp_actionscheduler_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_actionscheduler_logs`
--

LOCK TABLES `wp_actionscheduler_logs` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_logs` DISABLE KEYS */;
INSERT INTO `wp_actionscheduler_logs` VALUES
(1,7,'action created','2026-09-30 17:40:29','2026-09-30 17:40:29'),
(2,8,'action created','2026-09-30 17:40:29','2026-09-30 17:40:29'),
(3,9,'action created','2026-09-30 17:40:29','2026-09-30 17:40:29'),
(4,10,'action created','2026-10-01 13:07:31','2026-10-01 13:07:31'),
(5,11,'action created','2026-10-01 13:07:47','2026-10-01 13:07:47'),
(6,12,'action created','2026-10-01 13:08:04','2026-10-01 13:08:04'),
(7,13,'action created','2026-10-01 13:08:04','2026-10-01 13:08:04'),
(8,14,'action created','2026-10-01 13:08:26','2026-10-01 13:08:26'),
(9,15,'acción creada','2026-10-01 13:13:58','2026-10-01 13:13:58'),
(10,16,'acción creada','2026-10-01 13:16:05','2026-10-01 13:16:05'),
(11,17,'acción creada','2026-10-01 13:16:10','2026-10-01 13:16:10'),
(12,18,'acción creada','2026-10-01 13:16:10','2026-10-01 13:16:10'),
(13,19,'acción creada','2026-10-01 13:16:10','2026-10-01 13:16:10'),
(14,20,'acción creada','2026-10-02 13:11:05','2026-10-02 13:11:05'),
(15,21,'acción creada','2026-10-02 13:11:05','2026-10-02 13:11:05'),
(16,22,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(17,23,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(18,24,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(19,25,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(20,26,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(21,27,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(22,28,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(23,29,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(24,30,'acción creada','2026-10-02 13:11:06','2026-10-02 13:11:06'),
(25,31,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(26,32,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(27,33,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(28,34,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(29,35,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(30,36,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(31,37,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(32,38,'acción creada','2026-10-02 13:11:07','2026-10-02 13:11:07'),
(33,39,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(34,40,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(35,41,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(36,42,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(37,43,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(38,44,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(39,45,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(40,46,'acción creada','2026-10-02 13:11:08','2026-10-02 13:11:08'),
(41,47,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(42,48,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(43,49,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(44,50,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(45,51,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(46,52,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(47,53,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(48,54,'acción creada','2026-10-02 13:11:09','2026-10-02 13:11:09'),
(49,55,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(50,56,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(51,57,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(52,58,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(53,59,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(54,60,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(55,61,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(56,62,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(57,63,'acción creada','2026-10-02 13:11:10','2026-10-02 13:11:10'),
(58,64,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(59,65,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(60,66,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(61,67,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(62,68,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(63,69,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(64,70,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(65,71,'acción creada','2026-10-02 13:11:11','2026-10-02 13:11:11'),
(66,72,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(67,73,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(68,74,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(69,75,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(70,76,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(71,77,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(72,78,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(73,79,'acción creada','2026-10-02 13:11:12','2026-10-02 13:11:12'),
(74,80,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(75,81,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(76,82,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(77,83,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(78,84,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(79,85,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(80,86,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(81,87,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(82,88,'acción creada','2026-10-02 13:11:13','2026-10-02 13:11:13'),
(83,89,'acción creada','2026-10-02 13:11:14','2026-10-02 13:11:14'),
(84,90,'acción creada','2026-10-02 13:11:14','2026-10-02 13:11:14'),
(85,91,'acción creada','2026-10-02 13:11:14','2026-10-02 13:11:14');
/*!40000 ALTER TABLE `wp_actionscheduler_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES
(1,'cron','a:13:{i:1790789664;a:3:{s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}s:41:\"wp_privacy_personal_data_cleanup_requests\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1790789708;a:3:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:21:\"wp_update_user_counts\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1790789711;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1790789768;a:1:{s:28:\"wp_update_comment_type_batch\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:0:{}}}}i:1790789945;a:1:{s:30:\"wp_delete_temp_updater_backups\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}i:1790789990;a:1:{s:26:\"action_scheduler_run_queue\";a:1:{s:32:\"0d04ed39571b55704c122d726248bbac\";a:3:{s:8:\"schedule\";s:12:\"every_minute\";s:4:\"args\";a:1:{i:0;s:7:\"WP Cron\";}s:8:\"interval\";i:60;}}}i:1790790029;a:3:{s:20:\"jetpack_clean_nonces\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}s:20:\"jetpack_v2_heartbeat\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:33:\"wc_admin_process_orders_milestone\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1790790034;a:1:{s:29:\"wc_admin_unsnooze_admin_notes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1790793263;a:1:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1790795063;a:1:{s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1790796863;a:1:{s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1790876064;a:1:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','on'),
(2,'siteurl','http://localhost:8080','on'),
(3,'home','http://localhost:8080','on'),
(4,'blogname','Ecommerce','on'),
(5,'blogdescription','','on'),
(6,'users_can_register','0','on'),
(7,'admin_email','xxxxxxxxxxxx@fake.test','on'),
(8,'start_of_week','1','on'),
(9,'use_balanceTags','0','on'),
(10,'use_smilies','1','on'),
(11,'require_name_email','1','on'),
(12,'comments_notify','1','on'),
(13,'posts_per_rss','10','on'),
(14,'rss_use_excerpt','0','on'),
(15,'mailserver_url','mail.example.com','on'),
(16,'mailserver_login','login@example.com','on'),
(17,'mailserver_pass','','on'),
(18,'mailserver_port','110','on'),
(19,'default_category','1','on'),
(20,'default_comment_status','open','on'),
(21,'default_ping_status','open','on'),
(22,'default_pingback_flag','0','on'),
(23,'posts_per_page','10','on'),
(24,'date_format','F j, Y','on'),
(25,'time_format','g:i a','on'),
(26,'links_updated_date_format','F j, Y g:i a','on'),
(27,'comment_moderation','0','on'),
(28,'moderation_notify','1','on'),
(29,'permalink_structure','','on'),
(30,'rewrite_rules','','on'),
(31,'hack_file','0','on'),
(32,'blog_charset','UTF-8','on'),
(33,'moderation_keys','','off'),
(34,'active_plugins','a:1:{i:0;s:27:\"woocommerce/woocommerce.php\";}','on'),
(35,'category_base','','on'),
(36,'ping_sites','https://rpc.pingomatic.com/','on'),
(37,'comment_max_links','2','on'),
(38,'gmt_offset','0','on'),
(39,'default_email_category','1','on'),
(40,'recently_edited','','off'),
(41,'template','tienda-moda','on'),
(42,'stylesheet','tienda-moda','on'),
(43,'comment_registration','0','on'),
(44,'html_type','text/html','on'),
(45,'use_trackback','0','on'),
(46,'default_role','subscriber','on'),
(47,'db_version','61833','on'),
(48,'uploads_use_yearmonth_folders','1','on'),
(49,'upload_path','','on'),
(50,'blog_public','0','on'),
(51,'default_link_category','2','on'),
(52,'show_on_front','posts','on'),
(53,'tag_base','','on'),
(54,'show_avatars','1','on'),
(55,'avatar_rating','G','on'),
(56,'upload_url_path','','on'),
(57,'thumbnail_size_w','150','on'),
(58,'thumbnail_size_h','150','on'),
(59,'thumbnail_crop','1','on'),
(60,'medium_size_w','300','on'),
(61,'medium_size_h','300','on'),
(62,'avatar_default','mystery','on'),
(63,'large_size_w','1024','on'),
(64,'large_size_h','1024','on'),
(65,'image_default_link_type','none','on'),
(66,'image_default_size','','on'),
(67,'image_default_align','','on'),
(68,'close_comments_for_old_posts','0','on'),
(69,'close_comments_days_old','14','on'),
(70,'thread_comments','1','on'),
(71,'thread_comments_depth','5','on'),
(72,'page_comments','0','on'),
(73,'comments_per_page','50','on'),
(74,'default_comments_page','newest','on'),
(75,'comment_order','asc','on'),
(76,'sticky_posts','a:0:{}','on'),
(77,'widget_categories','a:0:{}','on'),
(78,'widget_text','a:0:{}','on'),
(79,'widget_rss','a:0:{}','on'),
(80,'uninstall_plugins','a:0:{}','off'),
(81,'timezone_string','','on'),
(82,'page_for_posts','0','on'),
(83,'page_on_front','0','on'),
(84,'default_post_format','0','on'),
(85,'link_manager_enabled','0','on'),
(86,'finished_splitting_shared_terms','1','on'),
(87,'site_icon','0','on'),
(88,'medium_large_size_w','768','on'),
(89,'medium_large_size_h','0','on'),
(90,'wp_page_for_privacy_policy','3','on'),
(91,'show_comments_cookies_opt_in','1','on'),
(92,'admin_email_lifespan','1806341663','on'),
(93,'disallowed_keys','','off'),
(94,'comment_previously_approved','1','on'),
(95,'auto_plugin_theme_update_emails','a:0:{}','off'),
(96,'auto_update_core_dev','enabled','on'),
(97,'auto_update_core_minor','enabled','on'),
(98,'auto_update_core_major','enabled','on'),
(99,'wp_force_deactivated_plugins','a:0:{}','on'),
(100,'wp_attachment_pages_enabled','0','on'),
(101,'wp_notes_notify','1','on'),
(102,'initial_db_version','61833','on'),
(103,'wp_user_roles','a:7:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:115:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:18:\"manage_woocommerce\";b:1;s:16:\"create_customers\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}s:8:\"customer\";a:2:{s:4:\"name\";s:8:\"Customer\";s:12:\"capabilities\";a:1:{s:4:\"read\";b:1;}}s:12:\"shop_manager\";a:2:{s:4:\"name\";s:12:\"Shop manager\";s:12:\"capabilities\";a:93:{s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:4:\"read\";b:1;s:18:\"read_private_pages\";b:1;s:18:\"read_private_posts\";b:1;s:10:\"edit_posts\";b:1;s:10:\"edit_pages\";b:1;s:20:\"edit_published_posts\";b:1;s:20:\"edit_published_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"edit_private_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:17:\"edit_others_pages\";b:1;s:13:\"publish_posts\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_posts\";b:1;s:12:\"delete_pages\";b:1;s:20:\"delete_private_pages\";b:1;s:20:\"delete_private_posts\";b:1;s:22:\"delete_published_pages\";b:1;s:22:\"delete_published_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:19:\"delete_others_pages\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:17:\"moderate_comments\";b:1;s:12:\"upload_files\";b:1;s:6:\"export\";b:1;s:6:\"import\";b:1;s:10:\"list_users\";b:1;s:18:\"edit_theme_options\";b:1;s:18:\"manage_woocommerce\";b:1;s:16:\"create_customers\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}}','on'),
(104,'fresh_site','0','off'),
(105,'user_count','1','off'),
(106,'widget_block','a:6:{i:2;a:1:{s:7:\"content\";s:19:\"<!-- wp:search /-->\";}i:3;a:1:{s:7:\"content\";s:154:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->\";}i:4;a:1:{s:7:\"content\";s:227:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {\"displayAvatar\":false,\"displayDate\":false,\"displayExcerpt\":false} /--></div><!-- /wp:group -->\";}i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}s:12:\"_multiwidget\";i:1;}','auto'),
(107,'sidebars_widgets','a:2:{s:19:\"wp_inactive_widgets\";a:5:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";i:3;s:7:\"block-5\";i:4;s:7:\"block-6\";}s:13:\"array_version\";i:3;}','auto'),
(108,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(109,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(110,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(111,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(112,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(113,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(114,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(115,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(116,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(117,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(118,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(119,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(120,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(121,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(126,'theme_mods_twentytwentyfive','a:2:{s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1790789798;s:4:\"data\";a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}}}}','off'),
(137,'can_compress_scripts','0','on'),
(152,'current_theme','Tienda de Moda','auto'),
(153,'theme_switched','','auto'),
(156,'theme_mods_tienda-moda','a:2:{s:18:\"nav_menu_locations\";a:0:{}s:18:\"custom_css_post_id\";i:-1;}','auto'),
(158,'action_scheduler_hybrid_store_demarkation','6','auto'),
(159,'schema-ActionScheduler_StoreSchema','8.0.1790789990','auto'),
(160,'schema-ActionScheduler_LoggerSchema','3.0.1790789990','auto'),
(166,'woocommerce_newly_installed','no','auto'),
(167,'woocommerce_order_stats_has_fulfillment_column','no','off'),
(168,'woocommerce_schema_version','920','auto'),
(169,'woocommerce_store_address','','on'),
(170,'woocommerce_store_address_2','','on'),
(171,'woocommerce_store_city','','on'),
(172,'woocommerce_default_country','CL','on'),
(173,'woocommerce_store_postcode','','on'),
(174,'woocommerce_allowed_countries','all','on'),
(175,'woocommerce_all_except_countries','','on'),
(176,'woocommerce_specific_allowed_countries','','on'),
(177,'woocommerce_ship_to_countries','','on'),
(178,'woocommerce_specific_ship_to_countries','','on'),
(179,'woocommerce_default_customer_address','base','on'),
(180,'woocommerce_address_autocomplete_enabled','no','on'),
(181,'woocommerce_calc_taxes','no','on'),
(182,'woocommerce_enable_coupons','yes','on'),
(183,'woocommerce_calc_discounts_sequentially','no','off'),
(184,'woocommerce_currency','CLP','on'),
(185,'woocommerce_currency_pos','left','on'),
(186,'woocommerce_price_thousand_sep','.','on'),
(187,'woocommerce_price_decimal_sep',',','on'),
(188,'woocommerce_price_num_decimals','0','on'),
(189,'woocommerce_shop_page_id','7','on'),
(190,'woocommerce_cart_redirect_after_add','no','on'),
(191,'woocommerce_enable_ajax_add_to_cart','yes','on'),
(192,'woocommerce_placeholder_image','6','on'),
(193,'woocommerce_weight_unit','lbs','on'),
(194,'woocommerce_dimension_unit','in','on'),
(195,'woocommerce_enable_reviews','yes','on'),
(196,'woocommerce_review_rating_verification_label','yes','off'),
(197,'woocommerce_review_rating_verification_required','no','off'),
(198,'woocommerce_enable_review_rating','yes','on'),
(199,'woocommerce_review_rating_required','yes','off'),
(200,'woocommerce_manage_stock','yes','on'),
(201,'woocommerce_hold_stock_minutes','60','off'),
(202,'woocommerce_notify_low_stock','yes','off'),
(203,'woocommerce_notify_no_stock','yes','off'),
(204,'woocommerce_notify_backorder','yes','off'),
(205,'woocommerce_stock_email_recipient','xxxxxxxxxxxx@fake.test','off'),
(206,'woocommerce_notify_low_stock_amount','2','off'),
(207,'woocommerce_notify_no_stock_amount','0','on'),
(208,'woocommerce_hide_out_of_stock_items','no','on'),
(209,'woocommerce_stock_format','','on'),
(210,'woocommerce_file_download_method','force','off'),
(211,'woocommerce_downloads_redirect_fallback_allowed','no','off'),
(212,'woocommerce_downloads_require_login','no','off'),
(213,'woocommerce_downloads_grant_access_after_payment','yes','off'),
(214,'woocommerce_downloads_deliver_inline','','off'),
(215,'woocommerce_downloads_add_hash_to_filename','yes','on'),
(216,'woocommerce_downloads_count_partial','yes','on'),
(218,'woocommerce_attribute_lookup_direct_updates','no','on'),
(219,'woocommerce_attribute_lookup_optimized_updates','no','on'),
(220,'woocommerce_product_match_featured_image_by_sku','no','on'),
(221,'woocommerce_prices_include_tax','no','on'),
(222,'woocommerce_tax_based_on','shipping','on'),
(223,'woocommerce_shipping_tax_class','inherit','on'),
(224,'woocommerce_tax_round_at_subtotal','no','on'),
(225,'woocommerce_tax_classes','','on'),
(226,'woocommerce_tax_display_shop','excl','on'),
(227,'woocommerce_tax_display_cart','excl','on'),
(228,'woocommerce_price_display_suffix','','on'),
(229,'woocommerce_tax_total_display','itemized','off'),
(230,'woocommerce_enable_shipping_calc','yes','off'),
(231,'woocommerce_shipping_cost_requires_address','no','on'),
(232,'woocommerce_shipping_hide_rates_when_free','no','off'),
(233,'woocommerce_ship_to_destination','billing','off'),
(234,'woocommerce_shipping_debug_mode','no','on'),
(235,'woocommerce_enable_guest_checkout','yes','off'),
(236,'woocommerce_enable_checkout_login_reminder','no','off'),
(237,'woocommerce_enable_signup_and_login_from_checkout','no','off'),
(238,'woocommerce_enable_myaccount_registration','no','off'),
(239,'woocommerce_registration_generate_password','yes','off'),
(240,'woocommerce_registration_generate_username','yes','off'),
(241,'woocommerce_erasure_request_removes_order_data','no','off'),
(242,'woocommerce_erasure_request_removes_download_data','no','off'),
(243,'woocommerce_allow_bulk_remove_personal_data','no','off'),
(244,'woocommerce_registration_privacy_policy_text','Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our [privacy_policy].','on'),
(245,'woocommerce_checkout_privacy_policy_text','Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our [privacy_policy].','on'),
(246,'woocommerce_delete_inactive_accounts','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(247,'woocommerce_trash_pending_orders','','off'),
(248,'woocommerce_trash_failed_orders','','off'),
(249,'woocommerce_trash_cancelled_orders','','off'),
(250,'woocommerce_anonymize_refunded_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(251,'woocommerce_anonymize_completed_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(252,'woocommerce_email_from_address','xxxxxxxxxxxx@fake.test','off'),
(253,'woocommerce_email_reply_to_enabled','no','off'),
(254,'woocommerce_email_reply_to_name','','off'),
(255,'woocommerce_email_reply_to_address','','off'),
(256,'woocommerce_email_header_image','','off'),
(257,'woocommerce_email_header_image_width','120','on'),
(258,'woocommerce_email_header_alignment','left','on'),
(259,'woocommerce_email_font_family','Helvetica','on'),
(260,'woocommerce_email_footer_text','{site_title}<br />{store_address}','off'),
(261,'woocommerce_email_base_color','#8526ff','off'),
(262,'woocommerce_email_background_color','#ffffff','off'),
(263,'woocommerce_email_body_background_color','#ffffff','off'),
(264,'woocommerce_email_text_color','#1e1e1e','off'),
(265,'woocommerce_email_footer_text_color','#787c82','off'),
(266,'woocommerce_email_auto_sync_with_theme','yes','off'),
(267,'woocommerce_pos_store_address','','on'),
(268,'woocommerce_pos_store_phone','','on'),
(269,'woocommerce_pos_store_email','xxxxxxxxxxxx@fake.test','on'),
(270,'woocommerce_pos_refund_returns_policy','','on'),
(271,'woocommerce_cart_page_id','8','off'),
(272,'woocommerce_checkout_page_id','9','off'),
(273,'woocommerce_myaccount_page_id','10','off'),
(274,'woocommerce_terms_page_id','','off'),
(275,'woocommerce_force_ssl_checkout','no','on'),
(276,'woocommerce_unforce_ssl_checkout','no','on'),
(277,'woocommerce_checkout_pay_endpoint','order-pay','on'),
(278,'woocommerce_checkout_order_received_endpoint','order-received','on'),
(279,'woocommerce_myaccount_add_payment_method_endpoint','add-payment-method','on'),
(280,'woocommerce_myaccount_delete_payment_method_endpoint','delete-payment-method','on'),
(281,'woocommerce_myaccount_set_default_payment_method_endpoint','set-default-payment-method','on'),
(282,'woocommerce_myaccount_orders_endpoint','orders','on'),
(283,'woocommerce_myaccount_view_order_endpoint','view-order','on'),
(284,'woocommerce_myaccount_downloads_endpoint','downloads','on'),
(285,'woocommerce_myaccount_edit_account_endpoint','edit-account','on'),
(286,'woocommerce_myaccount_edit_address_endpoint','edit-address','on'),
(287,'woocommerce_myaccount_payment_methods_endpoint','payment-methods','on'),
(288,'woocommerce_myaccount_lost_password_endpoint','lost-password','on'),
(289,'woocommerce_logout_endpoint','customer-logout','on'),
(290,'woocommerce_allow_tracking','no','on'),
(291,'woocommerce_show_marketplace_suggestions','yes','off'),
(292,'woocommerce_custom_orders_table_enabled','yes','on'),
(293,'woocommerce_analytics_enabled','yes','on'),
(294,'woocommerce_feature_rate_limit_checkout_enabled','no','on'),
(295,'woocommerce_feature_order_withdrawal_enabled','no','on'),
(296,'woocommerce_queue_flush_rewrite_rules','no','auto'),
(297,'woocommerce_feature_order_attribution_enabled','yes','on'),
(298,'woocommerce_hpos_datastore_caching_enabled','no','on'),
(299,'woocommerce_feature_remote_logging_enabled','yes','on'),
(300,'woocommerce_feature_deferred_transactional_emails_enabled','no','on'),
(301,'woocommerce_feature_customer_review_request_enabled','no','on'),
(302,'woocommerce_feature_email_improvements_enabled','yes','on'),
(305,'woocommerce_email_improvements_disabled_count','1','auto'),
(306,'woocommerce_email_improvements_first_disabled_at','2026-09-30 17:39:50','auto'),
(307,'woocommerce_email_improvements_last_disabled_at','2026-09-30 17:39:50','auto'),
(308,'woocommerce_feature_blueprint_enabled','yes','on'),
(309,'woocommerce_feature_cost_of_goods_sold_enabled','no','on'),
(310,'woocommerce_feature_product_gallery_videos_enabled','no','on'),
(311,'woocommerce_hpos_fts_index_enabled','no','on'),
(312,'woocommerce_feature_abandoned_cart_recovery_enabled','no','on'),
(313,'woocommerce_feature_block_email_editor_enabled','no','on'),
(314,'woocommerce_feature_mcp_integration_enabled','no','on'),
(315,'woocommerce_feature_destroy-empty-sessions_enabled','no','on'),
(316,'woocommerce_feature_rest_api_caching_enabled','no','on'),
(317,'woocommerce_cart_save_for_later_enabled','no','on'),
(318,'woocommerce_product_wishlist_enabled','no','on'),
(319,'woocommerce_feature_product_instance_caching_enabled','yes','on'),
(320,'woocommerce_feature_block_editor_unified_assets_enabled','no','on'),
(321,'woocommerce_single_image_width','600','on'),
(322,'woocommerce_thumbnail_image_width','300','on'),
(323,'woocommerce_checkout_highlight_required_fields','yes','on'),
(324,'woocommerce_demo_store','no','off'),
(325,'wc_downloads_approved_directories_mode','enabled','auto'),
(326,'woocommerce_permalinks','a:5:{s:12:\"product_base\";s:7:\"product\";s:13:\"category_base\";s:16:\"product-category\";s:8:\"tag_base\";s:11:\"product-tag\";s:14:\"attribute_base\";s:0:\"\";s:22:\"use_verbose_page_rules\";b:0;}','auto'),
(331,'default_product_cat','15','auto'),
(332,'woocommerce_refund_returns_page_id','11','auto'),
(335,'woocommerce_paypal_settings','a:25:{s:7:\"enabled\";s:2:\"no\";s:5:\"title\";s:6:\"PayPal\";s:11:\"description\";s:85:\"Pay via PayPal; you can pay with your credit card if you don\'t have a PayPal account.\";s:5:\"email\";s:22:\"xxxxxxxxxxxx@fake.test\";s:8:\"advanced\";s:0:\"\";s:8:\"testmode\";s:2:\"no\";s:13:\"paymentaction\";s:4:\"sale\";s:14:\"paypal_buttons\";s:3:\"yes\";s:14:\"invoice_prefix\";s:3:\"WC-\";s:13:\"send_shipping\";s:3:\"yes\";s:16:\"address_override\";s:2:\"no\";s:5:\"debug\";s:2:\"no\";s:9:\"image_url\";s:0:\"\";s:16:\"ipn_notification\";s:3:\"yes\";s:14:\"receiver_email\";s:22:\"xxxxxxxxxxxx@fake.test\";s:14:\"identity_token\";s:0:\"\";s:11:\"api_details\";s:0:\"\";s:12:\"api_username\";s:0:\"\";s:12:\"api_password\";s:0:\"\";s:13:\"api_signature\";s:0:\"\";s:20:\"sandbox_api_username\";s:0:\"\";s:20:\"sandbox_api_password\";s:0:\"\";s:21:\"sandbox_api_signature\";s:0:\"\";s:28:\"transact_onboarding_complete\";s:2:\"no\";s:12:\"_should_load\";s:2:\"no\";}','on'),
(336,'woocommerce_version','11.1.2','auto'),
(337,'woocommerce_db_version','11.1.2','auto'),
(338,'woocommerce_store_id','eb052f1c-60e7-44e3-bd12-50ac6f69a318','auto'),
(339,'woocommerce_admin_install_timestamp','1790789991','auto'),
(340,'woocommerce_inbox_variant_assignment','2','auto'),
(341,'woocommerce_remote_variant_assignment','100','auto'),
(342,'woocommerce_attribute_lookup_enabled','no','auto'),
(345,'woocommerce_admin_notices','a:0:{}','auto'),
(346,'woocommerce_maxmind_geolocation_settings','a:1:{s:15:\"database_prefix\";s:32:\"t9yZwLu66vkzXbofRXY0R22dqbUZnXCu\";}','on'),
(348,'widget_woocommerce_widget_cart','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(349,'widget_woocommerce_layered_nav_filters','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(350,'widget_woocommerce_layered_nav','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(351,'widget_woocommerce_price_filter','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(352,'widget_woocommerce_product_categories','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(353,'widget_woocommerce_product_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(354,'widget_woocommerce_product_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(355,'widget_woocommerce_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(356,'widget_woocommerce_recently_viewed_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(357,'widget_woocommerce_top_rated_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(358,'widget_woocommerce_recent_reviews','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(359,'widget_woocommerce_rating_filter','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(360,'widget_wc_brands_brand_description','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(361,'widget_woocommerce_brand_nav','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(362,'widget_wc_brands_brand_thumbnails','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(364,'current_theme_supports_woocommerce','yes','auto'),
(365,'woocommerce_custom_orders_table_created','yes','auto'),
(366,'woocommerce_coming_soon','no','auto'),
(367,'woocommerce_store_pages_only','yes','auto'),
(368,'woocommerce_email_improvements_default_enabled','yes','auto'),
(369,'woocommerce_email_improvements_first_enabled_at','2026-09-30 17:40:29','auto'),
(370,'woocommerce_email_improvements_last_enabled_at','2026-09-30 17:40:29','auto'),
(371,'woocommerce_email_improvements_enabled_count','1','auto'),
(372,'woocommerce_back_in_stock_allow_signups','yes','auto'),
(373,'woocommerce_analytics_scheduled_import','yes','auto'),
(374,'woocommerce_admin_scheduler_last_processed_order_modified_date','2026-09-30 17:39:29','auto'),
(375,'woocommerce_admin_scheduler_last_processed_order_id','0','auto'),
(376,'woocommerce_initial_installed_version','11.1.2','off'),
(377,'wc_blocks_db_schema_version','260','auto'),
(378,'wc_remote_inbox_notifications_stored_state','O:8:\"stdClass\":2:{s:22:\"there_were_no_products\";b:1;s:22:\"there_are_now_products\";b:0;}','off'),
(379,'action_scheduler_lock_async-request-runner','6abe5c56799436.64846948|1790860434','no'),
(382,'recovery_mode_email_last_sent','1790790690','auto'),
(383,'recovery_keys','a:1:{s:22:\"INuX4nKnGlPHe1WMCDsIWK\";a:2:{s:10:\"hashed_key\";s:49:\"$generic$Ypc_NB5oBe8htDZKTgfNCueoLd3IA9AokqE3nnc4\";s:10:\"created_at\";i:1790790690;}}','off'),
(386,'woocommerce_checkout_phone_field','optional','auto'),
(387,'woocommerce_checkout_company_field','hidden','auto'),
(388,'woocommerce_checkout_address_2_field','optional','auto'),
(398,'woocommerce_order_withdrawal_inbox_notification_created','yes','off'),
(407,'tienda_moda_wishlist_page_id','13','auto'),
(428,'woocommerce_task_list_tracked_completed_tasks','a:1:{i:0;s:8:\"products\";}','auto'),
(449,'WPLANG','es_CL','auto'),
(486,'product_cat_children','a:0:{}','auto'),
(613,'_transient_woocommerce_webhook_ids_status_active','a:0:{}','on'),
(614,'_transient_wc_attribute_taxonomies','a:0:{}','on'),
(615,'_transient_timeout_as-post-store-dependencies-met','1791033678','off'),
(616,'_transient_as-post-store-dependencies-met','yes','off'),
(617,'_transient_jetpack_autoloader_plugin_paths','a:1:{i:0;s:29:\"{{WP_PLUGIN_DIR}}/woocommerce\";}','on'),
(618,'_transient_doing_cron','1790947279.3505589962005615234375','on'),
(619,'_transient_timeout_woocommerce_blocks_asset_api_script_data','1793539279','off'),
(620,'_transient_woocommerce_blocks_asset_api_script_data','{\"script_data\":{\"assets\\/client\\/blocks\\/wc-settings.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-settings.js\",\"version\":\"5cdaba16c87338181b77\",\"dependencies\":[\"wc-types\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-types.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-types.js\",\"version\":\"c4b7280ca0810ce973be\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-entities.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-entities.js\",\"version\":\"bcb2165cc1d82aabfed2\",\"dependencies\":[\"wc-settings\",\"wp-core-data\",\"wp-data\",\"wp-deprecated\",\"wp-i18n\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-middleware.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-middleware.js\",\"version\":\"2c049fe250c153b7cac8\",\"dependencies\":[\"wp-api-fetch\",\"wp-polyfill\",\"wp-url\"]},\"assets\\/client\\/blocks\\/wc-blocks-data.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-data.js\",\"version\":\"afe6cbed0b2d6966962a\",\"dependencies\":[\"wc-blocks-checkout-events\",\"wc-blocks-registry\",\"wc-settings\",\"wc-types\",\"wp-api-fetch\",\"wp-data\",\"wp-data-controls\",\"wp-deprecated\",\"wp-dom\",\"wp-element\",\"wp-hooks\",\"wp-html-entities\",\"wp-i18n\",\"wp-is-shallow-equal\",\"wp-notices\",\"wp-polyfill\",\"wp-url\"]},\"assets\\/client\\/blocks\\/wc-blocks-registry.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-registry.js\",\"version\":\"8cf98119f62dbfe139c2\",\"dependencies\":[\"react-jsx-runtime\",\"wc-settings\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-shared-context.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-shared-context.js\",\"version\":\"621353d8a3a7c8d44b41\",\"dependencies\":[\"react-jsx-runtime\",\"wp-element\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-shared-hocs.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-shared-hocs.js\",\"version\":\"781196b1e16b60e862cb\",\"dependencies\":[\"react-jsx-runtime\",\"wc-blocks-data-store\",\"wc-blocks-shared-context\",\"wc-types\",\"wp-data\",\"wp-element\",\"wp-i18n\",\"wp-is-shallow-equal\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/blocks-components.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-components.js\",\"version\":\"024deac35759b91da09e\",\"dependencies\":[\"wc-cart-checkout-base\",\"wc-cart-checkout-vendors\",\"react\",\"react-dom\",\"react-jsx-runtime\",\"wc-blocks-data-store\",\"wc-sanitize\",\"wc-settings\",\"wc-types\",\"wp-a11y\",\"wp-compose\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-html-entities\",\"wp-i18n\",\"wp-notices\",\"wp-polyfill\",\"wp-primitives\"]},\"assets\\/client\\/blocks\\/wc-blocks-vendors.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-vendors.js\",\"version\":\"4d03e7985472169505ea\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks.js\",\"version\":\"96be36fcbe4ca4aab4d9\",\"dependencies\":[\"react-jsx-runtime\",\"wp-blocks\",\"wp-compose\",\"wp-dom-ready\",\"wp-element\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/price-format.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/price-format.js\",\"version\":\"0df720e448f7ab3c5d0d\",\"dependencies\":[\"wc-settings\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-frontend-vendors-frontend.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-frontend-vendors-frontend.js\",\"version\":\"680d02d748b4d3807a03\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-cart-checkout-vendors-frontend.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-cart-checkout-vendors-frontend.js\",\"version\":\"d075c6ab8086318714ff\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-cart-checkout-base-frontend.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-cart-checkout-base-frontend.js\",\"version\":\"fb0069b802d50bd5bf47\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/blocks-checkout.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-checkout.js\",\"version\":\"1082650d449aab026b31\",\"dependencies\":[\"wc-cart-checkout-base\",\"wc-cart-checkout-vendors\",\"react\",\"react-dom\",\"react-jsx-runtime\",\"wc-blocks-checkout-events\",\"wc-blocks-components\",\"wc-blocks-data-store\",\"wc-blocks-registry\",\"wc-sanitize\",\"wc-settings\",\"wc-types\",\"wp-a11y\",\"wp-compose\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-html-entities\",\"wp-i18n\",\"wp-is-shallow-equal\",\"wp-notices\",\"wp-polyfill\",\"wp-primitives\",\"wp-warning\"]},\"assets\\/client\\/blocks\\/blocks-checkout-events.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-checkout-events.js\",\"version\":\"1cd9ffa6e3cff96ad1b2\",\"dependencies\":[\"wc-types\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-schema-parser.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-schema-parser.js\",\"version\":\"63baa6fbe2326b07d735\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/admin\\/sanitize\\/index.js\":{\"src\":\"http:\\/\\/localhost:8080\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/admin\\/sanitize\\/index.js\",\"version\":\"6cc3684099bd6a5547b8\",\"dependencies\":[]}},\"version\":\"wc-11.1.2\",\"hash\":\"9df4767c28fdeb01d898cd3a743e1742\"}','off');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES
(1,2,'_wp_page_template','default'),
(2,3,'_wp_page_template','default'),
(3,6,'_wp_attached_file','woocommerce-placeholder.webp'),
(4,6,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:1200;s:6:\"height\";i:1200;s:4:\"file\";s:28:\"woocommerce-placeholder.webp\";s:8:\"filesize\";i:9892;s:5:\"sizes\";a:4:{s:6:\"medium\";a:5:{s:4:\"file\";s:36:\"woocommerce-placeholder-300x300.webp\";s:5:\"width\";i:300;s:6:\"height\";i:300;s:9:\"mime-type\";s:10:\"image/webp\";s:8:\"filesize\";i:1362;}s:5:\"large\";a:5:{s:4:\"file\";s:38:\"woocommerce-placeholder-1024x1024.webp\";s:5:\"width\";i:1024;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/webp\";s:8:\"filesize\";i:6032;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:36:\"woocommerce-placeholder-150x150.webp\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/webp\";s:8:\"filesize\";i:662;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:36:\"woocommerce-placeholder-768x768.webp\";s:5:\"width\";i:768;s:6:\"height\";i:768;s:9:\"mime-type\";s:10:\"image/webp\";s:8:\"filesize\";i:4240;}}s:10:\"image_meta\";a:13:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}s:3:\"alt\";s:0:\"\";}}'),
(83,18,'_billing_first_name','QA'),
(84,18,'_billing_last_name','Temporal'),
(85,18,'_billing_email','qa@example.invalid'),
(86,18,'_billing_phone','+56900000000'),
(87,18,'_billing_address_1','Dirección QA'),
(88,18,'_billing_city','Santiago'),
(89,18,'_billing_state','CL-RM'),
(90,18,'_billing_country','CL'),
(91,19,'_sku','MILENA-DEMO-001'),
(92,19,'total_sales','0'),
(93,19,'_tax_status','taxable'),
(94,19,'_tax_class',''),
(95,19,'_manage_stock','no'),
(96,19,'_backorders','no'),
(97,19,'_sold_individually','no'),
(98,19,'_virtual','no'),
(99,19,'_downloadable','no'),
(100,19,'_download_limit','-1'),
(101,19,'_download_expiry','-1'),
(102,19,'_stock',NULL),
(103,19,'_stock_status','instock'),
(104,19,'_wc_average_rating','0'),
(105,19,'_wc_review_count','0'),
(106,19,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(107,19,'_product_version','11.1.2'),
(108,20,'_variation_description',''),
(109,20,'_sku','MILENA-DEMO-001-S'),
(110,20,'_regular_price','34990'),
(111,20,'_sale_price','29990'),
(112,20,'total_sales','0'),
(113,20,'_tax_status','taxable'),
(114,20,'_tax_class','parent'),
(115,20,'_manage_stock','yes'),
(116,20,'_backorders','no'),
(117,20,'_sold_individually','no'),
(118,20,'_virtual','no'),
(119,20,'_downloadable','no'),
(120,20,'_download_limit','-1'),
(121,20,'_download_expiry','-1'),
(122,20,'_stock','4'),
(123,20,'_stock_status','instock'),
(124,20,'_wc_average_rating','0'),
(125,20,'_wc_review_count','0'),
(126,20,'attribute_talla','S'),
(127,20,'_price','29990'),
(128,20,'_product_version','11.1.2'),
(129,21,'_variation_description',''),
(130,21,'_sku','MILENA-DEMO-001-M'),
(131,21,'_regular_price','34990'),
(132,21,'_sale_price','29990'),
(133,21,'total_sales','0'),
(134,21,'_tax_status','taxable'),
(135,21,'_tax_class','parent'),
(136,21,'_manage_stock','yes'),
(137,21,'_backorders','no'),
(138,21,'_sold_individually','no'),
(139,21,'_virtual','no'),
(140,21,'_downloadable','no'),
(141,21,'_download_limit','-1'),
(142,21,'_download_expiry','-1'),
(143,21,'_stock','7'),
(144,21,'_stock_status','instock'),
(145,21,'_wc_average_rating','0'),
(146,21,'_wc_review_count','0'),
(147,21,'attribute_talla','M'),
(148,21,'_price','29990'),
(149,21,'_product_version','11.1.2'),
(150,22,'_variation_description',''),
(151,22,'_sku','MILENA-DEMO-001-L'),
(152,22,'_regular_price','34990'),
(153,22,'_sale_price','29990'),
(154,22,'total_sales','0'),
(155,22,'_tax_status','taxable'),
(156,22,'_tax_class','parent'),
(157,22,'_manage_stock','yes'),
(158,22,'_backorders','no'),
(159,22,'_sold_individually','no'),
(160,22,'_virtual','no'),
(161,22,'_downloadable','no'),
(162,22,'_download_limit','-1'),
(163,22,'_download_expiry','-1'),
(164,22,'_stock','10'),
(165,22,'_stock_status','instock'),
(166,22,'_wc_average_rating','0'),
(167,22,'_wc_review_count','0'),
(168,22,'attribute_talla','L'),
(169,22,'_price','29990'),
(170,22,'_product_version','11.1.2'),
(172,19,'_milena_demo_product','1'),
(173,23,'_sku','MILENA-DEMO-002'),
(174,23,'_regular_price','42990'),
(175,23,'total_sales','0'),
(176,23,'_tax_status','taxable'),
(177,23,'_tax_class',''),
(178,23,'_manage_stock','yes'),
(179,23,'_backorders','no'),
(180,23,'_sold_individually','no'),
(181,23,'_virtual','no'),
(182,23,'_downloadable','no'),
(183,23,'_download_limit','-1'),
(184,23,'_download_expiry','-1'),
(185,23,'_stock','6'),
(186,23,'_stock_status','instock'),
(187,23,'_wc_average_rating','0'),
(188,23,'_wc_review_count','0'),
(189,23,'_product_version','11.1.2'),
(190,23,'_price','42990'),
(191,23,'_milena_demo_product','1'),
(192,24,'_sku','MILENA-DEMO-003'),
(193,24,'total_sales','0'),
(194,24,'_tax_status','taxable'),
(195,24,'_tax_class',''),
(196,24,'_manage_stock','no'),
(197,24,'_backorders','no'),
(198,24,'_sold_individually','no'),
(199,24,'_virtual','no'),
(200,24,'_downloadable','no'),
(201,24,'_download_limit','-1'),
(202,24,'_download_expiry','-1'),
(203,24,'_stock',NULL),
(204,24,'_stock_status','instock'),
(205,24,'_wc_average_rating','0'),
(206,24,'_wc_review_count','0'),
(207,24,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(208,24,'_product_version','11.1.2'),
(209,25,'_variation_description',''),
(210,25,'_sku','MILENA-DEMO-003-S'),
(211,25,'_regular_price','38990'),
(212,25,'total_sales','0'),
(213,25,'_tax_status','taxable'),
(214,25,'_tax_class','parent'),
(215,25,'_manage_stock','yes'),
(216,25,'_backorders','no'),
(217,25,'_sold_individually','no'),
(218,25,'_virtual','no'),
(219,25,'_downloadable','no'),
(220,25,'_download_limit','-1'),
(221,25,'_download_expiry','-1'),
(222,25,'_stock','4'),
(223,25,'_stock_status','instock'),
(224,25,'_wc_average_rating','0'),
(225,25,'_wc_review_count','0'),
(226,25,'attribute_talla','S'),
(227,25,'_price','38990'),
(228,25,'_product_version','11.1.2'),
(229,26,'_variation_description',''),
(230,26,'_sku','MILENA-DEMO-003-M'),
(231,26,'_regular_price','38990'),
(232,26,'total_sales','0'),
(233,26,'_tax_status','taxable'),
(234,26,'_tax_class','parent'),
(235,26,'_manage_stock','yes'),
(236,26,'_backorders','no'),
(237,26,'_sold_individually','no'),
(238,26,'_virtual','no'),
(239,26,'_downloadable','no'),
(240,26,'_download_limit','-1'),
(241,26,'_download_expiry','-1'),
(242,26,'_stock','7'),
(243,26,'_stock_status','instock'),
(244,26,'_wc_average_rating','0'),
(245,26,'_wc_review_count','0'),
(246,26,'attribute_talla','M'),
(247,26,'_price','38990'),
(248,26,'_product_version','11.1.2'),
(249,27,'_variation_description',''),
(250,27,'_sku','MILENA-DEMO-003-L'),
(251,27,'_regular_price','38990'),
(252,27,'total_sales','0'),
(253,27,'_tax_status','taxable'),
(254,27,'_tax_class','parent'),
(255,27,'_manage_stock','yes'),
(256,27,'_backorders','no'),
(257,27,'_sold_individually','no'),
(258,27,'_virtual','no'),
(259,27,'_downloadable','no'),
(260,27,'_download_limit','-1'),
(261,27,'_download_expiry','-1'),
(262,27,'_stock','10'),
(263,27,'_stock_status','instock'),
(264,27,'_wc_average_rating','0'),
(265,27,'_wc_review_count','0'),
(266,27,'attribute_talla','L'),
(267,27,'_price','38990'),
(268,27,'_product_version','11.1.2'),
(270,24,'_milena_demo_product','1'),
(271,28,'_sku','MILENA-DEMO-004'),
(272,28,'_regular_price','47990'),
(273,28,'total_sales','0'),
(274,28,'_tax_status','taxable'),
(275,28,'_tax_class',''),
(276,28,'_manage_stock','yes'),
(277,28,'_backorders','no'),
(278,28,'_sold_individually','no'),
(279,28,'_virtual','no'),
(280,28,'_downloadable','no'),
(281,28,'_download_limit','-1'),
(282,28,'_download_expiry','-1'),
(283,28,'_stock','8'),
(284,28,'_stock_status','instock'),
(285,28,'_wc_average_rating','0'),
(286,28,'_wc_review_count','0'),
(287,28,'_product_version','11.1.2'),
(288,28,'_price','47990'),
(289,28,'_milena_demo_product','1'),
(290,29,'_sku','MILENA-DEMO-005'),
(291,29,'_regular_price','36990'),
(292,29,'total_sales','0'),
(293,29,'_tax_status','taxable'),
(294,29,'_tax_class',''),
(295,29,'_manage_stock','yes'),
(296,29,'_backorders','no'),
(297,29,'_sold_individually','no'),
(298,29,'_virtual','no'),
(299,29,'_downloadable','no'),
(300,29,'_download_limit','-1'),
(301,29,'_download_expiry','-1'),
(302,29,'_stock','9'),
(303,29,'_stock_status','instock'),
(304,29,'_wc_average_rating','0'),
(305,29,'_wc_review_count','0'),
(306,29,'_product_version','11.1.2'),
(307,29,'_price','36990'),
(308,29,'_milena_demo_product','1'),
(309,30,'_sku','MILENA-DEMO-006'),
(310,30,'_regular_price','44990'),
(311,30,'_sale_price','39990'),
(312,30,'total_sales','0'),
(313,30,'_tax_status','taxable'),
(314,30,'_tax_class',''),
(315,30,'_manage_stock','yes'),
(316,30,'_backorders','no'),
(317,30,'_sold_individually','no'),
(318,30,'_virtual','no'),
(319,30,'_downloadable','no'),
(320,30,'_download_limit','-1'),
(321,30,'_download_expiry','-1'),
(322,30,'_stock','10'),
(323,30,'_stock_status','instock'),
(324,30,'_wc_average_rating','0'),
(325,30,'_wc_review_count','0'),
(326,30,'_product_version','11.1.2'),
(327,30,'_price','39990'),
(328,30,'_milena_demo_product','1'),
(329,31,'_sku','MILENA-DEMO-007'),
(330,31,'_regular_price','39990'),
(331,31,'total_sales','0'),
(332,31,'_tax_status','taxable'),
(333,31,'_tax_class',''),
(334,31,'_manage_stock','yes'),
(335,31,'_backorders','no'),
(336,31,'_sold_individually','no'),
(337,31,'_virtual','no'),
(338,31,'_downloadable','no'),
(339,31,'_download_limit','-1'),
(340,31,'_download_expiry','-1'),
(341,31,'_stock','11'),
(342,31,'_stock_status','instock'),
(343,31,'_wc_average_rating','0'),
(344,31,'_wc_review_count','0'),
(345,31,'_product_version','11.1.2'),
(346,31,'_price','39990'),
(347,31,'_milena_demo_product','1'),
(348,32,'_sku','MILENA-DEMO-008'),
(349,32,'_regular_price','32990'),
(350,32,'total_sales','0'),
(351,32,'_tax_status','taxable'),
(352,32,'_tax_class',''),
(353,32,'_manage_stock','yes'),
(354,32,'_backorders','no'),
(355,32,'_sold_individually','no'),
(356,32,'_virtual','no'),
(357,32,'_downloadable','no'),
(358,32,'_download_limit','-1'),
(359,32,'_download_expiry','-1'),
(360,32,'_stock','12'),
(361,32,'_stock_status','instock'),
(362,32,'_wc_average_rating','0'),
(363,32,'_wc_review_count','0'),
(364,32,'_product_version','11.1.2'),
(365,32,'_price','32990'),
(366,32,'_milena_demo_product','1'),
(367,33,'_sku','MILENA-DEMO-009'),
(368,33,'total_sales','0'),
(369,33,'_tax_status','taxable'),
(370,33,'_tax_class',''),
(371,33,'_manage_stock','no'),
(372,33,'_backorders','no'),
(373,33,'_sold_individually','no'),
(374,33,'_virtual','no'),
(375,33,'_downloadable','no'),
(376,33,'_download_limit','-1'),
(377,33,'_download_expiry','-1'),
(378,33,'_stock',NULL),
(379,33,'_stock_status','instock'),
(380,33,'_wc_average_rating','0'),
(381,33,'_wc_review_count','0'),
(382,33,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(383,33,'_product_version','11.1.2'),
(384,34,'_variation_description',''),
(385,34,'_sku','MILENA-DEMO-009-S'),
(386,34,'_regular_price','24990'),
(387,34,'total_sales','0'),
(388,34,'_tax_status','taxable'),
(389,34,'_tax_class','parent'),
(390,34,'_manage_stock','yes'),
(391,34,'_backorders','no'),
(392,34,'_sold_individually','no'),
(393,34,'_virtual','no'),
(394,34,'_downloadable','no'),
(395,34,'_download_limit','-1'),
(396,34,'_download_expiry','-1'),
(397,34,'_stock','4'),
(398,34,'_stock_status','instock'),
(399,34,'_wc_average_rating','0'),
(400,34,'_wc_review_count','0'),
(401,34,'attribute_talla','S'),
(402,34,'_price','24990'),
(403,34,'_product_version','11.1.2'),
(404,35,'_variation_description',''),
(405,35,'_sku','MILENA-DEMO-009-M'),
(406,35,'_regular_price','24990'),
(407,35,'total_sales','0'),
(408,35,'_tax_status','taxable'),
(409,35,'_tax_class','parent'),
(410,35,'_manage_stock','yes'),
(411,35,'_backorders','no'),
(412,35,'_sold_individually','no'),
(413,35,'_virtual','no'),
(414,35,'_downloadable','no'),
(415,35,'_download_limit','-1'),
(416,35,'_download_expiry','-1'),
(417,35,'_stock','7'),
(418,35,'_stock_status','instock'),
(419,35,'_wc_average_rating','0'),
(420,35,'_wc_review_count','0'),
(421,35,'attribute_talla','M'),
(422,35,'_price','24990'),
(423,35,'_product_version','11.1.2'),
(424,36,'_variation_description',''),
(425,36,'_sku','MILENA-DEMO-009-L'),
(426,36,'_regular_price','24990'),
(427,36,'total_sales','0'),
(428,36,'_tax_status','taxable'),
(429,36,'_tax_class','parent'),
(430,36,'_manage_stock','yes'),
(431,36,'_backorders','no'),
(432,36,'_sold_individually','no'),
(433,36,'_virtual','no'),
(434,36,'_downloadable','no'),
(435,36,'_download_limit','-1'),
(436,36,'_download_expiry','-1'),
(437,36,'_stock','10'),
(438,36,'_stock_status','instock'),
(439,36,'_wc_average_rating','0'),
(440,36,'_wc_review_count','0'),
(441,36,'attribute_talla','L'),
(442,36,'_price','24990'),
(443,36,'_product_version','11.1.2'),
(445,33,'_milena_demo_product','1'),
(446,37,'_sku','MILENA-DEMO-010'),
(447,37,'_regular_price','29990'),
(448,37,'total_sales','0'),
(449,37,'_tax_status','taxable'),
(450,37,'_tax_class',''),
(451,37,'_manage_stock','yes'),
(452,37,'_backorders','no'),
(453,37,'_sold_individually','no'),
(454,37,'_virtual','no'),
(455,37,'_downloadable','no'),
(456,37,'_download_limit','-1'),
(457,37,'_download_expiry','-1'),
(458,37,'_stock','14'),
(459,37,'_stock_status','instock'),
(460,37,'_wc_average_rating','0'),
(461,37,'_wc_review_count','0'),
(462,37,'_product_version','11.1.2'),
(463,37,'_price','29990'),
(464,37,'_milena_demo_product','1'),
(465,38,'_sku','MILENA-DEMO-011'),
(466,38,'_regular_price','16990'),
(467,38,'_sale_price','11990'),
(468,38,'total_sales','0'),
(469,38,'_tax_status','taxable'),
(470,38,'_tax_class',''),
(471,38,'_manage_stock','yes'),
(472,38,'_backorders','no'),
(473,38,'_sold_individually','no'),
(474,38,'_virtual','no'),
(475,38,'_downloadable','no'),
(476,38,'_download_limit','-1'),
(477,38,'_download_expiry','-1'),
(478,38,'_stock','15'),
(479,38,'_stock_status','instock'),
(480,38,'_wc_average_rating','0'),
(481,38,'_wc_review_count','0'),
(482,38,'_product_version','11.1.2'),
(483,38,'_price','11990'),
(484,38,'_milena_demo_product','1'),
(485,39,'_sku','MILENA-DEMO-012'),
(486,39,'_regular_price','18990'),
(487,39,'total_sales','0'),
(488,39,'_tax_status','taxable'),
(489,39,'_tax_class',''),
(490,39,'_manage_stock','yes'),
(491,39,'_backorders','no'),
(492,39,'_sold_individually','no'),
(493,39,'_virtual','no'),
(494,39,'_downloadable','no'),
(495,39,'_download_limit','-1'),
(496,39,'_download_expiry','-1'),
(497,39,'_stock','16'),
(498,39,'_stock_status','instock'),
(499,39,'_wc_average_rating','0'),
(500,39,'_wc_review_count','0'),
(501,39,'_product_version','11.1.2'),
(502,39,'_price','18990'),
(503,39,'_milena_demo_product','1'),
(504,40,'_sku','MILENA-DEMO-013'),
(505,40,'_regular_price','21990'),
(506,40,'total_sales','0'),
(507,40,'_tax_status','taxable'),
(508,40,'_tax_class',''),
(509,40,'_manage_stock','yes'),
(510,40,'_backorders','no'),
(511,40,'_sold_individually','no'),
(512,40,'_virtual','no'),
(513,40,'_downloadable','no'),
(514,40,'_download_limit','-1'),
(515,40,'_download_expiry','-1'),
(516,40,'_stock','5'),
(517,40,'_stock_status','instock'),
(518,40,'_wc_average_rating','0'),
(519,40,'_wc_review_count','0'),
(520,40,'_product_version','11.1.2'),
(521,40,'_price','21990'),
(522,40,'_milena_demo_product','1'),
(523,41,'_sku','MILENA-DEMO-014'),
(524,41,'_regular_price','32990'),
(525,41,'total_sales','0'),
(526,41,'_tax_status','taxable'),
(527,41,'_tax_class',''),
(528,41,'_manage_stock','yes'),
(529,41,'_backorders','no'),
(530,41,'_sold_individually','no'),
(531,41,'_virtual','no'),
(532,41,'_downloadable','no'),
(533,41,'_download_limit','-1'),
(534,41,'_download_expiry','-1'),
(535,41,'_stock','6'),
(536,41,'_stock_status','instock'),
(537,41,'_wc_average_rating','0'),
(538,41,'_wc_review_count','0'),
(539,41,'_product_version','11.1.2'),
(540,41,'_price','32990'),
(541,41,'_milena_demo_product','1'),
(542,42,'_sku','MILENA-DEMO-015'),
(543,42,'_regular_price','28990'),
(544,42,'total_sales','0'),
(545,42,'_tax_status','taxable'),
(546,42,'_tax_class',''),
(547,42,'_manage_stock','yes'),
(548,42,'_backorders','no'),
(549,42,'_sold_individually','no'),
(550,42,'_virtual','no'),
(551,42,'_downloadable','no'),
(552,42,'_download_limit','-1'),
(553,42,'_download_expiry','-1'),
(554,42,'_stock','7'),
(555,42,'_stock_status','instock'),
(556,42,'_wc_average_rating','0'),
(557,42,'_wc_review_count','0'),
(558,42,'_product_version','11.1.2'),
(559,42,'_price','28990'),
(560,42,'_milena_demo_product','1'),
(561,43,'_sku','MILENA-DEMO-016'),
(562,43,'_regular_price','25990'),
(563,43,'_sale_price','20990'),
(564,43,'total_sales','0'),
(565,43,'_tax_status','taxable'),
(566,43,'_tax_class',''),
(567,43,'_manage_stock','yes'),
(568,43,'_backorders','no'),
(569,43,'_sold_individually','no'),
(570,43,'_virtual','no'),
(571,43,'_downloadable','no'),
(572,43,'_download_limit','-1'),
(573,43,'_download_expiry','-1'),
(574,43,'_stock','8'),
(575,43,'_stock_status','instock'),
(576,43,'_wc_average_rating','0'),
(577,43,'_wc_review_count','0'),
(578,43,'_product_version','11.1.2'),
(579,43,'_price','20990'),
(580,43,'_milena_demo_product','1'),
(581,44,'_sku','MILENA-DEMO-017'),
(582,44,'total_sales','0'),
(583,44,'_tax_status','taxable'),
(584,44,'_tax_class',''),
(585,44,'_manage_stock','no'),
(586,44,'_backorders','no'),
(587,44,'_sold_individually','no'),
(588,44,'_virtual','no'),
(589,44,'_downloadable','no'),
(590,44,'_download_limit','-1'),
(591,44,'_download_expiry','-1'),
(592,44,'_stock',NULL),
(593,44,'_stock_status','instock'),
(594,44,'_wc_average_rating','0'),
(595,44,'_wc_review_count','0'),
(596,44,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(597,44,'_product_version','11.1.2'),
(598,45,'_variation_description',''),
(599,45,'_sku','MILENA-DEMO-017-S'),
(600,45,'_regular_price','39990'),
(601,45,'total_sales','0'),
(602,45,'_tax_status','taxable'),
(603,45,'_tax_class','parent'),
(604,45,'_manage_stock','yes'),
(605,45,'_backorders','no'),
(606,45,'_sold_individually','no'),
(607,45,'_virtual','no'),
(608,45,'_downloadable','no'),
(609,45,'_download_limit','-1'),
(610,45,'_download_expiry','-1'),
(611,45,'_stock','4'),
(612,45,'_stock_status','instock'),
(613,45,'_wc_average_rating','0'),
(614,45,'_wc_review_count','0'),
(615,45,'attribute_talla','S'),
(616,45,'_price','39990'),
(617,45,'_product_version','11.1.2'),
(618,46,'_variation_description',''),
(619,46,'_sku','MILENA-DEMO-017-M'),
(620,46,'_regular_price','39990'),
(621,46,'total_sales','0'),
(622,46,'_tax_status','taxable'),
(623,46,'_tax_class','parent'),
(624,46,'_manage_stock','yes'),
(625,46,'_backorders','no'),
(626,46,'_sold_individually','no'),
(627,46,'_virtual','no'),
(628,46,'_downloadable','no'),
(629,46,'_download_limit','-1'),
(630,46,'_download_expiry','-1'),
(631,46,'_stock','7'),
(632,46,'_stock_status','instock'),
(633,46,'_wc_average_rating','0'),
(634,46,'_wc_review_count','0'),
(635,46,'attribute_talla','M'),
(636,46,'_price','39990'),
(637,46,'_product_version','11.1.2'),
(638,47,'_variation_description',''),
(639,47,'_sku','MILENA-DEMO-017-L'),
(640,47,'_regular_price','39990'),
(641,47,'total_sales','0'),
(642,47,'_tax_status','taxable'),
(643,47,'_tax_class','parent'),
(644,47,'_manage_stock','yes'),
(645,47,'_backorders','no'),
(646,47,'_sold_individually','no'),
(647,47,'_virtual','no'),
(648,47,'_downloadable','no'),
(649,47,'_download_limit','-1'),
(650,47,'_download_expiry','-1'),
(651,47,'_stock','10'),
(652,47,'_stock_status','instock'),
(653,47,'_wc_average_rating','0'),
(654,47,'_wc_review_count','0'),
(655,47,'attribute_talla','L'),
(656,47,'_price','39990'),
(657,47,'_product_version','11.1.2'),
(659,44,'_milena_demo_product','1'),
(660,48,'_sku','MILENA-DEMO-018'),
(661,48,'total_sales','0'),
(662,48,'_tax_status','taxable'),
(663,48,'_tax_class',''),
(664,48,'_manage_stock','no'),
(665,48,'_backorders','no'),
(666,48,'_sold_individually','no'),
(667,48,'_virtual','no'),
(668,48,'_downloadable','no'),
(669,48,'_download_limit','-1'),
(670,48,'_download_expiry','-1'),
(671,48,'_stock',NULL),
(672,48,'_stock_status','instock'),
(673,48,'_wc_average_rating','0'),
(674,48,'_wc_review_count','0'),
(675,48,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(676,48,'_product_version','11.1.2'),
(677,49,'_variation_description',''),
(678,49,'_sku','MILENA-DEMO-018-S'),
(679,49,'_regular_price','44990'),
(680,49,'total_sales','0'),
(681,49,'_tax_status','taxable'),
(682,49,'_tax_class','parent'),
(683,49,'_manage_stock','yes'),
(684,49,'_backorders','no'),
(685,49,'_sold_individually','no'),
(686,49,'_virtual','no'),
(687,49,'_downloadable','no'),
(688,49,'_download_limit','-1'),
(689,49,'_download_expiry','-1'),
(690,49,'_stock','4'),
(691,49,'_stock_status','instock'),
(692,49,'_wc_average_rating','0'),
(693,49,'_wc_review_count','0'),
(694,49,'attribute_talla','S'),
(695,49,'_price','44990'),
(696,49,'_product_version','11.1.2'),
(697,50,'_variation_description',''),
(698,50,'_sku','MILENA-DEMO-018-M'),
(699,50,'_regular_price','44990'),
(700,50,'total_sales','0'),
(701,50,'_tax_status','taxable'),
(702,50,'_tax_class','parent'),
(703,50,'_manage_stock','yes'),
(704,50,'_backorders','no'),
(705,50,'_sold_individually','no'),
(706,50,'_virtual','no'),
(707,50,'_downloadable','no'),
(708,50,'_download_limit','-1'),
(709,50,'_download_expiry','-1'),
(710,50,'_stock','7'),
(711,50,'_stock_status','instock'),
(712,50,'_wc_average_rating','0'),
(713,50,'_wc_review_count','0'),
(714,50,'attribute_talla','M'),
(715,50,'_price','44990'),
(716,50,'_product_version','11.1.2'),
(717,51,'_variation_description',''),
(718,51,'_sku','MILENA-DEMO-018-L'),
(719,51,'_regular_price','44990'),
(720,51,'total_sales','0'),
(721,51,'_tax_status','taxable'),
(722,51,'_tax_class','parent'),
(723,51,'_manage_stock','yes'),
(724,51,'_backorders','no'),
(725,51,'_sold_individually','no'),
(726,51,'_virtual','no'),
(727,51,'_downloadable','no'),
(728,51,'_download_limit','-1'),
(729,51,'_download_expiry','-1'),
(730,51,'_stock','10'),
(731,51,'_stock_status','instock'),
(732,51,'_wc_average_rating','0'),
(733,51,'_wc_review_count','0'),
(734,51,'attribute_talla','L'),
(735,51,'_price','44990'),
(736,51,'_product_version','11.1.2'),
(738,48,'_milena_demo_product','1'),
(739,52,'_sku','MILENA-DEMO-019'),
(740,52,'_regular_price','37990'),
(741,52,'total_sales','0'),
(742,52,'_tax_status','taxable'),
(743,52,'_tax_class',''),
(744,52,'_manage_stock','yes'),
(745,52,'_backorders','no'),
(746,52,'_sold_individually','no'),
(747,52,'_virtual','no'),
(748,52,'_downloadable','no'),
(749,52,'_download_limit','-1'),
(750,52,'_download_expiry','-1'),
(751,52,'_stock','11'),
(752,52,'_stock_status','instock'),
(753,52,'_wc_average_rating','0'),
(754,52,'_wc_review_count','0'),
(755,52,'_product_version','11.1.2'),
(756,52,'_price','37990'),
(757,52,'_milena_demo_product','1'),
(758,53,'_sku','MILENA-DEMO-020'),
(759,53,'_regular_price','42990'),
(760,53,'total_sales','0'),
(761,53,'_tax_status','taxable'),
(762,53,'_tax_class',''),
(763,53,'_manage_stock','yes'),
(764,53,'_backorders','no'),
(765,53,'_sold_individually','no'),
(766,53,'_virtual','no'),
(767,53,'_downloadable','no'),
(768,53,'_download_limit','-1'),
(769,53,'_download_expiry','-1'),
(770,53,'_stock','12'),
(771,53,'_stock_status','instock'),
(772,53,'_wc_average_rating','0'),
(773,53,'_wc_review_count','0'),
(774,53,'_product_version','11.1.2'),
(775,53,'_price','42990'),
(776,53,'_milena_demo_product','1'),
(777,54,'_sku','MILENA-DEMO-021'),
(778,54,'_regular_price','41990'),
(779,54,'_sale_price','36990'),
(780,54,'total_sales','0'),
(781,54,'_tax_status','taxable'),
(782,54,'_tax_class',''),
(783,54,'_manage_stock','yes'),
(784,54,'_backorders','no'),
(785,54,'_sold_individually','no'),
(786,54,'_virtual','no'),
(787,54,'_downloadable','no'),
(788,54,'_download_limit','-1'),
(789,54,'_download_expiry','-1'),
(790,54,'_stock','13'),
(791,54,'_stock_status','instock'),
(792,54,'_wc_average_rating','0'),
(793,54,'_wc_review_count','0'),
(794,54,'_product_version','11.1.2'),
(795,54,'_price','36990'),
(796,54,'_milena_demo_product','1'),
(797,55,'_sku','MILENA-DEMO-022'),
(798,55,'_regular_price','22990'),
(799,55,'total_sales','0'),
(800,55,'_tax_status','taxable'),
(801,55,'_tax_class',''),
(802,55,'_manage_stock','yes'),
(803,55,'_backorders','no'),
(804,55,'_sold_individually','no'),
(805,55,'_virtual','no'),
(806,55,'_downloadable','no'),
(807,55,'_download_limit','-1'),
(808,55,'_download_expiry','-1'),
(809,55,'_stock','14'),
(810,55,'_stock_status','instock'),
(811,55,'_wc_average_rating','0'),
(812,55,'_wc_review_count','0'),
(813,55,'_product_version','11.1.2'),
(814,55,'_price','22990'),
(815,55,'_milena_demo_product','1'),
(816,56,'_sku','MILENA-DEMO-023'),
(817,56,'total_sales','0'),
(818,56,'_tax_status','taxable'),
(819,56,'_tax_class',''),
(820,56,'_manage_stock','no'),
(821,56,'_backorders','no'),
(822,56,'_sold_individually','no'),
(823,56,'_virtual','no'),
(824,56,'_downloadable','no'),
(825,56,'_download_limit','-1'),
(826,56,'_download_expiry','-1'),
(827,56,'_stock',NULL),
(828,56,'_stock_status','instock'),
(829,56,'_wc_average_rating','0'),
(830,56,'_wc_review_count','0'),
(831,56,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(832,56,'_product_version','11.1.2'),
(833,57,'_variation_description',''),
(834,57,'_sku','MILENA-DEMO-023-S'),
(835,57,'_regular_price','32990'),
(836,57,'total_sales','0'),
(837,57,'_tax_status','taxable'),
(838,57,'_tax_class','parent'),
(839,57,'_manage_stock','yes'),
(840,57,'_backorders','no'),
(841,57,'_sold_individually','no'),
(842,57,'_virtual','no'),
(843,57,'_downloadable','no'),
(844,57,'_download_limit','-1'),
(845,57,'_download_expiry','-1'),
(846,57,'_stock','4'),
(847,57,'_stock_status','instock'),
(848,57,'_wc_average_rating','0'),
(849,57,'_wc_review_count','0'),
(850,57,'attribute_talla','S'),
(851,57,'_price','32990'),
(852,57,'_product_version','11.1.2'),
(853,58,'_variation_description',''),
(854,58,'_sku','MILENA-DEMO-023-M'),
(855,58,'_regular_price','32990'),
(856,58,'total_sales','0'),
(857,58,'_tax_status','taxable'),
(858,58,'_tax_class','parent'),
(859,58,'_manage_stock','yes'),
(860,58,'_backorders','no'),
(861,58,'_sold_individually','no'),
(862,58,'_virtual','no'),
(863,58,'_downloadable','no'),
(864,58,'_download_limit','-1'),
(865,58,'_download_expiry','-1'),
(866,58,'_stock','7'),
(867,58,'_stock_status','instock'),
(868,58,'_wc_average_rating','0'),
(869,58,'_wc_review_count','0'),
(870,58,'attribute_talla','M'),
(871,58,'_price','32990'),
(872,58,'_product_version','11.1.2'),
(873,59,'_variation_description',''),
(874,59,'_sku','MILENA-DEMO-023-L'),
(875,59,'_regular_price','32990'),
(876,59,'total_sales','0'),
(877,59,'_tax_status','taxable'),
(878,59,'_tax_class','parent'),
(879,59,'_manage_stock','yes'),
(880,59,'_backorders','no'),
(881,59,'_sold_individually','no'),
(882,59,'_virtual','no'),
(883,59,'_downloadable','no'),
(884,59,'_download_limit','-1'),
(885,59,'_download_expiry','-1'),
(886,59,'_stock','10'),
(887,59,'_stock_status','instock'),
(888,59,'_wc_average_rating','0'),
(889,59,'_wc_review_count','0'),
(890,59,'attribute_talla','L'),
(891,59,'_price','32990'),
(892,59,'_product_version','11.1.2'),
(894,56,'_milena_demo_product','1'),
(895,60,'_sku','MILENA-DEMO-024'),
(896,60,'_regular_price','35990'),
(897,60,'total_sales','0'),
(898,60,'_tax_status','taxable'),
(899,60,'_tax_class',''),
(900,60,'_manage_stock','yes'),
(901,60,'_backorders','no'),
(902,60,'_sold_individually','no'),
(903,60,'_virtual','no'),
(904,60,'_downloadable','no'),
(905,60,'_download_limit','-1'),
(906,60,'_download_expiry','-1'),
(907,60,'_stock','16'),
(908,60,'_stock_status','instock'),
(909,60,'_wc_average_rating','0'),
(910,60,'_wc_review_count','0'),
(911,60,'_product_version','11.1.2'),
(912,60,'_price','35990'),
(913,60,'_milena_demo_product','1'),
(914,61,'_sku','MILENA-DEMO-025'),
(915,61,'_regular_price','29990'),
(916,61,'total_sales','0'),
(917,61,'_tax_status','taxable'),
(918,61,'_tax_class',''),
(919,61,'_manage_stock','yes'),
(920,61,'_backorders','no'),
(921,61,'_sold_individually','no'),
(922,61,'_virtual','no'),
(923,61,'_downloadable','no'),
(924,61,'_download_limit','-1'),
(925,61,'_download_expiry','-1'),
(926,61,'_stock','5'),
(927,61,'_stock_status','instock'),
(928,61,'_wc_average_rating','0'),
(929,61,'_wc_review_count','0'),
(930,61,'_product_version','11.1.2'),
(931,61,'_price','29990'),
(932,61,'_milena_demo_product','1'),
(933,62,'_sku','MILENA-DEMO-026'),
(934,62,'_regular_price','34990'),
(935,62,'_sale_price','29990'),
(936,62,'total_sales','0'),
(937,62,'_tax_status','taxable'),
(938,62,'_tax_class',''),
(939,62,'_manage_stock','yes'),
(940,62,'_backorders','no'),
(941,62,'_sold_individually','no'),
(942,62,'_virtual','no'),
(943,62,'_downloadable','no'),
(944,62,'_download_limit','-1'),
(945,62,'_download_expiry','-1'),
(946,62,'_stock','6'),
(947,62,'_stock_status','instock'),
(948,62,'_wc_average_rating','0'),
(949,62,'_wc_review_count','0'),
(950,62,'_product_version','11.1.2'),
(951,62,'_price','29990'),
(952,62,'_milena_demo_product','1'),
(953,63,'_sku','MILENA-DEMO-027'),
(954,63,'_regular_price','54990'),
(955,63,'total_sales','0'),
(956,63,'_tax_status','taxable'),
(957,63,'_tax_class',''),
(958,63,'_manage_stock','yes'),
(959,63,'_backorders','no'),
(960,63,'_sold_individually','no'),
(961,63,'_virtual','no'),
(962,63,'_downloadable','no'),
(963,63,'_download_limit','-1'),
(964,63,'_download_expiry','-1'),
(965,63,'_stock','7'),
(966,63,'_stock_status','instock'),
(967,63,'_wc_average_rating','0'),
(968,63,'_wc_review_count','0'),
(969,63,'_product_version','11.1.2'),
(970,63,'_price','54990'),
(971,63,'_milena_demo_product','1'),
(972,64,'_sku','MILENA-DEMO-028'),
(973,64,'total_sales','0'),
(974,64,'_tax_status','taxable'),
(975,64,'_tax_class',''),
(976,64,'_manage_stock','no'),
(977,64,'_backorders','no'),
(978,64,'_sold_individually','no'),
(979,64,'_virtual','no'),
(980,64,'_downloadable','no'),
(981,64,'_download_limit','-1'),
(982,64,'_download_expiry','-1'),
(983,64,'_stock',NULL),
(984,64,'_stock_status','instock'),
(985,64,'_wc_average_rating','0'),
(986,64,'_wc_review_count','0'),
(987,64,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(988,64,'_product_version','11.1.2'),
(989,65,'_variation_description',''),
(990,65,'_sku','MILENA-DEMO-028-S'),
(991,65,'_regular_price','59990'),
(992,65,'total_sales','0'),
(993,65,'_tax_status','taxable'),
(994,65,'_tax_class','parent'),
(995,65,'_manage_stock','yes'),
(996,65,'_backorders','no'),
(997,65,'_sold_individually','no'),
(998,65,'_virtual','no'),
(999,65,'_downloadable','no'),
(1000,65,'_download_limit','-1'),
(1001,65,'_download_expiry','-1'),
(1002,65,'_stock','4'),
(1003,65,'_stock_status','instock'),
(1004,65,'_wc_average_rating','0'),
(1005,65,'_wc_review_count','0'),
(1006,65,'attribute_talla','S'),
(1007,65,'_price','59990'),
(1008,65,'_product_version','11.1.2'),
(1009,66,'_variation_description',''),
(1010,66,'_sku','MILENA-DEMO-028-M'),
(1011,66,'_regular_price','59990'),
(1012,66,'total_sales','0'),
(1013,66,'_tax_status','taxable'),
(1014,66,'_tax_class','parent'),
(1015,66,'_manage_stock','yes'),
(1016,66,'_backorders','no'),
(1017,66,'_sold_individually','no'),
(1018,66,'_virtual','no'),
(1019,66,'_downloadable','no'),
(1020,66,'_download_limit','-1'),
(1021,66,'_download_expiry','-1'),
(1022,66,'_stock','7'),
(1023,66,'_stock_status','instock'),
(1024,66,'_wc_average_rating','0'),
(1025,66,'_wc_review_count','0'),
(1026,66,'attribute_talla','M'),
(1027,66,'_price','59990'),
(1028,66,'_product_version','11.1.2'),
(1029,67,'_variation_description',''),
(1030,67,'_sku','MILENA-DEMO-028-L'),
(1031,67,'_regular_price','59990'),
(1032,67,'total_sales','0'),
(1033,67,'_tax_status','taxable'),
(1034,67,'_tax_class','parent'),
(1035,67,'_manage_stock','yes'),
(1036,67,'_backorders','no'),
(1037,67,'_sold_individually','no'),
(1038,67,'_virtual','no'),
(1039,67,'_downloadable','no'),
(1040,67,'_download_limit','-1'),
(1041,67,'_download_expiry','-1'),
(1042,67,'_stock','10'),
(1043,67,'_stock_status','instock'),
(1044,67,'_wc_average_rating','0'),
(1045,67,'_wc_review_count','0'),
(1046,67,'attribute_talla','L'),
(1047,67,'_price','59990'),
(1048,67,'_product_version','11.1.2'),
(1050,64,'_milena_demo_product','1'),
(1051,68,'_sku','MILENA-DEMO-029'),
(1052,68,'_regular_price','79990'),
(1053,68,'total_sales','0'),
(1054,68,'_tax_status','taxable'),
(1055,68,'_tax_class',''),
(1056,68,'_manage_stock','yes'),
(1057,68,'_backorders','no'),
(1058,68,'_sold_individually','no'),
(1059,68,'_virtual','no'),
(1060,68,'_downloadable','no'),
(1061,68,'_download_limit','-1'),
(1062,68,'_download_expiry','-1'),
(1063,68,'_stock','9'),
(1064,68,'_stock_status','instock'),
(1065,68,'_wc_average_rating','0'),
(1066,68,'_wc_review_count','0'),
(1067,68,'_product_version','11.1.2'),
(1068,68,'_price','79990'),
(1069,68,'_milena_demo_product','1'),
(1070,69,'_sku','MILENA-DEMO-030'),
(1071,69,'_regular_price','69990'),
(1072,69,'total_sales','0'),
(1073,69,'_tax_status','taxable'),
(1074,69,'_tax_class',''),
(1075,69,'_manage_stock','yes'),
(1076,69,'_backorders','no'),
(1077,69,'_sold_individually','no'),
(1078,69,'_virtual','no'),
(1079,69,'_downloadable','no'),
(1080,69,'_download_limit','-1'),
(1081,69,'_download_expiry','-1'),
(1082,69,'_stock','10'),
(1083,69,'_stock_status','instock'),
(1084,69,'_wc_average_rating','0'),
(1085,69,'_wc_review_count','0'),
(1086,69,'_product_version','11.1.2'),
(1087,69,'_price','69990'),
(1088,69,'_milena_demo_product','1'),
(1089,70,'_sku','MILENA-DEMO-031'),
(1090,70,'_regular_price','38990'),
(1091,70,'_sale_price','33990'),
(1092,70,'total_sales','0'),
(1093,70,'_tax_status','taxable'),
(1094,70,'_tax_class',''),
(1095,70,'_manage_stock','yes'),
(1096,70,'_backorders','no'),
(1097,70,'_sold_individually','no'),
(1098,70,'_virtual','no'),
(1099,70,'_downloadable','no'),
(1100,70,'_download_limit','-1'),
(1101,70,'_download_expiry','-1'),
(1102,70,'_stock','11'),
(1103,70,'_stock_status','instock'),
(1104,70,'_wc_average_rating','0'),
(1105,70,'_wc_review_count','0'),
(1106,70,'_product_version','11.1.2'),
(1107,70,'_price','33990'),
(1108,70,'_milena_demo_product','1'),
(1109,71,'_sku','MILENA-DEMO-032'),
(1110,71,'total_sales','0'),
(1111,71,'_tax_status','taxable'),
(1112,71,'_tax_class',''),
(1113,71,'_manage_stock','no'),
(1114,71,'_backorders','no'),
(1115,71,'_sold_individually','no'),
(1116,71,'_virtual','no'),
(1117,71,'_downloadable','no'),
(1118,71,'_download_limit','-1'),
(1119,71,'_download_expiry','-1'),
(1120,71,'_stock',NULL),
(1121,71,'_stock_status','instock'),
(1122,71,'_wc_average_rating','0'),
(1123,71,'_wc_review_count','0'),
(1124,71,'_product_attributes','a:1:{s:5:\"talla\";a:6:{s:4:\"name\";s:5:\"Talla\";s:5:\"value\";s:9:\"S | M | L\";s:8:\"position\";i:0;s:10:\"is_visible\";i:1;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),
(1125,71,'_product_version','11.1.2'),
(1126,72,'_variation_description',''),
(1127,72,'_sku','MILENA-DEMO-032-S'),
(1128,72,'_regular_price','42990'),
(1129,72,'total_sales','0'),
(1130,72,'_tax_status','taxable'),
(1131,72,'_tax_class','parent'),
(1132,72,'_manage_stock','yes'),
(1133,72,'_backorders','no'),
(1134,72,'_sold_individually','no'),
(1135,72,'_virtual','no'),
(1136,72,'_downloadable','no'),
(1137,72,'_download_limit','-1'),
(1138,72,'_download_expiry','-1'),
(1139,72,'_stock','4'),
(1140,72,'_stock_status','instock'),
(1141,72,'_wc_average_rating','0'),
(1142,72,'_wc_review_count','0'),
(1143,72,'attribute_talla','S'),
(1144,72,'_price','42990'),
(1145,72,'_product_version','11.1.2'),
(1146,73,'_variation_description',''),
(1147,73,'_sku','MILENA-DEMO-032-M'),
(1148,73,'_regular_price','42990'),
(1149,73,'total_sales','0'),
(1150,73,'_tax_status','taxable'),
(1151,73,'_tax_class','parent'),
(1152,73,'_manage_stock','yes'),
(1153,73,'_backorders','no'),
(1154,73,'_sold_individually','no'),
(1155,73,'_virtual','no'),
(1156,73,'_downloadable','no'),
(1157,73,'_download_limit','-1'),
(1158,73,'_download_expiry','-1'),
(1159,73,'_stock','7'),
(1160,73,'_stock_status','instock'),
(1161,73,'_wc_average_rating','0'),
(1162,73,'_wc_review_count','0'),
(1163,73,'attribute_talla','M'),
(1164,73,'_price','42990'),
(1165,73,'_product_version','11.1.2'),
(1166,74,'_variation_description',''),
(1167,74,'_sku','MILENA-DEMO-032-L'),
(1168,74,'_regular_price','42990'),
(1169,74,'total_sales','0'),
(1170,74,'_tax_status','taxable'),
(1171,74,'_tax_class','parent'),
(1172,74,'_manage_stock','yes'),
(1173,74,'_backorders','no'),
(1174,74,'_sold_individually','no'),
(1175,74,'_virtual','no'),
(1176,74,'_downloadable','no'),
(1177,74,'_download_limit','-1'),
(1178,74,'_download_expiry','-1'),
(1179,74,'_stock','10'),
(1180,74,'_stock_status','instock'),
(1181,74,'_wc_average_rating','0'),
(1182,74,'_wc_review_count','0'),
(1183,74,'attribute_talla','L'),
(1184,74,'_price','42990'),
(1185,74,'_product_version','11.1.2'),
(1187,71,'_milena_demo_product','1'),
(1188,75,'_sku','MILENA-DEMO-033'),
(1189,75,'_regular_price','36990'),
(1190,75,'total_sales','0'),
(1191,75,'_tax_status','taxable'),
(1192,75,'_tax_class',''),
(1193,75,'_manage_stock','yes'),
(1194,75,'_backorders','no'),
(1195,75,'_sold_individually','no'),
(1196,75,'_virtual','no'),
(1197,75,'_downloadable','no'),
(1198,75,'_download_limit','-1'),
(1199,75,'_download_expiry','-1'),
(1200,75,'_stock','13'),
(1201,75,'_stock_status','instock'),
(1202,75,'_wc_average_rating','0'),
(1203,75,'_wc_review_count','0'),
(1204,75,'_product_version','11.1.2'),
(1205,75,'_price','36990'),
(1206,75,'_milena_demo_product','1'),
(1207,76,'_sku','MILENA-DEMO-034'),
(1208,76,'_regular_price','33990'),
(1209,76,'total_sales','0'),
(1210,76,'_tax_status','taxable'),
(1211,76,'_tax_class',''),
(1212,76,'_manage_stock','yes'),
(1213,76,'_backorders','no'),
(1214,76,'_sold_individually','no'),
(1215,76,'_virtual','no'),
(1216,76,'_downloadable','no'),
(1217,76,'_download_limit','-1'),
(1218,76,'_download_expiry','-1'),
(1219,76,'_stock','14'),
(1220,76,'_stock_status','instock'),
(1221,76,'_wc_average_rating','0'),
(1222,76,'_wc_review_count','0'),
(1223,76,'_product_version','11.1.2'),
(1224,76,'_price','33990'),
(1225,76,'_milena_demo_product','1'),
(1226,77,'_sku','MILENA-DEMO-035'),
(1227,77,'_regular_price','29990'),
(1228,77,'total_sales','0'),
(1229,77,'_tax_status','taxable'),
(1230,77,'_tax_class',''),
(1231,77,'_manage_stock','yes'),
(1232,77,'_backorders','no'),
(1233,77,'_sold_individually','no'),
(1234,77,'_virtual','no'),
(1235,77,'_downloadable','no'),
(1236,77,'_download_limit','-1'),
(1237,77,'_download_expiry','-1'),
(1238,77,'_stock','15'),
(1239,77,'_stock_status','instock'),
(1240,77,'_wc_average_rating','0'),
(1241,77,'_wc_review_count','0'),
(1242,77,'_product_version','11.1.2'),
(1243,77,'_price','29990'),
(1244,77,'_milena_demo_product','1'),
(1245,78,'_sku','MILENA-DEMO-036'),
(1246,78,'_regular_price','17990'),
(1247,78,'_sale_price','12990'),
(1248,78,'total_sales','0'),
(1249,78,'_tax_status','taxable'),
(1250,78,'_tax_class',''),
(1251,78,'_manage_stock','yes'),
(1252,78,'_backorders','no'),
(1253,78,'_sold_individually','no'),
(1254,78,'_virtual','no'),
(1255,78,'_downloadable','no'),
(1256,78,'_download_limit','-1'),
(1257,78,'_download_expiry','-1'),
(1258,78,'_stock','16'),
(1259,78,'_stock_status','instock'),
(1260,78,'_wc_average_rating','0'),
(1261,78,'_wc_review_count','0'),
(1262,78,'_product_version','11.1.2'),
(1263,78,'_price','12990'),
(1264,78,'_milena_demo_product','1'),
(1265,79,'_sku','MILENA-DEMO-037'),
(1266,79,'_regular_price','14990'),
(1267,79,'total_sales','0'),
(1268,79,'_tax_status','taxable'),
(1269,79,'_tax_class',''),
(1270,79,'_manage_stock','yes'),
(1271,79,'_backorders','no'),
(1272,79,'_sold_individually','no'),
(1273,79,'_virtual','no'),
(1274,79,'_downloadable','no'),
(1275,79,'_download_limit','-1'),
(1276,79,'_download_expiry','-1'),
(1277,79,'_stock','5'),
(1278,79,'_stock_status','instock'),
(1279,79,'_wc_average_rating','0'),
(1280,79,'_wc_review_count','0'),
(1281,79,'_product_version','11.1.2'),
(1282,79,'_price','14990'),
(1283,79,'_milena_demo_product','1'),
(1284,80,'_sku','MILENA-DEMO-038'),
(1285,80,'_regular_price','12990'),
(1286,80,'total_sales','0'),
(1287,80,'_tax_status','taxable'),
(1288,80,'_tax_class',''),
(1289,80,'_manage_stock','yes'),
(1290,80,'_backorders','no'),
(1291,80,'_sold_individually','no'),
(1292,80,'_virtual','no'),
(1293,80,'_downloadable','no'),
(1294,80,'_download_limit','-1'),
(1295,80,'_download_expiry','-1'),
(1296,80,'_stock','6'),
(1297,80,'_stock_status','instock'),
(1298,80,'_wc_average_rating','0'),
(1299,80,'_wc_review_count','0'),
(1300,80,'_product_version','11.1.2'),
(1301,80,'_price','12990'),
(1302,80,'_milena_demo_product','1'),
(1303,81,'_sku','MILENA-DEMO-039'),
(1304,81,'_regular_price','34990'),
(1305,81,'total_sales','0'),
(1306,81,'_tax_status','taxable'),
(1307,81,'_tax_class',''),
(1308,81,'_manage_stock','yes'),
(1309,81,'_backorders','no'),
(1310,81,'_sold_individually','no'),
(1311,81,'_virtual','no'),
(1312,81,'_downloadable','no'),
(1313,81,'_download_limit','-1'),
(1314,81,'_download_expiry','-1'),
(1315,81,'_stock','7'),
(1316,81,'_stock_status','instock'),
(1317,81,'_wc_average_rating','0'),
(1318,81,'_wc_review_count','0'),
(1319,81,'_product_version','11.1.2'),
(1320,81,'_price','34990'),
(1321,81,'_milena_demo_product','1'),
(1322,82,'_sku','MILENA-DEMO-040'),
(1323,82,'_regular_price','15990'),
(1324,82,'total_sales','0'),
(1325,82,'_tax_status','taxable'),
(1326,82,'_tax_class',''),
(1327,82,'_manage_stock','yes'),
(1328,82,'_backorders','no'),
(1329,82,'_sold_individually','no'),
(1330,82,'_virtual','no'),
(1331,82,'_downloadable','no'),
(1332,82,'_download_limit','-1'),
(1333,82,'_download_expiry','-1'),
(1334,82,'_stock','8'),
(1335,82,'_stock_status','instock'),
(1336,82,'_wc_average_rating','0'),
(1337,82,'_wc_review_count','0'),
(1338,82,'_product_version','11.1.2'),
(1339,82,'_price','15990'),
(1340,82,'_milena_demo_product','1'),
(1341,19,'_price','29990'),
(1342,24,'_price','38990'),
(1343,33,'_price','24990'),
(1344,44,'_price','39990'),
(1345,48,'_price','44990'),
(1346,56,'_price','32990'),
(1347,64,'_price','59990'),
(1348,71,'_price','42990');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES
(1,1,'2026-09-30 17:34:24','2026-09-30 17:34:24','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2026-09-30 17:34:24','2026-09-30 17:34:24','',0,'http://localhost:8080/?p=1',0,'post','',1),
(2,1,'2026-09-30 17:34:24','2026-09-30 17:34:24','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\">\n<!-- wp:paragraph -->\n<p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p>\n<!-- /wp:paragraph -->\n</blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\">\n<!-- wp:paragraph -->\n<p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p>\n<!-- /wp:paragraph -->\n</blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://localhost:8080/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','publish','closed','open','','sample-page','','','2026-09-30 17:34:24','2026-09-30 17:34:24','',0,'http://localhost:8080/?page_id=2',0,'page','',0),
(3,1,'2026-09-30 17:34:24','2026-09-30 17:34:24','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we are</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://localhost:8080.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Comments</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Media</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Cookies</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Embedded content from other websites</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we share your data with</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">How long we retain your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">What rights you have over your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Where your data is sent</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\n<!-- /wp:paragraph -->\n','Privacy Policy','','draft','closed','open','','privacy-policy','','','2026-09-30 17:34:24','2026-09-30 17:34:24','',0,'http://localhost:8080/?page_id=3',0,'page','',0),
(4,0,'2026-09-30 17:34:24','2026-09-30 17:34:24','<!-- wp:page-list /-->','Navigation','','publish','closed','closed','','navigation','','','2026-09-30 17:34:24','2026-09-30 17:34:24','',0,'http://localhost:8080/?p=4',0,'wp_navigation','',0),
(5,1,'2026-09-30 17:35:11','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2026-09-30 17:35:11','0000-00-00 00:00:00','',0,'http://localhost:8080/?p=5',0,'post','',0),
(6,0,'2026-09-30 17:39:50','2026-09-30 17:39:50','','woocommerce-placeholder','','inherit','open','closed','','woocommerce-placeholder','','','2026-09-30 17:39:50','2026-09-30 17:39:50','',0,'http://localhost:8080/wp-content/uploads/2026/09/woocommerce-placeholder.webp',0,'attachment','image/webp',0),
(7,1,'2026-09-30 17:39:51','2026-09-30 17:39:51','','Shop','','publish','closed','closed','','shop','','','2026-09-30 17:39:51','2026-09-30 17:39:51','',0,'http://localhost:8080/?page_id=7',0,'page','',0),
(8,1,'2026-09-30 17:39:51','2026-09-30 17:39:51','<!-- wp:woocommerce/cart -->\n<div class=\"wp-block-woocommerce-cart alignwide is-loading\"><!-- wp:woocommerce/filled-cart-block -->\n<div class=\"wp-block-woocommerce-filled-cart-block\"><!-- wp:woocommerce/cart-items-block -->\n<div class=\"wp-block-woocommerce-cart-items-block\"><!-- wp:woocommerce/cart-line-items-block -->\n<div class=\"wp-block-woocommerce-cart-line-items-block\"></div>\n<!-- /wp:woocommerce/cart-line-items-block -->\n\n<!-- wp:woocommerce/product-collection {\"queryId\":0,\"query\":{\"perPage\":3,\"pages\":1,\"offset\":0,\"postType\":\"product\",\"order\":\"asc\",\"orderBy\":\"title\",\"search\":\"\",\"exclude\":[],\"inherit\":false,\"taxQuery\":{},\"isProductCollectionBlock\":true,\"featured\":false,\"woocommerceOnSale\":false,\"woocommerceStockStatus\":[\"instock\",\"outofstock\",\"onbackorder\"],\"woocommerceAttributes\":[],\"woocommerceHandPickedProducts\":[],\"filterable\":false,\"relatedBy\":{\"categories\":true,\"tags\":true}},\"tagName\":\"div\",\"displayLayout\":{\"type\":\"flex\",\"columns\":3,\"shrinkColumns\":true},\"dimensions\":{\"widthType\":\"fill\"},\"collection\":\"woocommerce/product-collection/cross-sells\",\"hideControls\":[\"filterable\"],\"queryContextIncludes\":[\"collection\"]} -->\n<div class=\"wp-block-woocommerce-product-collection\"><!-- wp:heading {\"textAlign\":\"left\",\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"1rem\"}}}} -->\n<h2 class=\"wp-block-heading has-text-align-left\" style=\"margin-bottom:1rem\">You may be interested in&hellip;</h2>\n\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-template -->\n<!-- wp:woocommerce/product-image {\"showSaleBadge\":false,\"imageSizing\":\"thumbnail\",\"isDescendentOfQueryLoop\":true} -->\n<!-- wp:woocommerce/product-sale-badge {\"align\":\"right\"} /-->\n<!-- /wp:woocommerce/product-image -->\n\n<!-- wp:post-title {\"textAlign\":\"center\",\"isLink\":true,\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"0.75rem\",\"top\":\"0\"}},\"typography\":{\"lineHeight\":\"1.4\"}},\"fontSize\":\"medium\",\"__woocommerceNamespace\":\"woocommerce/product-collection/product-title\"} /-->\n\n<!-- wp:woocommerce/product-price {\"isDescendentOfQueryLoop\":true,\"textAlign\":\"center\",\"fontSize\":\"small\"} /-->\n\n<!-- wp:woocommerce/product-button {\"textAlign\":\"center\",\"isDescendentOfQueryLoop\":true,\"fontSize\":\"small\"} /-->\n<!-- /wp:woocommerce/product-template --></div>\n<!-- /wp:woocommerce/product-collection --></div>\n\n<!-- /wp:woocommerce/cart-items-block -->\n\n<!-- wp:woocommerce/cart-totals-block -->\n<div class=\"wp-block-woocommerce-cart-totals-block\"><!-- wp:woocommerce/cart-order-summary-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-block\"><!-- wp:woocommerce/cart-order-summary-heading-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-heading-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-heading-block -->\n\n<!-- wp:woocommerce/cart-order-summary-coupon-form-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-coupon-form-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/cart-order-summary-subtotal-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-subtotal-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/cart-order-summary-fee-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-fee-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-fee-block -->\n\n<!-- wp:woocommerce/cart-order-summary-discount-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-discount-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-discount-block -->\n\n<!-- wp:woocommerce/cart-order-summary-shipping-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-shipping-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/cart-order-summary-taxes-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-taxes-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/cart-order-summary-block -->\n\n<!-- wp:woocommerce/cart-express-payment-block -->\n<div class=\"wp-block-woocommerce-cart-express-payment-block\"></div>\n<!-- /wp:woocommerce/cart-express-payment-block -->\n\n<!-- wp:woocommerce/proceed-to-checkout-block -->\n<div class=\"wp-block-woocommerce-proceed-to-checkout-block\"></div>\n<!-- /wp:woocommerce/proceed-to-checkout-block -->\n\n<!-- wp:woocommerce/cart-accepted-payment-methods-block -->\n<div class=\"wp-block-woocommerce-cart-accepted-payment-methods-block\"></div>\n<!-- /wp:woocommerce/cart-accepted-payment-methods-block --></div>\n<!-- /wp:woocommerce/cart-totals-block --></div>\n<!-- /wp:woocommerce/filled-cart-block -->\n\n<!-- wp:woocommerce/empty-cart-block -->\n<div class=\"wp-block-woocommerce-empty-cart-block\"><!-- wp:heading {\"textAlign\":\"center\",\"className\":\"with-empty-cart-icon wc-block-cart__empty-cart__title\"} -->\n<h2 class=\"wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title\">Your cart is currently empty!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:separator {\"className\":\"is-style-dots\"} -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity is-style-dots\"/>\n<!-- /wp:separator -->\n\n<!-- wp:heading {\"textAlign\":\"center\"} -->\n<h2 class=\"wp-block-heading has-text-align-center\">New in store</h2>\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-new {\"columns\":4,\"rows\":1} /--></div>\n<!-- /wp:woocommerce/empty-cart-block --></div>\n<!-- /wp:woocommerce/cart -->','Cart','','publish','closed','closed','','cart','','','2026-09-30 18:59:15','2026-09-30 18:59:15','',0,'http://localhost:8080/?page_id=8',0,'page','',0),
(9,1,'2026-09-30 17:39:51','2026-09-30 17:39:51','<!-- wp:woocommerce/checkout -->\n<div class=\"wp-block-woocommerce-checkout alignwide wc-block-checkout is-loading\"><!-- wp:woocommerce/checkout-fields-block -->\n<div class=\"wp-block-woocommerce-checkout-fields-block\"><!-- wp:woocommerce/checkout-express-payment-block -->\n<div class=\"wp-block-woocommerce-checkout-express-payment-block\"></div>\n<!-- /wp:woocommerce/checkout-express-payment-block -->\n\n<!-- wp:woocommerce/checkout-contact-information-block -->\n<div class=\"wp-block-woocommerce-checkout-contact-information-block\"></div>\n<!-- /wp:woocommerce/checkout-contact-information-block -->\n\n<!-- wp:woocommerce/checkout-shipping-method-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-method-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-method-block -->\n\n<!-- wp:woocommerce/checkout-pickup-options-block -->\n<div class=\"wp-block-woocommerce-checkout-pickup-options-block\"></div>\n<!-- /wp:woocommerce/checkout-pickup-options-block -->\n\n<!-- wp:woocommerce/checkout-shipping-address-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-address-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-address-block -->\n\n<!-- wp:woocommerce/checkout-billing-address-block -->\n<div class=\"wp-block-woocommerce-checkout-billing-address-block\"></div>\n<!-- /wp:woocommerce/checkout-billing-address-block -->\n\n<!-- wp:woocommerce/checkout-shipping-methods-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-methods-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-methods-block -->\n\n<!-- wp:woocommerce/checkout-payment-block -->\n<div class=\"wp-block-woocommerce-checkout-payment-block\"></div>\n<!-- /wp:woocommerce/checkout-payment-block -->\n\n<!-- wp:woocommerce/checkout-additional-information-block -->\n<div class=\"wp-block-woocommerce-checkout-additional-information-block\"></div>\n<!-- /wp:woocommerce/checkout-additional-information-block -->\n\n<!-- wp:woocommerce/checkout-order-note-block -->\n<div class=\"wp-block-woocommerce-checkout-order-note-block\"></div>\n<!-- /wp:woocommerce/checkout-order-note-block -->\n\n<!-- wp:woocommerce/checkout-terms-block -->\n<div class=\"wp-block-woocommerce-checkout-terms-block\"></div>\n<!-- /wp:woocommerce/checkout-terms-block -->\n\n<!-- wp:woocommerce/checkout-actions-block -->\n<div class=\"wp-block-woocommerce-checkout-actions-block\"></div>\n<!-- /wp:woocommerce/checkout-actions-block --></div>\n<!-- /wp:woocommerce/checkout-fields-block -->\n\n<!-- wp:woocommerce/checkout-totals-block -->\n<div class=\"wp-block-woocommerce-checkout-totals-block\"><!-- wp:woocommerce/checkout-order-summary-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-block\"><!-- wp:woocommerce/checkout-order-summary-cart-items-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-cart-items-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-cart-items-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-coupon-form-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-coupon-form-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-subtotal-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-subtotal-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-fee-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-fee-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-fee-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-discount-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-discount-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-discount-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-shipping-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-shipping-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-taxes-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-taxes-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/checkout-order-summary-block --></div>\n<!-- /wp:woocommerce/checkout-totals-block --></div>\n<!-- /wp:woocommerce/checkout -->','Checkout','','publish','closed','closed','','checkout','','','2026-09-30 17:39:51','2026-09-30 17:39:51','',0,'http://localhost:8080/?page_id=9',0,'page','',0),
(10,1,'2026-09-30 17:39:51','2026-09-30 17:39:51','<!-- wp:shortcode -->[woocommerce_my_account]<!-- /wp:shortcode -->','My account','','publish','closed','closed','','my-account','','','2026-09-30 17:39:51','2026-09-30 17:39:51','',0,'http://localhost:8080/?page_id=10',0,'page','',0),
(11,1,'2026-09-30 17:39:51','0000-00-00 00:00:00','<!-- wp:paragraph -->\n<p><b>This is a sample page.</b></p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Overview</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Our refund and returns policy lasts 30 days. If 30 days have passed since your purchase, we can’t offer you a full refund or exchange.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Several types of goods are exempt from being returned. Perishable goods such as food, flowers, newspapers or magazines cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Additional non-returnable items:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Gift cards</li>\n<li>Downloadable software products</li>\n<li>Some health and personal care items</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:paragraph -->\n<p>To complete your return, we require a receipt or proof of purchase.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Please do not send your purchase back to the manufacturer.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>There are certain situations where only partial refunds are granted:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Book with obvious signs of use</li>\n<li>CD, DVD, VHS tape, software, video game, cassette tape, or vinyl record that has been opened.</li>\n<li>Any item not in its original condition, is damaged or missing parts for reasons not due to our error.</li>\n<li>Any item that is returned more than 30 days after delivery</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Refunds</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {\"level\":3} -->\n<h3 class=\"wp-block-heading\">Late or missing refunds</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If you haven’t received a refund yet, first check your bank account again.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Then contact your credit card company, it may take some time before your refund is officially posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Next contact your bank. There is often some processing time before a refund is posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you’ve done all of this and you still have not received your refund yet, please contact us at {email address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {\"level\":3} -->\n<h3 class=\"wp-block-heading\">Sale items</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Only regular priced items may be refunded. Sale items cannot be refunded.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Exchanges</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>We only replace items if they are defective or damaged. If you need to exchange it for the same item, send us an email at {email address} and send your item to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Gifts</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If the item was marked as a gift when purchased and shipped directly to you, you’ll receive a gift credit for the value of your return. Once the returned item is received, a gift certificate will be mailed to you.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If the item wasn’t marked as a gift when purchased, or the gift giver had the order shipped to themselves to give to you later, we will send a refund to the gift giver and they will find out about your return.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Shipping returns</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>To return your product, you should mail your product to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Depending on where you live, the time it may take for your exchanged product to reach you may vary.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are returning more expensive items, you may consider using a trackable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Need help?</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Contact us at {email} for questions related to refunds and returns.</p>\n<!-- /wp:paragraph -->','Refund and Returns Policy','','draft','closed','closed','','refund_returns','','','2026-09-30 17:39:51','0000-00-00 00:00:00','',0,'http://localhost:8080/?page_id=11',0,'page','',0),
(12,0,'2026-09-30 18:59:15','2026-09-30 18:59:15','<!-- wp:woocommerce/cart -->\n<div class=\"wp-block-woocommerce-cart alignwide is-loading\"><!-- wp:woocommerce/filled-cart-block -->\n<div class=\"wp-block-woocommerce-filled-cart-block\"><!-- wp:woocommerce/cart-items-block -->\n<div class=\"wp-block-woocommerce-cart-items-block\"><!-- wp:woocommerce/cart-line-items-block -->\n<div class=\"wp-block-woocommerce-cart-line-items-block\"></div>\n<!-- /wp:woocommerce/cart-line-items-block -->\n\n<!-- wp:woocommerce/product-collection {\"queryId\":0,\"query\":{\"perPage\":3,\"pages\":1,\"offset\":0,\"postType\":\"product\",\"order\":\"asc\",\"orderBy\":\"title\",\"search\":\"\",\"exclude\":[],\"inherit\":false,\"taxQuery\":{},\"isProductCollectionBlock\":true,\"featured\":false,\"woocommerceOnSale\":false,\"woocommerceStockStatus\":[\"instock\",\"outofstock\",\"onbackorder\"],\"woocommerceAttributes\":[],\"woocommerceHandPickedProducts\":[],\"filterable\":false,\"relatedBy\":{\"categories\":true,\"tags\":true}},\"tagName\":\"div\",\"displayLayout\":{\"type\":\"flex\",\"columns\":3,\"shrinkColumns\":true},\"dimensions\":{\"widthType\":\"fill\"},\"collection\":\"woocommerce/product-collection/cross-sells\",\"hideControls\":[\"filterable\"],\"queryContextIncludes\":[\"collection\"]} -->\n<div class=\"wp-block-woocommerce-product-collection\"><!-- wp:heading {\"textAlign\":\"left\",\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"1rem\"}}}} -->\n<h2 class=\"wp-block-heading has-text-align-left\" style=\"margin-bottom:1rem\">You may be interested in&hellip;</h2>\n\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-template -->\n<!-- wp:woocommerce/product-image {\"showSaleBadge\":false,\"imageSizing\":\"thumbnail\",\"isDescendentOfQueryLoop\":true} -->\n<!-- wp:woocommerce/product-sale-badge {\"align\":\"right\"} /-->\n<!-- /wp:woocommerce/product-image -->\n\n<!-- wp:post-title {\"textAlign\":\"center\",\"isLink\":true,\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"0.75rem\",\"top\":\"0\"}},\"typography\":{\"lineHeight\":\"1.4\"}},\"fontSize\":\"medium\",\"__woocommerceNamespace\":\"woocommerce/product-collection/product-title\"} /-->\n\n<!-- wp:woocommerce/product-price {\"isDescendentOfQueryLoop\":true,\"textAlign\":\"center\",\"fontSize\":\"small\"} /-->\n\n<!-- wp:woocommerce/product-button {\"textAlign\":\"center\",\"isDescendentOfQueryLoop\":true,\"fontSize\":\"small\"} /-->\n<!-- /wp:woocommerce/product-template --></div>\n<!-- /wp:woocommerce/product-collection --></div>\n\n<!-- /wp:woocommerce/cart-items-block -->\n\n<!-- wp:woocommerce/cart-totals-block -->\n<div class=\"wp-block-woocommerce-cart-totals-block\"><!-- wp:woocommerce/cart-order-summary-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-block\"><!-- wp:woocommerce/cart-order-summary-heading-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-heading-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-heading-block -->\n\n<!-- wp:woocommerce/cart-order-summary-coupon-form-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-coupon-form-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/cart-order-summary-subtotal-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-subtotal-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/cart-order-summary-fee-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-fee-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-fee-block -->\n\n<!-- wp:woocommerce/cart-order-summary-discount-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-discount-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-discount-block -->\n\n<!-- wp:woocommerce/cart-order-summary-shipping-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-shipping-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/cart-order-summary-taxes-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-taxes-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/cart-order-summary-block -->\n\n<!-- wp:woocommerce/cart-express-payment-block -->\n<div class=\"wp-block-woocommerce-cart-express-payment-block\"></div>\n<!-- /wp:woocommerce/cart-express-payment-block -->\n\n<!-- wp:woocommerce/proceed-to-checkout-block -->\n<div class=\"wp-block-woocommerce-proceed-to-checkout-block\"></div>\n<!-- /wp:woocommerce/proceed-to-checkout-block -->\n\n<!-- wp:woocommerce/cart-accepted-payment-methods-block -->\n<div class=\"wp-block-woocommerce-cart-accepted-payment-methods-block\"></div>\n<!-- /wp:woocommerce/cart-accepted-payment-methods-block --></div>\n<!-- /wp:woocommerce/cart-totals-block --></div>\n<!-- /wp:woocommerce/filled-cart-block -->\n\n<!-- wp:woocommerce/empty-cart-block -->\n<div class=\"wp-block-woocommerce-empty-cart-block\"><!-- wp:heading {\"textAlign\":\"center\",\"className\":\"with-empty-cart-icon wc-block-cart__empty-cart__title\"} -->\n<h2 class=\"wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title\">Your cart is currently empty!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:separator {\"className\":\"is-style-dots\"} -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity is-style-dots\"/>\n<!-- /wp:separator -->\n\n<!-- wp:heading {\"textAlign\":\"center\"} -->\n<h2 class=\"wp-block-heading has-text-align-center\">New in store</h2>\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-new {\"columns\":4,\"rows\":1} /--></div>\n<!-- /wp:woocommerce/empty-cart-block --></div>\n<!-- /wp:woocommerce/cart -->','Cart','','inherit','closed','closed','','8-revision-v1','','','2026-09-30 18:59:15','2026-09-30 18:59:15','',8,'http://localhost:8080/?p=12',0,'revision','',0),
(13,0,'2026-09-30 19:47:51','2026-09-30 19:47:51','[tienda_moda_wishlist]','Favoritos','','publish','closed','closed','','favoritos','','','2026-09-30 19:47:51','2026-09-30 19:47:51','',0,'http://localhost:8080/?page_id=13',0,'page','',0),
(19,0,'2026-10-02 13:11:05','2026-10-02 13:11:05','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Aurora','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-aurora-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=vestido-aurora-demo',0,'product','',0),
(20,0,'2026-10-02 13:11:05','2026-10-02 13:11:05','','Vestido Aurora - S','Talla: S','publish','closed','closed','','vestido-aurora-s','','','2026-10-02 13:11:05','2026-10-02 13:11:05','',19,'http://localhost:8080/?post_type=product_variation&p=20',0,'product_variation','',0),
(21,0,'2026-10-02 13:11:05','2026-10-02 13:11:05','','Vestido Aurora - M','Talla: M','publish','closed','closed','','vestido-aurora-m','','','2026-10-02 13:11:05','2026-10-02 13:11:05','',19,'http://localhost:8080/?post_type=product_variation&p=21',0,'product_variation','',0),
(22,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','','Vestido Aurora - L','Talla: L','publish','closed','closed','','vestido-aurora-l','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',19,'http://localhost:8080/?post_type=product_variation&p=22',0,'product_variation','',0),
(23,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Midi Serena','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-midi-serena-demo','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',0,'http://localhost:8080/?product=vestido-midi-serena-demo',0,'product','',0),
(24,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Floral Emilia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-floral-emilia-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=vestido-floral-emilia-demo',0,'product','',0),
(25,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','','Vestido Floral Emilia - S','Talla: S','publish','closed','closed','','vestido-floral-emilia-s','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',24,'http://localhost:8080/?post_type=product_variation&p=25',0,'product_variation','',0),
(26,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','','Vestido Floral Emilia - M','Talla: M','publish','closed','closed','','vestido-floral-emilia-m','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',24,'http://localhost:8080/?post_type=product_variation&p=26',0,'product_variation','',0),
(27,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','','Vestido Floral Emilia - L','Talla: L','publish','closed','closed','','vestido-floral-emilia-l','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',24,'http://localhost:8080/?post_type=product_variation&p=27',0,'product_variation','',0),
(28,0,'2026-10-02 13:11:06','2026-10-02 13:11:06','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Nocturno Antonia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-nocturno-antonia-demo','','','2026-10-02 13:11:06','2026-10-02 13:11:06','',0,'http://localhost:8080/?product=vestido-nocturno-antonia-demo',0,'product','',0),
(29,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Camisero Isidora','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-camisero-isidora-demo','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',0,'http://localhost:8080/?product=vestido-camisero-isidora-demo',0,'product','',0),
(30,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Lino Catalina','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-lino-catalina-demo','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',0,'http://localhost:8080/?product=vestido-lino-catalina-demo',0,'product','',0),
(31,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Cruzado Josefa','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-cruzado-josefa-demo','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',0,'http://localhost:8080/?product=vestido-cruzado-josefa-demo',0,'product','',0),
(32,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Vestido Corto Amanda','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','vestido-corto-amanda-demo','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',0,'http://localhost:8080/?product=vestido-corto-amanda-demo',0,'product','',0),
(33,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Blusa Alba','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','blusa-alba-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=blusa-alba-demo',0,'product','',0),
(34,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','','Blusa Alba - S','Talla: S','publish','closed','closed','','blusa-alba-s','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',33,'http://localhost:8080/?post_type=product_variation&p=34',0,'product_variation','',0),
(35,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','','Blusa Alba - M','Talla: M','publish','closed','closed','','blusa-alba-m','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',33,'http://localhost:8080/?post_type=product_variation&p=35',0,'product_variation','',0),
(36,0,'2026-10-02 13:11:07','2026-10-02 13:11:07','','Blusa Alba - L','Talla: L','publish','closed','closed','','blusa-alba-l','','','2026-10-02 13:11:07','2026-10-02 13:11:07','',33,'http://localhost:8080/?post_type=product_variation&p=36',0,'product_variation','',0),
(37,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Blusa Satén Renata','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','blusa-saten-renata-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=blusa-saten-renata-demo',0,'product','',0),
(38,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Polera Esencial Blanca','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','polera-esencial-blanca-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=polera-esencial-blanca-demo',0,'product','',0),
(39,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Polera Rib Martina','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','polera-rib-martina-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=polera-rib-martina-demo',0,'product','',0),
(40,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Top Tejido Florencia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','top-tejido-florencia-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=top-tejido-florencia-demo',0,'product','',0),
(41,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Camisa Oversize Trinidad','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','camisa-oversize-trinidad-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=camisa-oversize-trinidad-demo',0,'product','',0),
(42,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Blusa Bordada Julieta','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','blusa-bordada-julieta-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=blusa-bordada-julieta-demo',0,'product','',0),
(43,0,'2026-10-02 13:11:08','2026-10-02 13:11:08','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Body Manga Larga Maite','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','body-manga-larga-maite-demo','','','2026-10-02 13:11:08','2026-10-02 13:11:08','',0,'http://localhost:8080/?product=body-manga-larga-maite-demo',0,'product','',0),
(44,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Jeans Rectos Olivia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','jeans-rectos-olivia-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=jeans-rectos-olivia-demo',0,'product','',0),
(45,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','','Jeans Rectos Olivia - S','Talla: S','publish','closed','closed','','jeans-rectos-olivia-s','','','2026-10-02 13:11:09','2026-10-02 13:11:09','',44,'http://localhost:8080/?post_type=product_variation&p=45',0,'product_variation','',0),
(46,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','','Jeans Rectos Olivia - M','Talla: M','publish','closed','closed','','jeans-rectos-olivia-m','','','2026-10-02 13:11:09','2026-10-02 13:11:09','',44,'http://localhost:8080/?post_type=product_variation&p=46',0,'product_variation','',0),
(47,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','','Jeans Rectos Olivia - L','Talla: L','publish','closed','closed','','jeans-rectos-olivia-l','','','2026-10-02 13:11:09','2026-10-02 13:11:09','',44,'http://localhost:8080/?post_type=product_variation&p=47',0,'product_variation','',0),
(48,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Pantalón Sastrero Clara','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','pantalon-sastrero-clara-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=pantalon-sastrero-clara-demo',0,'product','',0),
(49,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','','Pantalón Sastrero Clara - S','Talla: S','publish','closed','closed','','pantalon-sastrero-clara-s','','','2026-10-02 13:11:09','2026-10-02 13:11:09','',48,'http://localhost:8080/?post_type=product_variation&p=49',0,'product_variation','',0),
(50,0,'2026-10-02 13:11:09','2026-10-02 13:11:09','','Pantalón Sastrero Clara - M','Talla: M','publish','closed','closed','','pantalon-sastrero-clara-m','','','2026-10-02 13:11:09','2026-10-02 13:11:09','',48,'http://localhost:8080/?post_type=product_variation&p=50',0,'product_variation','',0),
(51,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','','Pantalón Sastrero Clara - L','Talla: L','publish','closed','closed','','pantalon-sastrero-clara-l','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',48,'http://localhost:8080/?post_type=product_variation&p=51',0,'product_variation','',0),
(52,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Pantalón Cargo Agustina','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','pantalon-cargo-agustina-demo','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',0,'http://localhost:8080/?product=pantalon-cargo-agustina-demo',0,'product','',0),
(53,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Jeans Wide Leg Dominga','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','jeans-wide-leg-dominga-demo','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',0,'http://localhost:8080/?product=jeans-wide-leg-dominga-demo',0,'product','',0),
(54,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Pantalón Lino Elisa','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','pantalon-lino-elisa-demo','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',0,'http://localhost:8080/?product=pantalon-lino-elisa-demo',0,'product','',0),
(55,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Leggings Comfort Sofía','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','leggings-comfort-sofia-demo','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',0,'http://localhost:8080/?product=leggings-comfort-sofia-demo',0,'product','',0),
(56,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Falda Midi Violeta','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','falda-midi-violeta-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=falda-midi-violeta-demo',0,'product','',0),
(57,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','','Falda Midi Violeta - S','Talla: S','publish','closed','closed','','falda-midi-violeta-s','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',56,'http://localhost:8080/?post_type=product_variation&p=57',0,'product_variation','',0),
(58,0,'2026-10-02 13:11:10','2026-10-02 13:11:10','','Falda Midi Violeta - M','Talla: M','publish','closed','closed','','falda-midi-violeta-m','','','2026-10-02 13:11:10','2026-10-02 13:11:10','',56,'http://localhost:8080/?post_type=product_variation&p=58',0,'product_variation','',0),
(59,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','','Falda Midi Violeta - L','Talla: L','publish','closed','closed','','falda-midi-violeta-l','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',56,'http://localhost:8080/?post_type=product_variation&p=59',0,'product_variation','',0),
(60,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Falda Plisada Leonor','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','falda-plisada-leonor-demo','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',0,'http://localhost:8080/?product=falda-plisada-leonor-demo',0,'product','',0),
(61,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Falda Denim Pascuala','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','falda-denim-pascuala-demo','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',0,'http://localhost:8080/?product=falda-denim-pascuala-demo',0,'product','',0),
(62,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Falda Satinada Mía','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','falda-satinada-mia-demo','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',0,'http://localhost:8080/?product=falda-satinada-mia-demo',0,'product','',0),
(63,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Chaqueta Denim Amalia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','chaqueta-denim-amalia-demo','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',0,'http://localhost:8080/?product=chaqueta-denim-amalia-demo',0,'product','',0),
(64,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Blazer Sastrero Victoria','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','blazer-sastrero-victoria-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=blazer-sastrero-victoria-demo',0,'product','',0),
(65,0,'2026-10-02 13:11:11','2026-10-02 13:11:11','','Blazer Sastrero Victoria - S','Talla: S','publish','closed','closed','','blazer-sastrero-victoria-s','','','2026-10-02 13:11:11','2026-10-02 13:11:11','',64,'http://localhost:8080/?post_type=product_variation&p=65',0,'product_variation','',0),
(66,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','','Blazer Sastrero Victoria - M','Talla: M','publish','closed','closed','','blazer-sastrero-victoria-m','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',64,'http://localhost:8080/?post_type=product_variation&p=66',0,'product_variation','',0),
(67,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','','Blazer Sastrero Victoria - L','Talla: L','publish','closed','closed','','blazer-sastrero-victoria-l','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',64,'http://localhost:8080/?post_type=product_variation&p=67',0,'product_variation','',0),
(68,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Abrigo Paño Magnolia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','abrigo-pano-magnolia-demo','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',0,'http://localhost:8080/?product=abrigo-pano-magnolia-demo',0,'product','',0),
(69,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Trench Ligero Rosario','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','trench-ligero-rosario-demo','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',0,'http://localhost:8080/?product=trench-ligero-rosario-demo',0,'product','',0),
(70,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Cardigan Suave Elena','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','cardigan-suave-elena-demo','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',0,'http://localhost:8080/?product=cardigan-suave-elena-demo',0,'product','',0),
(71,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Sweater Cuello Alto Blanca','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','sweater-cuello-alto-blanca-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=sweater-cuello-alto-blanca-demo',0,'product','',0),
(72,0,'2026-10-02 13:11:12','2026-10-02 13:11:12','','Sweater Cuello Alto Blanca - S','Talla: S','publish','closed','closed','','sweater-cuello-alto-blanca-s','','','2026-10-02 13:11:12','2026-10-02 13:11:12','',71,'http://localhost:8080/?post_type=product_variation&p=72',0,'product_variation','',0),
(73,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','','Sweater Cuello Alto Blanca - M','Talla: M','publish','closed','closed','','sweater-cuello-alto-blanca-m','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',71,'http://localhost:8080/?post_type=product_variation&p=73',0,'product_variation','',0),
(74,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','','Sweater Cuello Alto Blanca - L','Talla: L','publish','closed','closed','','sweater-cuello-alto-blanca-l','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',71,'http://localhost:8080/?post_type=product_variation&p=74',0,'product_variation','',0),
(75,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Chaleco Trenzado Amanda','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','chaleco-trenzado-amanda-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=chaleco-trenzado-amanda-demo',0,'product','',0),
(76,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Tejido Liviano Celeste','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','tejido-liviano-celeste-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=tejido-liviano-celeste-demo',0,'product','',0),
(77,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Cartera Mini Amelia','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','cartera-mini-amelia-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=cartera-mini-amelia-demo',0,'product','',0),
(78,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Cinturón Clásico Negro','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','cinturon-clasico-negro-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=cinturon-clasico-negro-demo',0,'product','',0),
(79,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Pañuelo Estampado Jardín','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','panuelo-estampado-jardin-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=panuelo-estampado-jardin-demo',0,'product','',0),
(80,0,'2026-10-02 13:11:13','2026-10-02 13:11:13','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Aros Dorados Luna','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','aros-dorados-luna-demo','','','2026-10-02 13:11:13','2026-10-02 13:11:13','',0,'http://localhost:8080/?product=aros-dorados-luna-demo',0,'product','',0),
(81,0,'2026-10-02 13:11:14','2026-10-02 13:11:14','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Bolso Tote Terracota','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','bolso-tote-terracota-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=bolso-tote-terracota-demo',0,'product','',0),
(82,0,'2026-10-02 13:11:14','2026-10-02 13:11:14','Producto de demostración creado para probar el diseño, el catálogo, el carrito y el proceso de compra de la tienda.','Gorro Tejido Nube','Una prenda versátil y cómoda para combinar durante toda la temporada.','publish','open','closed','','gorro-tejido-nube-demo','','','2026-10-02 13:11:14','2026-10-02 13:11:14','',0,'http://localhost:8080/?product=gorro-tejido-nube-demo',0,'product','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES
(1,1,0),
(19,4,0),
(19,8,0),
(19,16,0),
(23,2,0),
(23,16,0),
(24,4,0),
(24,16,0),
(28,2,0),
(28,16,0),
(29,2,0),
(29,16,0),
(30,2,0),
(30,16,0),
(31,2,0),
(31,16,0),
(32,2,0),
(32,8,0),
(32,16,0),
(33,4,0),
(33,17,0),
(37,2,0),
(37,17,0),
(38,2,0),
(38,17,0),
(39,2,0),
(39,17,0),
(40,2,0),
(40,17,0),
(41,2,0),
(41,17,0),
(42,2,0),
(42,8,0),
(42,17,0),
(43,2,0),
(43,17,0),
(44,4,0),
(44,18,0),
(48,4,0),
(48,18,0),
(52,2,0),
(52,18,0),
(53,2,0),
(53,18,0),
(54,2,0),
(54,18,0),
(55,2,0),
(55,8,0),
(55,18,0),
(56,4,0),
(56,19,0),
(60,2,0),
(60,19,0),
(61,2,0),
(61,19,0),
(62,2,0),
(62,19,0),
(63,2,0),
(63,20,0),
(64,4,0),
(64,20,0),
(68,2,0),
(68,8,0),
(68,20,0),
(69,2,0),
(69,20,0),
(70,2,0),
(70,21,0),
(71,4,0),
(71,21,0),
(75,2,0),
(75,21,0),
(76,2,0),
(76,21,0),
(77,2,0),
(77,22,0),
(78,2,0),
(78,8,0),
(78,22,0),
(79,2,0),
(79,22,0),
(80,2,0),
(80,22,0),
(81,2,0),
(81,22,0),
(82,2,0),
(82,22,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES
(1,1,'category','',0,1),
(2,2,'product_type','',0,32),
(3,3,'product_type','',0,0),
(4,4,'product_type','',0,8),
(5,5,'product_type','',0,0),
(6,6,'product_visibility','',0,0),
(7,7,'product_visibility','',0,0),
(8,8,'product_visibility','',0,6),
(9,9,'product_visibility','',0,0),
(10,10,'product_visibility','',0,0),
(11,11,'product_visibility','',0,0),
(12,12,'product_visibility','',0,0),
(13,13,'product_visibility','',0,0),
(14,14,'product_visibility','',0,0),
(15,15,'product_cat','',0,0),
(16,16,'product_cat','',0,8),
(17,17,'product_cat','',0,8),
(18,18,'product_cat','',0,6),
(19,19,'product_cat','',0,4),
(20,20,'product_cat','',0,4),
(21,21,'product_cat','',0,4),
(22,22,'product_cat','',0,6);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
INSERT INTO `wp_termmeta` VALUES
(1,15,'product_count_product_cat','0'),
(2,16,'product_count_product_cat','8'),
(3,17,'product_count_product_cat','8'),
(4,18,'product_count_product_cat','6'),
(5,19,'product_count_product_cat','4'),
(6,20,'product_count_product_cat','4'),
(7,21,'product_count_product_cat','4'),
(8,22,'product_count_product_cat','6');
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES
(1,'Uncategorized','uncategorized',0),
(2,'simple','simple',0),
(3,'grouped','grouped',0),
(4,'variable','variable',0),
(5,'external','external',0),
(6,'exclude-from-search','exclude-from-search',0),
(7,'exclude-from-catalog','exclude-from-catalog',0),
(8,'featured','featured',0),
(9,'outofstock','outofstock',0),
(10,'rated-1','rated-1',0),
(11,'rated-2','rated-2',0),
(12,'rated-3','rated-3',0),
(13,'rated-4','rated-4',0),
(14,'rated-5','rated-5',0),
(15,'Uncategorized','uncategorized',0),
(16,'Vestidos','vestidos',0),
(17,'Tops y Blusas','tops-y-blusas',0),
(18,'Pantalones','pantalones',0),
(19,'Faldas','faldas',0),
(20,'Abrigos y Chaquetas','abrigos-y-chaquetas',0),
(21,'Tejidos','tejidos',0),
(22,'Accesorios','accesorios',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_admin_note_actions`
--

LOCK TABLES `wp_wc_admin_note_actions` WRITE;
/*!40000 ALTER TABLE `wp_wc_admin_note_actions` DISABLE KEYS */;
INSERT INTO `wp_wc_admin_note_actions` VALUES
(1,1,'notify-refund-returns-page','Edit page','http://localhost:8080/wp-admin/post.php?post=11&action=edit','actioned','',NULL,NULL),
(2,2,'review-feature-settings','Get started','http://localhost:8080/wp-admin/admin.php?page=wc-settings&tab=advanced&section=features','actioned','',NULL,NULL),
(3,2,'learn-more','Learn more','https://woocommerce.com/document/customer-order-withdrawal/','unactioned','',NULL,NULL);
/*!40000 ALTER TABLE `wp_wc_admin_note_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_admin_notes`
--

LOCK TABLES `wp_wc_admin_notes` WRITE;
/*!40000 ALTER TABLE `wp_wc_admin_notes` DISABLE KEYS */;
INSERT INTO `wp_wc_admin_notes` VALUES
(1,'wc-refund-returns-page','info','en_US','Setup a Refund and Returns Policy page to boost your store\'s credibility.','We have created a sample draft Refund and Returns Policy page for you. Please have a look and update it to fit your store.','{}','unactioned','woocommerce-core','2026-09-30 17:40:29',NULL,0,'plain','',0,0,'info'),
(2,'wc-admin-order-withdrawal-feature','info','en_US','Enable order withdrawal for EU regulatory requirements','Stores selling to EU countries may need to offer customers a way to withdraw from qualifying orders. Review how to enable the order withdrawal feature in the Advanced settings.','{}','unactioned','woocommerce-admin','2026-09-30 18:59:15',NULL,0,'plain','',0,0,'info');
/*!40000 ALTER TABLE `wp_wc_admin_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_category_lookup`
--

LOCK TABLES `wp_wc_category_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_category_lookup` DISABLE KEYS */;
INSERT INTO `wp_wc_category_lookup` VALUES
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22);
/*!40000 ALTER TABLE `wp_wc_category_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_customer_lookup`
--

LOCK TABLES `wp_wc_customer_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_customer_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_customer_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_download_log`
--

LOCK TABLES `wp_wc_download_log` WRITE;
/*!40000 ALTER TABLE `wp_wc_download_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_download_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_email_unsubscribes`
--

LOCK TABLES `wp_wc_email_unsubscribes` WRITE;
/*!40000 ALTER TABLE `wp_wc_email_unsubscribes` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_email_unsubscribes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_addresses`
--

LOCK TABLES `wp_wc_order_addresses` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_coupon_lookup`
--

LOCK TABLES `wp_wc_order_coupon_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_coupon_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_coupon_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_operational_data`
--

LOCK TABLES `wp_wc_order_operational_data` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_operational_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_operational_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_product_lookup`
--

LOCK TABLES `wp_wc_order_product_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_product_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_product_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_stats`
--

LOCK TABLES `wp_wc_order_stats` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_order_tax_lookup`
--

LOCK TABLES `wp_wc_order_tax_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_tax_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_order_tax_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_orders`
--

LOCK TABLES `wp_wc_orders` WRITE;
/*!40000 ALTER TABLE `wp_wc_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_orders_meta`
--

LOCK TABLES `wp_wc_orders_meta` WRITE;
/*!40000 ALTER TABLE `wp_wc_orders_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_orders_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_product_attributes_lookup`
--

LOCK TABLES `wp_wc_product_attributes_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_attributes_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_product_attributes_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_product_download_directories`
--

LOCK TABLES `wp_wc_product_download_directories` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_download_directories` DISABLE KEYS */;
INSERT INTO `wp_wc_product_download_directories` VALUES
(1,'file:///var/www/html/wp-content/uploads/woocommerce_uploads/',1),
(2,'http://localhost:8080/wp-content/uploads/woocommerce_uploads/',1);
/*!40000 ALTER TABLE `wp_wc_product_download_directories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_product_meta_lookup`
--

LOCK TABLES `wp_wc_product_meta_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_meta_lookup` DISABLE KEYS */;
INSERT INTO `wp_wc_product_meta_lookup` VALUES
(19,'MILENA-DEMO-001','',0,0,29990.0000,29990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(20,'MILENA-DEMO-001-S','',0,0,29990.0000,29990.0000,1,4,'instock',0,0.00,0,'taxable','parent'),
(21,'MILENA-DEMO-001-M','',0,0,29990.0000,29990.0000,1,7,'instock',0,0.00,0,'taxable','parent'),
(22,'MILENA-DEMO-001-L','',0,0,29990.0000,29990.0000,1,10,'instock',0,0.00,0,'taxable','parent'),
(23,'MILENA-DEMO-002','',0,0,42990.0000,42990.0000,0,6,'instock',0,0.00,0,'taxable',''),
(24,'MILENA-DEMO-003','',0,0,38990.0000,38990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(25,'MILENA-DEMO-003-S','',0,0,38990.0000,38990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(26,'MILENA-DEMO-003-M','',0,0,38990.0000,38990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(27,'MILENA-DEMO-003-L','',0,0,38990.0000,38990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(28,'MILENA-DEMO-004','',0,0,47990.0000,47990.0000,0,8,'instock',0,0.00,0,'taxable',''),
(29,'MILENA-DEMO-005','',0,0,36990.0000,36990.0000,0,9,'instock',0,0.00,0,'taxable',''),
(30,'MILENA-DEMO-006','',0,0,39990.0000,39990.0000,1,10,'instock',0,0.00,0,'taxable',''),
(31,'MILENA-DEMO-007','',0,0,39990.0000,39990.0000,0,11,'instock',0,0.00,0,'taxable',''),
(32,'MILENA-DEMO-008','',0,0,32990.0000,32990.0000,0,12,'instock',0,0.00,0,'taxable',''),
(33,'MILENA-DEMO-009','',0,0,24990.0000,24990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(34,'MILENA-DEMO-009-S','',0,0,24990.0000,24990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(35,'MILENA-DEMO-009-M','',0,0,24990.0000,24990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(36,'MILENA-DEMO-009-L','',0,0,24990.0000,24990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(37,'MILENA-DEMO-010','',0,0,29990.0000,29990.0000,0,14,'instock',0,0.00,0,'taxable',''),
(38,'MILENA-DEMO-011','',0,0,11990.0000,11990.0000,1,15,'instock',0,0.00,0,'taxable',''),
(39,'MILENA-DEMO-012','',0,0,18990.0000,18990.0000,0,16,'instock',0,0.00,0,'taxable',''),
(40,'MILENA-DEMO-013','',0,0,21990.0000,21990.0000,0,5,'instock',0,0.00,0,'taxable',''),
(41,'MILENA-DEMO-014','',0,0,32990.0000,32990.0000,0,6,'instock',0,0.00,0,'taxable',''),
(42,'MILENA-DEMO-015','',0,0,28990.0000,28990.0000,0,7,'instock',0,0.00,0,'taxable',''),
(43,'MILENA-DEMO-016','',0,0,20990.0000,20990.0000,1,8,'instock',0,0.00,0,'taxable',''),
(44,'MILENA-DEMO-017','',0,0,39990.0000,39990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(45,'MILENA-DEMO-017-S','',0,0,39990.0000,39990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(46,'MILENA-DEMO-017-M','',0,0,39990.0000,39990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(47,'MILENA-DEMO-017-L','',0,0,39990.0000,39990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(48,'MILENA-DEMO-018','',0,0,44990.0000,44990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(49,'MILENA-DEMO-018-S','',0,0,44990.0000,44990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(50,'MILENA-DEMO-018-M','',0,0,44990.0000,44990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(51,'MILENA-DEMO-018-L','',0,0,44990.0000,44990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(52,'MILENA-DEMO-019','',0,0,37990.0000,37990.0000,0,11,'instock',0,0.00,0,'taxable',''),
(53,'MILENA-DEMO-020','',0,0,42990.0000,42990.0000,0,12,'instock',0,0.00,0,'taxable',''),
(54,'MILENA-DEMO-021','',0,0,36990.0000,36990.0000,1,13,'instock',0,0.00,0,'taxable',''),
(55,'MILENA-DEMO-022','',0,0,22990.0000,22990.0000,0,14,'instock',0,0.00,0,'taxable',''),
(56,'MILENA-DEMO-023','',0,0,32990.0000,32990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(57,'MILENA-DEMO-023-S','',0,0,32990.0000,32990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(58,'MILENA-DEMO-023-M','',0,0,32990.0000,32990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(59,'MILENA-DEMO-023-L','',0,0,32990.0000,32990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(60,'MILENA-DEMO-024','',0,0,35990.0000,35990.0000,0,16,'instock',0,0.00,0,'taxable',''),
(61,'MILENA-DEMO-025','',0,0,29990.0000,29990.0000,0,5,'instock',0,0.00,0,'taxable',''),
(62,'MILENA-DEMO-026','',0,0,29990.0000,29990.0000,1,6,'instock',0,0.00,0,'taxable',''),
(63,'MILENA-DEMO-027','',0,0,54990.0000,54990.0000,0,7,'instock',0,0.00,0,'taxable',''),
(64,'MILENA-DEMO-028','',0,0,59990.0000,59990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(65,'MILENA-DEMO-028-S','',0,0,59990.0000,59990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(66,'MILENA-DEMO-028-M','',0,0,59990.0000,59990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(67,'MILENA-DEMO-028-L','',0,0,59990.0000,59990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(68,'MILENA-DEMO-029','',0,0,79990.0000,79990.0000,0,9,'instock',0,0.00,0,'taxable',''),
(69,'MILENA-DEMO-030','',0,0,69990.0000,69990.0000,0,10,'instock',0,0.00,0,'taxable',''),
(70,'MILENA-DEMO-031','',0,0,33990.0000,33990.0000,1,11,'instock',0,0.00,0,'taxable',''),
(71,'MILENA-DEMO-032','',0,0,42990.0000,42990.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(72,'MILENA-DEMO-032-S','',0,0,42990.0000,42990.0000,0,4,'instock',0,0.00,0,'taxable','parent'),
(73,'MILENA-DEMO-032-M','',0,0,42990.0000,42990.0000,0,7,'instock',0,0.00,0,'taxable','parent'),
(74,'MILENA-DEMO-032-L','',0,0,42990.0000,42990.0000,0,10,'instock',0,0.00,0,'taxable','parent'),
(75,'MILENA-DEMO-033','',0,0,36990.0000,36990.0000,0,13,'instock',0,0.00,0,'taxable',''),
(76,'MILENA-DEMO-034','',0,0,33990.0000,33990.0000,0,14,'instock',0,0.00,0,'taxable',''),
(77,'MILENA-DEMO-035','',0,0,29990.0000,29990.0000,0,15,'instock',0,0.00,0,'taxable',''),
(78,'MILENA-DEMO-036','',0,0,12990.0000,12990.0000,1,16,'instock',0,0.00,0,'taxable',''),
(79,'MILENA-DEMO-037','',0,0,14990.0000,14990.0000,0,5,'instock',0,0.00,0,'taxable',''),
(80,'MILENA-DEMO-038','',0,0,12990.0000,12990.0000,0,6,'instock',0,0.00,0,'taxable',''),
(81,'MILENA-DEMO-039','',0,0,34990.0000,34990.0000,0,7,'instock',0,0.00,0,'taxable',''),
(82,'MILENA-DEMO-040','',0,0,15990.0000,15990.0000,0,8,'instock',0,0.00,0,'taxable','');
/*!40000 ALTER TABLE `wp_wc_product_meta_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_rate_limits`
--

LOCK TABLES `wp_wc_rate_limits` WRITE;
/*!40000 ALTER TABLE `wp_wc_rate_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_rate_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_reserved_stock`
--

LOCK TABLES `wp_wc_reserved_stock` WRITE;
/*!40000 ALTER TABLE `wp_wc_reserved_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_reserved_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_tax_rate_classes`
--

LOCK TABLES `wp_wc_tax_rate_classes` WRITE;
/*!40000 ALTER TABLE `wp_wc_tax_rate_classes` DISABLE KEYS */;
INSERT INTO `wp_wc_tax_rate_classes` VALUES
(1,'Reduced rate','reduced-rate'),
(2,'Zero rate','zero-rate');
/*!40000 ALTER TABLE `wp_wc_tax_rate_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_wc_webhooks`
--

LOCK TABLES `wp_wc_webhooks` WRITE;
/*!40000 ALTER TABLE `wp_wc_webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_api_keys`
--

LOCK TABLES `wp_woocommerce_api_keys` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_attribute_taxonomies`
--

LOCK TABLES `wp_woocommerce_attribute_taxonomies` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_downloadable_product_permissions`
--

LOCK TABLES `wp_woocommerce_downloadable_product_permissions` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_log`
--

LOCK TABLES `wp_woocommerce_log` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_order_itemmeta`
--

LOCK TABLES `wp_woocommerce_order_itemmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_order_items`
--

LOCK TABLES `wp_woocommerce_order_items` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_payment_tokenmeta`
--

LOCK TABLES `wp_woocommerce_payment_tokenmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_payment_tokens`
--

LOCK TABLES `wp_woocommerce_payment_tokens` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_locations`
--

LOCK TABLES `wp_woocommerce_shipping_zone_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_methods`
--

LOCK TABLES `wp_woocommerce_shipping_zone_methods` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_shipping_zones`
--

LOCK TABLES `wp_woocommerce_shipping_zones` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_tax_rate_locations`
--

LOCK TABLES `wp_woocommerce_tax_rate_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `wp_woocommerce_tax_rates`
--

LOCK TABLES `wp_woocommerce_tax_rates` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-10-02 13:21:34
