-- phpMyAdmin SQL Dump
-- version 3.3.4
-- http://www.phpmyadmin.net
--
-- Хост: db36.valuehost.ru
-- Время создания: Июн 25 2012 г., 17:42
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
  `alt` varchar(200) default NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `add_date` (`add_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `day_operations`
--

CREATE TABLE IF NOT EXISTS `day_operations` (
  `operation_id` int(11) unsigned NOT NULL,
  `summ` float(12,3) NOT NULL,
  `date` datetime NOT NULL,
  KEY `operation_id` (`operation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `operations`
--

CREATE TABLE IF NOT EXISTS `operations` (
  `id` int(11) unsigned NOT NULL,
  `sender_id` int(11) unsigned NOT NULL,
  `receiver_id` int(11) unsigned default NULL,
  `order_id` int(11) unsigned default NULL,
  `type` enum('0','1') NOT NULL default '0',
  `summ` float(12,3) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `date` (`date`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `add_date` datetime NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  `box_id` int(11) unsigned NOT NULL,
  `clicks_limit` int(11) unsigned default NULL,
  `views_limit` int(11) unsigned default NULL,
  `period` int(11) default NULL,
  `accept_date` datetime default NULL,
  `clicks` int(11) NOT NULL default '0',
  `views` int(11) NOT NULL default '0',
  `status` enum('0','1','2','3') NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`),
  KEY `box_id` (`box_id`),
  KEY `accept_date` (`accept_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `hash` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `last_ip` varchar(15) NOT NULL,
  `last_date` datetime NOT NULL,
  PRIMARY KEY  (`hash`),
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
  `topic` text,
  `add_date` datetime NOT NULL,
  `click_price` float(12,3) NOT NULL default '0.000',
  `view_price` float(12,3) NOT NULL default '0.000',
  `time_price` float(12,3) NOT NULL default '0.000',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `hostname` (`hostname`),
  KEY `add_date` (`add_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `statistics`
--

CREATE TABLE IF NOT EXISTS `statistics` (
  `date` datetime NOT NULL,
  `order_id` int(11) unsigned NOT NULL,
  `clicks` int(11) unsigned NOT NULL default '0',
  `views` int(11) unsigned NOT NULL default '0',
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `referral_id` int(11) unsigned  default NULL,
  `login` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `password_end` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `phone` varchar(30) default NULL,
  `balance` float(12,3) unsigned NOT NULL default '0.000',
  `register_date` datetime NOT NULL,
  `register_ip` varchar(20) NOT NULL,
  `name` varchar(50) default NULL,
  `surname` varchar(50) default NULL,
  `sex` enum('man','woman','other') default 'other',
  `country` varchar(30) default NULL,
  `region` varchar(30) default NULL,
  `city` varchar(30) default NULL,
  `birthday` datetime default NULL,
  `site` varchar(200) default NULL,
  `icq` bigint(20) unsigned default NULL,
  `about` text,
  `avatar` varchar(250) default NULL,
  `automatic_mode` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `mail` (`mail`),
  KEY `referral_id` (`referral_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `boxes`
--
ALTER TABLE `boxes`
  ADD CONSTRAINT `boxes_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `day_operations`
--
ALTER TABLE `day_operations`
  ADD CONSTRAINT `day_operations_ibfk1` FOREIGN KEY (`operation_id`) REFERENCES `operations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `operations`
--
ALTER TABLE `operations`
  ADD CONSTRAINT `operations_ibfk1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `operations_ibfk2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `operations_ibfk3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `statistics_fk1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
