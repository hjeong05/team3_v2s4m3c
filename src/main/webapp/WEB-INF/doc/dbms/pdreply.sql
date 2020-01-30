/**********************************/
/* Table Name: ��� */
/**********************************/
DROP TABLE pdreply;

CREATE TABLE pdreply(
        pdreplyno                               NUMBER(10)          NOT NULL         PRIMARY KEY,
        pdcontentsno                       NUMBER(10)          NOT NULL ,
        memberno                             NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
        starcnt                                  NUMBER(3,1)           NOT NULL , -- ����
        content                               VARCHAR2(1000)     NOT NULL,
        passwd                                VARCHAR2(20)       NOT NULL,
        rdate                                   DATE                  NOT NULL,
  FOREIGN KEY (pdcontentsno) REFERENCES PDCONTENTS (pdcontentsno),
  FOREIGN KEY (MEMBERNO) REFERENCES MKMEMBER (MEMBERNO)
);

COMMENT ON TABLE pdreply is '���';
COMMENT ON COLUMN pdreply.pdreplyno is '��۹�ȣ';
COMMENT ON COLUMN pdreply.pdcontentsno is '��������ȣ';
COMMENT ON COLUMN pdreply.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN pdreply.starcnt is '����';
COMMENT ON COLUMN pdreply.content is '����';
COMMENT ON COLUMN pdreply.passwd is '��й�ȣ';
COMMENT ON COLUMN pdreply.rdate is '�����';

1) ���
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             2, 1, 3, '���1', '1234', sysdate);
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             2, 1, 4, '���2', '1234', sysdate);
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             1, 1, 4.5, '���3', '1234', sysdate);     

2) ��ü ���
SELECT pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate
FROM pdreply
ORDER BY pdreplyno DESC;

 PDREPLYNO PDCONTENTSNO MEMBERNO STARCNT CONTENT PASSWD RDATE
 --------- ------------ -------- ------- ------- ------ ---------------------
         3            1        1     4.5 ���3     1234   2020-01-02 12:31:48.0
         2            1        1       4 ���2     1234   2020-01-02 12:31:47.0
         1            1        1       3 ���1     1234   2020-01-02 12:31:46.0

3) contentsno �� ���
SELECT pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate
FROM pdreply
WHERE pdcontentsno=1
ORDER BY pdreplyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD
 ------- ---------- -------- ------- ------
       3          1        1 ���3     1234
       2          1        1 ���2     1234
       1          1        1 ���1     1234


4) ����
-- �н����� �˻�
SELECT count(passwd) as cnt
FROM pdreply
WHERE pdreplyno=1 AND passwd='1234';

 CNT
 ---
   1
   
-- ����
DELETE FROM pdreply
WHERE pdreplyno=1;

5) contentsno�� �ش��ϴ� ��� �� Ȯ�� �� ���� 
SELECT COUNT(*) as cnt
FROM pdreply
WHERE pdcontentsno = 1;

 CNT
 ---
   1
   
DELETE pdreply
WHERE pdcontentsno = 1;

6) memberno�� �ش��ϴ� ��� �� Ȯ�� �� ����
SELECT COUNT(*) as cnt
FROM pdreply
WHERE memberno = 1;

DELETE pdreply
WHERE memberno = 1;

DELETE FROM pdreply;

7) ȸ��ID�� ���
SELECT m.id, 
          r.pdreplyno, r.pdcontentsno, r.starcnt, r.memberno, r.content, r.passwd, r.rdate
FROM member m, pdreply r
WHERE (m.memberno = r.memberno) AND r.pdcontentsno=1
ORDER BY pdreplyno DESC;

 ID       REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD
 -------- ------- ---------- -------- ------- ------
 user1          3          1        1 ���3     1
 user2          2          1        1 ���2     1
 user1          1          1        1 ���1     1
 
 8) ������ �н����� �˻�
SELECT count(*) as cnt
FROM pdreply
WHERE pdreplyno=1 AND passwd='1234'; 

 CNT
 ---
   0
   
9) ����
DELETE FROM pdreply
WHERE pdreplyno=1;

10) ��� ���� 
SELECT COUNT(*) as cnt
FROM pdreply;