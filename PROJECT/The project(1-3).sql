/* В данном курсовом проекте ,я постарался сделать реляционную базу данных книжного онлайн-магазина.В данной базе данных у нас хранится информация 
о пользователях данного магазина,их данные,книги,их жанры,информация о покупках ,о продавцах,скидки ,сообщения между продавцами и покупателями. */





DROP DATABASE IF EXISTS booksshop;
CREATE DATABASE booksshop;
USE booksshop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED,
	INDEX users_firstname_lastname_idx(firstname,lastname)

);

INSERT INTO users
	(firstname, lastname,email,phone)
VALUES 
	('Антон','Шипулин','brevno1@inbox.ru',89003003030),
	('Антон','Ярцев','brevno2@inbox.ru',89003003031),
	('Сергей','Шемп','brevno3@inbox.ru',89003003032),
	('Игорь','Жбанков','brevno4@inbox.ru',89003003033),
	('Анатолий','Медведев','brevno5@inbox.ru',89003003034),
	('Максим','Губанов','brevno6@inbox.ru',89003003035),
	('Ренат','Фахрутдинов','brevno7@inbox.ru',89003003036),
	('Ярослав','Кобрин','brevno8@inbox.ru',89003003037),
	('Остап','Бендер','brevno9@inbox.ru',89003003038),
	('Евгений','Евтушенко','brevno10@inbox.ru',89003003039);

	

DROP TABLE IF EXISTS profiles; -- Профиль наших ПОЛЬЗОВАТЕЛЕЙ
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	gender CHAR(1),
	birthday DATE,
	hometown VARCHAR(255),
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO profiles
	(gender,birthday,hometown)
VALUES 
	('m','1990-12-20','Omsk'),
	('m','1991-11-21','Omsk'),
	('m','1992-10-22','Omsk'),
	('m','1993-12-23','Omsk'),
	('m','1994-09-24','Omsk'),
	('m','1995-08-25','Omsk'),
	('m','1996-11-26','Omsk'),
	('m','1997-10-27','Omsk'),
	('m','1998-06-28','Omsk'),
	('m','1999-05-29','Omsk');

	




DROP TABLE IF EXISTS books;    -- КНИГИ
CREATE TABLE books (
	id SERIAL PRIMARY KEY,
	name VARCHAR(120),
	author VARCHAR (120)
);


INSERT INTO books
	(name, author)
VALUES 
('1984','Джордж Оруэлл'),
('Время жить и время умирать','Эрих Мария Ремарк'),
('Женщины','Чарльз Буковски'),
('Герой нашего времени','М.Ю. Лермонтов'),
('По ком звонит колокол','Эрнест Хемингуэй'),
('Памяти Каталонии','Джордж Оруэлл'),
('О новый дивный мир!','Олдос Хаксли'),
('Три товарища','Эрих Мария Ремарк'),
('Триумфальная арка','Эрих Мария Ремарк'),
('На западном фронте без перемен','Эрих Мария Ремарк'),
('Кирпичи','Данияр Сугралинов'),
('Скотный двор','Джордж Оруэлл'),
('Анна Каренина','Л.Толстой'),
('Об алкоголе','Чарльз Буковски'),
('Тысяча жизней','Жан-Поль Бельмондо'),
('Мужские правила','Марк Мэнсон'),
('Куда приводят мечты','Ричард Матесон'),
('Сталин.Жизнь одного вождя','Олег Хлевнюк'),
('Вторая жизнь','Маша Трауб'),
('Бесприданница','Александр Островский'),
('Прощай оружие','Эрнест хемингуэй'),
('Капитанская дочка','А.С. Пушкин');



DROP TABLE IF EXISTS buy;    -- Приобритение книг
CREATE TABLE buy (
	user_id BIGINT UNSIGNED NOT NULL,
	book_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id,book_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (book_id) REFERENCES books(id) ON UPDATE CASCADE ON DELETE CASCADE	
);

INSERT INTO buy 
	(user_id,book_id)
VALUES 
	('1','3'),
	('2','4'),
	('3','5'),
	('4','6'),
	('5','7'),
	('6','8'),
	('7','9'),
	('8','10'),
	('9','11'),
	('10','12'),
	('1','13'),
	('2','14'),
	('3','15'),
	('4','16'),
	('5','17'),
	('6','18'),
	('7','19'),
	('8','20'),
	('9','21');

	

DROP TABLE IF EXISTS sellers;  -- Помощник(продавец) на сайте
CREATE TABLE sellers (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(120),
	lastname VARCHAR(120),
	birthday DATE,
	gender CHAR(1)
	
);

INSERT INTO sellers
	(firstname , lastname,birthday,gender)
VALUES 
	('Семен','Сурунов','1990-12-30','м'),
	('Виктор','Обухов','1989-11-21','м'),
	('Анна','Ярик','1995-02-11','ж');
	-- TRUNCATE  sellers;
	-- DELETE FROM sellers;
	--  UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'sellers';
	

DROP TABLE IF EXISTS discounts;   -- Скидки
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	book_id BIGINT UNSIGNED NOT NULL,
	discount BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (book_id) REFERENCES books(id) ON UPDATE CASCADE ON DELETE CASCADE

);

INSERT INTO discounts  
	(book_id,discount)
VALUES	
	('2','20'),
	('3','30'),
	('5','5'),
	('12','10'),
	('6','25'),
	('7','5'),
	('8','10'),
	('9','5'),
	('10','10'),
	('11','15');

DROP TABLE IF EXISTS genre;   -- Жанр книг (НЕ СДЕЛАЛ.УТОЧНИТЬ)
CREATE TABLE genre (
	id SERIAL PRIMARY KEY,
	book_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(120),
	FOREIGN KEY (book_id) REFERENCES books(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO genre
	(name,book_id)
VALUES 
	('Антиутопия','1'),
	('Роман','2'),
	('Роман','3'),
	('Приключения','4'),
	('Драма','5'),
	('Роман','6'),
	('Антиутопия','7'),
	('Роман','8'),
	('Роман','9'),
	('Роман','10'),
	('Приключения','11'),
	('Антиутопия','12'),
	('Драма','13'),
	('Автобиография','14'),
	('Автобиография','15'),
	('Приключения','16'),
	('Драма','17'),
	('Автобиография','18'),
	('Драма','19'),
	('Роман','20'),
	('Драма','21'),
	('Приключения','22');
	



DROP TABLE IF EXISTS messages;   -- Сообщения
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL, -- ОТПРАВИТЕЛЬ
	seller_id BIGINT UNSIGNED NOT NULL,  -- Получатель (продавец)
	body TEXT,
	created_at DATETIME DEFAULT NOW(),   -- ДАТА СОЗДАНИЯ СООБЩЕНИЯ
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (seller_id) REFERENCES sellers(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO messages
	(user_id,seller_id,body)
VALUES 
('1','2','Здравствуйте.Есть ли у вас Оруэлл?'),
('2','2','Привет,тебе помочь?'),
('3','1','Здравствуйте.'),
('4','1','Спасибо,за помощь!'),
('5','1','Здравствуйте.Есть ли у вас Ремарк?'),
('1','2','Здравствуйте.Есть ли у вас Буковски?'),
('6','1','Хеллоу'),
('7','2','Спасибо,До свидания!?'),
('8','3','Здравствуйте,как ваше настроение?'),
('9','2','Вы мне не поможете?'),
('10','2','Книги очень дорогие'); 

DROP TABLE IF EXISTS feedback;    -- Отзыв
CREATE TABLE feedback (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
	
);
  INSERT INTO feedback
	(user_id,body)
VALUES 
('1','Мне всё понравилось'),
('2','Доволен'),
('3','Книга,отстой!'),
('1','Мне всё понравилось'),
('5','Мне всё понравилось'),
('1','Не очень'),
('7','Ха-ха-ха'),
('9','Я под впечатлением.'),
('1','Хорошая книга!'),
('10','Ура!'); 


