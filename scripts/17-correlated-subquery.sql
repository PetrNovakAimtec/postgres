DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;

CREATE TABLE tabulka1 (id INT PRIMARY KEY);
CREATE TABLE tabulka2 (id INT PRIMARY KEY, a_id INT REFERENCES tabulka1 (id),
                val INT, UNIQUE (a_id));

INSERT INTO tabulka1 SELECT i               FROM generate_series(1,10000) s(i);
INSERT INTO tabulka2 SELECT i, i, mod(i,23) FROM generate_series(1,10000) s(i);

ANALYZE tabulka1;
ANALYZE tabulka2;

EXPLAIN ANALYZE
  SELECT tabulka1.id, (SELECT val FROM tabulka2 WHERE a_id = tabulka1.id) AS val FROM tabulka1;

-- rewritten as join (not exactly the same behaviour)
EXPLAIN ANALYZE
  SELECT tabulka1.id, tabulka2.val FROM tabulka1 LEFT JOIN tabulka2 ON (tabulka1.id = tabulka2.a_id);
