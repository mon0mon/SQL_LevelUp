/*
 Ch03 SQL의 조건 분기
 */

-- Part09
-- 집계와 조건 분기

/*
1. 집계 대상으로 조건 분기
*/

DROP TABLE IF EXISTS Population CASCADE;
CREATE TABLE Population
(
    prefecture VARCHAR(32),
    sex        CHAR(1),
    pop        INTEGER,
    CONSTRAINT pk_pop PRIMARY KEY (prefecture, sex)
);

INSERT INTO Population
VALUES ('성남', '1', 60);
INSERT INTO Population
VALUES ('성남', '2', 40);
INSERT INTO Population
VALUES ('수원', '1', 90);
INSERT INTO Population
VALUES ('수원', '2', 100);
INSERT INTO Population
VALUES ('광명', '1', 100);
INSERT INTO Population
VALUES ('광명', '2', 50);
INSERT INTO Population
VALUES ('일산', '1', 100);
INSERT INTO Population
VALUES ('일산', '2', 100);
INSERT INTO Population
VALUES ('용인', '1', 20);
INSERT INTO Population
VALUES ('용인', '2', 200);

-- Code_3-03
SELECT prefecture, SUM(pop_men) AS pop_men, SUM(pop_wom) AS pop_wom
FROM (SELECT prefecture, pop AS pop_men, NULL AS pop_wom
      FROM population
      WHERE sex = '1'
      UNION
      SELECT prefecture, NULL AS pop_men, pop AS pop_wom
      FROM population
      WHERE sex = '2') TMP
GROUP BY prefecture;

/*
광명,100,50
성남,60,40
수원,90,100
용인,20,200
일산,100,100
*/

/*
QUERY PLAN
GroupAggregate  (cost=36.71..36.83 rows=6 width=98) (actual time=0.209..0.220 rows=5 loops=1)
  Group Key: population.prefecture
  ->  Sort  (cost=36.71..36.73 rows=6 width=90) (actual time=0.194..0.197 rows=10 loops=1)
        Sort Key: population.prefecture
        Sort Method: quicksort  Memory: 25kB
        ->  HashAggregate  (cost=36.58..36.64 rows=6 width=90) (actual time=0.120..0.126 rows=10 loops=1)
"              Group Key: population.prefecture, population.pop, (NULL::integer)"
              Batches: 1  Memory Usage: 24kB
              ->  Append  (cost=0.00..36.53 rows=6 width=90) (actual time=0.046..0.089 rows=10 loops=1)
                    ->  Seq Scan on population  (cost=0.00..18.25 rows=3 width=90) (actual time=0.044..0.050 rows=5 loops=1)
                          Filter: (sex = '1'::bpchar)
                          Rows Removed by Filter: 5
                    ->  Seq Scan on population population_1  (cost=0.00..18.25 rows=3 width=90) (actual time=0.007..0.035 rows=5 loops=1)
                          Filter: (sex = '2'::bpchar)
                          Rows Removed by Filter: 5
Planning Time: 0.380 ms
Execution Time: 0.495 ms
*/

-- Code_3-04
SELECT prefecture,
       SUM(CASE WHEN sex = '1' THEN pop ELSE 0 END) AS pop_men,
       SUM(CASE WHEN sex = '2' THEN pop ELSE 0 END) AS pop_wom
FROM population
GROUP BY prefecture;

/*
수원,90,100
성남,60,40
용인,20,200
광명,100,50
일산,100,100
*/

/*
QUERY PLAN
HashAggregate  (cost=24.85..26.85 rows=200 width=98) (actual time=0.096..0.102 rows=5 loops=1)
  Group Key: prefecture
  Batches: 1  Memory Usage: 40kB
  ->  Seq Scan on population  (cost=0.00..16.60 rows=660 width=94) (actual time=0.031..0.037 rows=10 loops=1)
Planning Time: 0.255 ms
Execution Time: 0.205 ms
*/
