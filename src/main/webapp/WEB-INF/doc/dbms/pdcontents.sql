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

COMMENT ON TABLE pdcontents is '상품컨텐츠';
COMMENT ON COLUMN pdcontents.productcateno is '상품 카테고리 번호';
COMMENT ON COLUMN pdcontents.title is '상품명';
COMMENT ON COLUMN pdcontents.content is '내용';
COMMENT ON COLUMN pdcontents.price is '가격';
COMMENT ON COLUMN pdcontents.recom is '추천수';
COMMENT ON COLUMN pdcontents.cnt is '조회수';
COMMENT ON COLUMN pdcontents.replycnt is '댓글수';
COMMENT ON COLUMN pdcontents.rdate is '등록일';
COMMENT ON COLUMN pdcontents.word is '검색어';
COMMENT ON COLUMN pdcontents.fname is '원본 파일명';
COMMENT ON COLUMN pdcontents.fupname is '업로드 파일명';
COMMENT ON COLUMN pdcontents.thumb is 'Thumb 파일';
COMMENT ON COLUMN pdcontents.fsize is '파일 사이즈';

1) 등록
INSERT INTO contents(mkcontentsno, productcateno,title,
                              content,recom,cnt,replycnt,rdate,word)
                              
 -- PK 생성
 SELECT NVL(MAX(pdcontentsno),0) + 1 as pdcontentsno FROM pdcontents;

 PDCONTENTSNO
 ------------
            1

 -- productcate 테이블 목록 확인 
SELECT productcateno, name, seqno, cnt
FROM productcate
ORDER BY seqno ASC; 

-- 1) contents 등록 (member:1, categrpno: 1),
--     varchar에 ''등록되면 null이 insert 됨. 
INSERT INTO pdcontents(pdcontentsno, 
                              productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize )
 VALUES((SELECT NVL(MAX(pdcontentsno),0)+1 as pdcontentsno FROM pdcontents),
              1, '비빔밥', 1200, '내용1',
             0, 0, 0, sysdate, '', 'bibmbap.jpg', 'bibmbap_1.jpg', 'bibmbap_t.jpg', 1000);
                        
-- 2) 목록
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
ORDER BY pdcontentsno DESC;

PDCONTENTSNO PRODUCTCATENO TITLE CONTENT RECOM CNT REPLYCNT RDATE                 WORD FNAME       FUPNAME       THUMB         FSIZE
 ------------ ------------- ----- ------- ----- --- -------- --------------------- ---- ----------- ------------- ------------- -----
            1             1 비빔밥   내용1         0   0        0 2019-12-11 17:47:23.0 NULL bibmbap.jpg bibmbap_1.jpg bibmbap_t.jpg  1000
            
-- 3) productcate별 전체 목록
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
WHERE productcateno=1 --1: 한식, --2: 중식 
ORDER BY pdcontentsno DESC;

 PDCONTENTSNO PDTHUMBNO PRODUCTCATENO TITLE CONTENT RECOM CNT REPLYCNT RDATE                 WORD
 ------------ --------- ------------- ----- ------- ----- --- -------- --------------------- ----
            1         1             1 비빔밥   내용1         0   0        0 2019-12-11 16:55:02.0 NULL
         
-- 4) 전체 레코드 수 
SELECT COUNT(*) as count
FROM pdcontents;

 COUNT
 -----
     1
     
-- 5) 조회
SELECT pdcontentsno, productcateno, title, price, content,
                              recom,cnt,replycnt,rdate,word, fname, fupname, thumb, fsize 
FROM pdcontents
WHERE pdcontentsno=1;
     
-- 6) 수정
UPDATE pdcontents
SET title='김치볶음밥', content='내용 수정', word='검색어'
WHERE pdcontentsno = 1;

-- 7) 삭제
DELETE FROM pdcontents
WHERE pdcontentsno = 1;


-- 8) FK 부모 테이블별 레코드 갯수 산출
SELECT pdcontentsno, productcateno, title, price, 
FROM pdcontents
WHERE productcateno = 1;

 MKCONTENTSNO PRODUCTCATENO TITLE
 ------------ ------------- -----
            1             1 제목 수정
            
SELECT COUNT(*) as cnt
FROM pdcontents
WHERE productcateno = 1;

 CNT
 ---
   1

   --- 여기까지 ㅇ12.09
-- 9) FK 부모 테이블별 레코드 삭제
DELETE FROM contents
WHERE categrpno = 1;

/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
		rplyno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.rplyno is '댓글번호';
COMMENT ON COLUMN reply.contentsno is '컨텐츠번호';


/**********************************/
/* Table Name: 부서 */
/**********************************/
CREATE TABLE department(
		departmentno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE department is '부서';
COMMENT ON COLUMN department.departmentno is '부서번호';


/**********************************/
/* Table Name: 직원 */
/**********************************/
CREATE TABLE employee(
		employeeno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		departmentno                  		NUMBER(10)		 NULL ,
  FOREIGN KEY (departmentno) REFERENCES department (departmentno)
);

COMMENT ON TABLE employee is '직원';
COMMENT ON COLUMN employee.employeeno is '직원번호';
COMMENT ON COLUMN employee.departmentno is '부서번호';


/**********************************/
/* Table Name: 회원 로그인 내역 */
/**********************************/
CREATE TABLE login(
		loginno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE login is '회원 로그인 내역';
COMMENT ON COLUMN login.loginno is '로그인번호';
COMMENT ON COLUMN login.memberno is '회원번호';


/**********************************/
/* Table Name: 직원 로그인 내역 */
/**********************************/
CREATE TABLE login2(
		login2no                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		employeeno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (employeeno) REFERENCES employee (employeeno)
);

COMMENT ON TABLE login2 is '직원 로그인 내역';
COMMENT ON COLUMN login2.login2no is '로그인번호2';
COMMENT ON COLUMN login2.employeeno is '직원번호';


/**********************************/
/* Table Name: 첨부파일 */
/**********************************/
CREATE TABLE attachfile(
		attachfileno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno)
);

COMMENT ON TABLE attachfile is '첨부파일';
COMMENT ON COLUMN attachfile.attachfileno is '첨부파일번호';
COMMENT ON COLUMN attachfile.contentsno is '컨텐츠번호';


