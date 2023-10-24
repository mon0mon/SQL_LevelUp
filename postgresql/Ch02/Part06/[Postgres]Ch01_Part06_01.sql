/*
 Ch02 SQL 기초
 */

-- Part06
-- SELECT 구문

DROP TABLE IF EXISTS Address CASCADE;
CREATE TABLE Address
(
    name      VARCHAR(32) NOT NULL,
    phone_nbr VARCHAR(32),
    address   VARCHAR(32) NOT NULL,
    sex       CHAR(4)     NOT NULL,
    age       INTEGER     NOT NULL,
    PRIMARY KEY (name)
);

INSERT INTO Address
VALUES ('인성', '080-3333-XXXX', '서울시', '남', 30);
INSERT INTO Address
VALUES ('하진', '090-0000-XXXX', '서울시', '여', 21);
INSERT INTO Address
VALUES ('준', '090-2984-XXXX', '서울시', '남', 45);
INSERT INTO Address
VALUES ('민', '080-3333-XXXX', '부산시', '남', 32);
INSERT INTO Address
VALUES ('하린', NULL, '부산시', '여', 55);
INSERT INTO Address
VALUES ('빛나래', '080-5848-XXXX', '인천시', '여', 19);
INSERT INTO Address
VALUES ('인아', NULL, '인천시', '여', 20);
INSERT INTO Address
VALUES ('아린', '090-1922-XXXX', '속초시', '여', 25);
INSERT INTO Address
VALUES ('기주', '090-0001-XXXX', '서귀포시', '남', 32);


SELECT name, phone_nbr, address, sex, age
FROM Address;

/*

인성,080-3333-XXXX,서울시,남   ,30
하진,090-0000-XXXX,서울시,여   ,21
준,090-2984-XXXX,서울시,남   ,45
민,080-3333-XXXX,부산시,남   ,32
하린,"",부산시,여   ,55
빛나래,080-5848-XXXX,인천시,여   ,19
인아,"",인천시,여   ,20
아린,090-1922-XXXX,속초시,여   ,25
기주,090-0001-XXXX,서귀포시,남   ,32
 */


SELECT name, address
FROM Address
WHERE Address.address = '인천시';

/*
빛나래,인천시
인아,인천시
 */

SELECT name, age
FROM Address
WHERE age >= 30;

/*
인성,30
준,45
민,32
하린,55
기주,32
 */

SELECT name, address
FROM Address
WHERE Address.address <> '서울시';

/*
민,부산시
하린,부산시
빛나래,인천시
인아,인천시
아린,속초시
기주,서귀포시
 */

SELECT name, address, age
FROM Address
WHERE Address.address = '서울시'
  AND age >= 30;

/*
인성,서울시,30
준,서울시,45
*/

SELECT name, address, age
FROM Address
WHERE Address.address = '서울시'
  AND age >= 30;
/*
인성,서울시,30
준,서울시,45
*/

