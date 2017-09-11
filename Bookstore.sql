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


