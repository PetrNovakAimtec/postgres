DROP TABLE IF EXISTS tabulka1 CASCADE;

CREATE TABLE tabulka1 (id INT, val INT8);
INSERT INTO tabulka1 SELECT i,i FROM generate_series(1,1000000) s(i);
CREATE INDEX tabulka1_idx ON tabulka1(id);
ANALYZE tabulka1;
EXPLAIN ANALYZE SELECT id, val FROM tabulka1 WHERE id = 1000;
