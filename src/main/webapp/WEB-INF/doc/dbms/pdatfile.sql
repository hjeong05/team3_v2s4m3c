
/**********************************/
/* Table Name: ÷������ */
/**********************************/
DROP TABLE pdatfile;
CREATE TABLE pdatfile(
        pdatfileno                  NUMBER(10)         NOT NULL         PRIMARY KEY,
        pdcontentsno                   NUMBER(10)         NULL ,
        fname                             VARCHAR2(100)         NOT NULL,
        fupname                      VARCHAR2(100)         NOT NULL,
        thumb                         VARCHAR2(100)         NULL ,
        fsize                                 NUMBER(10)         DEFAULT 0         NOT NULL,
        rdate                           DATE     NOT NULL,
  FOREIGN KEY (pdcontentsno) REFERENCES pdcontents (pdcontentsno)
);

COMMENT ON TABLE pdatfile is '÷������';
COMMENT ON COLUMN pdatfile.pdatfileno is '÷�����Ϲ�ȣ';
COMMENT ON COLUMN pdatfile.pdcontentsno is '��ǰ��������ȣ';
COMMENT ON COLUMN pdatfile.fname is '���� ���ϸ�';
COMMENT ON COLUMN pdatfile.fupname is '���ε� ���ϸ�';
COMMENT ON COLUMN pdatfile.thumb is 'Thumb ����';
COMMENT ON COLUMN pdatfile.fsize is '���� ������';
COMMENT ON COLUMN pdatfile.rdate is '�����';

-- 1) ���
SELECT NVL(MAX(pdatfileno), 0) + 1 as pdatfileno FROM pdatfile;
 
 PDATFILENO
 ----------
          1

SELECT *
FROM pdcontents
ORDER BY pdcontentsno ASC;
 
 PDCONTENTSNO PDTHUMBNO PRODUCTCATENO TITLE
 ------------ --------- ------------- -----
            1         1             1 ��ġ������

            
1) ���
INSERT INTO pdatfile(pdatfileno, pdcontentsno, fname, fupname, thumb, fsize, rdate)
VALUES((SELECT NVL(MAX(pdatfileno), 0) + 1 as pdatfileno FROM pdatfile),
             3, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);
        
-- 2) ���( pdcontentsno ���� ���� ����, pdattachfileno ���� ��������)
SELECT pdatfileno, pdcontentsno, fname, fupname, thumb, fsize, rdate
FROM pdatfile
ORDER BY pdcontentsno DESC,  pdatfileno ASC;

 -------------- ------------ ------------ -------------- -------------- ----- ---------------------
              1            1 samyang.jpg  samyang_1.jpg  samyang_t.jpg   1000 2019-12-11 10:44:42.0
              2            1 samyang2.jpg samyang2_1.jpg samyang2_t.jpg  2000 2019-12-11 10:44:43.0
              3            1 samyang3.jpg samyang3_1.jpg samyang3_t.jpg  3000 2019-12-11 10:44:44.0
              
-- 3) �ۺ� ���� ���(contentsno ���� ���� ����, attachfileno ���� ��������)
SELECT pdatfileno, pdcontentsno, fname, fupname, thumb, fsize, rdate
FROM pdatfile
WHERE pdcontentsno = 1
ORDER BY fname ASC;

 PDATTACHFILENO PDCONTENTSNO FNAME        FUPNAME        THUMB          FSIZE RDATE
 -------------- ------------ ------------ -------------- -------------- ----- ---------------------
              1            1 samyang.jpg  samyang_1.jpg  samyang_t.jpg   1000 2019-12-11 10:44:42.0
              2            1 samyang2.jpg samyang2_1.jpg samyang2_t.jpg  2000 2019-12-11 10:44:43.0
              3            1 samyang3.jpg samyang3_1.jpg samyang3_t.jpg  3000 2019-12-11 10:44:44.0

-- 4) �ϳ��� ���� ����
DELETE FROM pdattachfile
WHERE pdattachfileno = 1;

-- 5) FK contentsno �θ� ���̺� ���ڵ� ���� ����
SELECT pdatfileno, pdcontentsno, fname, fupname, thumb, fsize, rdate
FROM pdattachfile
WHERE pdcontentsno = 1;

 ATTACHFILENO CONTENTSNO FNAME        FUPNAME        THUMB            FSIZE  RDATE
 ------------ ---------- ------------ -------------- ---------------- ------ ---------------------
            3          1 winter15.jpg winter15.jpg   winter15_t.jpg   443446 2019-12-04 16:00:11.0
            4          1 winter16.jpg winter16.jpg   winter16_t.jpg    99992 2019-12-04 16:00:11.0
            5          1 winter18.jpg winter18.jpg   winter18_t.jpg   120298 2019-12-04 16:00:11.0
            6          1 winter.zip   winter.zip     NULL             770036 2019-12-05 12:13:45.0
            8          1 winter20.jpg winter20.jpg   winter20_t.jpg    75726 2019-12-05 15:46:25.0
            1          1 winter12.jpg winter12_0.jpg winter12_0_t.jpg 395511 2019-12-04 16:00:11.0
            2          1 winter14.jpg winter14.jpg   winter14_t.jpg    84563 2019-12-04 16:00:11.0
            
SELECT COUNT(*) as cnt
FROM pdattachfile
WHERE pdcontentsno = 1;

 CNT
 ---
   7   
             
-- 6) FK �θ� ���̺� ���ڵ� ����
DELETE FROM pdattachfile
WHERE pdcontentsno = 6;

(3 rows affected)

-- 7) ��ȸ
SELECT pdatfileno, pdcontentsno, fname, fupname, thumb, fsize, rdate
FROM pdatfile
WHERE pdatfileno = 1;