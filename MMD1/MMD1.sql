DROP TABLE IF EXISTS movie_director
DROP TABLE IF EXISTS director
DROP TABLE IF EXISTS movie

CREATE TABLE director
(
    id INT PRIMARY KEY,
    full_name NVARCHAR(64) NOT NULL,
)

CREATE TABLE movie
(
    id INT identity(1,1) PRIMARY KEY,
    title NVARCHAR(64) NOT NULL,
    data_added DATETIME DEFAULT GETUTCDATE(),
    rating INT CHECK (rating>=0 AND rating <= 10)
)

CREATE TABLE movie_director
(
    movie_id INT FOREIGN KEY REFERENCES movie,
    director_id INT FOREIGN KEY REFERENCES director,
    CONSTRAINT id PRIMARY KEY (director_id,movie_id)
)

INSERT INTO director
    (id, full_name)
VALUES
    (1, 'Frank Darabont'),
    (2, 'Francis Ford Coppola'),
    (3, 'Christopher Nolan'),
    (4, 'Sidney Lumet'),
    (5, 'Steven Spielberg'),
    (6, 'Peter Jackson'),
    (7, 'Quentin Tarantino'),
    (8, 'Sergio Leone'),
    (9, 'Robert Zemeckis'),
    (10, 'David Fincher'),
    (11, 'Christopher Nolan'),
    (12, 'Irvin Kershner'),
    (13, 'Lana Wachowski'),
    (14, 'Lilly Wachowski'),
    (15, 'Martin Scorsese'),
    (16, 'Milos Forman'),
    (17, 'David Fincher'),
    (18, 'Akira Kurosawa')

INSERT INTO movie
    (title, rating)
VALUES
    ('The Shawshank Redemption', 10),
    ('The Godfather', 7),
    ('The Dark Knight', 10),
    ('The Godfather Part II', NULL),
    ('12 Angry Men', 10),
    ('Schindler''s List', 9),
    ('The Lord of the Rings: The Return of the King', 9),
    ('Pulp Fiction', 7),
    ('The Lord of the Rings: The Fellowship of the Ring', 9),
    ('The Good, the Bad and the Ugly', 8),
    ('Forrest Gump', 9),
    ('Fight Club', 9),
    ('The Lord of the Rings: The Two Towers', 9),
    ('Inception', 9),
    ('Star Wars: Episode V - The Empire Strikes Back', 9),
    ('The Matrix', 8),
    ('Goodfellas', 6),
    ('One Flew Over the Cuckoo''s Nest', 10),
    ('Se7en', 5),
    ('Seven Samurai', 7)

INSERT INTO movie_director
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 2),
    (5, 4),
    (6, 5),
    (7, 6),
    (8, 7),
    (9, 6),
    (10, 8),
    (11, 9),
    (12, 10),
    (13, 6),
    (14, 11),
    (15, 12),
    (16, 13),
    (16, 14),
    (17, 15),
    (18, 16),
    (19, 17),
    (20, 18)

-- Izvada visas filmas, kurām ir ievadīts reitings, un sakārto primāri pēc reitinga un sekundāri augošā secībā pēc alfabēta
SELECT *
FROM movie
WHERE rating IS NOT NULL
ORDER BY rating DESC, title ASC

-- Izvada visas saistības starp filmām un to režisoriem un sakārto filmu nosaukumu augošā secībā pēc alfabēta
SELECT movie.title, director.full_name
FROM movie_director
    JOIN movie on movie.id = movie_director.movie_id
    JOIN director on director.id = movie_director.director_id
ORDER BY movie.title ASC

DELETE FROM movie_director
DELETE FROM	movie
DELETE FROM director

DROP TABLE movie_director
DROP TABLE movie
DROP TABLE director