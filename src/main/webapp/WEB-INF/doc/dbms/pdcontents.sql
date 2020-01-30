/**********************************/
/* Table Name: pdcontents */
/**********************************/
DROP TABLE pdcontents CASCADE CONSTRAINTS; 

CREATE TABLE pdcontents(
		pdcontentsno                  NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		productcateno                 NUMBER(10)		 NOT NULL,
		title                         		    VARCHAR2(300)		 NOT NULL,
		price                             NUMBER(10)    NOT NULL,
		content                       		CLOB		 NOT NULL,
		recom                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		cnt                           		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		replycnt                      		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		word                          		VARCHAR2(100)		 NULL ,
		fname                            VARCHAR2(100)         NOT NULL,
    fupname                        VARCHAR2(100)         NOT NULL,
    thumb                           VARCHAR2(100)         NULL ,
    fsize                              NUMBER(10)         DEFAULT 0         NOT NULL,
		FOREIGN KEY (productcateno) REFERENCES productcate (productcateno)
);

COMMENT ON TABLE pdcontents is '��ǰ������';
COMMENT ON COLUMN pdcontents.productcateno is '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN pdcontents.title is '��ǰ��';
COMMENT ON COLUMN pdcontents.content is '����';
COMMENT ON COLUMN pdcontents.price is '����';
COMMENT ON COLUMN pdcontents.recom is '��õ��';
COMMENT ON COLUMN pdcontents.cnt is '��ȸ��';
COMMENT ON COLUMN pdcontents.replycnt is '��ۼ�';
COMMENT ON COLUMN pdcontents.rdate is '�����';
COMMENT ON COLUMN pdcontents.word is '�˻���';
COMMENT ON COLUMN pdcontents.fname is '���� ���ϸ�';
COMMENT ON COLUMN pdcontents.fupname is '���ε� ���ϸ�';
COMMENT ON COLUMN pdcontents.thumb is 'Thumb ����';
COMMENT ON COLUMN pdcontents.fsize is '���� ������';

1) ���
INSERT INTO contents(mkcontentsno, productcateno,title,
                              content,recom,cnt,replycnt,rdate,word)
                              
 -- PK ����
 SELECT NVL(MAX(pdcontentsno),0) + 1 as pdcontentsno FROM pdcontents;

 PDCONTENTSNO
 ------------
            1

 -- productcate ���̺� ��� Ȯ�� 
SELECT productcateno, name, seqno, cnt
FROM productcate
ORDER BY seqno ASC; 

-- 1) contents ��� (member:1, categrpno: 1),
--     varchar�� ''��ϵǸ� null�� insert ��. 
INSERT INTO pdcontents(pdcontentsno, 
                              productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize )
 VALUES((SELECT NVL(MAX(pdcontentsno),0)+1 as pdcontentsno FROM pdcontents),
              1, '�����', 1200, '����1',
             0, 0, 0, sysdate, '', 'bibmbap.jpg', 'bibmbap_1.jpg', 'bibmbap_t.jpg', 1000);
                        
-- 2) ���
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
ORDER BY pdcontentsno DESC;

PDCONTENTSNO PRODUCTCATENO TITLE CONTENT RECOM CNT REPLYCNT RDATE                 WORD FNAME       FUPNAME       THUMB         FSIZE
 ------------ ------------- ----- ------- ----- --- -------- --------------------- ---- ----------- ------------- ------------- -----
            1             1 �����   ����1         0   0        0 2019-12-11 17:47:23.0 NULL bibmbap.jpg bibmbap_1.jpg bibmbap_t.jpg  1000
            
-- 3) productcate�� ��ü ���
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
WHERE productcateno=1 --1: �ѽ�, --2: �߽� 
ORDER BY pdcontentsno DESC;

 PDCONTENTSNO PDTHUMBNO PRODUCTCATENO TITLE CONTENT RECOM CNT REPLYCNT RDATE                 WORD
 ------------ --------- ------------- ----- ------- ----- --- -------- --------------------- ----
            1         1             1 �����   ����1         0   0        0 2019-12-11 16:55:02.0 NULL
         
-- 4) ��ü ���ڵ� �� 
SELECT COUNT(*) as count
FROM pdcontents;

 COUNT
 -----
     1
     
-- 5) ��ȸ
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
WHERE pdcontentsno=1;
     
-- 6) ����
UPDATE pdcontents
SET title='��ġ������', content='���� ����', word='�˻���'
WHERE pdcontentsno = 1;

-- 7) ����
DELETE FROM pdcontents
WHERE pdcontentsno = 1;


-- 8) FK �θ� ���̺� ���ڵ� ���� ����
SELECT pdcontentsno, productcateno, title, price, 
FROM pdcontents
WHERE productcateno = 1;

 MKCONTENTSNO PRODUCTCATENO TITLE
 ------------ ------------- -----
            1             1 ���� ����
            
SELECT COUNT(*) as cnt
FROM pdcontents
WHERE productcateno = 1;

 CNT
 ---
   1

   --- ������� ��12.09
-- 9) FK �θ� ���̺� ���ڵ� ����
DELETE FROM contents
WHERE categrpno = 1;

/**********************************/
/* Table Name: ��� */
/**********************************/
CREATE TABLE reply(
		rplyno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno)
);

COMMENT ON TABLE reply is '���';
COMMENT ON COLUMN reply.rplyno is '��۹�ȣ';
COMMENT ON COLUMN reply.contentsno is '��������ȣ';


/**********************************/
/* Table Name: �μ� */
/**********************************/
CREATE TABLE department(
		departmentno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE department is '�μ�';
COMMENT ON COLUMN department.departmentno is '�μ���ȣ';


/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE employee(
		employeeno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		departmentno                  		NUMBER(10)		 NULL ,
  FOREIGN KEY (departmentno) REFERENCES department (departmentno)
);

COMMENT ON TABLE employee is '����';
COMMENT ON COLUMN employee.employeeno is '������ȣ';
COMMENT ON COLUMN employee.departmentno is '�μ���ȣ';


/**********************************/
/* Table Name: ȸ�� �α��� ���� */
/**********************************/
CREATE TABLE login(
		loginno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE login is 'ȸ�� �α��� ����';
COMMENT ON COLUMN login.loginno is '�α��ι�ȣ';
COMMENT ON COLUMN login.memberno is 'ȸ����ȣ';


/**********************************/
/* Table Name: ���� �α��� ���� */
/**********************************/
CREATE TABLE login2(
		login2no                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		employeeno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (employeeno) REFERENCES employee (employeeno)
);

COMMENT ON TABLE login2 is '���� �α��� ����';
COMMENT ON COLUMN login2.login2no is '�α��ι�ȣ2';
COMMENT ON COLUMN login2.employeeno is '������ȣ';


/**********************************/
/* Table Name: ÷������ */
/**********************************/
CREATE TABLE attachfile(
		attachfileno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno)
);

COMMENT ON TABLE attachfile is '÷������';
COMMENT ON COLUMN attachfile.attachfileno is '÷�����Ϲ�ȣ';
COMMENT ON COLUMN attachfile.contentsno is '��������ȣ';


