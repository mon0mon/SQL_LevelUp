/*
 Ch03 SQL의 조건 분기
 */

-- Part08
-- UNION을 사용한 쓸데없이 긴 표현

/*
1. UNION을 사용한 조건 분기와 관련된 간단한 예제
*/

DROP TABLE IF EXISTS Items CASCADE;
CREATE TABLE Items
(
    item_id      INTEGER  NOT NULL,
    year         INTEGER  NOT NULL,
    item_name    CHAR(32) NOT NULL,
    price_tax_ex INTEGER  NOT NULL,
    price_tax_in INTEGER  NOT NULL,
    PRIMARY KEY (item_id, year)
);

INSERT INTO Items
VALUES (100, 2000, '머그컵', 500, 525);
INSERT INTO Items
VALUES (100, 2001, '머그컵', 520, 546);
INSERT INTO Items
VALUES (100, 2002, '머그컵', 600, 630);
INSERT INTO Items
VALUES (100, 2003, '머그컵', 600, 630);
INSERT INTO Items
VALUES (101, 2000, '티스푼', 500, 525);
INSERT INTO Items
VALUES (101, 2001, '티스푼', 500, 525);
INSERT INTO Items
VALUES (101, 2002, '티스푼', 500, 525);
INSERT INTO Items
VALUES (101, 2003, '티스푼', 500, 525);
INSERT INTO Items
VALUES (102, 2000, '나이프', 600, 630);
INSERT INTO Items
VALUES (102, 2001, '나이프', 550, 577);
INSERT INTO Items
VALUES (102, 2002, '나이프', 550, 577);
INSERT INTO Items
VALUES (102, 2003, '나이프', 400, 420);

-- Code_3-01
SELECT item_name, year, price_tax_ex AS price
FROM items
WHERE year <= 2001
UNION ALL
SELECT item_name, year, price_tax_in AS price
FROM items
WHERE year >= 2002
ORDER BY item_name, year;

/*
나이프                             ,2000,600
나이프                             ,2001,550
나이프                             ,2002,577
나이프                             ,2003,420
머그컵                             ,2000,500
머그컵                             ,2001,520
머그컵                             ,2002,630
머그컵                             ,2003,630
티스푼                             ,2000,500
티스푼                             ,2001,500
티스푼                             ,2002,525
*/

/*
QUERY PLAN
Sort  (cost=45.66..46.43 rows=306 width=140)
"  Sort Key: items.item_name, items.year"
  ->  Append  (cost=0.00..33.03 rows=306 width=140)
        ->  Seq Scan on items  (cost=0.00..15.75 rows=153 width=140)
              Filter: (year <= 2001)
        ->  Seq Scan on items items_1  (cost=0.00..15.75 rows=153 width=140)
              Filter: (year >= 2002)

items 테이블을 2번 Seq Scan 하는 걸 알 수 있음
테이블의 크기에 비례하여, 접근 비용도 증가
테이블이 커질수록 캐시 히트율이 낮아지므로, 비효율적인 쿼리
*/

-- Code_3-02
SELECT item_name,
       year,
       CASE
           WHEN year <= 2001 THEN price_tax_ex
           WHEN year >= 2002 THEN price_tax_in END AS price
FROM items
ORDER BY item_name, year;

/*
나이프                             ,2000,600
나이프                             ,2001,550
나이프                             ,2002,577
나이프                             ,2003,420
머그컵                             ,2000,500
머그컵                             ,2001,520
머그컵                             ,2002,630
머그컵                             ,2003,630
티스푼                             ,2000,500
티스푼                             ,2001,500
티스푼                             ,2002,525
티스푼                             ,2003,525
*/

/*
Sort  (cost=37.24..38.39 rows=460 width=140)
"  Sort Key: item_name, year"
  ->  Seq Scan on items  (cost=0.00..16.90 rows=460 width=140)

기존의 쿼리에 비해 Seq Scan 한번으로 처리 가능하므로, 성능적으로 우월
*/