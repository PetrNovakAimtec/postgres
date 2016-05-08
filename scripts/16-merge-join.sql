DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;

CREATE TABLE tabulka1 AS SELECT i, md5(i::text) val FROM generate_series(1,100000) s(i);
CREATE TABLE tabulka2 AS SELECT i, md5(i::text) val FROM generate_series(1,100000) s(i);
CREATE INDEX tabulka1_idx ON tabulka1(i);
CREATE INDEX tabulka2_idx ON tabulka2(i);
ANALYZE tabulka1;
ANALYZE tabulka2;

EXPLAIN SELECT * FROM tabulka1 JOIN tabulka2 USING (i);
EXPLAIN ANALYZE SELECT * FROM tabulka1 JOIN tabulka2 USING (i);

-- withouth an index
DROP INDEX tabulka2_idx;
ANALYZE tabulka1;
ANALYZE tabulka2;

EXPLAIN ANALYZE SELECT * FROM tabulka1 JOIN tabulka2 USING (i) ORDER BY i;

-- with indexes
DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;
CREATE TABLE tabulka1 AS SELECT i, i/10 j FROM generate_series(1,1000000) s(i);
CREATE TABLE tabulka2 AS SELECT i/10 i FROM generate_series(1,1000000) s(i);

CREATE INDEX tabulka1_idx ON tabulka1(j);
CREATE INDEX tabulka2_idx ON tabulka2(i);
ANALYZE tabulka1;
ANALYZE tabulka2;
EXPLAIN SELECT * FROM tabulka1 JOIN tabulka2 ON (tabulka1.j = tabulka2.i);
