/*
 Ch02 SQL 기초
 */

-- Part06
-- SELECT 구문

DROP VIEW IF EXISTS CountAddress;
CREATE VIEW CountAddress (v_address, cnt)
AS
SELECT Address.address, COUNT(*)
FROM Address
GROUP BY Address.address;

SELECT v_address, cnt
FROM CountAddress;
/*
서울시,3
부산시,2
서귀포시,1
속초시,1
인천시,2
*/

DROP TABLE IF EXISTS Address2 CASCADE;
CREATE TABLE Address2
(name       VARCHAR(32) NOT NULL,
 phone_nbr  VARCHAR(32) ,
 address    VARCHAR(32) NOT NULL,
 sex        CHAR(4) NOT NULL,
 age        INTEGER NOT NULL,
 PRIMARY KEY (name));

INSERT INTO Address2 VALUES('인성', '080-3333-XXXX', '서울시', '남', 30);
INSERT INTO Address2 VALUES('민',   '080-3333-XXXX', '부산시', '남', 32);
INSERT INTO Address2 VALUES('준서', NULL,            '부산시', '남', 18);
INSERT INTO Address2 VALUES('지연', '080-2367-XXXX', '인천시', '여', 19);
INSERT INTO Address2 VALUES('서준', NULL,            '인천시', '여', 20);
INSERT INTO Address2 VALUES('중진', '090-0205-XXXX', '속초시', '남', 25);

SELECT name
from Address
WHERE name In (SELECT name FROM Address2);