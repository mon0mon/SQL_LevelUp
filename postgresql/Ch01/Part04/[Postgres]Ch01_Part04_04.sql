/*
 Ch01 DMBS 아키텍쳐
 */

-- Part04
-- 실행 계획이 SQL 구문의 성능을 결정

-- 4. 간단한 테이블 결합의 실행 계획

DROP TABLE IF EXISTS Reservations CASCADE;
CREATE TABLE Reservations
(
    reserve_id   INTEGER NOT NULL,
    shop_id      CHAR(5),
    reserve_name VARCHAR(64),
    CONSTRAINT pk_reservations PRIMARY KEY (reserve_id)
);

INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (1, '00001', 'A씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (2, '00002', 'B씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (3, '00003', 'C씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (4, '00004', 'D씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (5, '00005', 'E씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (6, '00005', 'F씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (7, '00006', 'G씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (8, '00006', 'H씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (9, '00007', 'I씨');
INSERT INTO Reservations (reserve_id, shop_id, reserve_name)
VALUES (10, '00010', 'J씨');


-- 예약이 존재하는 점포를 선택하는 SELECT 구문
EXPLAIN
SELECT shop_name, S.shop_id
FROM Shops S
         INNER JOIN Reservations R ON S.shop_id = R.shop_id;

/*
 DBMS에서 결합을 할 때는 3가지의 알고리즘을 사용
 1. Nested Loops
    - 한 테이블을 읽으면서 레코드 하나마다 결합 조건에 맞는 레코드를 다른 테이블에서 찾는 방식
    - 절차 지향형 언어(C언어)에서 이중 반복으로 구현되므로 중첩 반복 (Nested Loops)라는 이름이 붙음
    * DBMS는 내부적으로 절차 지향형 방법을 사용해 데이터 접근을 수행
 2. Sort Merge
    - 결합 키(여기선 점포 ID)로 레코드를 정렬하고, 순차적으로 두 개의 테이블을 결합하는 방법
    - 정렬에 사용하는 메모리는 2장에서 다룬 `워킹 메모리`를 사용
 3. Hash
    - 결합 키 값을 해시값으로 매핑하는 방법
    - Sort Merge와 동일하게 워킹 메모리를 필요로 함
 */