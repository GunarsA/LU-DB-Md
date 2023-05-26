DROP TABLE IF EXISTS rating
DROP TABLE IF EXISTS users
DROP TABLE IF EXISTS movie

CREATE TABLE users
(
    id INT PRIMARY KEY,
    full_name NVARCHAR(64) NOT NULL,
    username NVARCHAR(64) NOT NULL,
    gender NVARCHAR(64) NOT NULL
)

CREATE TABLE movie
(
    id INT identity(1,1) PRIMARY KEY,
    title NVARCHAR(64) NOT NULL,
    year INT,
    data_added DATETIME DEFAULT GETUTCDATE(),
)

CREATE TABLE rating
(
    movie_id INT FOREIGN KEY REFERENCES movie,
    user_id INT FOREIGN KEY REFERENCES users,
    rating INT CHECK (rating>=0 AND rating <= 10),
    CONSTRAINT id PRIMARY KEY (user_id,movie_id)
)

INSERT INTO users
    (id, full_name, username, gender)
VALUES
    (1, 'Emily Johnson', 'emilyj', 'Female'),
    (2, 'Alex Rodriguez', 'alexr', 'Male'),
    (3, 'Sophia Lee', 'sophial', 'Female'),
    (4, 'David Kim', 'davidk', 'Male'),
    (5, 'Jessica Smith', 'jessicas', 'Female'),
    (6, 'Ryan Lee', 'ryanl', 'Male'),
    (7, 'Ava Patel', 'avap', 'Female'),
    (8, 'Luke Brown', 'lukeb', 'Male'),
    (9, 'Emma Davis', 'emmad', 'Female'),
    (10, 'Jacob Wilson', 'jacobw', 'Male'),
    (11, 'Olivia Martin', 'oliviam', 'Female'),
    (12, 'William Chen', 'williamc', 'Male'),
    (13, 'Grace Thompson', 'gracet', 'Female'),
    (14, 'Ethan Brown', 'ethanb', 'Male'),
    (15, 'Madison Lee', 'madisonl', 'Female'),
    (16, 'Michael Kim', 'michaelk', 'Male'),
    (17, 'Isabella Davis', 'isabellad', 'Female'),
    (18, 'Daniel Rodriguez', 'danielr', 'Male'),
    (19, 'Chloe Wilson', 'chloew', 'Female'),
    (20, 'Benjamin Patel', 'benjaminp', 'Male')

INSERT INTO movie
    (title, year)
VALUES
    ('The Shawshank Redemption', 1994),
    ('The Godfather', 1972),
    ('The Dark Knight', 2008),
    ('The Lord of the Rings: The Fellowship of the Ring', 2001),
    ('Pulp Fiction', 1994),
    ('Forrest Gump', 1994),
    ('Inception', 2010),
    ('The Lord of the Rings: The Two Towers', 2002),
    ('Star Wars: Episode IV - A New Hope', 1977),
    ('The Matrix', 1999),
    ('The Silence of the Lambs', 1991),
    ('Goodfellas', 1990),
    ('The Departed', 2006),
    ('The Lord of the Rings: The Return of the King', 2003),
    ('The Godfather: Part II', 1974),
    ('Schindler''s List', 1993),
    ('Saving Private Ryan', 1998),
    ('Fight Club', 1999),
    ('The Green Mile', 1999),
    ('The Usual Suspects', 1995)

INSERT INTO rating
    (movie_id, user_id, rating)
VALUES
    (1, 1, 9),
    (2, 2, 8),
    (3, 3, 10),
    (4, 4, 9),
    (5, 5, 7),
    (6, 6, 8),
    (7, 7, 6),
    (8, 8, 9),
    (9, 9, 10),
    (10, 10, 8),
    (11, 1, 9),
    (12, 2, 10),
    (13, 3, 7),
    (14, 4, 8),
    (15, 5, 6),
    (16, 6, 10),
    (17, 7, 9),
    (18, 8, 8),
    (19, 9, 7),
    (20, 10, 9),
    (1, 2, 7),
    (2, 3, 9),
    (3, 4, 8),
    (4, 5, 6),
    (5, 6, 9),
    (6, 7, 7),
    (7, 8, 10),
    (8, 9, 8),
    (9, 10, 7),
    (10, 1, 6),
    (11, 2, 9),
    (12, 3, 8),
    (13, 4, 7),
    (14, 5, 9),
    (15, 6, 6),
    (16, 7, 8),
    (17, 8, 7),
    (18, 9, 9),
    (19, 10, 8),
    (20, 1, 10),
    (1, 3, 4),
    (2, 4, 5),
    (3, 5, 6),
    (4, 6, 3),
    (5, 7, 4),
    (6, 8, 5),
    (7, 9, 6),
    (8, 10, 7),
    (9, 1, 4),
    (10, 2, 3),
    (11, 3, 5),
    (12, 4, 4),
    (13, 5, 6),
    (14, 6, 3),
    (15, 7, 7),
    (16, 8, 5),
    (17, 9, 4),
    (18, 10, 6),
    (19, 1, 3),
    (20, 2, 5),
    (1, 15, 8),
    (2, 12, 9),
    (3, 14, 7),
    (4, 11, 6),
    (5, 17, 8),
    (6, 19, 10),
    (7, 20, 9),
    (8, 16, 8),
    (9, 13, 7),
    (10, 18, 9),
    (11, 11, 8),
    (12, 12, 7),
    (13, 13, 6),
    (14, 14, 9),
    (15, 15, 8),
    (16, 16, 10),
    (17, 17, 9),
    (18, 18, 8),
    (19, 19, 7),
    (20, 20, 9)

-- Izvada visus reitingus, kuri lielāki par 7 (ar lietotājvardiem un filmu nosaukumiem)
SELECT users.username, movie.title, rating.rating
FROM rating
    JOIN users ON rating.user_id = users.id
    JOIN movie ON rating.movie_id = movie.id
WHERE rating.rating > 7
ORDER BY rating DESC

-- Izvada filmu videjo gadu pie katra reitinga, kuram ir vismaz 3 ieraksti, izņemot 10
SELECT rating.rating, count(*) as amount, avg(movie.year) as [average year]
FROM rating
    JOIN movie on rating.movie_id = movie.id
WHERE rating.rating <> 10
GROUP BY rating.rating
HAVING count(*) > 3
ORDER BY rating DESC

-- Izvada ierakstu skaitu sagrupētu pēc vērtibas un lietotāja dzimuma
SELECT rating.rating, users.gender, count(*) as count
FROM rating
    JOIN users on rating.user_id = users.id
GROUP BY rating.rating, users.gender
ORDER BY rating DESC

-- Izvada katra lietotaja reitingu skaitu.
SELECT username, (SELECT count(*)
    FROM rating
    WHERE rating.user_id = users.id) as count
from users

-- Izvada visus reitingus, kuru vertiba ir virs vidējās
SELECT * FROM rating
where rating > (SELECT avg(rating) FROM rating)

DELETE FROM rating
DELETE FROM movie
DELETE FROM users

DROP TABLE rating
DROP TABLE movie
DROP TABLE users