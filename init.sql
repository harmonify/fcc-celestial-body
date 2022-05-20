-- Script to initialize the PostgreSQL 'universe' database
CREATE DATABASE universe;

\c universe;

-- 
-- Tables
-- 
CREATE TABLE galaxy(
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  constellation VARCHAR(255) NOT NULL,
  is_spherical BOOLEAN,
  distance_from_earth_in_mly NUMERIC
);

CREATE TABLE star(
  star_id SERIAL PRIMARY KEY,
  galaxy_id INT REFERENCES galaxy(galaxy_id),
  name VARCHAR(255) NOT NULL UNIQUE,
  distance_from_earth_in_ly NUMERIC,
  visual_magnitude_from_earth NUMERIC
);

CREATE TABLE planet(
  planet_id SERIAL PRIMARY KEY,
  star_id INT REFERENCES star(star_id),
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  has_life BOOLEAN,
  distance_from_star_in_au NUMERIC,
  number_of_moons INT
);

CREATE TABLE moon(
  moon_id SERIAL PRIMARY KEY,
  planet_id INT REFERENCES planet(planet_id),
  name VARCHAR(255) NOT NULL UNIQUE,
  designation_label INT,
  diameter_in_km NUMERIC
);

CREATE TABLE black_hole(
  black_hole_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  distance_from_earth_in_ly NUMERIC
);

-- 
-- Data
-- 
INSERT INTO galaxy(name, constellation, is_spherical, distance_from_earth_in_mly)
VALUES ('Milky Way Galaxy', 'Sagittarius', TRUE, 0),
  ('Andromeda Galaxy', 'Andromeda', TRUE, 2.5),
  ('Centaurus A', 'Centaurus', FALSE, 13.7),
  ('NGC 4038', 'Corvus', FALSE, 45),
  ('NGC 4039', 'Corvus', FALSE, 65),
  ('Bode''s Galaxy', 'Ursa Major', TRUE, 12);

INSERT INTO star(galaxy_id, name, distance_from_earth_in_ly, visual_magnitude_from_earth)
-- 1 refer to 'Milky Way Galaxy'
VALUES (1, 'Sun', 0.000015823820, -26.74), 
  (1, 'Sirius', 8.6, -1.46),
  (1, 'Canopus', 310, -0.74),
  (1, 'Rigil Kentaurus & Toliman', 4.4, -0.27),
  (1, 'Arcturus', 37, -0.05),
  (1, 'Vega', 25, 0.03);

INSERT INTO planet(star_id, name, description, has_life, number_of_moons, distance_from_star_in_au)
-- 'planet' table is not normalized because the 'number_of_moons' column;'number_of_moons' column to pass the tests
-- 1 refer to 'Sun'
VALUES (1, 'Earth', 'Our home', TRUE, 1, 1.00000011),
  (1, 'Mercury', 'The nearest to sun', FALSE, 0, 0.38709893),
  (1, 'Venus', 'We land we melt', FALSE, 0, 0.72333199),
  (1, 'Mars', 'Jump here go float float', FALSE, 2, 1.52366231),
  (1, 'Jupiter', 'The biggest Earth sibling', FALSE, 80, 5.20336301),
  (1, 'Saturn', 'Stylish', FALSE, 83, 9.53707032),
  (1, 'Uranus', 'Blue as sky', FALSE, 27, 19.19126393),
  (1, 'Neptune', 'That youngest sibling', FALSE, 14,  30.06896348),
  (1, 'Ceres', 'First asteroido found', FALSE, 0, 2.766),
  (1, 'Pluto', 'Like a snowy road', FALSE, 5, 39.482),
  (1, 'Haumea', NULL, FALSE, 2, 43.335),
  (1, 'Makemake', NULL, FALSE, 1, 45.792),
  (1, 'Eris', 'Red-ish', FALSE, 1, 67.668);

INSERT INTO moon(planet_id, name, designation_label, diameter_in_km)
-- 1 refer to 'Earth'
-- 4 refer to 'Mars'
-- 5 refer to 'Jupiter'
VALUES (1, 'Moon', 1, 3500),
  (4, 'Phobos', 1, 22.2),
  (4, 'Deimos', 2, 12.6),
  (5, 'Metis', 16, 43),
  (5, 'Adrastea', 15, 16.4),
  (5, 'Amalthea', 5, 167),
  (5, 'Thebe', 14, 98.6),
  (5, 'Io', 1, 3643.2),
  (5, 'Europa', 2, 3121.6),
  (5, 'Ganymede', 3, 5268.2),
  (5, 'Callisto', 4, 4820.6),
  (5, 'Themisto', 18, 9),
  (5, 'Leda', 13, 21.5),
  (5, 'Ersa', 71, 3),
  (5, 'Himalia', 6, 139.6),
  (5, 'Pandia', 65, 3),
  (5, 'Lysithea', 10, 42.2),
  (5, 'Elara', 7, 79.9),
  (5, 'Dia', 53, 4),
  (5, 'S/2003 J 10', NULL, 2);

INSERT INTO black_hole(name, distance_from_earth_in_ly)
VALUES ('V Puppis', 960),
  ('A0620-00', 3000),
  ('MOA-2011-BLG-191', 5150);
