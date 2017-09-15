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
`visitDate` date NOT NULL,
`visitHour` time not null,
`visitStatus` varchar (15) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
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
("Jakub", "Wojdyn", "1990-02-01", "Oleśnica", "Na Grobli 12c/55", "M"),
("Bogumił", "Wał", "1984-11-01", "Wrocław", "Kościuszki 2b/11", "M"),
("Marianna", "Srocz", "1946-05-25", "Legnica", "Wrocławska 2", "F"),
("Krystyna", "Gaz", "1977-07-07", "Wrocław", "Legnicka 5c/5", "F"),
("Damian", "Dawidowicz", "1988-03-11", "Sobótka", "3", "M");

INSERT INTO Doctors (doctorName, doctorSurname) values 
("Jerzy", "Karzeł"),
("Krystyna", "Danielczuk"),
("Lech", "Kaczyński"),
("Maria", "Lewa-Tywa");

INSERT INTO Workhours (IDdoctor, workstart, workend) values 
(1, 06, 14),
(2, 10, 18),
(3, 14, 22),
(4, 22, 06);

INSERT INTO  visits (IDdoctor, IDpatient,visitdate, visithour, visitstatus) values 
(1,1,"2017-09-14", "07:30:00", "arranged"),
(1,4,"2017-09-12", "09:30:00", "arranged"),
(2,5,"2017-09-18", "12:30:00", "arranged"),
(3,7,"2017-09-15", "14:00:00", "completed"),
(4,6,"2017-09-14", "04:30:00", "completed");

INSERT INTO prescriptions (IDvisit, presmedicines) values 
(4, "Ibuprofen, cough syrup"),
(5, "APAP, MAXIGRA");





# TRIGGERS (wszystkie trigger rejestruja czas ustawienia wpisu w tabeli activities w formie data/godzina wpisu)

# trigger dodaje informację do activities o tym, że pacjent dodał sie do bazy, jednocześnie ustawia mu wizytę, a że pacjent przyszedł nagle, tzn. że go boli a więc czas wizyty ustawia na teraz.
delimiter |
Create Trigger addPatient
after insert on patients
for each row
begin 
insert  into activities 
set activityDescription= (select(concat("Pacjent : ", new.patientname," ", new.patientsurname, " dodał sie do bazy pacjentów"))), timeofactivity=now();
insert into visits(iddoctor, idpatient, visitdate, visithour) values (1, (select idpatient from patients order by idpatient desc limit 1), curdate(),curtime());
END
|
#trigger informuje o zmianie danych osobowych pacjenta o danym ID
Create Trigger editionPatient
after update on patients
for each row
begin
insert into activities
set activitydescription=(select(concat("Pacjent : ", new.patientname," ", new.patientsurname, " o numerze ", old.idpatient,  " zmienił swoje dane osobowe"))),  timeofactivity=now();
end
|
# trigger miał dodawać wpis do activities odnośnie umówienia wizyty, miał być wypasiony ale jakoś nie moge dojść czemu nie działa, jeszcze go poprawię ...
Create Trigger addVisit
after insert on visits
for each row
begin
insert into activities
set activityDescription=((select(concat("Pacjent : ", p.patientname," ", p.patientsurname, " umówił wizytę na dzień ", new.visitdate, new.visithour))
from patients as p, visits as v where p.idpatient=v.idpatient));
#timeofactivity=now();
end 
|
# trigger dodaje wpis do activities odnośnie wypisania recepty, a także ustawia na podstawie id wizyty status completed, bo rozumiem, że jeżeli jest recepta to wizyta juz sie odbyła
Create Trigger addPrescription
after insert on prescriptions
for each row
begin
insert into activities
set activityDescription=((select(concat("Wypisano receptę nr ", new.idprescription , " odnośnie wizyty nr ", new.idvisit)))), timeofactivity=now();
update visits
set visitstatus="completed" where idvisit=new.idprescription;
end
|
/*
TESTOWE KWERENDY

select * from patients;
|
update patients set patientname="Dawid" where idpatient=7;
|
select * from activities;

|
drop trigger editionpatient;
|
INSERT INTO  visits (IDdoctor, IDpatient,visitdate, visithour, visitstatus) values 
(2,3,"2017-09-15", "13:30:00", "arranged");
|
drop trigger addvisit;
|
INSERT INTO prescriptions (IDvisit, presmedicines) values 
(3, "Ibuprofen, cough syrup");
|
select * from visits; */












