/*
 * ------------------------------------
 *  NOTE: This test behaves differenly
 * ------------------------------------
 *
 * float8.out - test output for 64-bit systems and
 * float8_1.out - test output for 32-bit systems.
 *
 */


set enable_seqscan=off;

CREATE TABLE test_float8 (
	i float8
);

INSERT INTO test_float8 VALUES (-2),(-1),(0),(1),(2),(3);

CREATE INDEX idx_float8 ON test_float8 USING rum (i);

SELECT * FROM test_float8 WHERE i<1::float8 ORDER BY i;
SELECT * FROM test_float8 WHERE i<=1::float8 ORDER BY i;
SELECT * FROM test_float8 WHERE i=1::float8 ORDER BY i;
SELECT * FROM test_float8 WHERE i>=1::float8 ORDER BY i;
SELECT * FROM test_float8 WHERE i>1::float8 ORDER BY i;

EXPLAIN (costs off)
SELECT *, i <=> 0::float8 FROM test_float8 ORDER BY i <=> 0::float8;
SELECT *, i <=> 0::float8 FROM test_float8 ORDER BY i <=> 0::float8;

EXPLAIN (costs off)
SELECT *, i <=> 1::float8 FROM test_float8 WHERE i<1::float8 ORDER BY i <=> 1::float8;
SELECT *, i <=> 1::float8 FROM test_float8 WHERE i<1::float8 ORDER BY i <=> 1::float8;
