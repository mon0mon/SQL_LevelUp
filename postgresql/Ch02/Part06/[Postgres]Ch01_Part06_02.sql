/*
 Ch02 SQL 기초
 */

-- Part06
-- SELECT 구문

SELECT name, address, age
FROM Address
WHERE Address.address = '서울시'
   OR age >= 30;
/*
인성,서울시,30
하진,서울시,21
준,서울시,45
민,부산시,32
하린,부산시,55
기주,서귀포시,32
 */

SELECT name, address
FROM Address
WHERE Address.address = '서울시'
   OR Address.address = '부산시'
   OR Address.address = '인천시';
/*
인성,서울시
하진,서울시
준,서울시
민,부산시
하린,부산시
빛나래,인천시
인아,인천시
*/

SELECT name, address
FROM Address
WHERE Address.address IN ('서울시', '부산시', '인천시');
/*
인성,서울시
하진,서울시
준,서울시
민,부산시
하린,부산시
빛나래,인천시
인아,인천시
*/

-- NULL인 칼럼을 검색 할 때는 IS NULL 키워드 사용
--SELECT name, address
--FROM Address
--WHERE phone_nbr = NULL;
SELECT name, phone_nbr
FROM Address
WHERE phone_nbr IS NULL;
/*
하린,
인아,
*/

SELECT sex, COUNT(*)
FROM Address
GROUP BY sex;
/*
남   ,4
여   ,5
*/

SELECT Address.address, COUNT(*)
FROM Address
GROUP BY Address.address;
/*
서울시,3
부산시,2
서귀포시,1
속초시,1
인천시,2
*/

SELECT COUNT(*)
FROM Address
GROUP BY ();
/*
9
*/

SELECT Address.address, COUNT(*)
FROM address
GROUP BY Address.address
HAVING COUNT(*) = 1;
/*
서귀포시,1
속초시,1
*/

SELECT name, phone_nbr, Address.address, sex, age
FROM Address
ORDER BY age DESC;
/*
하린,,부산시,여   ,55
준,090-2984-XXXX,서울시,남   ,45
기주,090-0001-XXXX,서귀포시,남   ,32
민,080-3333-XXXX,부산시,남   ,32
인성,080-3333-XXXX,서울시,남   ,30
아린,090-1922-XXXX,속초시,여   ,25
하진,090-0000-XXXX,서울시,여   ,21
인아,,인천시,여   ,20
빛나래,080-5848-XXXX,인천시,여   ,19
*/