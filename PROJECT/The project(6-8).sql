
--  6) JOIN
-- Показать пользователей,которые купили хотя бы одну книгу.
USE booksshop;
SELECT u.firstname,u.lastname 
FROM 
	users AS u 
JOIN 
	buy b 	
ON b.user_id = u.id;
-- GROUP BY u.firstname ,u.lastname ;

-- Посчитать,какое количество сообщений отправил пользователь с id= 1?

USE booksshop;
SELECT 
	COUNT(*)
FROM 
	messages m 
JOIN 
	users u 
ON m.user_id = u.id
WHERE user_id = 1;



-- Показать какие книги покупали пользователи младше 25 лет
USE booksshop ;
SELECT
	name,author 
FROM
	books b 
JOIN 
	buy b2 ON b.id = b2.book_id 
JOIN 
	users u ON b2.user_id =u.id 
JOIN 
	profiles p ON u.id = p.user_id 
WHERE TIMESTAMPDIFF(YEAR,birthday,NOW()) < 25;


-- Сколько сообщений получил продавец с id =2
USE booksshop;
SELECT 
	COUNT(*)
FROM 
	messages m 
JOIN 
	sellers s 
ON s.id = m.seller_id 
WHERE seller_id = 2;


-- Какого жанра книга,которую купил пользователь c id = 2?(Скрипт не выполняется ,не могу понять почему)
USE booksshop ;
SELECT
	name,id
FROM 
	genre g 
JOIN
	books b ON b.id = g.book_id 
JOIN 
	 buy b2 ON b.id = b2.book_id 
JOIN 
	users u ON b2.user_id =u.id 
WHERE user_id =2;


-- Вывести на экран всех пользователей и их отзывы.Выводить пользователей,даже если они ничего не писали

USE booksshop ;
SELECT 
	firstname,lastname 
FROM 
	users u 
LEFT JOIN 
	feedback f ON f.user_id = u.id
    
-- 7)ПРЕДСТАВЛЕНИЯ    
    
    -- Показать книги,которые присутствуют в магазине и их жанры 
	
CREATE VIEW list AS
	SELECT books.name AS BOOK,
		genre.name AS GENRE
			from books,genre
				WHERE books.id = genre.book_id ;
SELECT * FROM list
	
-- Показать имена пользователей и их дату рождения

CREATE VIEW people AS 
	SELECT users.lastname ,users.firstname AS NAME,
		profiles.gender AS GENDER
			from users,profiles 
				WHERE profiles.user_id = users.id ;
SELECT * FROM people



-- 8)ФУНКЦИИ И ТРИГГЕРЫ

-- Функция,которая показывает профили,в зависимости от  введённого возраста


USE booksshop
DELIMITER //
DROP PROCEDURE IF EXISTS promo//
CREATE PROCEDURE promo (IN num BIGINT) 
BEGIN
	IF (num > 27) THEN
		SELECT user_id,gender,hometown FROM profiles WHERE birthday IN (SELECT birthday FROM profiles WHERE TIMESTAMPDIFF(YEAR,birthday,NOW()) > 27 ) ;
	ELSEIF (num < 27) THEN
		SELECT user_id,gender,hometown FROM profiles WHERE birthday IN (SELECT birthday FROM profiles WHERE TIMESTAMPDIFF(YEAR,birthday,NOW()) < 27 ) ;
	ELSE 
		SELECT user_id,gender,hometown FROM profiles WHERE birthday IN (SELECT birthday FROM profiles WHERE TIMESTAMPDIFF(YEAR,birthday,NOW()) = 27 ) ;
	END IF;
END // 
delimiter ;

CALL promo(20);


-- Функция,которая показывает книги, по указанной скидке.


USE bookshop 
DELIMITER //
DROP PROCEDURE IF EXISTS disc//
CREATE PROCEDURE disc (IN num BIGINT)
BEGIN 
	IF (num = 5) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 5);
	ELSEIF (num = 10) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 10);
	ELSEIF (num = 15) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 15);
	ELSEIF (num = 20) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 20);
	ELSEIF (num = 25) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 25);
	ELSEIF (num = 30) THEN 
		SELECT book_id FROM discounts WHERE discount IN (SELECT discount FROM discounts WHERE discount = 30);
	ELSE SELECT 'Такой скидки нет!';
	END IF;
END//
delimiter ;

CALL disc(145);



-- Триггеры

-- Триггер ,который выведет переменную,где подсчитает кол-во сообщений 
USE bookshop 
delimiter //
DROP TRIGGER IF EXISTS show_count//
CREATE TRIGGER show_count BEFORE INSERT on messages
FOR EACH ROW 
BEGIN 
	SELECT COUNT(*) INTO @total FROM messages ;
END//


SELECT * FROM messages m 
SELECT @total;



-- Создадим доп.таблицу prices и пусть триггер подсчитает сумму товаров

USE bookshop 
delimiter //
DROP TABLE IF EXISTS prices//
CREATE TABLE prices (
	id SERIAL PRIMARY KEY,
	schoolbook BIGINT UNSIGNED NOT NULL,
	journal BIGINT UNSIGNED NOT NULL,
	newspaper BIGINT UNSIGNED NOT NULL,
	total BIGINT UNSIGNED NOT NULL
)//

delimiter //
DROP TRIGGER IF EXISTS price_on_insert//
CREATE TRIGGER price_on_insert BEFORE INSERT ON prices
FOR EACH ROW 
BEGIN 
	SET NEW.total = NEW.schoolbook + NEW.journal + NEW.newspaper ; 
END//
  
delimiter //
DROP TRIGGER IF EXISTS price_on_update//
CREATE TRIGGER price_on_update BEFORE UPDATE ON prices
FOR EACH ROW 
BEGIN 
	SET NEW.total = NEW.schoolbook + NEW.journal + NEW.newspaper ;
END//
 


INSERT INTO prices 
	(schoolbook,journal,newspaper)
VALUES
	(200,150,270);

SELECT * FROM prices;



		
		


