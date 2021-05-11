CREATE TABLE member (
	member_id varchar2(20) NOT NULL,
	member_pw varchar2(300) NOT NULL,
	member_profile varchar2(200) NULL,
	member_re_profile varchar2(200) NULL
);

COMMENT ON COLUMN member.member_id IS '회원가입시 필수';
COMMENT ON COLUMN member.member_pw IS '회원가입시 필수 (암호화)';

CREATE TABLE lecture (
	lecture_no number NOT NULL,
	ref_lec_cat_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	lecture_name varchar2(150) NOT NULL,
	lecture_type char(1) NOT NULL,
	lecture_intro varchar2(3000) NOT NULL,
	lecture_thumb_origin varchar2(200) NULL,
	lecture_thumb_renamed varchar2(200) NULL,
	lecture_price number NULL,
	lecture_accept_yn char(1) DEFAULT 'N' NOT NULL,
	lecture_guideline number DEFAULT 1 NULL
);

COMMENT ON COLUMN lecture.lecture_no IS 'SEQ_LEC_NO';
COMMENT ON COLUMN lecture.ref_lec_cat_no IS 'SEQ_LEC_CAT_NO';
COMMENT ON COLUMN lecture.ref_member_id IS '회원가입시 필수';

COMMENT ON COLUMN lecture.lecture_intro IS '값이 html코드로 들어갈지 고민';

COMMENT ON COLUMN lecture.lecture_guideline IS '하루에 들을 강의갯수 추천';

CREATE TABLE basket (
	basket_no number NOT NULL,
	ref_lecture_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	basket_date date DEFAULT sysdate NOT NULL
);

COMMENT ON COLUMN basket.basket_no IS 'seq_basket_no';

CREATE TABLE pick (
	pick_no	number		NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	ref_lecture_no number NOT NULL,
	pick_date date DEFAULT sysdate NOT NULL
);

COMMENT ON COLUMN pick.pick_no IS 'seq_pick_no';

CREATE TABLE messenger (
	msg_no number NOT NULL,
	ref_writer_id varchar2(20) NOT NULL,
	ref_receiver_id	varchar2(20) NOT NULL,
	msg_title varchar2(200) NOT NULL,
	msg_content varchar2(3000) NOT NULL,
	msg_date date DEFAULT sysdate NOT NULL,
	read_yn char(1) DEFAULT N NOT NULL
);

COMMENT ON COLUMN messenger.msg_no IS 'seq_msg_no';

CREATE TABLE notice (
	notice_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	notice_title varchar2(200) NOT NULL,
	notice_content varchar2(3000) NOT NULL,
	notice_date	date DEFAULT sysdate NOT NULL,
	notice_count number	DEFAULT 0 NOT NULL
);

CREATE TABLE study_board (
	std_brd_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	ref_lecture_no number NOT NULL,
	std_brd_title varchar2(100) NOT NULL,
	std_brd_content varchar2(3000) NOT NULL,
	std_brd_date date DEFAULT sysdate NOT NULL,
	std_brd_count number DEFAULT 0 NOT NULL
);

CREATE TABLE lecture_category (
	lec_cat_no number NOT NULL,
	lec_cat_name varchar2(50) NOT NULL
);

COMMENT ON COLUMN lecture_category.lec_cat_no IS 'SEQ_LEC_CAT_NO';

CREATE TABLE counsel (
	counsel_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	counsel_category varchar2(30) NOT NULL,
	counsel_title varchar2(200) NOT NULL,
	counsel_content varchar2(3000) NOT NULL,
	counsel_q_no number NULL,
	counsel_level number DEFAULT 1 NOT NULL,
	counsel_date date DEFAULT sysdate NOT NULL
);

COMMENT ON COLUMN counsel.counsel_no IS 'seq_counsel_no';
COMMENT ON COLUMN counsel.ref_member_id IS '작성자 아이디';
COMMENT ON COLUMN counsel.counsel_category IS '문의글 카테고리';
COMMENT ON COLUMN counsel.counsel_q_no IS '참조중인 문의번호';
COMMENT ON COLUMN counsel.counsel_level IS '1 질문 2 답변';

CREATE TABLE counseling_chat (
	chat_no	number NOT NULL,
	sender_id varchar2(20) NOT NULL,
	receiver_id varchar2(20) NOT NULL,
	chat_content varchar2(200) NOT NULL,
	chat_reg_date date DEFAULT sysdate NOT NULL
);

COMMENT ON COLUMN counseling_chat.chat_no IS 'SEQ_CHAT_NO';

CREATE TABLE payment (
	pay_code varchar2(40) NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	pay_no number NOT NULL,
	pay_cost number	 NOT NULL,
	pay_date date DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN payment.pay_no IS 'seq_pay_no';

CREATE TABLE lecture_part (
	lecture_part_no number NOT NULL,
	ref_lecture_no number NOT NULL,
	lecture_part_title varchar2(50) NULL
);

COMMENT ON COLUMN lecture_part.lecture_part_no IS 'SEQ_LEC_PART_NO';

CREATE TABLE study_comment (
	std_cmt_no number NOT NULL,
	ref_std_brd_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	std_cmt_content varchar2(3000) NOT NULL,
	std_cmt_date date DEFAULT sysdate NOT NULL
);

CREATE TABLE search (
	search_keyword varchar2(100) NOT NULL,
	search_date	date DEFAULT sysdate NOT NULL,
	ref_member_id varchar2(20) NOT NULL
);

CREATE TABLE lecture_comment (
	ref_lecture_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	lec_assessment number NOT NULL,
	lec_comment	varchar2(1500) NOT NULL
);

COMMENT ON COLUMN lecture_comment.ref_lecture_no IS 'SEQ_LEC_NO';

CREATE TABLE lecture_click (
	ref_lecture_no number NOT NULL,
	ref_member_id varchar2(20) NOT NULL,
	click_no number NULL
);

CREATE TABLE lecture_progress (
	ref_member_id varchar2(20) NOT NULL,
	ref_lecture_no number NOT NULL,
	ref_lec_chapter_no number NOT NULL,
	section_sign_up_yn char(1) DEFAULT 'N' NOT NULL,
	section_sign_up_progress number NULL,
	section_start_date date NULL,
	section_end_date date NULL
);

COMMENT ON COLUMN lecture_progress.ref_lec_chapter_no IS 'SEQ_LEC_CHAPTER_NO';
COMMENT ON COLUMN lecture_progress.section_sign_up_progress IS '구현가능 시 사용';
COMMENT ON COLUMN lecture_progress.section_start_date IS '구현 가능시 사용';
COMMENT ON COLUMN lecture_progress.section_end_date IS '구현 가능시 사용';

CREATE TABLE teacher (
	ref_member_id varchar2(20) NOT NULL,
	teacher_name varchar2(20) NOT NULL,
	teacher_phone varchar2(11) NOT NULL,
	ref_lec_cat_no number NOT NULL,
	teacher_introduce varchar2(3000) NOT NULL,
	teacher_link varchar2(500) NOT NULL,
	teacher_bank varchar2(30) NOT NULL,
	teacher_account varchar2(30) NOT NULL,
	teacher_acc_name varchar2(20) NOT NULL
);

CREATE TABLE attachment (
	attach_no number NOT NULL,
	ref_contents_no number NOT NULL,
	original_filename varchar2(200) NOT NULL,
	renamed_filename varchar2(200) NOT NULL,
	ref_contents_group_no varchar2(3) NOT NULL
);

COMMENT ON COLUMN attachment.attach_no IS 'SEQ_ATTACH_NO';
COMMENT ON COLUMN attachment.ref_contents_no IS '어느 컨텐츠의  첨부파일인지';

CREATE TABLE contents_group (
	contents_group_no varchar2(3) NOT NULL,
	contents_group_name varchar2(20) NOT NULL,
	contents_attach_path varchar2(100) NOT NULL
);

CREATE TABLE pay_lecture (
	pay_code varchar2(40) NOT NULL,
	ref_lecture_no number NOT NULL
);

COMMENT ON COLUMN pay_lecture.ref_lecture_no IS 'SEQ_LEC_NO';

CREATE TABLE lecture_chapter (
	lec_chapter_no number NOT NULL,
	ref_lec_part_no number NOT NULL,
	lec_chapter_title varchar2(50) NULL,
	lec_chapter_video varchar2(200) NULL,
	lec_chapter_re_video varchar2(200) NULL
);

COMMENT ON COLUMN lecture_chapter.lec_chapter_no IS 'SEQ_LEC_CHAPTER_NO';
COMMENT ON COLUMN lecture_chapter.ref_lec_part_no IS 'SEQ_LEC_PART_NO';

CREATE TABLE streaming_date (
	ref_lecture_no number NOT NULL,
	streaming_date date NOT NULL,
	streaming_cnt number NULL
);

COMMENT ON COLUMN streaming_date.streaming_cnt IS '총 순서중 몇번째 강의인지(트리거로 짜면 될듯)';

CREATE TABLE lec_streaming_session (
	lecture_no number NOT NULL,
	lec_stream_session varchar2(200) NOT NULL
);

COMMENT ON COLUMN lec_streaming_session.lecture_no IS 'SEQ_LEC_NO';

CREATE TABLE authorities (
	auth varchar2(50) NOT NULL,
	member_id varchar2(20) NOT NULL
);

COMMENT ON COLUMN authorities.member_id IS '회원가입시 필수';

ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_id
);

ALTER TABLE lecture ADD CONSTRAINT PK_LECTURE PRIMARY KEY (
	lecture_no
);

ALTER TABLE basket ADD CONSTRAINT PK_BASKET PRIMARY KEY (
	basket_no
);

ALTER TABLE pick ADD CONSTRAINT PK_PICK PRIMARY KEY (
	pick_no
);

ALTER TABLE messenger ADD CONSTRAINT PK_MESSENGER PRIMARY KEY (
	msg_no
);

ALTER TABLE notice ADD CONSTRAINT PK_NOTICE PRIMARY KEY (
	notice_no
);

ALTER TABLE study_board ADD CONSTRAINT PK_STUDY_BOARD PRIMARY KEY (
	std_brd_no
);

ALTER TABLE lecture_category ADD CONSTRAINT PK_LECTURE_CATEGORY PRIMARY KEY (
	lec_cat_no
);

ALTER TABLE counsel ADD CONSTRAINT PK_COUNSEL PRIMARY KEY (
	counsel_no
);

ALTER TABLE counseling_chat ADD CONSTRAINT PK_COUNSELING_CHAT PRIMARY KEY (
	chat_no
);

ALTER TABLE payment ADD CONSTRAINT PK_PAYMENT PRIMARY KEY (
	pay_code
);

ALTER TABLE lecture_part ADD CONSTRAINT PK_LECTURE_PART PRIMARY KEY (
	lecture_part_no
);

ALTER TABLE study_comment ADD CONSTRAINT PK_STUDY_COMMENT PRIMARY KEY (
	std_cmt_no
);

ALTER TABLE teacher ADD CONSTRAINT PK_TEACHER PRIMARY KEY (
	ref_member_id
);

ALTER TABLE attachment ADD CONSTRAINT PK_ATTACHMENT PRIMARY KEY (
	attach_no
);

ALTER TABLE contents_group ADD CONSTRAINT PK_CONTENTS_GROUP PRIMARY KEY (
	contents_group_no
);

ALTER TABLE lecture_chapter ADD CONSTRAINT PK_LECTURE_CHAPTER PRIMARY KEY (
	lec_chapter_no
);

ALTER TABLE authorities ADD CONSTRAINT PK_AUTHORITIES PRIMARY KEY (
	auth,
	member_id
);

ALTER TABLE teacher ADD CONSTRAINT FK_member_TO_teacher_1 FOREIGN KEY (
	ref_member_id
)
REFERENCES member (
	member_id
);

ALTER TABLE authorities ADD CONSTRAINT FK_member_TO_authorities_1 FOREIGN KEY (
	member_id
)
REFERENCES member (
	member_id
);

