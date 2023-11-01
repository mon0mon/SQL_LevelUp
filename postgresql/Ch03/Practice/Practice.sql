DROP TABLE IF EXISTS ThreeElements CASCADE;
CREATE TABLE ThreeElements
(key    CHAR(8),
 name   VARCHAR(32),
 date_1 DATE,
 flg_1  CHAR(1),
 date_2 DATE,
 flg_2  CHAR(1),
 date_3 DATE,
 flg_3  CHAR(1),
    PRIMARY KEY(key));

INSERT INTO ThreeElements VALUES ('1', 'a', '2013-11-01', 'T', NULL, NULL, NULL, NULL);
INSERT INTO ThreeElements VALUES ('2', 'b', NULL, NULL, '2013-11-01', 'T', NULL, NULL);
INSERT INTO ThreeElements VALUES ('3', 'c', NULL, NULL, '2013-11-01', 'F', NULL, NULL);
INSERT INTO ThreeElements VALUES ('4', 'd', NULL, NULL, '2013-12-30', 'T', NULL, NULL);
INSERT INTO ThreeElements VALUES ('5', 'e', NULL, NULL, NULL, NULL, '2013-11-01', 'T');
INSERT INTO ThreeElements VALUES ('6', 'f', NULL, NULL, NULL, NULL, '2013-12-01', 'F');

CREATE INDEX IDX_1 ON ThreeElements (date_1, flg_1) ;
CREATE INDEX IDX_2 ON ThreeElements (date_2, flg_2) ;
CREATE INDEX IDX_3 ON ThreeElements (date_3, flg_3) ;

INSERT INTO ThreeElements VALUES ('7', 'g', '2013-11-01', 'F', NULL, NULL, '2013-11-01', 'T');

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
7       ,g,2013-11-01,F,null,null,2013-11-01,T
*/

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
7       ,g,2013-11-01,F,null,null,2013-11-01,T
*/

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
7       ,g,2013-11-01,F,null,null,2013-11-01,T
*/

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