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

SELECT name,
       sex,
       age,
       RANK() OVER (PARTITION BY sex ORDER BY age DESC) AS rank
FROM Address;

SELECT name,
       sex,
       age,
       DENSE_RANK() OVER (PARTITION BY sex ORDER BY age DESC) AS rank
FROM Address;

UPDATE Address
SET age = 21
WHERE name = '인아';