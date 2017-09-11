DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE Bookstore;
USE bookstore;
CREATE TABLE Books (
`IDbook` int NOT NULL AUTO_INCREMENT,
`authorName` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`authorSurname` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`title` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`price` float,
PRIMARY KEY (`IDbook`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE Customers (
`IDcustomer` int NOT NULL AUTO_INCREMENT,
`customerName` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`customerSurname` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`city` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`IDcustomer`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE Orders (
`IDorder` int NOT NULL AUTO_INCREMENT,
`IDcustomer` int NOT NULL,
`IDbook` int NOT NULL,
`orderDate` DATE,
`status` varchar(20) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`IDorder`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

#INSERT

INSERT INTO books (authorName, authorSurname, title, price) values 
("Jan", "Michalak", "Zaawansowane programowanie w PHP", 47.29),
("Andrzej", "Krawczyk", "Windows 10 PL. Zaawansowane zarządzanie systemem", 49.99),
("Paweł", "Jakubowski", "HTML5.Tworzenie witryn", 53.65),
("Tomasz", "Kowalski", "Urządzenia techniki komputerowej", 34.15),
("Łukasz", "Pasternak", "Java:Tworzenie nowoczesnych stron WWW", 29.99);

INSERT INTO customers (customerName, customerSurname, city) values
("Łukasz", "Lewandowski", "Poznań"),
("Jan", "Nowak", "Katowice"),
("Maciej", "Wójcik", "Bydgoszcz"),
("Agnieszka", "Jankowska", "Lublin"),
("Tomasz", "Mazur", "Jelenia Góra"),
("Michał", "Zieliński", "Kraków"),
("Artur", "Rutkowski", "Kielce"),
("Mateusz", "Skorupa", "Gdańsk"),
("Jerzy", "Rutkowski", "Włóżmitu"),
("Anna", "Karenna", "Tumidaj");

INSERT INTO orders (IDcustomer, idbook, orderdate, status) values
(2,4, "2017-10-08", "oczekiwanie"),
(7,1, "2017-09-05", "wysłano"),
(9,1, "2017-10-11", "wysłano"),
(2,2, "2017-10-15", "oczekiwanie"),
(2,5, "2017-08-12", "oczekiwanie"),
(3,2, "2017-10-20", "wysłano"),
(4,3, "2017-08-14", "wysłano"),
(8,1, "2017-08-19", "wysłano"),
(3,1, "2017-11-19", "wysłano"),
(9,2, "2017-12-28", "oczekiwanie");

#powtórzenie
#select title from books order by title asc;
#select * from books where price = (select max(price) from books);
#select * from orders where status = "wysłano";
#select * from customers where customersurname = "rutkowski";
#select * from books where title like "%php%";
#select * from orders order by orderdate asc;


/*SELECT c.customername, c.customersurname, o.idorder, o.orderdate 
FROM customers as c, orders as o
WHERE o.idcustomer = c.idcustomer;*/

/*select c.customername, c.customersurname 
from customers as c, orders as o
where o.idbook = 2 and c.idcustomer = o.idcustomer;*/

/*select b.title, b.authorname, b.authorsurname
from books as b, orders as o, customers as c
where c.customername = "Jan" and c.customersurname="nowak" 
and c.idcustomer = o.idcustomer and o.idbook = b.idbook;*/

select c.customername, c.customersurname, o.idorder, o.orderdate, o.status, b.title
from customers as c, orders as o, books as b
where c.customersurname="rutkowski" and c.idcustomer = o.idorder and o.idbook = b.idbook 
order by o.orderdate asc ;
 










