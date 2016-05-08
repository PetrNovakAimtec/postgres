DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;

-- tabulka s 1M radek
CREATE TABLE tabulka1 AS SELECT i FROM generate_series(1,10000) s(i);
CREATE TABLE tabulka2 AS SELECT d FROM generate_series('2010-1-1'::timestamp, '2015-1-1'::timestamp, '1 hour'::interval) s(d);

-- posbirat statistiky
ANALYZE tabulka1;
ANALYZE tabulka2;

-- komplikovana podminka nad INT sloupcem

EXPLAIN ANALYZE SELECT * FROM tabulka1 WHERE i*i < -1;

CREATE INDEX tabulka1_idx ON tabulka1((i*i));

EXPLAIN ANALYZE SELECT * FROM tabulka1 WHERE i*i < -1;

-- komplikovana podminka nad datumem

EXPLAIN ANALYZE SELECT * FROM tabulka2 WHERE d::text LIKE '2013-01-%';

EXPLAIN ANALYZE SELECT * FROM tabulka2 WHERE d BETWEEN '2013-01-01' AND '2013-01-02';

EXPLAIN ANALYZE SELECT * FROM tabulka2 WHERE d >= '2013-01-01' AND d < '2013-01-02';
