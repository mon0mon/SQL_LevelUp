/*
 Ch01 DMBS 아키텍쳐
 */

-- Part04
-- 실행 계획이 SQL 구문의 성능을 결정

-- 1. 실행 계획 확인 방법
DROP TABLE IF EXISTS Shops CASCADE;
CREATE TABLE Shops
(
    shop_id   CHAR(5) PRIMARY KEY ,
    shop_name VARCHAR(64),
    rating    INTEGER,
    area      VARCHAR(64)
);

INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00001', '○○상점', 3, '서울');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00002', '△△상점', 5, '속초');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00003', '××상점', 4, '부산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00004', '□□상점', 5, '순천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00005', 'A상점', 5, '구미');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00006', 'B상점', 4, '양양');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00007', 'C상점', 3, '군산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00008', 'D상점', 1, '진주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00009', 'E상점', 3, '창원');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00010', 'F상점', 4, '목포');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00011', 'G상점', 2, '나주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00012', 'H상점', 3, '인천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00013', 'I상점', 4, '대전');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00014', 'J상점', 1, '광양');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00015', 'K상점', 5, '세종');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00016', 'L상점', 2, '일산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00017', 'M상점', 5, '대구');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00018', 'N상점', 4, '울산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00019', 'O상점', 4, '마산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00020', 'P상점', 1, '고양');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00021', 'Q상점', 1, '평택');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00022', 'R상점', 3, '오산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00023', 'S상점', 3, '과천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00024', 'T상점', 4, '구리');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00025', 'U상점', 5, '김천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00026', 'V상점', 4, '영천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00027', 'W상점', 5, '상주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00028', 'X상점', 1, '거제');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00029', 'Y상점', 5, '밀양');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00030', 'Z상점', 5, '통영');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00031', 'AA상점', 5, '여수');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00032', 'BB상점', 5, '동해');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00033', 'CC상점', 2, '원주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00034', 'DD상점', 4, '포항');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00035', 'EE상점', 3, '시흥');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00036', 'FF상점', 3, '태백');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00037', 'GG상점', 2, '강릉');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00038', 'HH상점', 4, '삼척');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00039', 'II상점', 3, '익산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00040', 'JJ상점', 1, '남원');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00041', 'KK상점', 4, '정읍');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00042', 'LL상점', 3, '안동');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00043', 'MM상점', 5, '김제');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00044', 'NN상점', 1, '광주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00045', 'OO상점', 3, '하남');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00046', 'PP상점', 4, '화성');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00047', 'QQ상점', 4, '여수');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00048', 'RR상점', 3, '서울');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00049', 'SS상점', 5, '속초');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00050', 'TT상점', 5, '부산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00051', 'UU상점', 5, '순천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00052', 'VV상점', 3, '구미');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00053', 'WW상점', 2, '양양');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00054', 'XX상점', 1, '군산');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00055', 'YY상점', 5, '진주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00056', 'ZZ상점', 2, '창원');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00057', 'AAA상점', 4, '목포');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00058', 'BBB상점', 3, '나주');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00059', 'CCC상점', 4, '인천');
INSERT INTO Shops (shop_id, shop_name, rating, area)
VALUES ('00060', '☆☆상점', 1, '대전');



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

