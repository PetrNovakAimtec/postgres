DROP TABLE IF EXISTS tabulka1 CASCADE;
DROP TABLE IF EXISTS tabulka2 CASCADE;
-- dve jednoduche tabulky, kazda s 10.000 radek
CREATE TABLE tabulka1 AS SELECT i FROM generate_series(1,10000) s(i);
CREATE TABLE tabulka2 AS SELECT i FROM generate_series(1,10000) s(i);

ANALYZE tabulka1;
ANALYZE tabulka2;

-- kartezsky soucin tabulek
EXPLAIN SELECT * FROM tabulka1, tabulka2;

-- neindexovatelna podminka
EXPLAIN SELECT * FROM tabulka1 JOIN tabulka2 ON (tabulka1.i <= tabulka2.i);

-- indexovatelna podminka
CREATE INDEX tabulka2_idx ON tabulka2(i);

EXPLAIN SELECT * FROM tabulka1 JOIN tabulka2 ON (tabulka1.i <= tabulka2.i);
