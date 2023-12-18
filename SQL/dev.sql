SELECT *
FROM   tab;

--student 테이블 추가
CREATE TABLE student (
        student_number   VARCHAR2(10) PRIMARY KEY,
        student_name     VARCHAR(100) NOT NULL,
        english_score    NUMBER DEFAULT 80,
        mathematics_score NUMBER DEFAULT 70
        );

--등록, 수정, 삭제, 단건조회, 목록 

--student 테이블에 데이터 등록
INSERT INTO student
VALUES      ('23-001', '홍길동', 70, 75);

INSERT INTO student(student_number, student_name)
VALUES      ('23-007', '김민수');

SELECT *
FROM   student;

--데이터 수정
UPDATE student
SET    english_score = 85,
       mathematics_score = 75
WHERE  student_number = '23-002';

--데이터 삭제
DELETE student
WHERE  student_number = '23-002';

--데이터 단건 조회
SELECT *
FROM   student
WHERE  student_number = '23-002';


--books 테이블 생성
CREATE TABLE book (
        book_code   VARCHAR2(10) PRIMARY KEY,
        book_name   VARCHAR(100) NOT NULL,
        author      VARCHAR(100),
        publisher   VARCHAR(100),
        book_cost   NUMBER DEFAULT 10000
        );

INSERT INTO book
VALUES      ('A001', '이것이 리눅스다', '우재남', '한빛미디어', 36000);

INSERT INTO book
VALUES      ('A002', '혼자 공부하는 자바', '신용권', '한빛미디어', 24000);

INSERT INTO book
VALUES      ('B001', '자바스크립트 파워북', '어포스트', '어포스트', 22000);

SELECT   *
FROM     book
ORDER BY 1;


---------------모여서 투표로 국내여행 테이블 생성-------------------
select *
from ;

CREATE TABLE travel_member (
        mem_id   VARCHAR2(100) PRIMARY KEY,
        mem_pw   VARCHAR(100) NOT NULL,
        mem_name    VARCHAR(100) not null,
        mem_rights   VARCHAR(100) default 'user'
        );
        
insert into travel_member 
values ('sujin', 'sujin', '이수진', 'admin');
insert into travel_member
values ('user', 'user', '홍길동', 'user');
insert into travel_member
values ('jaenam', 'jaenam', '홍길동', 'user');

select *
from travel_member;

delete from travel_plan;
drop table travel_plan;
create table travel_plan (
       text_no number,
       area_code VARCHAR(100) NOT NULL,
       travel_course VARCHAR(100) NOT NULL,
       use_time VARCHAR(100) NOT NULL,
       use_money VARCHAR(100) NOT NULL,
       mem_id VARCHAR2(100)
       --travel_like number default 0,
       --text_hide char (1) --y/n로 구분
       );
       
       drop sequence text_auto_no;
       create sequence text_auto_no
       increment by 1
       start with 1;
       
insert into travel_plan
values (text_auto_no.nextval, 053, '반월당 점심 투어', '3시간', '5만원', 'sujin');
insert into travel_plan
values (text_auto_no.nextval, 053, '반월당 저녁 투어', '3시간', '10만원', 'user');

select *
from travel_plan;

--drop table travel_comment;
create table travel_comment (
       mem_id VARCHAR2(100),
       comment_content VARCHAR(100) NOT NULL,
       comment_date date default sysdate,
       text_no number default 0,
       comment_hide char (1) --y/n로 구분
       );

insert into travel_comment
values ('sujin', '좋아요', '12-15', 0, 'y');

select *
from travel_comment;

create table travel_attend (
        text_no number default 0,
        mem_id VARCHAR2(100)
        );
    
insert into travel_attend
values (1, 'sujin');

select * 
from travel_attend;
     