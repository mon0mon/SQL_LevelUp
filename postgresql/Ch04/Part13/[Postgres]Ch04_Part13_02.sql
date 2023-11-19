/*
 Ch04 집약과 자르기
 */

-- Part13
-- 자르기

/*
2. PARTITION BY 구를 사용한 자르기
*/

SELECT name,
       age,
       CASE
           WHEN age < 20 THEN '어린이'
           WHEN age BETWEEN 20 AND 69 THEN '성인'
           WHEN age >= 70 THEN '노인'
           ELSE NULL END                                         AS age_class,
       RANK() OVER (PARTITION BY CASE
                                     WHEN age < 20 THEN '어린이'
                                     WHEN age BETWEEN 20 AND 69 THEN '성인'
                                     WHEN age >= 70 THEN '노인'
                                     ELSE NULL END ORDER BY age) AS age_rank_in_class
FROM persons
ORDER BY age_class DESC, age_rank_in_class ASC;

/*
Darwin,12,어린이,1
Adela,21,성인,1
Dawson,25,성인,2
Anderson,30,성인,3
Donald,30,성인,3
Bill,39,성인,5
Becky,54,성인,6
Bates,87,노인,1
*/

/*
QUERY PLAN
Sort  (cost=158.02..160.49 rows=990 width=78)
"  Sort Key: (CASE WHEN (age < 20) THEN '어린이'::text WHEN ((age >= 20) AND (age <= 69)) THEN '성인'::text WHEN (age >= 70) THEN '노인'::text ELSE NULL::text END) DESC, (rank() OVER (?))"
  ->  WindowAgg  (cost=79.06..108.76 rows=990 width=78)
        ->  Sort  (cost=79.06..81.53 rows=990 width=70)
"              Sort Key: (CASE WHEN (age < 20) THEN '어린이'::text WHEN ((age >= 20) AND (age <= 69)) THEN '성인'::text WHEN (age >= 70) THEN '노인'::text ELSE NULL::text END), age"
              ->  Seq Scan on persons  (cost=0.00..29.80 rows=990 width=70)
*/