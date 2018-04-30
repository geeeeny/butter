DELETE TABLE BOARDS;

CREATE TABLE BOARDS (
    BOARD_ID NUMBER PRIMARY KEY,
    TITLE VARCHAR2(256) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    READ_CNT NUMBER,
    CONTENT CLOB,
    REG_DATE DATE,
    UPDATE_DATE DATE
);

CREATE SEQUENCE BOARDS_SEQ;

SELECT * FROM BOARDS;


DELETE TABLE ATTACHMENTS;

CREATE TABLE ATTACHMENTS(
	ATTACHMENT_ID NUMBER PRIMARY KEY,
	FILE_NAME VARCHAR2(256),
	LOCATION VARCHAR2(1024),
	BOARD_ID NUMBER,
	REG_DATE DATE,
	CONSTRAINT F_ATTACHMENTS_BOARD FOREIGN KEY(BOARD_ID)
	REFERENCES BOARDS(BOARD_ID)
);

CREATE SEQUENCE ATTACHMENTS_SEQ;

SELECT * FROM ATTACHMENTS;

CREATE TABLE AVATAS(
	user_id VARCHAR2(20) PRIMARY KEY,
	image BLOB
);

select * from avatas;

CREATE TABLE REPLIES( 
	REPLY_ID NUMBER PRIMARY KEY, 
	BOARD_ID NUMBER, REPLY_LEVEL NUMBER, 
	PARENT NUMBER, 
	WRITER VARCHAR2(20) NOT NULL, 
	CONTENT VARCHAR2(1024), 
	DELETED NUMBER(1), 
	REG_DATE DATE, 
	UPDATE_DATE DATE, 
	CONSTRAINT F_REPLIES_BOARD FOREIGN KEY(BOARD_ID) REFERENCES BOARDS(BOARD_ID), 
	CONSTRAINT F_REPLIES_MEMBER FOREIGN KEY(WRITER) REFERENCES MEMBERS(USER_ID) 
);

select * from replies;

CREATE SEQUENCE REPLIES_SEQ;

-- 채팅
CREATE TABLE TALKS (
	TALK_ID NUMBER PRIMARY KEY,	
	USER_ID VARCHAR2(20),		--보낸 사람
	WITH_TALK VARCHAR2(20),		--받는 사람
	RECEIVED NUMBER(1),			--1: 수신, 0: 발신
	CHECKED NUMBER(1),			--확인 여부
	MESSAGE VARCHAR2(1024),
	REG_DATE DATE
);

CREATE SEQUENCE TALKS_SEQ;

--test data
insert into talks(talk_id, user_id, with_talk, received, checked, message, reg_date)
values(talks_seq.nextval, 'go', 'admin', 0, 0, '공지1', sysdate);

insert into talks(talk_id, user_id, with_talk, received, checked, message, reg_date)
values(talks_seq.nextval, 'go', 'admin', 0, 0, '공지2', sysdate);

insert into talks(talk_id, user_id, with_talk, received, checked, message, reg_date)
values(talks_seq.nextval, 'go', 'hong', 0, 0, '안녕', sysdate);

-- 회원별 신규 메시지 개수 출력
select with_talk, count(*) newMessages from talks
where checked=0 and user_id='go'
group by with_talk;

select user_id, name, newMessages
from
	members m,
	(select with_talk, count(*) newMessages from talks
		where checked=0 and user_id='go'
		group by with_talk
	) t
where m.user_id<>'go' and m.user_id=t.with_talk(+)
order by newMessages DESC;

-- 회원별 최근 등록된 talk 출력
SELECT MAX(TALK_ID) FROM TALKS
WHERE USER_ID='go' AND RECEIVED=1
GROUP BY WITH_TALK;

SELECT * FROM TALKS
WHERE USER_ID='go' AND RECEIVED=1
AND TALK_ID IN (
	SELECT MAX(TALK_ID) FROM TALKS
	WHERE USER_ID='go' AND RECEIVED=1
	GROUP BY WITH_TALK
)
ORDER BY REG_DATE DESC;