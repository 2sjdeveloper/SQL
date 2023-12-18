SELECT *
FROM   tab;

--student ���̺� �߰�
CREATE TABLE student (
        student_number   VARCHAR2(10) PRIMARY KEY,
        student_name     VARCHAR(100) NOT NULL,
        english_score    NUMBER DEFAULT 80,
        mathematics_score NUMBER DEFAULT 70
        );

--���, ����, ����, �ܰ���ȸ, ��� 

--student ���̺� ������ ���
INSERT INTO student
VALUES      ('23-001', 'ȫ�浿', 70, 75);

INSERT INTO student(student_number, student_name)
VALUES      ('23-007', '��μ�');

SELECT *
FROM   student;

--������ ����
UPDATE student
SET    english_score = 85,
       mathematics_score = 75
WHERE  student_number = '23-002';

--������ ����
DELETE student
WHERE  student_number = '23-002';

--������ �ܰ� ��ȸ
SELECT *
FROM   student
WHERE  student_number = '23-002';


--books ���̺� ����
CREATE TABLE book (
        book_code   VARCHAR2(10) PRIMARY KEY,
        book_name   VARCHAR(100) NOT NULL,
        author      VARCHAR(100),
        publisher   VARCHAR(100),
        book_cost   NUMBER DEFAULT 10000
        );

INSERT INTO book
VALUES      ('A001', '�̰��� ��������', '���糲', '�Ѻ��̵��', 36000);

INSERT INTO book
VALUES      ('A002', 'ȥ�� �����ϴ� �ڹ�', '�ſ��', '�Ѻ��̵��', 24000);

INSERT INTO book
VALUES      ('B001', '�ڹٽ�ũ��Ʈ �Ŀ���', '������Ʈ', '������Ʈ', 22000);

SELECT   *
FROM     book
ORDER BY 1;


---------------�𿩼� ��ǥ�� �������� ���̺� ����-------------------
select *
from ;

CREATE TABLE travel_member (
        mem_id   VARCHAR2(100) PRIMARY KEY,
        mem_pw   VARCHAR(100) NOT NULL,
        mem_name    VARCHAR(100) not null,
        mem_rights   VARCHAR(100) default 'user'
        );
        
insert into travel_member 
values ('sujin', 'sujin', '�̼���', 'admin');
insert into travel_member
values ('user', 'user', 'ȫ�浿', 'user');
insert into travel_member
values ('jaenam', 'jaenam', 'ȫ�浿', 'user');

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
       --text_hide char (1) --y/n�� ����
       );
       
       drop sequence text_auto_no;
       create sequence text_auto_no
       increment by 1
       start with 1;
       
insert into travel_plan
values (text_auto_no.nextval, 053, '�ݿ��� ���� ����', '3�ð�', '5����', 'sujin');
insert into travel_plan
values (text_auto_no.nextval, 053, '�ݿ��� ���� ����', '3�ð�', '10����', 'user');

select *
from travel_plan;

--drop table travel_comment;
create table travel_comment (
       mem_id VARCHAR2(100),
       comment_content VARCHAR(100) NOT NULL,
       comment_date date default sysdate,
       text_no number default 0,
       comment_hide char (1) --y/n�� ����
       );

insert into travel_comment
values ('sujin', '���ƿ�', '12-15', 0, 'y');

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
     