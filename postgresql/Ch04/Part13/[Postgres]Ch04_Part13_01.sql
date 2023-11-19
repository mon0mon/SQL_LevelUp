/*
 Ch04 집약과 자르기
 */

-- Part13
-- 자르기

/*
1. 자르기와 파티션
*/

DROP TABLE IF EXISTS Persons CASCADE;
CREATE TABLE Persons
(
    name   VARCHAR(8) NOT NULL,
    age    INTEGER    NOT NULL,
    height FLOAT      NOT NULL,
    weight FLOAT      NOT NULL,
    PRIMARY KEY (name)
);

INSERT INTO Persons
VALUES ('Anderson', 30, 188, 90);
INSERT INTO Persons
VALUES ('Adela', 21, 167, 55);
INSERT INTO Persons
VALUES ('Bates', 87, 158, 48);
INSERT INTO Persons
VALUES ('Becky', 54, 187, 70);
INSERT INTO Persons
VALUES ('Bill', 39, 177, 120);
INSERT INTO Persons
VALUES ('Chris', 90, 175, 48);
INSERT INTO Persons
VALUES ('Darwin', 12, 160, 55);
INSERT INTO Persons
VALUES ('Dawson', 25, 182, 90);
INSERT INTO Persons
VALUES ('Donald', 30, 176, 53);

-- Code_4-08
SELECT SUBSTRING(name, 1, 1) AS label1, COUNT(*)
FROM Persons
GROUP BY SUBSTRING(name, 1, 1)
ORDER BY label1;

/*
A,2
B,3
C,1
D,3
 */

/*
QUERY PLAN
GroupAggregate  (cost=71.63..91.43 rows=990 width=40)
"  Group Key: (""substring""((name)::text, 1, 1))"
  ->  Sort  (cost=71.63..74.11 rows=990 width=32)
"        Sort Key: (""substring""((name)::text, 1, 1))"
        ->  Seq Scan on persons  (cost=0.00..22.38 rows=990 width=32)
*/

-- Code_4-09
SELECT CASE
           WHEN age < 20 THEN '어린이'
           WHEN age BETWEEN 20 AND 69 THEN '성인'
           WHEN age >= 70 THEN '노인'
           ELSE NULL END AS age_class,
       COUNT(*)
FROM Persons
GROUP BY CASE
             WHEN age < 20 THEN '어린이'
             WHEN age BETWEEN 20 AND 69 THEN '성인'
             WHEN age >= 70 THEN '노인'
             ELSE NULL END
ORDER BY age_class DESC;

/*
어린이,1
성인,6
노인,2
*/

/*
QUERY PLAN
Sort  (cost=46.39..46.89 rows=200 width=40)
  Sort Key: (CASE WHEN (age < 20) THEN '어린이'::text WHEN ((age >= 20) AND (age <= 69)) THEN '성인'::text WHEN (age >= 70) THEN '노인'::text ELSE NULL::text END) DESC
  ->  HashAggregate  (cost=34.75..38.75 rows=200 width=40)
        Group Key: CASE WHEN (age < 20) THEN '어린이'::text WHEN ((age >= 20) AND (age <= 69)) THEN '성인'::text WHEN (age >= 70) THEN '노인'::text ELSE NULL::text END
        ->  Seq Scan on persons  (cost=0.00..29.80 rows=990 width=32)
*/

-- Code_4-10
SELECT CASE
           WHEN weight / POWER(height / 100, 2) < 18.5 THEN '저체중'
           WHEN 18.5 <= weight / POWER(height / 100, 2)
               AND weight / POWER(height / 100, 2) < 25 THEN '정상'
           WHEN 25 <= weight / POWER(height / 100, 2) THEN '과체중'
           ELSE NULL END AS bmi,
       COUNT(*)
FROM Persons
GROUP BY CASE
             WHEN weight / POWER(height / 100, 2) < 18.5 THEN '저체중'
             WHEN 18.5 <= Persons.weight / POWER(height / 100, 2)
                 AND weight / POWER(height / 100, 2) < 25 THEN '정상'
             WHEN 25 <= weight / POWER(height / 100, 2) THEN '과체중'
             ELSE NULL END;

/*
과체중,3
정상,4
저체중,2
*/

/*
QUERY PLAN
HashAggregate  (cost=64.45..74.45 rows=200 width=40)
"  Group Key: CASE WHEN ((weight / power((height / '100'::double precision), '2'::double precision)) < '18.5'::double precision) THEN '저체중'::text WHEN (('18.5'::double precision <= (weight / power((height / '100'::double precision), '2'::double precision))) AND ((weight / power((height / '100'::double precision), '2'::double precision)) < '25'::double precision)) THEN '정상'::text WHEN ('25'::double precision <= (weight / power((height / '100'::double precision), '2'::double precision))) THEN '과체중'::text ELSE NULL::text END"
  ->  Seq Scan on persons  (cost=0.00..59.50 rows=990 width=32)
*/