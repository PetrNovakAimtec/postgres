DROP TABLE IF EXISTS tabulka1 CASCADE;

-- vytvor tabulku se dvema sloupci
CREATE TABLE tabulka1 (a1 INT, a2 TEXT);

-- vloz do ni 10000 radek, zkonstruovanych tak aby zabraly 1000 stranek
INSERT INTO tabulka1 SELECT i, REPEAT(md5(i::TEXT),23) FROM generate_series(1,10000) s(i);

-- posbirat statistiky
ANALYZE tabulka1;

-- zobraz statistiky
SELECT relpages, reltuples FROM pg_class WHERE relname = 'tabulka1';

-- zobraz dotaz
EXPLAIN SELECT * FROM tabulka1 WHERE a1 = 100;

-- drop table tabulka1