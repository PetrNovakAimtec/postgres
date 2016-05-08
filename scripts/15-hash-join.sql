DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;

CREATE TABLE tabulka1 AS SELECT i FROM generate_series(1,10000) s(i);
CREATE TABLE tabulka2 AS SELECT i FROM generate_series(1,10000) s(i);
ANALYZE tabulka1;
ANALYZE tabulka2;

EXPLAIN SELECT * FROM tabulka1 JOIN tabulka2 USING (i) WHERE tabulka1.i < 1000;

DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;

CREATE TABLE tabulka1 AS SELECT i FROM generate_series(1,1000000) s(i);
CREATE TABLE tabulka2 AS SELECT i FROM generate_series(1,1000000) s(i);
ANALYZE tabulka1;
ANALYZE tabulka2;
EXPLAIN ANALYZE SELECT * FROM tabulka1 JOIN tabulka2 USING (i);
