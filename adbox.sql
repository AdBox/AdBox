-- phpMyAdmin SQL Dump
-- version 3.3.4
-- http://www.phpmyadmin.net
--
-- Хост: db36.valuehost.ru
-- Время создания: Июн 24 2012 г., 14:09
-- Версия сервера: 5.0.90
-- Версия PHP: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `zanzibar2_adbo`
--

-- --------------------------------------------------------

--
-- Структура таблицы `boxes`
--

CREATE TABLE IF NOT EXISTS `boxes` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `src` varchar(500) NOT NULL,
  `href` varchar(500) NOT NULL,
  `alt` varchar(200) NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `date` datetime NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  `box_id` int(11) unsigned NOT NULL,
  `clicks_limit` int(11) unsigned default NULL,
  `views_limit` int(11) unsigned default NULL,
  `end_time` datetime default NULL,
  `clicks_count` int(11) default NULL,
  `views_count` int(11) default NULL,
  `status` enum('0','1','2','3') NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`),
  KEY `box_id` (`box_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `key` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `ip_create` varchar(15) NOT NULL,
  `ip_last` varchar(15) NOT NULL,
  `date_create` datetime NOT NULL default '0000-00-00 00:00:00',
  `date_last` datetime NOT NULL,
  PRIMARY KEY  (`key`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `sites`
--

CREATE TABLE IF NOT EXISTS `sites` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `hostname` varchar(200) NOT NULL,
  `theme` varchar(500) NOT NULL,
  `date_add` datetime NOT NULL,
  `click_price` float(12,3) NOT NULL default '1.000',
  `view_price` float(12,3) NOT NULL default '1.000',
  `time_price` float(12,3) NOT NULL default '1.000',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `statistics`
--

CREATE TABLE IF NOT EXISTS `statistics` (
  `date` datetime NOT NULL,
  `order_id` int(11) unsigned NOT NULL,
  `clicks_count` int(11) unsigned NOT NULL,
  `views_count` int(11) unsigned NOT NULL,
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `login` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `phone` varchar(30) default NULL,
  `balance` float(12,3) unsigned NOT NULL default '0.000',
  `date_register` datetime NOT NULL,
  `ip_register` varchar(20) NOT NULL,
  `name` varchar(50) default NULL,
  `surname` varchar(50) default NULL,
  `sex` enum('man','woman','other') NOT NULL default 'other',
  `country` varchar(30) default NULL,
  `region` varchar(30) default NULL,
  `city` varchar(30) default NULL,
  `birthday` datetime default NULL,
  `site` varchar(200) default NULL,
  `icq` bigint(20) unsigned default NULL,
  `about` text,
  `date` datetime default NULL,
  `avatar` varchar(250) default NULL,
  `foto` varchar(250) default NULL,
  `automatic` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `boxes`
--
ALTER TABLE `boxes`
  ADD CONSTRAINT `boxes_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_fk` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `statistics_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
