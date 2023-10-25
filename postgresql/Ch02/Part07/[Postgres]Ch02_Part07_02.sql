/*
 Ch02 SQL 기초
 */

-- Part07
-- 조건 분기, 집합 연산, 윈도우 함수, 갱신

/*
2. SQL의 집합 연산
*/

-- Code_2-23
SELECT *
FROM Address
UNION
SELECT *
FROM Address2
ORDER BY name;

/*
서준,,인천시,여
하린,,부산시,여
기주,090-0001-XXXX,서귀포시,남
인성,080-3333-XXXX,서울시,남
하진,090-0000-XXXX,서울시,여
아린,090-1922-XXXX,속초시,여
인아,,인천시,여
중진,090-0205-XXXX,속초시,남
빛나래,080-5848-XXXX,인천시,여
지연,080-2367-XXXX,인천시,여
준,090-2984-XXXX,서울시,남
민,080-3333-XXXX,부산시,남
준서,,부산시,남
*/

-- Code_2-24
SELECT *
FROM Address
INTERSECT
SELECT *
FROM Address2;
/*
민,080-3333-XXXX,부산시,남   ,32
인성,080-3333-XXXX,서울시,남   ,30
*/


/*
 Except 차집합
 테이블의 순서에 따라 결과가 달라짐 (교환법칙 성립 X)
 Oracle에서는 MINUS
*/
-- Code_2-25
SELECT *
FROM Address
EXCEPT
SELECT *
FROM Address2;
/*
빛나래,080-5848-XXXX,인천시,여   ,19
준,090-2984-XXXX,서울시,남   ,45
하린,,부산시,여   ,55
기주,090-0001-XXXX,서귀포시,남   ,32
하진,090-0000-XXXX,서울시,여   ,21
아린,090-1922-XXXX,속초시,여   ,25
인아,,인천시,여   ,20
*/