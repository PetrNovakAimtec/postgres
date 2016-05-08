DROP TABLE IF EXISTS tabulka3 CASCADE;
DROP TABLE IF EXISTS tabulka4 CASCADE;

-- tabulky s trivialni strukturou
CREATE TABLE tabulka3 (id INT);
CREATE TABLE tabulka4 (id INT);

-- naplneni 1M radek do kazde tabulky
INSERT INTO tabulka3 SELECT i FROM generate_series(1,1000000) s(i);
INSERT INTO tabulka4 SELECT i FROM generate_series(1,1000000) s(i);

ANALYZE tabulka3;
ANALYZE tabulka4;

-- pouze explain (bez instrumentace)
EXPLAIN SELECT * FROM tabulka3 JOIN tabulka4 ON (tabulka3.id = tabulka4.id);

-- zakladni analyze dotazu
EXPLAIN ANALYZE SELECT * FROM tabulka3 JOIN tabulka4 ON (tabulka3.id = tabulka4.id);

-- bez casovani (nejvetsi overhead)
EXPLAIN (ANALYZE, TIMING OFF) SELECT * FROM tabulka3 JOIN tabulka4 ON (tabulka3.id = tabulka4.id);

-- nebo naopak s dalsimi dodatecnymi informacemi
EXPLAIN (ANALYZE, VERBOSE, COSTS, BUFFERS, FORMAT JSON) SELECT * FROM tabulka3 JOIN tabulka4 ON (tabulka3.id = tabulka4.id);

