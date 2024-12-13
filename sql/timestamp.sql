/*
 * ------------------------------------
 *  NOTE: This test behaves differenly
 * ------------------------------------
 *
 * timestamp.out - test output for 64-bit systems and
 * timestamp_1.out - test output for 32-bit systems.
 *
 */


CREATE TABLE test_timestamp (
	i timestamp
);

INSERT INTO test_timestamp VALUES
	( '2004-10-26 03:55:08' ),
	( '2004-10-26 04:55:08' ),
	( '2004-10-26 05:55:08' ),
	( '2004-10-26 08:55:08' ),
	( '2004-10-26 09:55:08' ),
	( '2004-10-26 10:55:08' )
;

SELECT i <=> '2004-10-26 06:24:08', i FROM test_timestamp ORDER BY 1, 2 ASC;
SELECT i <=| '2004-10-26 06:24:08', i FROM test_timestamp ORDER BY 1, 2 ASC;
SELECT i |=> '2004-10-26 06:24:08', i FROM test_timestamp ORDER BY 1, 2 ASC;

CREATE INDEX idx_timestamp ON test_timestamp USING rum (i);

set enable_seqscan=off;

explain (costs off)
SELECT * FROM test_timestamp WHERE i<'2004-10-26 08:55:08'::timestamp ORDER BY i;
SELECT * FROM test_timestamp WHERE i<'2004-10-26 08:55:08'::timestamp ORDER BY i;

explain (costs off)
SELECT * FROM test_timestamp WHERE i<='2004-10-26 08:55:08'::timestamp ORDER BY i;
SELECT * FROM test_timestamp WHERE i<='2004-10-26 08:55:08'::timestamp ORDER BY i;

explain (costs off)
SELECT * FROM test_timestamp WHERE i='2004-10-26 08:55:08'::timestamp ORDER BY i;
SELECT * FROM test_timestamp WHERE i='2004-10-26 08:55:08'::timestamp ORDER BY i;

explain (costs off)
SELECT * FROM test_timestamp WHERE i>='2004-10-26 08:55:08'::timestamp ORDER BY i;
SELECT * FROM test_timestamp WHERE i>='2004-10-26 08:55:08'::timestamp ORDER BY i;

explain (costs off)
SELECT * FROM test_timestamp WHERE i>'2004-10-26 08:55:08'::timestamp ORDER BY i;
SELECT * FROM test_timestamp WHERE i>'2004-10-26 08:55:08'::timestamp ORDER BY i;

explain (costs off)
SELECT *, i <=> '2004-10-26 08:55:08'::timestamp FROM test_timestamp
	ORDER BY i <=> '2004-10-26 08:55:08'::timestamp;
SELECT *, i <=> '2004-10-26 08:55:08'::timestamp FROM test_timestamp
	ORDER BY i <=> '2004-10-26 08:55:08'::timestamp;

explain (costs off)
SELECT *, i <=> '2004-10-26 05:00:00'::timestamp FROM test_timestamp
	WHERE i>'2004-10-26 05:00:00'::timestamp ORDER BY i <=> '2004-10-26 05:00:00'::timestamp;
SELECT *, i <=> '2004-10-26 05:00:00'::timestamp FROM test_timestamp
	WHERE i>'2004-10-26 05:00:00'::timestamp ORDER BY i <=> '2004-10-26 05:00:00'::timestamp;

-- Tests for timestamptz

SELECT i::timestamptz AS i INTO test_timestamptz FROM test_timestamp;
CREATE INDEX idx_timestamptz ON test_timestamptz USING rum (i);

explain (costs off)
SELECT * FROM test_timestamptz WHERE i>'2004-10-26 08:55:08'::timestamptz ORDER BY i;
SELECT * FROM test_timestamptz WHERE i>'2004-10-26 08:55:08'::timestamptz ORDER BY i;

explain (costs off)
SELECT *, i <=> '2004-10-26 08:55:08'::timestamptz FROM test_timestamptz
	ORDER BY i <=> '2004-10-26 08:55:08'::timestamptz;
SELECT *, i <=> '2004-10-26 08:55:08'::timestamptz FROM test_timestamptz
	ORDER BY i <=> '2004-10-26 08:55:08'::timestamptz;

explain (costs off)
SELECT *, i <=> '2004-10-26 05:00:00'::timestamptz FROM test_timestamptz
	WHERE i>'2004-10-26 05:00:00'::timestamptz ORDER BY i <=> '2004-10-26 05:00:00'::timestamptz;
SELECT *, i <=> '2004-10-26 05:00:00'::timestamptz FROM test_timestamptz
	WHERE i>'2004-10-26 05:00:00'::timestamptz ORDER BY i <=> '2004-10-26 05:00:00'::timestamptz;
