/*
 Ch04 집약과 자르기
 */

-- Part12
-- 집약

/*
1. 여러 개의 레코드를 한 개의 레코드로 집약
*/

DROP TABLE IF EXISTS NonAggTbl CASCADE;
CREATE TABLE NonAggTbl
(
    id        VARCHAR(32) NOT NULL,
    data_type CHAR(1)     NOT NULL,
    data_1    INTEGER,
    data_2    INTEGER,
    data_3    INTEGER,
    data_4    INTEGER,
    data_5    INTEGER,
    data_6    INTEGER
);

DELETE
FROM NonAggTbl;
INSERT INTO NonAggTbl
VALUES ('Jim', 'A', 100, 10, 34, 346, 54, NULL);
INSERT INTO NonAggTbl
VALUES ('Jim', 'B', 45, 2, 167, 77, 90, 157);
INSERT INTO NonAggTbl
VALUES ('Jim', 'C', NULL, 3, 687, 1355, 324, 457);
INSERT INTO NonAggTbl
VALUES ('Ken', 'A', 78, 5, 724, 457, NULL, 1);
INSERT INTO NonAggTbl
VALUES ('Ken', 'B', 123, 12, 178, 346, 85, 235);
INSERT INTO NonAggTbl
VALUES ('Ken', 'C', 45, NULL, 23, 46, 687, 33);
INSERT INTO NonAggTbl
VALUES ('Beth', 'A', 75, 0, 190, 25, 356, NULL);
INSERT INTO NonAggTbl
VALUES ('Beth', 'B', 435, 0, 183, NULL, 4, 325);
INSERT INTO NonAggTbl
VALUES ('Beth', 'C', 96, 128, NULL, 0, 0, 12);

-- Code_4-01
SELECT id, data_1, data_2
FROM NonAggTbl
WHERE id = 'Jim'
  AND data_type = 'A';

/*
Jim,100,10
*/

-- Code_4-02
SELECT id, data_3, data_4, data_5
FROM NonAggTbl
WHERE id = 'Jim'
  AND data_type = 'B';

/*
Jim,167,77,90
*/

-- Code_4-03
SELECT id, data_6
FROM NonAggTbl
WHERE id = 'Jim'
  AND data_type = 'C';

/*
Jim,457
*/

-- Code_4_04
SELECT id,
       CASE WHEN data_type = 'A' THEN data_1 ELSE NULL END AS data_1,
       CASE WHEN data_type = 'A' THEN data_2 ELSE NULL END AS data_2,
       CASE WHEN data_type = 'B' THEN data_3 ELSE NULL END AS data_3,
       CASE WHEN data_type = 'B' THEN data_4 ELSE NULL END AS data_4,
       CASE WHEN data_type = 'B' THEN data_5 ELSE NULL END AS data_5,
       CASE WHEN data_type = 'C' THEN data_6 ELSE NULL END AS data_6
FROM NonAggTbl
GROUP BY id;

/*
[42803] ERROR: column "nonaggtbl.data_type" must appear in the GROUP BY
clause or be used in an aggregate function Position: 30
*/

-- Code_4_04
SELECT id,
       MAX(CASE WHEN data_type = 'A' THEN data_1 ELSE NULL END) AS data_1,
       MAX(CASE WHEN data_type = 'A' THEN data_2 ELSE NULL END) AS data_2,
       MAX(CASE WHEN data_type = 'B' THEN data_3 ELSE NULL END) AS data_3,
       MAX(CASE WHEN data_type = 'B' THEN data_4 ELSE NULL END) AS data_4,
       MAX(CASE WHEN data_type = 'B' THEN data_5 ELSE NULL END) AS data_5,
       MAX(CASE WHEN data_type = 'C' THEN data_6 ELSE NULL END) AS data_6
FROM NonAggTbl
GROUP BY id;

/*
Jim,100,10,167,77,90,457
Beth,75,0,183,null,4,12
Ken,78,5,178,346,85,33
*/

/*
QUERY PLAN
HashAggregate  (cost=34.22..36.22 rows=200 width=106)
  Group Key: id
  ->  Seq Scan on nonaggtbl  (cost=0.00..15.70 rows=570 width=114)
*/