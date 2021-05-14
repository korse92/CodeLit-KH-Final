
ADROP TABLE "MEMBER" CASCADE CONSTRAINTS;


DROP TABLE "MEMBER" CASCADE CONSTRAINTS;

CREATE TABLE "MEMBER" (
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(300)		NOT NULL,
	"MEMBER_PROFILE"	VARCHAR2(200)		NULL,
	"MEMBER_RE_PROFILE"	VARCHAR2(200)		NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_ID" IS '회원가입시 필수';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원가입시 필수 (암호화)';

DROP TABLE "LECTURE" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE" (
	"LECTURE_NO"	NUMBER		NOT NULL,
	"REF_LEC_CAT_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"LECTURE_NAME"	VARCHAR2(150)		NOT NULL,
	"LECTURE_TYPE"	CHAR(1)		NOT NULL,
	"LECTURE_INTRO"	VARCHAR2(3000)		NOT NULL,
	"LECTURE_THUMB_ORIGIN"	VARCHAR2(200)		NULL,
	"LECTURE_THUMB_RENAMED"	VARCHAR2(200)		NULL,
	"LECTURE_PRICE"	NUMBER		NULL,
	"LECTURE_ACCEPT_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"LECTURE_GUIDELINE"	NUMBER	DEFAULT 1	NULL
);

COMMENT ON COLUMN "LECTURE"."LECTURE_NO" IS 'SEQ_LEC_NO';
COMMENT ON COLUMN "LECTURE"."REF_LEC_CAT_NO" IS 'SEQ_LEC_CAT_NO';
COMMENT ON COLUMN "LECTURE"."REF_MEMBER_ID" IS '회원가입시 필수';
COMMENT ON COLUMN "LECTURE"."LECTURE_INTRO" IS '값이 html코드로 들어갈지 고민';
COMMENT ON COLUMN "LECTURE"."LECTURE_GUIDELINE" IS '하루에 들을 강의갯수 추천';

DROP TABLE "BASKET" CASCADE CONSTRAINTS;
CREATE TABLE "BASKET" (
	"BASKET_NO"	NUMBER		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"BASKET_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "BASKET"."BASKET_NO" IS 'seq_basket_no';

DROP TABLE "PICK" CASCADE CONSTRAINTS;
CREATE TABLE "PICK" (
	"PICK_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"PICK_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "PICK"."PICK_NO" IS 'seq_pick_no';

DROP TABLE "MESSENGER" CASCADE CONSTRAINTS;
CREATE TABLE "MESSENGER" (
	"MSG_NO"	NUMBER		NOT NULL,
	"REF_WRITER_ID"	VARCHAR2(20)		NOT NULL,
	"REF_RECEIVER_ID"	VARCHAR2(20)		NOT NULL,
	"MSG_TITLE"	VARCHAR2(200)		NOT NULL,
	"MSG_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"MSG_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"READ_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "MESSENGER"."MSG_NO" IS 'seq_msg_no';

DROP TABLE "NOTICE" CASCADE CONSTRAINTS;
CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"NOTICE_TITLE"	VARCHAR2(200)		NOT NULL,
	"NOTICE_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"NOTICE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"NOTICE_COUNT"	NUMBER	DEFAULT 0	NOT NULL
);

DROP TABLE "STUDY_BOARD" CASCADE CONSTRAINTS;
CREATE TABLE "STUDY_BOARD" (
	"STD_BRD_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"STD_BRD_TITLE"	VARCHAR2(100)		NOT NULL,
	"STD_BRD_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"STD_BRD_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"STD_BRD_COUNT"	NUMBER	DEFAULT 0	NOT NULL
);

DROP TABLE "LECTURE_CATEGORY" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_CATEGORY" (
	"LEC_CAT_NO"	NUMBER		NOT NULL,
	"LEC_CAT_NAME"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "LECTURE_CATEGORY"."LEC_CAT_NO" IS 'SEQ_LEC_CAT_NO';

DROP TABLE "COUNSEL" CASCADE CONSTRAINTS;
CREATE TABLE "COUNSEL" (
	"COUNSEL_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"COUNSEL_CATEGORY"	VARCHAR2(30)		NOT NULL,
	"COUNSEL_TITLE"	VARCHAR2(200)		NOT NULL,
	"COUNSEL_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"COUNSEL_Q_NO"	NUMBER		NULL,
	"COUNSEL_LEVEL"	NUMBER	DEFAULT 1	NOT NULL,
	"COUNSEL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "COUNSEL"."COUNSEL_NO" IS 'seq_counsel_no';
COMMENT ON COLUMN "COUNSEL"."REF_MEMBER_ID" IS '작성자 아이디';
COMMENT ON COLUMN "COUNSEL"."COUNSEL_CATEGORY" IS '문의글 카테고리';
COMMENT ON COLUMN "COUNSEL"."COUNSEL_Q_NO" IS '참조중인 문의번호';
COMMENT ON COLUMN "COUNSEL"."COUNSEL_LEVEL" IS '1 질문 2 답변';

DROP TABLE "COUNSELING_CHAT" CASCADE CONSTRAINTS;
CREATE TABLE "COUNSELING_CHAT" (
	"CHAT_NO"	NUMBER		NOT NULL,
	"SENDER_ID"	VARCHAR2(20)		NOT NULL,
	"RECEIVER_ID"	VARCHAR2(20)		NOT NULL,
	"CHAT_CONTENT"	VARCHAR2(200)		NOT NULL,
	"CHAT_REG_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "COUNSELING_CHAT"."CHAT_NO" IS 'SEQ_CHAT_NO';

DROP TABLE "PAYMENT" CASCADE CONSTRAINTS;
CREATE TABLE "PAYMENT" (
	"PAY_CODE"	VARCHAR2(40)		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"PAY_NO"	NUMBER		NOT NULL,
	"PAY_COST"	NUMBER		NOT NULL,
	"PAY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "PAYMENT"."PAY_NO" IS 'seq_pay_no';

DROP TABLE "LECTURE_PART" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_PART" (
	"LECTURE_PART_NO"	NUMBER		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"LECTURE_PART_TITLE"	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN "LECTURE_PART"."LECTURE_PART_NO" IS 'SEQ_LEC_PART_NO';

DROP TABLE "STUDY_COMMENT" CASCADE CONSTRAINTS;
CREATE TABLE "STUDY_COMMENT" (
	"STD_CMT_NO"	NUMBER		NOT NULL,
	"REF_STD_BRD_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"STD_CMT_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"STD_CMT_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

DROP TABLE "SEARCH" CASCADE CONSTRAINTS;
CREATE TABLE "SEARCH" (
	"SEARCH_KEYWORD"	VARCHAR2(100)		NOT NULL,
	"SEARCH_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL
);

DROP TABLE "LECTURE_COMMENT" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_COMMENT" (
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"LEC_ASSESSMENT"	NUMBER		NOT NULL,
	"LEC_COMMENT"	VARCHAR2(1500)		NOT NULL
);

COMMENT ON COLUMN "LECTURE_COMMENT"."REF_LECTURE_NO" IS 'SEQ_LEC_NO';

DROP TABLE "LECTURE_CLICK" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_CLICK" (
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"CLICK_NO"	NUMBER		NULL
);

DROP TABLE "LECTURE_PROGRESS" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_PROGRESS" (
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"REF_LEC_CHAPTER_NO"	NUMBER		NOT NULL,
	"SECTION_SIGN_UP_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"SECTION_SIGN_UP_PROGRESS"	NUMBER		NULL,
	"SECTION_START_DATE"	DATE		NULL,
	"SECTION_END_DATE"	DATE		NULL
);

COMMENT ON COLUMN "LECTURE_PROGRESS"."REF_LEC_CHAPTER_NO" IS 'SEQ_LEC_CHAPTER_NO';
COMMENT ON COLUMN "LECTURE_PROGRESS"."SECTION_SIGN_UP_PROGRESS" IS '구현가능 시 사용';
COMMENT ON COLUMN "LECTURE_PROGRESS"."SECTION_START_DATE" IS '구현 가능시 사용';
COMMENT ON COLUMN "LECTURE_PROGRESS"."SECTION_END_DATE" IS '구현 가능시 사용';

DROP TABLE "TEACHER" CASCADE CONSTRAINTS;
CREATE TABLE "TEACHER" (
	"REF_MEMBER_ID"	VARCHAR2(20)		NOT NULL,
	"TEACHER_NAME"	VARCHAR2(20)		NOT NULL,
	"TEACHER_PHONE"	VARCHAR2(11)		NOT NULL,
	"REF_LEC_CAT_NO"	NUMBER		NOT NULL,
	"TEACHER_INTRODUCE"	VARCHAR2(3000)		NOT NULL,
	"TEACHER_LINK"	VARCHAR2(500)		NOT NULL,
	"TEACHER_BANK"	VARCHAR2(30)		NOT NULL,
	"TEACHER_ACCOUNT"	VARCHAR2(30)		NOT NULL,
	"TEACHER_ACC_NAME"	VARCHAR2(20)		NOT NULL
);

DROP TABLE "ATTACHMENT" CASCADE CONSTRAINTS;
CREATE TABLE "ATTACHMENT" (
	"ATTACH_NO"	NUMBER		NOT NULL,
	"REF_CONTENTS_NO"	NUMBER		NOT NULL,
	"ORIGINAL_FILENAME"	VARCHAR2(200)		NOT NULL,
	"RENAMED_FILENAME"	VARCHAR2(200)		NOT NULL,
	"REF_CONTENTS_GROUP_NO"	VARCHAR2(3)		NOT NULL
);

COMMENT ON COLUMN "ATTACHMENT"."ATTACH_NO" IS 'SEQ_ATTACH_NO';
COMMENT ON COLUMN "ATTACHMENT"."REF_CONTENTS_NO" IS '어느 컨텐츠의  첨부파일인지';

DROP TABLE "CONTENTS_GROUP" CASCADE CONSTRAINTS;
CREATE TABLE "CONTENTS_GROUP" (
	"CONTENTS_GROUP_NO"	VARCHAR2(3)		NOT NULL,
	"CONTENTS_GROUP_NAME"	VARCHAR2(20)		NOT NULL,
	"CONTENTS_ATTACH_PATH"	VARCHAR2(100)		NOT NULL
);

DROP TABLE "PAY_LECTURE" CASCADE CONSTRAINTS;
CREATE TABLE "PAY_LECTURE" (
	"PAY_CODE"	VARCHAR2(40)		NOT NULL,
	"REF_LECTURE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PAY_LECTURE"."REF_LECTURE_NO" IS 'SEQ_LEC_NO';

DROP TABLE "LECTURE_CHAPTER" CASCADE CONSTRAINTS;
CREATE TABLE "LECTURE_CHAPTER" (
	"LEC_CHAPTER_NO"	NUMBER		NOT NULL,
	"REF_LEC_PART_NO"	NUMBER		NOT NULL,
	"LEC_CHAPTER_TITLE"	VARCHAR2(50)		NULL,
	"LEC_CHAPTER_VIDEO"	VARCHAR2(200)		NULL,
	"LEC_CHAPTER_RE_VIDEO"	VARCHAR2(200)		NULL
);

COMMENT ON COLUMN "LECTURE_CHAPTER"."LEC_CHAPTER_NO" IS 'SEQ_LEC_CHAPTER_NO';
COMMENT ON COLUMN "LECTURE_CHAPTER"."REF_LEC_PART_NO" IS 'SEQ_LEC_PART_NO';

DROP TABLE "STREAMING_DATE" CASCADE CONSTRAINTS;
CREATE TABLE "STREAMING_DATE" (
	"REF_LECTURE_NO"	NUMBER		NOT NULL,
	"STREAMING_DATE"	DATE		NOT NULL,
	"STREAMING_CNT"	NUMBER		NULL
);

COMMENT ON COLUMN "STREAMING_DATE"."STREAMING_CNT" IS '총 순서중 몇번째 강의인지(트리거로 짜면 될듯)';

DROP TABLE "LEC_STREAMING_SESSION" CASCADE CONSTRAINTS;
CREATE TABLE "LEC_STREAMING_SESSION" (
	"LECTURE_NO"	NUMBER		NOT NULL,
	"LEC_STREAM_SESSION"	VARCHAR2(200)		NOT NULL
);

COMMENT ON COLUMN "LEC_STREAMING_SESSION"."LECTURE_NO" IS 'SEQ_LEC_NO';

DROP TABLE "AUTHORITIES" CASCADE CONSTRAINTS;
CREATE TABLE "AUTHORITIES" (
	"AUTH"	VARCHAR2(50)		NOT NULL,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "AUTHORITIES"."MEMBER_ID" IS '회원가입시 필수';



-- remember-me 관련테이블 persistent_logins
drop table persistent_logins;
create table persistent_logins (
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null, -- username, password, expiry time 등을 hashing한 값
    last_used timestamp not null
);

--================================
-- PK
--================================
ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_ID"
);

ALTER TABLE "LECTURE" ADD CONSTRAINT "PK_LECTURE" PRIMARY KEY (
	"LECTURE_NO"
);

ALTER TABLE "BASKET" ADD CONSTRAINT "PK_BASKET" PRIMARY KEY (
	"BASKET_NO"
);

ALTER TABLE "PICK" ADD CONSTRAINT "PK_PICK" PRIMARY KEY (
	"PICK_NO"
);

ALTER TABLE "MESSENGER" ADD CONSTRAINT "PK_MESSENGER" PRIMARY KEY (
	"MSG_NO"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY (
	"NOTICE_NO"
);

ALTER TABLE "STUDY_BOARD" ADD CONSTRAINT "PK_STUDY_BOARD" PRIMARY KEY (
	"STD_BRD_NO"
);

ALTER TABLE "LECTURE_CATEGORY" ADD CONSTRAINT "PK_LECTURE_CATEGORY" PRIMARY KEY (
	"LEC_CAT_NO"
);

ALTER TABLE "COUNSEL" ADD CONSTRAINT "PK_COUNSEL" PRIMARY KEY (
	"COUNSEL_NO"
);

ALTER TABLE "COUNSELING_CHAT" ADD CONSTRAINT "PK_COUNSELING_CHAT" PRIMARY KEY (
	"CHAT_NO"
);

ALTER TABLE "PAYMENT" ADD CONSTRAINT "PK_PAYMENT" PRIMARY KEY (
	"PAY_CODE"
);

ALTER TABLE "LECTURE_PART" ADD CONSTRAINT "PK_LECTURE_PART" PRIMARY KEY (
	"LECTURE_PART_NO"
);

ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "PK_STUDY_COMMENT" PRIMARY KEY (
	"STD_CMT_NO"
);

ALTER TABLE "TEACHER" ADD CONSTRAINT "PK_TEACHER" PRIMARY KEY (
	"REF_MEMBER_ID"
);

ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "PK_ATTACHMENT" PRIMARY KEY (
	"ATTACH_NO"
);

ALTER TABLE "CONTENTS_GROUP" ADD CONSTRAINT "PK_CONTENTS_GROUP" PRIMARY KEY (
	"CONTENTS_GROUP_NO"
);

ALTER TABLE "LECTURE_CHAPTER" ADD CONSTRAINT "PK_LECTURE_CHAPTER" PRIMARY KEY (
	"LEC_CHAPTER_NO"
);

ALTER TABLE "AUTHORITIES" ADD CONSTRAINT "PK_AUTHORITIES" PRIMARY KEY (
	"AUTH",
	"MEMBER_ID"
);


--================================
-- FK
--================================
ALTER TABLE "LECTURE" ADD CONSTRAINT "FK_LEC_CAT_TO_LEC_1" FOREIGN KEY (
	"REF_LEC_CAT_NO"
)
REFERENCES "LECTURE_CATEGORY" (
	"LEC_CAT_NO"
);

ALTER TABLE "LECTURE" ADD CONSTRAINT "FK_MEMBER_TO_LECTURE_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "BASKET" ADD CONSTRAINT "FK_LECTURE_TO_BASKET_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "BASKET" ADD CONSTRAINT "FK_MEMBER_TO_BASKET_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "PICK" ADD CONSTRAINT "FK_MEMBER_TO_PICK_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "PICK" ADD CONSTRAINT "FK_LECTURE_TO_PICK_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "MESSENGER" ADD CONSTRAINT "FK_MEMBER_TO_MESSENGER_1" FOREIGN KEY (
	"REF_WRITER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;

ALTER TABLE "MESSENGER" ADD CONSTRAINT "FK_MEMBER_TO_MESSENGER_2" FOREIGN KEY (
	"REF_RECEIVER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "NOTICE" ADD CONSTRAINT "FK_MEMBER_TO_NOTICE_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;

ALTER TABLE "STUDY_BOARD" ADD CONSTRAINT "FK_MEMBER_TO_STUDY_BOARD_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "STUDY_BOARD" ADD CONSTRAINT "FK_LEC_TO_STUDY_BRD_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete set null;

ALTER TABLE "COUNSEL" ADD CONSTRAINT "FK_MEMBER_TO_COUNSEL_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;
-- 일반 회원 삭제시에 해당 아이디의 질문과 거기에 달린 답변 삭제 trigger 필요

ALTER TABLE "COUNSELING_CHAT" ADD CONSTRAINT "FK_MEMBER_TO_COUNSEL_CHAT_1" FOREIGN KEY (
	"SENDER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;
-- 웹소켓 고려 (db 고민)

ALTER TABLE "COUNSELING_CHAT" ADD CONSTRAINT "FK_MEMBER_TO_COUNSEL_CHAT_2" FOREIGN KEY (
	"RECEIVER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;
-- 웹소켓 고려 (db 고민)

ALTER TABLE "PAYMENT" ADD CONSTRAINT "FK_MEMBER_TO_PAYMENT_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;

ALTER TABLE "LECTURE_PART" ADD CONSTRAINT "FK_LEC_TO_LEC_PART_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;


ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "FK_STUDY_BRD_TO_STUDY_CMT_1" FOREIGN KEY (
	"REF_STD_BRD_NO"
)
REFERENCES "STUDY_BOARD" (
	"STD_BRD_NO"
)
on delete cascade;



ALTER TABLE "STUDY_COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_STUDY_COMMENT_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;

ALTER TABLE "SEARCH" ADD CONSTRAINT "FK_MEMBER_TO_SEARCH_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "LECTURE_COMMENT" ADD CONSTRAINT "FK_LECTURE_TO_LEC_CMT_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "LECTURE_COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_LEC_CMT_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete set null;

ALTER TABLE "LECTURE_CLICK" ADD CONSTRAINT "FK_LECTURE_TO_LEC_CLK_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "LECTURE_CLICK" ADD CONSTRAINT "FK_MEMBER_TO_LEC_CLK_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "LECTURE_PROGRESS" ADD CONSTRAINT "FK_MEMBER_TO_LEC_PROG_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "LECTURE_PROGRESS" ADD CONSTRAINT "FK_LEC_TO_LEC_PROG_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "LECTURE_PROGRESS" ADD CONSTRAINT "FK_LEC_CHAP_TO_LEC_PROG_1" FOREIGN KEY (
	"REF_LEC_CHAPTER_NO"
)
REFERENCES "LECTURE_CHAPTER" (
	"LEC_CHAPTER_NO"
)
on delete cascade;

ALTER TABLE "TEACHER" ADD CONSTRAINT "FK_MEMBER_TO_TEACHER_1" FOREIGN KEY (
	"REF_MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

ALTER TABLE "TEACHER" ADD CONSTRAINT "FK_LEC_CAT_TO_TEACH_1" FOREIGN KEY (
	"REF_LEC_CAT_NO"
)
REFERENCES "LECTURE_CATEGORY" (
	"LEC_CAT_NO"
);

ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "FK_CONTENTS_GRP_TO_ATTACH_1" FOREIGN KEY (
	"REF_CONTENTS_GROUP_NO"
)
REFERENCES "CONTENTS_GROUP" (
	"CONTENTS_GROUP_NO"
);

ALTER TABLE "PAY_LECTURE" ADD CONSTRAINT "FK_PAYMENT_TO_PAY_LECTURE_1" FOREIGN KEY (
	"PAY_CODE"
)
REFERENCES "PAYMENT" (
	"PAY_CODE"
)
on delete cascade;

ALTER TABLE "PAY_LECTURE" ADD CONSTRAINT "FK_LECTURE_TO_PAY_LECTURE_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete set null;

ALTER TABLE "LECTURE_CHAPTER" ADD CONSTRAINT "FK_LEC_PART_TO_LEC_CHAP_1" FOREIGN KEY (
	"REF_LEC_PART_NO"
)
REFERENCES "LECTURE_PART" (
	"LECTURE_PART_NO"
)
on delete cascade;

ALTER TABLE "STREAMING_DATE" ADD CONSTRAINT "FK_LEC_TO_STREAM_DATE_1" FOREIGN KEY (
	"REF_LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "LEC_STREAMING_SESSION" ADD CONSTRAINT "FK_LEC_TO_LEC_STREAM_SESSION_1" FOREIGN KEY (
	"LECTURE_NO"
)
REFERENCES "LECTURE" (
	"LECTURE_NO"
)
on delete cascade;

ALTER TABLE "AUTHORITIES" ADD CONSTRAINT "FK_MEMBER_TO_AUTHORITIES_1" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
)
on delete cascade;

------------------------
-- sequence
------------------------
create sequence SEQ_LEC_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence SEQ_LEC_CAT_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence seq_basket_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence seq_pick_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence seq_msg_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence seq_counsel_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence SEQ_CHAT_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence seq_pay_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence SEQ_LEC_PART_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence SEQ_LEC_CHAPTER_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

create sequence SEQ_ATTACH_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------
-- 추가된 쿼리들
--------------------------------

insert into member values ('admin', '$2a$10$X8GL750RHq/TpQh9hVPnd.Krj13dW5QlKAvUIbIIVI.dPVzPYUmd2', null, null);
insert into authorities values ('ROLE_ADMIN', 'admin');
insert into authorities values ('ROLE_USER', 'admin');

insert into member values ('user', '$2a$10$X8GL750RHq/TpQh9hVPnd.Krj13dW5QlKAvUIbIIVI.dPVzPYUmd2', null, null);
insert into authorities values ('ROLE_USER', 'user');

insert into member values ('teacher', '$2a$10$X8GL750RHq/TpQh9hVPnd.Krj13dW5QlKAvUIbIIVI.dPVzPYUmd2', null, null);
insert into authorities values ('ROLE_TEACHER', 'teacher');
insert into authorities values ('ROLE_USER', 'teacher');

insert into member values ('test', '$2a$10$X8GL750RHq/TpQh9hVPnd.Krj13dW5QlKAvUIbIIVI.dPVzPYUmd2', null, null);
insert into authorities values ('ROLE_USER', 'test');
----------

insert into lecture_category values(lec_cat_no.nextval, '프런트');
insert into lecture_category values(lec_cat_no.nextval, '백엔드');
insert into lecture_category values(lec_cat_no.nextval, '빅데이터');
----------
delete from teacher where ref_member_id = 'test';
commit;
select * from lecture_category;
select * from member;
select * from authorities;

desc member;
select * from teacher;
select * from authorities;
