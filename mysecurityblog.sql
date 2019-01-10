-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 10 2019 г., 10:21
-- Версия сервера: 10.1.33-MariaDB
-- Версия PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mysecurityblog`
--

-- --------------------------------------------------------

--
-- Структура таблицы `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `caption` varchar(45) NOT NULL COMMENT 'Заголовок статьи',
  `text` text NOT NULL COMMENT 'Текст статьи',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата добавления статьи.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL COMMENT 'Текст коментария',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата коментария',
  `users_login` varchar(15) NOT NULL COMMENT 'Юзер пославший коментарий',
  `articles_id` int(11) NOT NULL COMMENT 'Статья, которой послан коментарий'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `groupuser`
--

CREATE TABLE `groupuser` (
  `name` varchar(20) NOT NULL COMMENT 'Наименование группы',
  `users_login` varchar(15) NOT NULL COMMENT 'Вторичный ключ от таблицы users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `groupuser`
--

INSERT INTO `groupuser` (`name`, `users_login`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Структура таблицы `groupuser_has_articles`
--

CREATE TABLE `groupuser_has_articles` (
  `groupuser_name` varchar(20) NOT NULL,
  `articles_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `login` varchar(15) NOT NULL COMMENT 'Логин',
  `password` varchar(64) NOT NULL COMMENT 'Пароль'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`login`, `password`) VALUES
('admin', '123456');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `caption_UNIQUE` (`caption`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comments_users` (`users_login`),
  ADD KEY `fk_comments_articles` (`articles_id`);

--
-- Индексы таблицы `groupuser`
--
ALTER TABLE `groupuser`
  ADD PRIMARY KEY (`name`),
  ADD KEY `fk_groupuser_users` (`users_login`);

--
-- Индексы таблицы `groupuser_has_articles`
--
ALTER TABLE `groupuser_has_articles`
  ADD PRIMARY KEY (`groupuser_name`,`articles_id`),
  ADD KEY `fk_groupuser_has_articles_articles` (`articles_id`),
  ADD KEY `fk_groupuser_has_articles_groupuser` (`groupuser_name`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_articles` FOREIGN KEY (`articles_id`) REFERENCES `articles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comments_users` FOREIGN KEY (`users_login`) REFERENCES `users` (`login`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `groupuser`
--
ALTER TABLE `groupuser`
  ADD CONSTRAINT `fk_groupuser_users` FOREIGN KEY (`users_login`) REFERENCES `users` (`login`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `groupuser_has_articles`
--
ALTER TABLE `groupuser_has_articles`
  ADD CONSTRAINT `fk_groupuser_has_articles_articles` FOREIGN KEY (`articles_id`) REFERENCES `articles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_groupuser_has_articles_groupuser` FOREIGN KEY (`groupuser_name`) REFERENCES `groupuser` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
