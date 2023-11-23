/*
 Ch05 반복문
 */

-- Part15
-- 반복계의 공포

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales
(
    company CHAR(1) NOT NULL,
    year    INTEGER NOT NULL,
    sale    INTEGER NOT NULL,
    CONSTRAINT pk_sales PRIMARY KEY (company, year)
);

INSERT INTO Sales
VALUES ('A', 2002, 50);
INSERT INTO Sales
VALUES ('A', 2003, 52);
INSERT INTO Sales
VALUES ('A', 2004, 55);
INSERT INTO Sales
VALUES ('A', 2007, 55);
INSERT INTO Sales
VALUES ('B', 2001, 27);
INSERT INTO Sales
VALUES ('B', 2005, 28);
INSERT INTO Sales
VALUES ('B', 2006, 28);
INSERT INTO Sales
VALUES ('B', 2009, 30);
INSERT INTO Sales
VALUES ('C', 2001, 40);
INSERT INTO Sales
VALUES ('C', 2005, 39);
INSERT INTO Sales
VALUES ('C', 2006, 38);
INSERT INTO Sales
VALUES ('C', 2010, 35);

DROP TABLE IF EXISTS Sales2;
CREATE TABLE Sales2
(
    company CHAR(1) NOT NULL,
    year    INTEGER NOT NULL,
    sale    INTEGER NOT NULL,
    var     CHAR(1),
    CONSTRAINT pk_sales2 PRIMARY KEY (company, year)
);

/*
1. 자르기와 파티션
*/

-- CREATE OR REPLACE PROCEDURE PROC_INSERT_VAR
-- IS
--
--   /* 커서 선언 */
--   CURSOR c_sales IS
--        SELECT company, year, sale
--          FROM Sales
--         ORDER BY company, year;
--
--   /* 레코드 타입 선언 */
--   rec_sales c_sales%ROWTYPE;
--
--   /* 카운터 */
--   i_pre_sale INTEGER := 0;
--   c_company CHAR(1) := '*';
--   c_var CHAR(1) := '*';
--
-- BEGIN
--
-- OPEN c_sales;
--
--   LOOP
--     /* 레코드를 패치해서 변수에 대입 */
--     fetch c_sales into rec_sales;
--     /* 레코드가 없다면 반복을 종료 */
--     exit when c_sales%notfound;
--
--     IF (c_company = rec_sales.company) THEN
--         /* 직전 레코드가 같은 회사의 레코드 일 때 */
--         /* 직전 레코드와 매상을 비교 */
--         IF (i_pre_sale < rec_sales.sale) THEN
--             c_var := '+';
--         ELSIF (i_pre_sale > rec_sales.sale) THEN
--             c_var := '-';
--         ELSE
--             c_var := '=';
--         END IF;
--
--     ELSE
--         c_var := NULL;
--     END IF;
--
--     /* 등록 대상이 테이블에 테이블을 등록 */
--     INSERT INTO Sales2 (company, year, sale, var)
--       VALUES (rec_sales.company, rec_sales.year, rec_sales.sale, c_var);
--
--     c_company := rec_sales.company;
--     i_pre_sale := rec_sales.sale;
--
--   END LOOP;
--
--   CLOSE c_sales;
--   commit;
-- END;
