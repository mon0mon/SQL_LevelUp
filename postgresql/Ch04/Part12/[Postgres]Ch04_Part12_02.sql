/*
 Ch04 집약과 자르기
 */

-- Part12
-- 집약

/*
2. 합쳐서 하나
*/

DROP TABLE IF EXISTS PriceByAge CASCADE;
CREATE TABLE PriceByAge
(
    product_id VARCHAR(32) NOT NULL,
    low_age    INTEGER     NOT NULL,
    high_age   INTEGER     NOT NULL,
    price      INTEGER     NOT NULL,
    PRIMARY KEY (product_id, low_age),
    CHECK (low_age < high_age)
);

INSERT INTO PriceByAge
VALUES ('제품1', 0, 50, 2000);
INSERT INTO PriceByAge
VALUES ('제품1', 51, 100, 3000);
INSERT INTO PriceByAge
VALUES ('제품2', 0, 100, 4200);
INSERT INTO PriceByAge
VALUES ('제품3', 0, 20, 500);
INSERT INTO PriceByAge
VALUES ('제품3', 31, 70, 800);
INSERT INTO PriceByAge
VALUES ('제품3', 71, 100, 1000);
INSERT INTO PriceByAge
VALUES ('제품4', 0, 99, 8900);

-- Code_4-06
SELECT product_id
FROM PriceByAge
GROUP BY product_id
HAVING SUM(high_age - low_age + 1) = 101
ORDER BY product_id;

DROP TABLE IF EXISTS HotelRooms CASCADE;
CREATE TABLE HotelRooms
(room_nbr INTEGER,
 start_date DATE,
 end_date   DATE,
     PRIMARY KEY(room_nbr, start_date));

INSERT INTO HotelRooms VALUES(101, '2008-02-01', '2008-02-06');
INSERT INTO HotelRooms VALUES(101, '2008-02-06', '2008-02-08');
INSERT INTO HotelRooms VALUES(101, '2008-02-10', '2008-02-13');
INSERT INTO HotelRooms VALUES(202, '2008-02-05', '2008-02-08');
INSERT INTO HotelRooms VALUES(202, '2008-02-08', '2008-02-11');
INSERT INTO HotelRooms VALUES(202, '2008-02-11', '2008-02-12');
INSERT INTO HotelRooms VALUES(303, '2008-02-03', '2008-02-17');

-- Code_4-07
SELECT room_nbr, sum(end_date - start_date) as working_days
from HotelRooms
GROUP BY room_nbr
HAVING sum(end_date - start_date) >= 10
ORDER BY room_nbr;

/*
101,10
303,14
*/

/*
QUERY PLAN
Sort  (cost=50.23..50.40 rows=67 width=12)
  Sort Key: room_nbr
  ->  HashAggregate  (cost=45.70..48.20 rows=67 width=12)
        Group Key: room_nbr
        Filter: (sum((end_date - start_date)) >= 10)
        ->  Seq Scan on hotelrooms  (cost=0.00..30.40 rows=2040 width=12)
*/