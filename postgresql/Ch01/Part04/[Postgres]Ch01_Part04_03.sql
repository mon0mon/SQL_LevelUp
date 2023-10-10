/*
 Ch01 DMBS 아키텍쳐
 */

-- Part04
-- 실행 계획이 SQL 구문의 성능을 결정

-- 3. 인덱스 스캔의 실행 계획
EXPLAIN
SELECT *
FROM Shops
WHERE shop_id = '00050';

/*
 Index Scan using shops_pkey on shops  (cost=0.14..8.16 rows=1 width=320)
  Index Cond: (shop_id = '00050'::bpchar)

 인덱스를 기반으로 한 실행 계획에서의 차이
 1. 조작 대상 ( shops )
    - 기존과 동일
 2. 조작 대상이 되는 레코드 수 ( rows=1 )
    - WHERE 구에서 기본 키가 '00050'인 점포를 지정했으니, 대상 역시 레코드 하나
 3. 접근 대상 객체와 조작 ( Index Scan )
    - 기존의 Seq Scan과 다르게 Index Scan을 수행
    - 풀 스캔(정수 스케일)과 비교하여 인덱스 스캔(로그 스케일)가 N개 이상의 데이터에선 효율적인 접근 가능
    - https://images.velog.io/images/welloff_jj/post/5d29a3fb-c5e1-4f81-919b-7ddfd774add5/%E1%84%87%E1%85%B5%E1%86%A8%E1%84%8B%E1%85%A9.jpeg
 */

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

