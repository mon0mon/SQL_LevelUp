/*
 Ch02 SQL 기초
 */

-- Part07
-- 조건 분기, 집합 연산, 윈도우 함수, 갱신

/*
1. SQL과 조건 분기
*/

-- Code_2-22
SELECT name,
       Address.address,
       CASE
           WHEN Address.address = '서울시' THEN '경기'
           WHEN Address.address = '인천시' THEN '경기'
           WHEN Address.address = '부산시' THEN '영남'
           WHEN Address.address = '속초시' THEN '관동'
           WHEN Address.address = '서귀포시' THEN '호남'
           ELSE NULL END AS district
FROM Address;

/*
인성,서울시,경기
하진,서울시,경기
준,서울시,경기
민,부산시,영남
하린,부산시,영남
빛나래,인천시,경기
인아,인천시,경기
아린,속초시,관동
기주,서귀포시,호남
*/