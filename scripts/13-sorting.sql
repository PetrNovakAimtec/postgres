﻿DROP TABLE IF EXISTS tabulka1 CASCADE;
CREATE TABLE tabulka1 AS SELECT i FROM generate_series(1,1000000) s(i);
ANALYZE tabulka1;

EXPLAIN ANALYZE SELECT * FROM tabulka1 ORDER BY i;

CREATE INDEX tabulka1_idx ON tabulka1(i);
ANALYZE tabulka1;

EXPLAIN ANALYZE SELECT * FROM tabulka1 ORDER BY i;
