CREATE DATABASE universe;

\c universe;

CREATE TABLE galaxy(
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  constellation VARCHAR(255) NOT NULL,
  is_spherical BOOLEAN,
  distance_from_earth_in_mly NUMERIC,
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
  distance_from_star_in_au NUMERIC
);

CREATE TABLE moon(
  moon_id SERIAL PRIMARY KEY,
  planet_id INT REFERENCES planet(planet_id),
  name VARCHAR(255) NOT NULL UNIQUE,
  designation_label VARCHAR(255) NOT NULL UNIQUE,
  diameter_in_km NUMERIC
);

CREATE TABLE black_hole(
  black_hole_id SERIAL PRIMARY KEY,
  designation_name VARCHAR(255) NOT NULL UNIQUE,
  distance_from_earth_in_ly NUMERIC
);

-- Insert Rows
INSERT INTO galaxy(name, constellation, is_spherical, distance_from_earth_in_mly)
VALUES ('Milky Way Galaxy', 'Sagittarius', TRUE, 0),
  ('Andromeda Galaxy', 'Andromeda', TRUE, 2.5),
  ('Centaurus A', 'Centaurus', FALSE, 13.7),
  ('NGC 4038', 'Corvus', FALSE, 45),
  ('NGC 4039', 'Corvus', FALSE, 65),
  ('Bode''s Galaxy', 'Ursa Major', TRUE, 12);

INSERT INTO star(galaxy_id, name, distance_from_earth_in_ly)
VALUES (1, 'Sun', 0.000015823820, −26.74), -- 1 refer to 'Milky Way Galaxy'
  (1, 'Sirius', 8.6, −1.46),
  (1, 'Canopus', 310, −0.74),
  (1, 'Rigil Kentaurus & Toliman', 4.4, -0.27),
  (1, 'Arcturus', 37, −0.05),
  (1, 'Vega', 25, 0.03);

INSERT INTO planet(star_id, name, description, has_life, distance_from_star_in_au),
VALUES (1, 'Earth', 'Our home', TRUE, 1.00000011), -- 1 refer to 'Sun'
  (1, 'Mercury', 'The nearest to sun eh', FALSE, 0.38709893),
  (1, 'Venus', 'We land we melt', FALSE, 0.72333199),
  (1, 'Mars', 'Sleep here go float float', FALSE, 1.52366231),
  (1, 'Jupiter', 'The biggest Earth sibling', FALSE, 5.20336301),
  (1, 'Saturn', 'Stylish as hecko', FALSE, 9.53707032),
  (1, 'Uranus', 'Blue as sky', FALSE, 19.19126393),
  (1, 'Neptune', 'That youngest sibling', FALSE, 30.06896348),
  (1, 'Ceres', 'The first asteroido found', FALSE, 2.766),
  (1, 'Pluto', 'Like a snowy road', FALSE, 39.482),
  (1, 'Haumea', NULL, FALSE, 43.335),
  (1, 'Makemake', NULL, FALSE, 45.792),
  (1, 'Eris', 'Red-ish', FALSE, 67.668);

INSERT INTO moon(planet_id, name, designation_label, diameter)
VALUES (1, 'Moon', 'I', 3500), -- 1 refer to 'Earth'
  (4, 'Phobos', 'I', 22.2), -- 4 refer to 'Mars'
  (4, 'Deimos', 'II', 12.6),
  (5, 'Metis', 'XVI', 43), -- 5 refer to 'Jupiter'
  (5, 'Adrastea', 'XV', 16.4),
  (5, 'Amalthea', 'V', 167),
  (5, 'Thebe', 'XIV', 98.6),
  (5, 'Io', 'I', 3643.2),
  (5, 'Europa', 'II', 3121.6),
  (5, 'Ganymede', 'III', 5268.2),
  (5, 'Callisto', 'IV', 4820.6),
  (5, 'Themisto', 'XVIII', 9),
  (5, 'Leda', 'XIII', 21.5),
  (5, 'Ersa', 'LXXI', 3),
  (5, 'Himalia', 'VI', 139.6),
  (5, 'Pandia', 'LXV', 3),
  (5, 'Lysithea', 'X', 42.2),
  (5, 'Elara', 'VII', 79.9),
  (5, 'Dia', 'LIII', 4),
  (5, 'S/2003 J 10', NULL, 2);

INSERT INTO black_hole(designation_name, distance_from_earth_in_ly)
VALUES ('V Puppis', 960),
  ('A0620-00', 3000),
  ('MOA-2011-BLG-191', 5150);
