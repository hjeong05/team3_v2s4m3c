-----------------------------------------------------------------------------------------
1. 회원 카테고리: memcate
-----------------------------------------------------------------------------------------

DROP TABLE memcate;

CREATE TABLE memcate(
        memcateno           NUMBER(10)         NOT NULL         PRIMARY KEY,
        name                    VARCHAR2(50)     NOT NULL,
        seqno                   NUMBER(7)          DEFAULT 0        NOT NULL,
        visible                   CHAR(1)              DEFAULT 'Y'      NOT NULL,
        rdate                     DATE                  NOT NULL,
        cnt                        NUMBER(7)         NULL 
);

COMMENT ON TABLE memcate is '멤버 카테고리 그룹';
COMMENT ON COLUMN memcate.memcateno is '멤버 카테고리 그룹 번호';
COMMENT ON COLUMN memcate.name is '멤버 카테고리 이름';
COMMENT ON COLUMN memcate.seqno is '출력 순서';
COMMENT ON COLUMN memcate.visible is '출력 모드';
COMMENT ON COLUMN memcate.rdate is '그룹 생성일';
COMMENT ON COLUMN memcate.cnt is '등록된 회원수';

-- 등록
INSERT INTO memcate(memcateno, name, seqno, visible, rdate, cnt)
VALUES((SELECT NVL(MAX(memcateno), 0) + 1 as memcateno FROM memcate), '우수 회원', 1, 'Y', sysdate, 0);

INSERT INTO memcate(memcateno, name, seqno, visible, rdate, cnt)
VALUES((SELECT NVL(MAX(memcateno), 0) + 1 as memcateno FROM memcate), '일반 회원', 1, 'Y', sysdate, 0);

INSERT INTO memcate(memcateno, name, seqno, visible, rdate, cnt)
VALUES((SELECT NVL(MAX(memcateno), 0) + 1 as memcateno FROM memcate), '정지 회원', 1, 'Y', sysdate, 0);

-- 목록
SELECT memcateno, name, seqno, visible, rdate, cnt
FROM memcate
ORDER BY seqno ASC;

-- 수정
UPDATE memcate
SET name='일반 회원', seqno = 1, visible='Y'
WHERE memcateno = 3;

-- 삭제
DELETE FROM memcate
COMMIT;
 
DELETE FROM memcate
WHERE memcateno = 2;

-- 카테고리별 회원 수 증가 / 감소
UPDATE memcate 
SET cnt = cnt + 1 
WHERE memcateno=1;

UPDATE memcate 
SET cnt = cnt - 1 
WHERE memcateno=1;

-- 순서 변경 상향 / 하향
UPDATE memcate
SET seqno = seqno - 1
WHERE memcateno = 1;

UPDATE memcate
SET seqno = seqno + 1
WHERE memcateno = 1;

-- 회원수 초기화(0명)
UPDATE memcate 
SET cnt = 0 
WHERE memcateno = 2;