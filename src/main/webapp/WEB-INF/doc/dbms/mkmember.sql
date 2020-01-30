-----------------------------------------------------------------------------------------
2. 회원 카테고리: mkmember
-----------------------------------------------------------------------------------------
DROP TABLE memcate;
DROP TABLE mkmember;

CREATE TABLE mkmember(
  memberno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  memcateno     NUMBER(10)     NOT NULL, -- 회원 등급 카테고리 번호
  id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel          VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  address1  VARCHAR(80)       NULL, -- 주소 1
  address2  VARCHAR(50)       NULL, -- 주소 2
  mdate     DATE             NOT NULL, -- 가입일    
  PRIMARY KEY (memberno),                     -- 한번 등록된 값은 중복 안됨
  FOREIGN KEY (memcateno) REFERENCES memcate (memcateno)
);

COMMENT ON TABLE MKMEMBER is '회원';
COMMENT ON COLUMN MKMEMBER.memberno is '회원 번호';
COMMENT ON COLUMN MKMEMBER.memcateno is '등급 카테고리 번호';
COMMENT ON COLUMN MKMEMBER.ID is '아이디';
COMMENT ON COLUMN MKMEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MKMEMBER.MNAME is '성명';
COMMENT ON COLUMN MKMEMBER.TEL is '전화번호';
COMMENT ON COLUMN MKMEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN MKMEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MKMEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MKMEMBER.MDATE is '가입일';

1. 등록
 
1) id 중복 확인
SELECT COUNT(id) as cnt
FROM mkmember
WHERE id='user1';
   
2) 등록
- 일련번호 산출 서브쿼리
- MAX(memberno): memberno 컬럼의 값중에 가장 큰 값을 산출
- 레코드가 없으면 MAX 함수의 결과는 NULL이됩니다.
SELECT MAX(memberno) as memberno FROM mkmember;
 
 - NULL 값은 사칙연산의 결과도 NULL이됩니다. 의미 없음.
SELECT MAX(memberno)+1 as memberno FROM mkmember;
 
 - NVL(값, 변환할 값): 값이 NULL이면 변환할 값으로 변경, 
   NULL을 0으로 변경
SELECT NVL(MAX(memberno), 0) as memberno FROM mkmember;
   
- NULL을 처리하면서 새로운 최대값 산출 SQL
SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember;
 
-- 관리용 회원 기준
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember), 1,
'qnaadmin', '1234', 'QNA관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember),1,
'crm', '1234', '고객관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
-- 개인 회원 기준
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember), 1,
'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember), 1,
'user2', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember), 1,
'user3', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
-- 그룹별 공유회원 기준
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember), 1,
'team1', '1234', '개발팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM mkmember),1,
'team2', '1234', '웹퍼블리셔팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO mkmember(memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member),1,
'team3', '1234', '디자인팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
 
2. 목록
-- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM mkmember
ORDER BY memberno ASC; 

-- 회원 등급별 목록
SELECT memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM mkmember
WHERE memcateno=1
ORDER BY memberno ASC;
   
3. 조회
 
1) user1 사원 정보 보기
SELECT memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM mkmember
WHERE memberno = 1;
 
SELECT memberno, memcateno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM mkmember
WHERE id = 'user1';
   
4. 수정
UPDATE mkmember 
SET mname='아로미', tel='111-1111-1111', zipcode='00000',
      address1='경기도', address2='파주시'
WHERE memberno=1;
 
5. 패스워드 변경

1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM mkmember
WHERE memberno=1 AND passwd='1234';
 
2) 패스워드 수정
UPDATE mkmember
SET passwd='0000'
WHERE memberno=1 AND passwd='1111';
 
6. 삭제

1) 모두 삭제 -- 실수하면 안되니까 구현하지 말 것!
DELETE FROM mkmember; 
 
2) 특정 회원 삭제
DELETE FROM mkmember
WHERE memberno=4;
 
7. 로그인
SELECT COUNT(memberno) as cnt
FROM mkmember
WHERE id='user1' AND passwd='1234';

8. 등급별 회원수
SELECT count(*) AS cnt
FROM mkmember
WHERE memcateno=2;

9. 등급별 회원 삭제
DELETE FROM mkmember
WHERE memcateno=2;

10. 회원 등급 변경
UPDATE mkmember 
SET memcateno=1
WHERE memberno=1;