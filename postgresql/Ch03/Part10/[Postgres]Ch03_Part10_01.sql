/*
 Ch03 SQL의 조건 분기
 */

-- Part10
-- 그래도 UNION이 필요한 경우

/*
1. UNION을 사용할 수 밖에 없는 경우
*/

DROP TABLE IF EXISTS ThreeElements CASCADE;
CREATE TABLE ThreeElements
(
    key    CHAR(8),
    name   VARCHAR(32),
    date_1 DATE,
    flg_1  CHAR(1),
    date_2 DATE,
    flg_2  CHAR(1),
    date_3 DATE,
    flg_3  CHAR(1),
    PRIMARY KEY (key)
);

INSERT INTO ThreeElements
VALUES ('1', 'a', '2013-11-01', 'T', NULL, NULL, NULL, NULL);
INSERT INTO ThreeElements
VALUES ('2', 'b', NULL, NULL, '2013-11-01', 'T', NULL, NULL);
INSERT INTO ThreeElements
VALUES ('3', 'c', NULL, NULL, '2013-11-01', 'F', NULL, NULL);
INSERT INTO ThreeElements
VALUES ('4', 'd', NULL, NULL, '2013-12-30', 'T', NULL, NULL);
INSERT INTO ThreeElements
VALUES ('5', 'e', NULL, NULL, NULL, NULL, '2013-11-01', 'T');
INSERT INTO ThreeElements
VALUES ('6', 'f', NULL, NULL, NULL, NULL, '2013-12-01', 'F');

CREATE INDEX IDX_1 ON ThreeElements (date_1, flg_1);
CREATE INDEX IDX_2 ON ThreeElements (date_2, flg_2);
CREATE INDEX IDX_3 ON ThreeElements (date_3, flg_3);

-- Code_3-08
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE date_1 = '2013-11-01'
  AND flg_1 = 'T'
UNION
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE date_2 = '2013-11-01'
  AND flg_2 = 'T'
UNION
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE date_3 = '2013-11-01'
  AND flg_3 = 'T'
ORDER BY key;

/*
1       ,a,2013-11-01,T,null,null,null,null
2       ,b,null,null,2013-11-01,T,null,null
5       ,e,null,null,null,null,2013-11-01,T
*/

/*
QUERY PLAN
Sort  (cost=3.40..3.41 rows=3 width=154)
  Sort Key: threeelements.key
  ->  HashAggregate  (cost=3.35..3.38 rows=3 width=154)
"        Group Key: threeelements.key, threeelements.name, threeelements.date_1, threeelements.flg_1, threeelements.date_2, threeelements.flg_2, threeelements.date_3, threeelements.flg_3"
        ->  Append  (cost=0.00..3.29 rows=3 width=154)
              ->  Seq Scan on threeelements  (cost=0.00..1.09 rows=1 width=154)
                    Filter: ((date_1 = '2013-11-01'::date) AND (flg_1 = 'T'::bpchar))
              ->  Seq Scan on threeelements threeelements_1  (cost=0.00..1.09 rows=1 width=154)
                    Filter: ((date_2 = '2013-11-01'::date) AND (flg_2 = 'T'::bpchar))
              ->  Seq Scan on threeelements threeelements_2  (cost=0.00..1.09 rows=1 width=154)
                    Filter: ((date_3 = '2013-11-01'::date) AND (flg_3 = 'T'::bpchar))
*/

-- Code_3-09
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE (date_1 = '2013-11-01' AND flg_1 = 'T')
   OR (date_2 = '2013-11-01' AND flg_2 = 'T')
   OR (date_3 = '2013-11-01' AND flg_3 = 'T')
ORDER BY key;

/*
1       ,a,2013-11-01,T,null,null,null,null
2       ,b,null,null,2013-11-01,T,null,null
5       ,e,null,null,null,null,2013-11-01,T
*/

/*
QUERY PLAN
Sort  (cost=1.16..1.16 rows=1 width=154)
  Sort Key: key
  ->  Seq Scan on threeelements  (cost=0.00..1.15 rows=1 width=154)
        Filter: (((date_1 = '2013-11-01'::date) AND (flg_1 = 'T'::bpchar)) OR ((date_2 = '2013-11-01'::date) AND (flg_2 = 'T'::bpchar)) OR ((date_3 = '2013-11-01'::date) AND (flg_3 = 'T'::bpchar)))
*/


-- Code_3-10
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE ('2013-11-01', 'T')
          IN ((date_1, flg_1), (date_2, flg_2), (date_3, flg_3))
ORDER BY key;

/*
1       ,a,2013-11-01,T,null,null,null,null
2       ,b,null,null,2013-11-01,T,null,null
5       ,e,null,null,null,null,2013-11-01,T
*/

/*
QUERY PLAN
Sort  (cost=1.16..1.16 rows=1 width=154)
  Sort Key: key
  ->  Seq Scan on threeelements  (cost=0.00..1.15 rows=1 width=154)
        Filter: ((('2013-11-01'::date = date_1) AND ('T'::bpchar = flg_1)) OR (('2013-11-01'::date = date_2) AND ('T'::bpchar = flg_2)) OR (('2013-11-01'::date = date_3) AND ('T'::bpchar = flg_3)))
*/


-- Code_3-11
SELECT key,
       name,
       date_1,
       flg_1,
       date_2,
       flg_2,
       date_3,
       flg_3
FROM ThreeElements
WHERE CASE
          WHEN date_1 = '2013-11-01' THEN flg_1
          WHEN date_2 = '2013-11-01' THEN flg_2
          WHEN date_3 = '2013-11-01' THEN flg_3
          ELSE NULL END = 'T'
ORDER BY key;

/*
1       ,a,2013-11-01,T,null,null,null,null
2       ,b,null,null,2013-11-01,T,null,null
5       ,e,null,null,null,null,2013-11-01,T
*/

/*
QUERY PLAN
Sort  (cost=1.13..1.14 rows=1 width=154)
  Sort Key: key
  ->  Seq Scan on threeelements  (cost=0.00..1.12 rows=1 width=154)
        Filter: (CASE WHEN (date_1 = '2013-11-01'::date) THEN flg_1 WHEN (date_2 = '2013-11-01'::date) THEN flg_2 WHEN (date_3 = '2013-11-01'::date) THEN flg_3 ELSE NULL::bpchar END = 'T'::bpchar)
*/