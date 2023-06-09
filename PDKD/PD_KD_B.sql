-- B variants
CREATE TABLE valsts
(
    nosaukums NVARCHAR(64) NOT NULL,
    valsts_kods NVARCHAR(64) NOT NULL,
    galvaspilseta_id INT,
    PRIMARY KEY (valsts_kods)
);
CREATE TABLE pilseta
(
    id INT,
    nosaukums NVARCHAR(64) NOT NULL,
    iedziivotaji_sk INT NOT NULL,
    valsts_kods NVARCHAR(64) FOREIGN KEY REFERENCES valsts,
    PRIMARY KEY (id)
);
ALTER TABLE valsts 
ADD CONSTRAINT galvaspilseta_id
FOREIGN KEY (galvaspilseta_id) REFERENCES pilseta(id);

INSERT INTO valsts
    (nosaukums, valsts_kods)
VALUES
    ('Latvija', 'LV'),
    ('Lielbritānija', 'GB'),
    ('Krievija', 'RU'),
    ('Amerikas Savienotās Valstis', 'US'),
    ('Kanāda', 'CA'),
    ('Ķīna', 'CN'),
    ('Austrālija', 'AU'),
    ('Japāna', 'JP'),
    ('Vācija', 'DE'),
    ('Francija', 'FR');
INSERT INTO pilseta
    (id, nosaukums, iedziivotaji_sk, valsts_kods)
VALUES
    (1, 'Rīga', 632614, 'LV'),
    (2, 'Londona', 8908081, 'GB'),
    (3, 'Maskava', 12692466, 'RU'),
    (4, 'Ņujorka', 8398748, 'US'),
    (5, 'Toronto', 2731571, 'CA'),
    (6, 'Pekina', 21540000, 'CN'),
    (7, 'Sidneja', 5312163, 'AU'),
    (8, 'Tokija', 9273000, 'JP'),
    (9, 'Berlīne', 3669491, 'DE'),
    (10, 'Parīze', 2148271, 'FR'),
    (11, 'Jelgava', 55667, 'LV'),
    (12, 'Bristol', 463400, 'GB'),
    (13, 'Sanktpēterburga', 5383890, 'RU'),
    (14, 'Losandželosa', 3999759, 'US'),
    (15, 'Montreala', 1760660, 'CA'),
    (16, 'Šanhaja', 24183300, 'CN'),
    (17, 'Melburna', 5078193, 'AU'),
    (18, 'Osaka', 2691000, 'JP'),
    (19, 'Minhene', 1456039, 'DE'),
    (20, 'Liona', 506615, 'FR'),
    (21, 'Liepāja', 69452, 'LV'),
    (22, 'Liverpūle', 864122, 'GB'),
    (23, 'Kazana', 1216965, 'RU'),
    (24, 'Čikāga', 2705994, 'US'),
    (25, 'Vankūvera', 631486, 'CA'),
    (26, 'Čongkinga', 30165500, 'CN'),
    (27, 'Brisbena', 2279400, 'AU'),
    (28, 'Nagoja', 2266700, 'JP'),
    (29, 'Hamburga', 1841179, 'DE'),
    (30, 'Marseļa', 861635, 'FR');
UPDATE valsts
SET galvaspilseta_id = 1
WHERE valsts_kods = 'LV';
UPDATE valsts
SET galvaspilseta_id = 2
WHERE valsts_kods = 'GB';
UPDATE valsts
SET galvaspilseta_id = 3
WHERE valsts_kods = 'RU';
UPDATE valsts
SET galvaspilseta_id = 4
WHERE valsts_kods = 'US';
UPDATE valsts
SET galvaspilseta_id = 5
WHERE valsts_kods = 'CA';
UPDATE valsts
SET galvaspilseta_id = 6
WHERE valsts_kods = 'CN';
UPDATE valsts
SET galvaspilseta_id = 7
WHERE valsts_kods = 'AU';
UPDATE valsts
SET galvaspilseta_id = 8
WHERE valsts_kods = 'JP';
UPDATE valsts
SET galvaspilseta_id = 9
WHERE valsts_kods = 'DE';
UPDATE valsts
SET galvaspilseta_id = 10
WHERE valsts_kods = 'FR';

-- Triju tabulu Join
SELECT pilseta1.nosaukums AS pilseta, valsts.nosaukums AS valsts, pilseta2.nosaukums AS valsts_galvaspilseta
FROM pilseta AS pilseta1
    INNER JOIN valsts ON pilseta1.valsts_kods = valsts.valsts_kods
    INNER JOIN pilseta AS pilseta2 ON valsts.galvaspilseta_id = pilseta2.id;

-- Salikts apakšvaicājums
-- Kā analoģisku piemeru izmantoju savas tabulas ignorejot galvaspilsetas ārejo atslēgu
-- Atrod videjo iedzivotaju skaitu pilsētam no patvaļīgas valsts
SELECT avg(iedziivotaji_sk) as videjais
FROM pilseta
WHERE valsts_kods = 'LV';
-- Atrod videjo iedzivotaju skaitu pilsētam no valsts, kurai tas ir vieslielakais
SELECT TOP 1
    (SELECT avg(iedziivotaji_sk) as videjais
    FROM pilseta
    WHERE pilseta.valsts_kods = valsts.valsts_kods) AS max_videjais
FROM valsts
ORDER BY max_videjais DESC;
-- Atrod nosaukumu valstīj, kurai videjais pilsetu iedzivotaju skaits ir vieslielakais
SELECT valsts.nosaukums
FROM valsts
WHERE 
    (SELECT avg(iedziivotaji_sk) as videjais
FROM pilseta
WHERE pilseta.valsts_kods = valsts.valsts_kods) = 
    (SELECT TOP 1
    (SELECT avg(iedziivotaji_sk) as videjais
    FROM pilseta
    WHERE pilseta.valsts_kods = valsts2.valsts_kods) AS max_videjais
FROM valsts as valsts2
ORDER BY max_videjais DESC);

-- SQL 'loga' funkcija
SELECT
    pilseta.nosaukums AS pilseta,
    valsts.nosaukums AS valsts,
    pilseta.iedziivotaji_sk AS iedzivotaji_pilseta,
    sum(pilseta.iedziivotaji_sk) OVER (PARTITION BY valsts.nosaukums) AS iedzivotaji_summa_valsts
FROM pilseta
    INNER JOIN valsts ON pilseta.valsts_kods = valsts.valsts_kods;

-- Tabulu izmešana
ALTER TABLE valsts
DROP CONSTRAINT galvaspilseta_id;
DROP TABLE pilseta;
DROP TABLE valsts;