DROP TABLE IF EXISTS tabulka2 CASCADE;

-- tabulka se 4 sloupci
CREATE TABLE tabulka2 (a1 INT, a2 INT, a3 INT, a4 INT);

-- 1M radek s ruznym statistickym rozdelenim
INSERT INTO tabulka2
     SELECT
            MOD(i,50),              -- 50 hodnot (uniform)
            MOD(i,1000),            -- 1000 hodnot (uniform)
            1000 * pow(random(),2), -- 1000 hodnot (skewed)
            (CASE WHEN MOD(i,3) = 0 THEN NULL ELSE i END)
FROM generate_series(1,1000000) s(i);

-- posbirat statistiky
ANALYZE tabulka2;

-- zobrazit rozdeleni jednotlivych sloupcu
SELECT a1, COUNT(*) FROM tabulka2 GROUP BY 1 ORDER BY 1;
SELECT a2, COUNT(*) FROM tabulka2 GROUP BY 1 ORDER BY 1;
SELECT a3, COUNT(*) FROM tabulka2 GROUP BY 1 ORDER BY 1;
SELECT a4, COUNT(*) FROM tabulka2 GROUP BY 1 ORDER BY 1;

-- zobrazit statistiky
SELECT * FROM pg_stats WHERE tablename = 'tabulka2' AND attname = 'a1';
SELECT * FROM pg_stats WHERE tablename = 'tabulka2' AND attname = 'a2';
SELECT * FROM pg_stats WHERE tablename = 'tabulka2' AND attname = 'a3';
SELECT * FROM pg_stats WHERE tablename = 'tabulka2' AND attname = 'a4';

-- drop table tabulka2