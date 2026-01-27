.mode column
.headers off

DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS agents;

CREATE TABLE studios (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE movies (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  year_released INTEGER NOT NULL,
  mpaa_rating TEXT NOT NULL,
  studio_id INTEGER NOT NULL,
  FOREIGN KEY (studio_id) REFERENCES studios(id)
);

CREATE TABLE agents (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE actors (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  agent_id INTEGER,
  FOREIGN KEY (agent_id) REFERENCES agents(id)
);

CREATE TABLE roles (
  id INTEGER PRIMARY KEY,
  movie_id INTEGER NOT NULL,
  actor_id INTEGER NOT NULL,
  character_name TEXT NOT NULL,
  billing_order INTEGER NOT NULL,
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (actor_id) REFERENCES actors(id)
);

INSERT INTO studios VALUES (1, 'Warner Bros.');

INSERT INTO movies VALUES
(1, 'Batman Begins', 2005, 'PG-13', 1),
(2, 'The Dark Knight', 2008, 'PG-13', 1),
(3, 'The Dark Knight Rises', 2012, 'PG-13', 1);

INSERT INTO agents VALUES (1, 'Agent Smith');

INSERT INTO actors VALUES
(1, 'Christian Bale', NULL),
(2, 'Michael Caine', NULL),
(3, 'Liam Neeson', NULL),
(4, 'Katie Holmes', NULL),
(5, 'Gary Oldman', NULL),
(6, 'Heath Ledger', NULL),
(7, 'Aaron Eckhart', NULL),
(8, 'Maggie Gyllenhaal', NULL),
(9, 'Tom Hardy', NULL),
(10, 'Joseph Gordon-Levitt', NULL),
(11, 'Anne Hathaway', NULL);

INSERT INTO roles (movie_id, actor_id, character_name, billing_order) VALUES
(1,1,Bruce Wayne,1),
(1,2,Alfred,2),
(1,3,Ras Al Ghul,3),
(1,4,Rachel Dawes,4),
(1,5,Commissioner Gordon,5),
(2,1,Bruce Wayne,1),
(2,6,Joker,2),
(2,7,Harvey Dent,3),
(2,2,Alfred,4),
(2,8,Rachel Dawes,5),
(3,1,Bruce Wayne,1),
(3,5,Commissioner Gordon,2),
(3,9,Bane,3),
(3,10,John Blake,4),
(3,11,Selina Kyle,5);

UPDATE actors SET agent_id = 1 WHERE name = 'Christian Bale';

.print "Movies"
.print "======"

SELECT m.title, m.year_released, m.mpaa_rating, s.name FROM movies m JOIN studios s ON m.studio_id = s.id;

.print ""
.print "Top Cast"
.print "========"

SELECT m.title, a.name, r.character_name FROM roles r JOIN movies m ON r.movie_id = m.id JOIN actors a ON r.actor_id = a.id ORDER BY m.year_released, r.billing_order;

.print ""
.print "Represented by agent"
.print "===================="

SELECT a.name FROM actors a WHERE a.agent_id = 1;
