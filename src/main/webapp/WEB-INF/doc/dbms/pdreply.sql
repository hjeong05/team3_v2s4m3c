/**********************************/
/* Table Name: 댓글 */
/**********************************/
DROP TABLE pdreply;

CREATE TABLE pdreply(
        pdreplyno                               NUMBER(10)          NOT NULL         PRIMARY KEY,
        pdcontentsno                       NUMBER(10)          NOT NULL ,
        memberno                             NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
        starcnt                                  NUMBER(3,1)           NOT NULL , -- 평점
        content                               VARCHAR2(1000)     NOT NULL,
        passwd                                VARCHAR2(20)       NOT NULL,
        rdate                                   DATE                  NOT NULL,
  FOREIGN KEY (pdcontentsno) REFERENCES PDCONTENTS (pdcontentsno),
  FOREIGN KEY (MEMBERNO) REFERENCES MKMEMBER (MEMBERNO)
);

COMMENT ON TABLE pdreply is '댓글';
COMMENT ON COLUMN pdreply.pdreplyno is '댓글번호';
COMMENT ON COLUMN pdreply.pdcontentsno is '컨텐츠번호';
COMMENT ON COLUMN pdreply.memberno is '회원 번호';
COMMENT ON COLUMN pdreply.starcnt is '평점';
COMMENT ON COLUMN pdreply.content is '내용';
COMMENT ON COLUMN pdreply.passwd is '비밀번호';
COMMENT ON COLUMN pdreply.rdate is '등록일';

1) 등록
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             2, 1, 3, '댓글1', '1234', sysdate);
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             2, 1, 4, '댓글2', '1234', sysdate);
INSERT INTO pdreply(pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate)
VALUES((SELECT NVL(MAX(pdreplyno), 0) + 1 as pdreplyno FROM pdreply),
             1, 1, 4.5, '댓글3', '1234', sysdate);     

2) 전체 목록
SELECT pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate
FROM pdreply
ORDER BY pdreplyno DESC;

 PDREPLYNO PDCONTENTSNO MEMBERNO STARCNT CONTENT PASSWD RDATE
 --------- ------------ -------- ------- ------- ------ ---------------------
         3            1        1     4.5 댓글3     1234   2020-01-02 12:31:48.0
         2            1        1       4 댓글2     1234   2020-01-02 12:31:47.0
         1            1        1       3 댓글1     1234   2020-01-02 12:31:46.0

3) contentsno 별 목록
SELECT pdreplyno, pdcontentsno, memberno, starcnt, content, passwd, rdate
FROM pdreply
WHERE pdcontentsno=1
ORDER BY pdreplyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD
 ------- ---------- -------- ------- ------
       3          1        1 댓글3     1234
       2          1        1 댓글2     1234
       1          1        1 댓글1     1234


4) 삭제
-- 패스워드 검사
SELECT count(passwd) as cnt
FROM pdreply
WHERE pdreplyno=1 AND passwd='1234';

 CNT
 ---
   1
   
-- 삭제
DELETE FROM pdreply
WHERE pdreplyno=1;

5) contentsno에 해당하는 댓글 수 확인 및 삭제 
SELECT COUNT(*) as cnt
FROM pdreply
WHERE pdcontentsno = 1;

 CNT
 ---
   1
   
DELETE pdreply
WHERE pdcontentsno = 1;

6) memberno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM pdreply
WHERE memberno = 1;

DELETE pdreply
WHERE memberno = 1;

DELETE FROM pdreply;

7) 회원ID의 출력
SELECT m.id, 
          r.pdreplyno, r.pdcontentsno, r.starcnt, r.memberno, r.content, r.passwd, r.rdate
FROM member m, pdreply r
WHERE (m.memberno = r.memberno) AND r.pdcontentsno=1
ORDER BY pdreplyno DESC;

 ID       REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD
 -------- ------- ---------- -------- ------- ------
 user1          3          1        1 댓글3     1
 user2          2          1        1 댓글2     1
 user1          1          1        1 댓글1     1
 
 8) 삭제용 패스워드 검사
SELECT count(*) as cnt
FROM pdreply
WHERE pdreplyno=1 AND passwd='1234'; 

 CNT
 ---
   0
   
9) 삭제
DELETE FROM pdreply
WHERE pdreplyno=1;

10) 댓글 개수 
SELECT COUNT(*) as cnt
FROM pdreply;