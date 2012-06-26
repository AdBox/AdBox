-- phpMyAdmin SQL Dump
-- version 3.2.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 26, 2012 at 07:27 PM
-- Server version: 5.1.40
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `adbox2`
--

-- --------------------------------------------------------

--
-- Table structure for table `boxes`
--

CREATE TABLE IF NOT EXISTS `boxes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `src` varchar(500) NOT NULL,
  `href` varchar(500) NOT NULL,
  `alt` varchar(200) DEFAULT NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `add_date` (`add_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `day_operations`
--

CREATE TABLE IF NOT EXISTS `day_operations` (
  `operation_id` int(11) unsigned NOT NULL,
  `summ` float(12,2) NOT NULL,
  `date` datetime NOT NULL,
  KEY `operation_id` (`operation_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `operations`
--

CREATE TABLE IF NOT EXISTS `operations` (
  `id` int(11) unsigned NOT NULL,
  `sender_id` int(11) unsigned NOT NULL,
  `receiver_id` int(11) unsigned DEFAULT NULL,
  `order_id` int(11) unsigned DEFAULT NULL,
  `type` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `summ` float(12,2) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `date` (`date`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  `box_id` int(11) unsigned NOT NULL,
  `new_box_id` int(11) unsigned DEFAULT NULL,
  `clicks_limit` int(11) unsigned DEFAULT NULL,
  `views_limit` int(11) unsigned DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `accept_date` datetime DEFAULT NULL,
  `clicks` int(11) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `status` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `box_id` (`box_id`),
  KEY `accept_date` (`accept_date`),
  KEY `new_box_id` (`new_box_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `hash` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `last_ip` varchar(15) NOT NULL,
  `last_date` datetime NOT NULL,
  PRIMARY KEY (`hash`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE IF NOT EXISTS `sites` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `hostname` varchar(200) NOT NULL,
  `topic` text,
  `add_date` datetime NOT NULL,
  `click_price` float(12,2) NOT NULL DEFAULT '0.00',
  `view_price` float(12,2) NOT NULL DEFAULT '0.00',
  `time_price` float(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `hostname` (`hostname`),
  KEY `add_date` (`add_date`),
  KEY `click_price` (`click_price`),
  KEY `view_price` (`view_price`),
  KEY `time_price` (`time_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `statistics`
--

CREATE TABLE IF NOT EXISTS `statistics` (
  `date` datetime NOT NULL,
  `order_id` int(11) unsigned NOT NULL,
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  KEY `order_id` (`order_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `referral_id` int(11) unsigned DEFAULT NULL,
  `login` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `password_end` varchar(50) NOT NULL,
  `activate` tinyint(4) NOT NULL DEFAULT '0',
  `mail` varchar(50) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `balance` float(12,3) unsigned NOT NULL DEFAULT '0.000',
  `register_date` datetime NOT NULL,
  `register_ip` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `sex` enum('man','woman','other') DEFAULT 'other',
  `country` varchar(30) DEFAULT NULL,
  `region` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `site` varchar(200) DEFAULT NULL,
  `icq` bigint(20) unsigned DEFAULT NULL,
  `about` text,
  `avatar` varchar(250) DEFAULT NULL,
  `automatic_mode` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `mail` (`mail`),
  KEY `referral_id` (`referral_id`),
  KEY `referral_id_2` (`referral_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `boxes`
--
ALTER TABLE `boxes`
  ADD CONSTRAINT `boxes_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `day_operations`
--
ALTER TABLE `day_operations`
  ADD CONSTRAINT `day_operations_ibfk1` FOREIGN KEY (`operation_id`) REFERENCES `operations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `operations`
--
ALTER TABLE `operations`
  ADD CONSTRAINT `operations_ibfk1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `operations_ibfk2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `operations_ibfk3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`new_box_id`) REFERENCES `boxes` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`);

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `statistics_fk1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`referral_id`) REFERENCES `users` (`id`);
