/*
 Ch03 SQL의 조건 분기
 */

-- Part09
-- 집계와 조건 분기

/*
2. 집약 결과로 조건 분기
*/

DROP TABLE IF EXISTS Employees CASCADE;
CREATE TABLE Employees
(
    emp_id   CHAR(3)  NOT NULL,
    team_id  INTEGER  NOT NULL,
    emp_name CHAR(16) NOT NULL,
    team     CHAR(16) NOT NULL,
    PRIMARY KEY (emp_id, team_id)
);

INSERT INTO Employees
VALUES ('201', 1, 'Joe', '상품기획');
INSERT INTO Employees
VALUES ('201', 2, 'Joe', '개발');
INSERT INTO Employees
VALUES ('201', 3, 'Joe', '영업');
INSERT INTO Employees
VALUES ('202', 2, 'Jim', '개발');
INSERT INTO Employees
VALUES ('203', 3, 'Carl', '영업');
INSERT INTO Employees
VALUES ('204', 1, 'Bree', '상품기획');
INSERT INTO Employees
VALUES ('204', 2, 'Bree', '개발');
INSERT INTO Employees
VALUES ('204', 3, 'Bree', '영업');
INSERT INTO Employees
VALUES ('204', 4, 'Bree', '관리');
INSERT INTO Employees
VALUES ('205', 1, 'Kim', '상품기획');
INSERT INTO Employees
VALUES ('205', 2, 'Kim', '개발');

-- Code_3-05

SELECT emp_name,
       MAX(team) AS team
FROM Employees
GROUP BY Employees.emp_name
HAVING COUNT(*) = 1
UNION
SELECT emp_name,
       '2개를 겸무' AS team
FROM Employees
GROUP BY Employees.emp_name
HAVING COUNT(*) = 2
UNION
SELECT emp_name,
       '3개 이상을 겸무' AS team
FROM employees
GROUP BY Employees.emp_name
HAVING COUNT(*) >= 3;

/*
Carl            ,영업
Bree            ,3개 이상을 겸무
Jim             ,개발
Kim             ,2개를 겸무
Joe             ,3개 이상을 겸무
*/

/*
QUERY PLAN
HashAggregate  (cost=59.09..59.78 rows=69 width=100) (actual time=0.242..0.251 rows=5 loops=1)
"  Group Key: employees.emp_name, (max(employees.team))"
  Batches: 1  Memory Usage: 24kB
  ->  Append  (cost=17.70..58.75 rows=69 width=100) (actual time=0.113..0.227 rows=5 loops=1)
        ->  HashAggregate  (cost=17.70..20.20 rows=1 width=100) (actual time=0.111..0.120 rows=2 loops=1)
              Group Key: employees.emp_name
              Filter: (count(*) = 1)
              Batches: 1  Memory Usage: 40kB
              Rows Removed by Filter: 3
              ->  Seq Scan on employees  (cost=0.00..14.40 rows=440 width=136) (actual time=0.035..0.042 rows=11 loops=1)
        ->  HashAggregate  (cost=16.60..19.10 rows=1 width=100) (actual time=0.047..0.052 rows=1 loops=1)
              Group Key: employees_1.emp_name
              Filter: (count(*) = 2)
              Batches: 1  Memory Usage: 40kB
              Rows Removed by Filter: 4
              ->  Seq Scan on employees employees_1  (cost=0.00..14.40 rows=440 width=68) (actual time=0.011..0.016 rows=11 loops=1)
        ->  HashAggregate  (cost=16.60..19.10 rows=67 width=100) (actual time=0.045..0.049 rows=2 loops=1)
              Group Key: employees_2.emp_name
              Filter: (count(*) >= 3)
              Batches: 1  Memory Usage: 40kB
              Rows Removed by Filter: 3
              ->  Seq Scan on employees employees_2  (cost=0.00..14.40 rows=440 width=68) (actual time=0.010..0.014 rows=11 loops=1)
Planning Time: 0.682 ms
Execution Time: 1.116 ms
*/

-- Code_3-06
SELECT emp_name,
       CASE
           WHEN COUNT(*) = 1 THEN max(team)
           WHEN COUNT(*) = 2 THEN '2개를 겸무'
           WHEN COUNT(*) >= 3 THEN '3개 이상을 겸무'
           END AS team
FROM Employees
GROUP BY Employees.emp_name;

/*
Carl            ,영업
Jim             ,개발
Kim             ,2개를 겸무
Joe             ,3개 이상을 겸무
Bree            ,3개 이상을 겸무
*/

/*
QUERY PLAN
HashAggregate  (cost=17.70..21.20 rows=200 width=100) (actual time=0.073..0.080 rows=5 loops=1)
  Group Key: emp_name
  Batches: 1  Memory Usage: 40kB
  ->  Seq Scan on employees  (cost=0.00..14.40 rows=440 width=136) (actual time=0.024..0.028 rows=11 loops=1)
Planning Time: 0.170 ms
Execution Time: 0.155 ms
*/