1) DDL
/**********************************/
/* Table Name: ��ǰ ī�װ� */
/**********************************/
DROP TABLE productcate CASCADE CONSTRAINTS; 
  
CREATE TABLE productcate(
    productcateno                NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                            VARCHAR2(50)     NOT NULL,
    seqno                           NUMBER(7)    DEFAULT 0     NOT NULL,
    cnt                               NUMBER(7)    DEFAULT 0     NOT NULL            
);

COMMENT ON TABLE productcate is '��ǰ ī�װ�';
COMMENT ON COLUMN productcate.productcateno is '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN productcate.name is '��ǰ �з���';
COMMENT ON COLUMN productcate.seqno is '��� ����';
COMMENT ON COLUMN productcate.cnt is '��ϵ� ���� ��';

-- ���
INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '�ѽ�', 1,0);
            
INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '�߽�', 2, 0);

INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '�Ͻ�', 3, 0);

INSERT INTO productcate(productcateno, name, seqno, cnt)
VALUES((SELECT NVL(MAX(productcateno), 0) + 1 as productcateno FROM productcate),
            '�н�', 4, 0);
-- ���
SELECT productcateno, name, seqno, cnt
FROM productcate
ORDER BY seqno ASC;     
    
-- ����
      UPDATE productcate
      SET name= '�����ƽ�', seqno = 3
      WHERE productcateno = 3;
      
-- ����
DELETE FROM productcate
WHERE productcateno = 4;
 
-- ��ȸ
SELECT productcateno, name, seqno, cnt
FROM productcate
WHERE productcateno= 1;

SELECT *
FROM productcate
ORDER BY seqno ASC;

 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 �ѽ�       1   0
             2 �߽�       2   0
             3 �Ͻ�       3   0
             
-- cnt ����
UPDATE productcate
SET cnt = cnt + 1
WHERE productcateno = 1;

 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 �ѽ�       1   1
             2 �߽�       2   0
             3 �����ƽ�     3   0
             
-- cnt ����
UPDATE productcate
SET cnt = cnt - 1
WHERE productcateno = 1;
             
 PRODUCTCATENO NAME SEQNO CNT
 ------------- ---- ----- ---
             1 �ѽ�       1   0
             2 �߽�       2   0
             3 �����ƽ�     3   0
