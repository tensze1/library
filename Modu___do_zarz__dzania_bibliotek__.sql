-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 25 2025 г., 11:53
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Moduł do zarządzania biblioteką`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ActivityLog`
--

CREATE TABLE `ActivityLog` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `log_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Books`
--

CREATE TABLE `Books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `year_published` int(11) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `available_copies` int(11) DEFAULT 1,
  `total_copies` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Books`
--

INSERT INTO `Books` (`book_id`, `title`, `author`, `publisher`, `year_published`, `isbn`, `category_id`, `available_copies`, `total_copies`) VALUES
(1, '1984', 'George Orwell', 'Secker & Warburg', 1949, '9780451524935', 1, 3, 3),
(2, 'The Pragmatic Programmer', 'Andrew Hunt, David Thomas', 'Addison-Wesley', 1999, '9780201616224', 2, 2, 2),
(3, 'A Brief History of Time', 'Stephen Hawking', 'Bantam', 1988, '9780553380163', 3, 2, 2),
(4, 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, '9780132350884', 2, 1, 1),
(5, 'Harry Potter and the Philosopher’s Stone', 'J.K. Rowling', 'Bloomsbury', 1997, '9780747532699', 4, 4, 5),
(6, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, '9780743273565', 5, 2, 2),
(7, 'The Art of War', 'Sun Tzu', 'Oxford Univ Press', -500, '9780195015409', 6, 1, 1),
(8, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'Harper', 2011, '9780062316097', 7, 2, 2),
(9, 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Farrar, Straus', 2011, '9780374533557', 8, 3, 3),
(10, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Allen & Unwin', 1954, '9780261103252', 4, 2, 2),
(11, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1960, '9780061120084', 5, 3, 3),
(12, 'Introduction to Algorithms', 'Cormen, Leiserson, Rivest, Stein', 'MIT Press', 2009, '9780262033848', 2, 2, 2),
(13, 'Deep Work', 'Cal Newport', 'Grand Central Publishing', 2016, '9781455586691', 8, 2, 2),
(14, 'Dune', 'Frank Herbert', 'Chilton Books', 1965, '9780441172719', 4, 3, 3),
(15, 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 1951, '9780316769488', 5, 2, 2),
(16, 'Zero to One', 'Peter Thiel', 'Crown Business', 2014, '9780804139298', 8, 2, 2),
(17, 'Cosmos', 'Carl Sagan', 'Random House', 1980, '9780345331359', 3, 1, 1),
(18, 'Brave New World', 'Aldous Huxley', 'Chatto & Windus', 1932, '9780060850524', 1, 2, 2),
(19, 'The Clean Coder', 'Robert C. Martin', 'Prentice Hall', 2011, '9780137081073', 2, 1, 1),
(20, 'Homo Deus', 'Yuval Noah Harari', 'Harper', 2015, '9780062464316', 7, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Categories`
--

CREATE TABLE `Categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Categories`
--

INSERT INTO `Categories` (`category_id`, `name`) VALUES
(5, 'Classic Literature'),
(4, 'Fantasy'),
(1, 'Fiction'),
(7, 'History / Sociology'),
(2, 'IT / Programming'),
(6, 'Philosophy / Strategy'),
(8, 'Psychology / Economy'),
(3, 'Science');

-- --------------------------------------------------------

--
-- Структура таблицы `Loans`
--

CREATE TABLE `Loans` (
  `loan_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `loan_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('borrowed','returned','overdue') DEFAULT 'borrowed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Penalties`
--

CREATE TABLE `Penalties` (
  `penalty_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `issued_date` date NOT NULL,
  `paid` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ActivityLog`
--
ALTER TABLE `ActivityLog`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `Loans`
--
ALTER TABLE `Loans`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Индексы таблицы `Penalties`
--
ALTER TABLE `Penalties`
  ADD PRIMARY KEY (`penalty_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Индексы таблицы `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ActivityLog`
--
ALTER TABLE `ActivityLog`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `Books`
--
ALTER TABLE `Books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `Categories`
--
ALTER TABLE `Categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `Loans`
--
ALTER TABLE `Loans`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `Penalties`
--
ALTER TABLE `Penalties`
  MODIFY `penalty_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `ActivityLog`
--
ALTER TABLE `ActivityLog`
  ADD CONSTRAINT `activitylog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Ограничения внешнего ключа таблицы `Books`
--
ALTER TABLE `Books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`category_id`);

--
-- Ограничения внешнего ключа таблицы `Loans`
--
ALTER TABLE `Loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  ADD CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`);

--
-- Ограничения внешнего ключа таблицы `Penalties`
--
ALTER TABLE `Penalties`
  ADD CONSTRAINT `penalties_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `Loans` (`loan_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
