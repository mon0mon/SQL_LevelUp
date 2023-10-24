/*
 Ch02 SQL 기초
 */

-- Part07
-- 조건 분기, 집합 연산, 윈도우 함수, 갱신

/*
3. 윈도우 함수
*/

-- Code_2-26
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

-- Code_2-27
SELECT Address.address,
       COUNT(*) OVER (PARTITION BY Address.address) AS count
FROM Address
ORDER BY count;

/*
서귀포시,1
속초시,1
부산시,2
부산시,2
인천시,2
인천시,2
서울시,3
서울시,3
서울시,3
*/

/*
RANK() 함수의 경우, 공동 순위가 나올 경우 공동 순위가 나온 만큼 하위 순위를 건너뜀
이런 건너뜀 없이 순위를 구하고 싶을 경우 DENSE_RANK() 함수를 사용
*/
-- Code_2-28
SELECT name,
       age,
       RANK() OVER (ORDER BY age DESC ) AS rank
FROM Address;

/*
RANK()
하린,55,1
준,45,2
기주,32,3
민,32,3
인성,30,5
아린,25,6
하진,21,7
인아,20,8
빛나래,19,9
*/

-- Code_2-29
SELECT name,
       age,
       DENSE_RANK() OVER (ORDER BY age DESC ) AS rank
FROM Address;

/*
DENSE_RANK()
하린,55,1
준,45,2
기주,32,3
민,32,3
인성,30,4
아린,25,5
하진,21,6
인아,20,7
빛나래,19,8
*/