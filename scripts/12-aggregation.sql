DROP TABLE IF EXISTS tabulka1 CASCADE;
CREATE TABLE tabulka1 (i INT, j INT, k INT);
INSERT INTO tabulka1 SELECT mod(i, 1000), mod(i, 1333), mod(i,3498)
                FROM generate_series(1,100000) s(i);

EXPLAIN SELECT i, count(*) FROM tabulka1 GROUP BY i;

EXPLAIN SELECT DISTINCT i  FROM tabulka1 GROUP BY i;

