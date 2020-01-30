1) DDL
/**********************************/
/* Table Name: 상품 카테고리 */
/**********************************/
DROP TABLE productcate CASCADE CONSTRAINTS; 
  
CREATE TABLE productcate(
    productcateno                NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                            VARCHAR2(50)     NOT NULL,
    seqno                           NUMBER(7)    DEFAULT 0     NOT NULL,
    cnt                               NUMBER(7)    DEFAULT 0     NOT NULL            
);

COMMENT ON TABLE productcate is '상품 카테고리';
COMMENT ON COLUMN productcate.productcateno is '상품 카테고리 번호';
COMMENT ON COLUMN productcate.name is '상품 분류명';
COMMENT ON COLUMN productcate.seqno is '출력 순서';
COMMENT ON COLUMN productcate.cnt is '등록된 음식 수';

-- 등록
INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '한식', 1,0);
            
INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '중식', 2, 0);

INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '일식', 3, 0);

INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '분식', 4, 0);
-- 목록
SELECT productcateno, name, seqno, cnt
FROM productcate
ORDER BY seqno ASC;     
    
-- 수정
      UPDATE productcate
      SET name= '동남아식', seqno = 3
      WHERE productcateno = 3;
      
-- 삭제
DELETE FROM productcate
WHERE productcateno = 4;
 
-- 조회
SELECT productcateno, name, seqno, cnt
FROM productcate
WHERE productcateno= 1;

SELECT *
FROM productcate
ORDER BY seqno ASC;

 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 한식       1   0
             2 중식       2   0
             3 일식       3   0
             
-- cnt 증가
UPDATE productcate
SET cnt = cnt + 1
WHERE productcateno = 1;

 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 한식       1   1
             2 중식       2   0
             3 동남아식     3   0
             
-- cnt 감소
UPDATE productcate
SET cnt = cnt - 1
WHERE productcateno = 1;
             
 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 한식       1   0
             2 중식       2   0
             3 동남아식     3   0
