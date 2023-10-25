/*
 Ch02 SQL 기초
 */

-- Part07
-- 조건 분기, 집합 연산, 윈도우 함수, 갱신

/*
4. 트랜잭션과 갱신
*/

-- Code_2-30
DELETE
FROM Address
WHERE address.name LIKE '인성';
INSERT INTO Address(name, phone_nbr, address, sex, age)
VALUES ('인성', '080-3333-XXXX', '서울시', '남', 30);

-- Code_2-31
DELETE
FROM Address
WHERE TRUE;
INSERT INTO Address (name, phone_nbr, address, sex, age)
VALUES ('인성', '080-3333-XXXX', '서울시', '남', 30),
       ('하진', '090-0000-XXXX', '서울시', '여', 21),
       ('준', '090-2984-XXXX', '서울시', '남', 45),
       ('민', '080-3333-XXXX', '부산시', '남', 32),
       ('하린', NULL, '부산시', '여', 55),
       ('빛나래', '080-5848-XXXX', '인천시', '여', 19),
       ('인아', NULL, '인천시', '여', 20),
       ('아린', '090-1922-XXXX', '속초시', '여', 25),
       ('기주', '090-0001-XXXX', '서귀포시', '남', 32);

-- Code_2-32
DELETE
FROM Address;

-- Code_2-33
DELETE
FROM Address
WHERE Address.address = '인천시';

-- Code_2-34
SELECT *
FROM Address;

-- Code_2-35
UPDATE Address
SET phone_nbr='080-5849-XXXX'
WHERE name = '빛나래';

-- Code_2-36
SELECT *
FROM Address;

-- code_2-37
UPDATE Address
SET phone_nbr = '080-5848-XXXX'
WHERE name = '빛나래';
UPDATE Address
SET age = 20
WHERE name = '빛나래';

-- code_2-38
UPDATE Address
SET phone_nbr = '080-5848-XXXX',
    age       = 20
WHERE name = '빛나래';
UPDATE Address
SET (phone_nbr, age) = ('080-5848-XXXX', 20)
WHERE name = '빛나래';