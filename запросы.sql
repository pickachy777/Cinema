CREATE DATABASE CinemaDB;
USE CinemaDB;

-- Таблица Auditorium
CREATE TABLE Auditorium (
    ID_auditorium INT PRIMARY KEY,
    Name VARCHAR(255),
    Capacity INT
);

-- Таблица Movie
CREATE TABLE Movie (
    ID_movie INT PRIMARY KEY,
    Title VARCHAR(255),
    Genre VARCHAR(100),
    Duration INT
);

-- Таблица Showtime
CREATE TABLE Showtime (
    ID_showtime INT PRIMARY KEY,
    ID_movie INT,
    ID_auditorium INT,
    Time DATETIME,
    FOREIGN KEY (ID_movie) REFERENCES Movie(ID_movie),
    FOREIGN KEY (ID_auditorium) REFERENCES Auditorium(ID_auditorium)
);

-- Таблица Ticket
CREATE TABLE Ticket (
    ID_ticket INT PRIMARY KEY,
    ID_showtime INT,
    seat_number VARCHAR(10),
    status VARCHAR(20),
    price DECIMAL(10,2),
    date DATETIME,
    FOREIGN KEY (ID_showtime) REFERENCES Showtime(ID_showtime)
);

-- Таблица Repertoire
CREATE TABLE Repertoire (
    ID_repertoire INT PRIMARY KEY,
    ID_movie INT,
    show_date DATETIME,
    FOREIGN KEY (ID_movie) REFERENCES Movie(ID_movie)
);

-- Заполнение таблицы Auditorium
INSERT INTO Auditorium (ID_auditorium, Name, Capacity) VALUES 
(1, 'Main Hall', 200),
(2, 'VIP Hall', 50),
(3, 'Small Hall', 100);

-- Заполнение таблицы Movie
INSERT INTO Movie (ID_movie, Title, Genre, Duration) VALUES 
(1, 'Inception', 'Sci-Fi', 148),
(2, 'The Godfather', 'Crime', 175),
(3, 'Toy Story', 'Animation', 81);

-- Заполнение таблицы Showtime
INSERT INTO Showtime (ID_showtime, ID_movie, ID_auditorium, Time) VALUES 
(1, 1, 1, '2024-01-01 18:00:00'),
(2, 2, 1, '2024-01-01 20:30:00'),
(3, 3, 2, '2024-01-02 15:00:00');

-- Заполнение таблицы Ticket
INSERT INTO Ticket (ID_ticket, ID_showtime, seat_number, status, price, date) VALUES 
(1, 1, 'A1', 'sold', 10.00, '2024-01-01'),
(2, 1, 'A2', 'sold', 10.00, '2024-01-01'),
(3, 2, 'B1', 'available', 12.00, '2024-01-01'),
(4, 3, 'C1', 'sold', 8.00, '2024-01-02');

-- Заполнение таблицы Repertoire
INSERT INTO Repertoire (ID_repertoire, ID_movie, show_date) VALUES 
(1, 1, '2024-01-01'),
(2, 2, '2024-01-01'),
(3, 3, '2024-01-02');

SELECT m.Title, r.show_date 
FROM Repertoire r
JOIN Movie m ON r.ID_movie = m.ID_movie
WHERE r.show_date BETWEEN '2024-01-01' AND '2024-01-02';

SELECT t.seat_number 
FROM Ticket t
WHERE t.ID_showtime = 2 AND t.status = 'available';

SELECT t.seat_number 
FROM Ticket t
WHERE t.ID_showtime = 1 AND t.status = 'sold';

SELECT DISTINCT m.Title 
FROM Movie m
JOIN Showtime s ON m.ID_movie = s.ID_movie
WHERE s.Time BETWEEN '2024-01-01 00:00:00' AND '2024-01-01 23:59:59';

SELECT SUM(t.price) AS total_sales 
FROM Ticket t 
WHERE t.ID_showtime = 1 AND t.status = 'sold';

SELECT SUM(t.price) AS total_unsold 
FROM Ticket t 
WHERE t.ID_showtime = 2 AND t.status = 'available';

SELECT SUM(t.price) AS total_sales_period 
FROM Ticket t 
JOIN Showtime s ON t.ID_showtime = s.ID_showtime 
WHERE s.Time BETWEEN '2024-01-01' AND '2024-01-02' AND t.status = 'sold';

SELECT SUM(t.price) AS total_losses 
FROM Ticket t 
JOIN Showtime s ON t.ID_showtime = s.ID_showtime 
WHERE s.Time BETWEEN '2024-01-01' AND '2024-01-02' AND t.status = 'available';

SELECT SUM(t.price) AS total_sales 
FROM Ticket t 
JOIN Repertoire r ON r.ID_movie = t.ID_showtime 
WHERE r.ID_movie = 3 AND t.status = 'sold'; -- Замените `1` на нужный ID фильма.

SELECT s.Time, 
       COUNT(CASE WHEN t.status = 'sold' THEN 1 END) AS sold_count,
       COUNT(CASE WHEN t.status = 'available' THEN 1 END) AS available_count 
FROM Showtime s 
LEFT JOIN Ticket t ON s.ID_showtime = t.ID_showtime 
WHERE s.ID_movie = 3 -- Замените `1` на нужный ID фильма.
GROUP BY s.Time;












