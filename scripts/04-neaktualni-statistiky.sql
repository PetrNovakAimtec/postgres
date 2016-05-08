DROP TABLE IF EXISTS tabulka4 CASCADE;
-- jednoducha tabulka
CREATE TABLE tabulka4 (id int);
INSERT INTO tabulka4 SELECT i FROM generate_series(1,100000) s(i);

-- preskocit analyzu
-- ANALYZE tabulka4;

-- zobrazit plan (pouziva 33% odhad pro podminku)
EXPLAIN ANALYZE SELECT id FROM tabulka4 WHERE id < 100;

-- posbirat statistiky
ANALYZE tabulka4;

-- spustit znovu
EXPLAIN ANALYZE SELECT id FROM tabulka4 WHERE id < 100;
