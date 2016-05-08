DROP TABLE IF EXISTS tabulka1 CASCADE;
-- vytvorime tabulku s jednim sloupcem, obsahujicim pouze sude hodnoty
CREATE TABLE tabulka1 AS SELECT 2*i AS i FROM generate_series(1,100000) s(i);

ANALYZE tabulka1;

-- jednoducha "korektni" podminka
EXPLAIN ANALYZE SELECT * FROM tabulka1 AS tabulka1_a JOIN tabulka1 AS tabulka1_b ON (tabulka1_a.i = tabulka1_b.i);

-- problematicka podminka v joinu
EXPLAIN ANALYZE SELECT * FROM tabulka1 AS tabulka1_a JOIN tabulka1 AS tabulka1_b ON (tabulka1_a.i = (tabulka1_b.i - 1));
