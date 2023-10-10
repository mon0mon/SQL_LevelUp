/*
 Ch01 DMBS 아키텍쳐
 */

-- Part04
-- 실행 계획이 SQL 구문의 성능을 결정

-- 2. 테이블 풀 스캔의 실행 계획
EXPLAIN
SELECT *
FROM Shops;

/*
Seq Scan on shops  (cost=0.00..1.60 rows=60 width=25)

DBMS에서 공통적으로 나타나는 출력 포맷

1. 조작 대상 객체 ( shops )
    - 테이블, 인덱스, 파티션, 시퀀스 등 SQL 구문으로 조작할 수 있는 객체가 대상
2. 객체에 대한 조작의 종류 ( Seq Scan )
    - 객체에 대한 조작 종류로 실행 계획에서 가장 중요한 부분
    - DBMS에 따라 다르지만, 실행 비용(Cost)라는 지표는 추정치인 경우가 많으므로 절대적인 지표로 사용하지 말 것
3. 조작 대상이 되는 레코드 수 ( rows=60 )
    - 얼마나 많은 레코드가 처리되는지에 따라 SQL 구문 전체의 실행 비용을 파악하는 지표로 사용할 수 있음
    - 옵티마이저가 실행 계획을 만들 때, 카탈로그 매니저로부터 얻은 값이므로 실제 값과는 차이가 있을 수 있음
 */



-- 3. 인덱스 스캔의 실행 계획
EXPLAIN
SELECT *
FROM Shops
WHERE shop_id = '00050';


/*
의문점

처음 쿼리를 실행 했을 때는 아래 쿼리문이 수행됨

Index Scan using shops_pkey on shops  (cost=0.14..8.16 rows=1 width=320)
  Index Cond: (shop_id = '00050'::bpchar)

시간이 지나고 다시 쿼리를 실행하면 아래 쿼리문이 수행됨

 Seq Scan on shops  (cost=0.00..1.75 rows=1 width=25)
   Filter: (shop_id = '00050'::bpchar)

참고링크
https://stackoverflow.com/questions/5203755/why-does-postgresql-perform-sequential-scan-on-indexed-column

책에서 54p 저자주에 해당 내용이 간략하게 언급되어 있음
`
8)저자주_사실 60개 정도 분량의 레코드는, WHERE 구에 기본 키를 지정해도 인덱스 스캔을 사용하지 않고 풀 스캔을 하는 경우도 있습니다.
`
 */

