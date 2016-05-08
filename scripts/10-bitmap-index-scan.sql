DROP TABLE IF EXISTS tabulka1 CASCADE;

CREATE TABLE tabulka1 AS SELECT mod(i,100) AS x,
                         mod(i,101) AS y FROM generate_series(1,1000000) s(i);
CREATE INDEX tabulka1x_idx ON tabulka1(x);
CREATE INDEX tabulka1y_idx ON tabulka1(y);
ANALYZE tabulka1;
EXPLAIN SELECT * FROM tabulka1 WHERE x < 5 AND y < 5;
