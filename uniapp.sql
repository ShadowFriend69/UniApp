-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 30 2024 г., 10:03
-- Версия сервера: 8.0.31
-- Версия PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `uniapp`
--

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

CREATE TABLE `city` (
  `city_id` int NOT NULL COMMENT 'id города',
  `city` varchar(25) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'название города'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `city`
--

INSERT INTO `city` (`city_id`, `city`) VALUES
(1, 'Москва'),
(3, 'Уфа'),
(4, 'Казань');

-- --------------------------------------------------------

--
-- Структура таблицы `edu`
--

CREATE TABLE `edu` (
  `education_id` int NOT NULL COMMENT 'id  типа образования',
  `education` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'образование'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `edu`
--

INSERT INTO `edu` (`education_id`, `education`) VALUES
(1, 'среднее'),
(2, 'бакалавр'),
(3, 'магистр'),
(4, 'специалитет'),
(5, 'среднеее');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL COMMENT 'id пользователя',
  `user_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'имя пользователя'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Таблица пользователей';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `user_name`) VALUES
(1, 'Тест'),
(2, 'Тест1'),
(3, 'Тестовый'),
(4, 'Тест'),
(5, 'Имя');

-- --------------------------------------------------------

--
-- Структура таблицы `user_cities`
--

CREATE TABLE `user_cities` (
  `user_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `user_cities`
--

INSERT INTO `user_cities` (`user_id`, `city_id`) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 1),
(5, NULL),
(1, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `user_education`
--

CREATE TABLE `user_education` (
  `user_id` int DEFAULT NULL,
  `education_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `user_education`
--

INSERT INTO `user_education` (`user_id`, `education_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`);

--
-- Индексы таблицы `edu`
--
ALTER TABLE `edu`
  ADD PRIMARY KEY (`education_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Индексы таблицы `user_cities`
--
ALTER TABLE `user_cities`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Индексы таблицы `user_education`
--
ALTER TABLE `user_education`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `education_id` (`education_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int NOT NULL AUTO_INCREMENT COMMENT 'id города', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `edu`
--
ALTER TABLE `edu`
  MODIFY `education_id` int NOT NULL AUTO_INCREMENT COMMENT 'id  типа образования', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT COMMENT 'id пользователя', AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `user_cities`
--
ALTER TABLE `user_cities`
  ADD CONSTRAINT `user_cities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_cities_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Ограничения внешнего ключа таблицы `user_education`
--
ALTER TABLE `user_education`
  ADD CONSTRAINT `user_education_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_education_ibfk_2` FOREIGN KEY (`education_id`) REFERENCES `edu` (`education_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
