DROP DATABASE IF EXISTS clinic;
CREATE DATABASE clinic;
USE clinic;

#CREATE

CREATE TABLE Patients (
`IDpatient` int NOT NULL AUTO_INCREMENT,
`patientName` varchar(40) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`patientSurname` varchar(40) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`dateOfBirth` date NOT NULL,
`City` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`Address` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`Gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`IDpatient`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE Doctors (
`IDdoctor` int NOT NULL AUTO_INCREMENT,
`doctorName` varchar(40) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`doctorSurname` varchar(40) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`IDdoctor`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE WorkHours (
`IDworkhour` int NOT NULL AUTO_INCREMENT,
`IDdoctor` int NOT NULL,
`workstart` int NOT NULL,
`workend` int NOT NULL,
PRIMARY KEY (`IDworkhour`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE Visits (
`IDvisit` int NOT NULL AUTO_INCREMENT,
`IDdoctor` int NOT NULL,
`IDpatient` int NOT NULL,
`visitDate` datetime NOT NULL,
PRIMARY KEY (`IDvisit`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

CREATE TABLE Prescriptions (
`IDprescription` int NOT NULL AUTO_INCREMENT,
`IDvisit` int NOT NULL,
`presMedicines` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
PRIMARY KEY (`IDprescription`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;


CREATE TABLE Activities (
`IDactivity` int NOT NULL AUTO_INCREMENT,
`activityDescription` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
`timeOfActivity` datetime NOT NULL,
PRIMARY KEY (`IDactivity`))
DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1;

#INSERT

INSERT INTO Patients (patientName, patientSurname, dateofbirth, city, address, gender) values 
("Jan", "Nowak", "1967-09-25", "Wrocław", "Na Grobli 2/5", "M"),
("Janina", "Piła", "1923-11-02", "Wrocław", "Kościuszki 22b/15", "F"),
("Jakub", "Wojdyn", "1990-02-01", "Oleśnica", "Na Grobli 12c/55", "M");

INSERT INTO Doctors (doctorName, doctorSurname) values 
("Jerzy", "Karzeł"),
("Krystyna", "Danielczuk"),
("Lech", "Kaczyński");

INSERT INTO Workhours (IDdoctor, workstart, workend) values 
("Jerzy", "Karzeł"),
("Krystyna", "Danielczuk"),
("Lech", "Kaczyński");

delimiter |
Create Trigger addPatient
after insert on patients
for each row
begin 
insert  into activities 
set message= (select(concat("Pacjent :", new.patientname," ", new.patientsurname, "dodał sie do bazy pacjentów")));
insert into visits(iddoctor, idpatient, visitdate) values (1, null, 
END

















