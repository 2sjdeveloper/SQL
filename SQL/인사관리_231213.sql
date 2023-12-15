--12월 13일
--제약조건 활용

--1. NOT NULL

--테이블 생성
create table emp_test(empid NUMBER(5),
                      empname VARCHAR2(10) not null,
                      duty VARCHAR2(9),
                      sal NUMBER(7,2),
                      bonus NUMBER(7,2),
                      mgr NUMBER(5),
                      hire_date DATE,
                      deptid NUMBER(2));
--널값 입력 : 오류
insert into emp_test(empid, empname)
values (10, null);
--낫널값 입력 : 오류 없음
insert into emp_test(empid, empname)
values (10,'YD');
            
            
--2. UNIQUE

create table dept_test(deptid NUMBER(2),
                       dname VARCHAR2(14),
                       loc VARCHAR2(13),
                       UNIQUE(dname));

insert into dept_test(deptid, dname)
values (10, null); -- 널값 입력 가능
insert into dept_test(deptid, dname)
values (20, 'YD');
insert into dept_test(deptid, dname)
values (20, 'YD'); --중복값이라 오류 뜸.


--3. PRIMARY KEY
drop table dept_test;

create table dept_test(deptid NUMBER(2) primary key,
                       dname VARCHAR2(14),
                       loc VARCHAR2(13),
                       UNIQUE(dname));

insert into dept_test
values (10, 'YD', 'Daegu');
insert into dept_test
values (20, 'YD1', 'Daegu');
insert into dept_test
values (20, 'YD2', 'Daegu'); --중복값 입력 오류
insert into dept_test
values (NULL, 'YD3', 'Daegu'); --널값 입력 오류


--4. FOREIGN KEY
drop table emp_test;
--테이블 레벨에서 지정
create table emp_test(empid     NUMBER(5),
                      empname   VARCHAR2(10) not null,
                      duty      VARCHAR2(9),
                      sal       NUMBER(7,2),
                      bonus     NUMBER(7,2),
                      mgr       NUMBER(5),
                      hire_date DATE,
                      deptid    NUMBER(2),
 FOREIGN KEY(deptid) REFERENCES dept_test(deptid) on delete set null); --테이블 레벨에서 지정
--on delete set null : 부모 테이블 삭제시 자식 테이블 값에서 null값으로 변환 
--컬럼 레벨에서 지정 : deptid    NUMBER(2) REFERENCES dept_test(deptid));

insert into emp_test(empid, empname, deptid)
values (100, 'YD1', 10);
insert into emp_test(empid, empname, deptid)
values (200, 'YD2', null);
insert into emp_test(empid, empname, deptid)
values (300, 'YD3', 30); --부모키 찾을 수 없어서 오류.

select *
from   emp_test;

drop table emp_test;

delete dept_test
where  deptid = 10; --부모 데이터 deptid 테이블에서 10을 삭제

select *
from   dept_test; --자식에서도 없어짐.

--5. CHECK 제약조건
drop table emp_test;

create table emp_test(empid     NUMBER(5) ,
                      empname   VARCHAR2(10) not null,
                      duty      VARCHAR2(9),
                      sal       NUMBER(7,2),
                      bonus     NUMBER(7,2),
                      mgr       NUMBER(5),
                      hire_date DATE,
                      deptid    NUMBER(2) CHECK (deptid between 10 and 99),
 FOREIGN KEY(deptid) REFERENCES dept_test(deptid));
 
 
 -----------제약조건 수정 및 보기
 --1.1 제약조건 추가
 alter table emp_test
 add    primary key(empid); --프라이머리 키 지정
 
 alter table emp_test
 add         foreign key(mgr) references emp_test(empid); --프라이머리 키 추가..?
 
 alter table emp_test
 modify (duty not null); --낫 널 제약조건 추가
--modify (duty VARCHAR2(9) not null); : 원칙.

--1.2 제약조건 삭제

--제약조건 확인
desc user_cons_columns;

select constratint_name, contraint_type, search_condition
from   user_constraints;

select constraint_name, column_name, table_name
from   user_cons_columns --sys c 로 시작하는 것들이 우리가 만든 제약조건
where  table_name = 'EMP_TEST';

--제약조건 삭제
alter table emp_test
drop constraint sys_c007022; --sys_c007022 이 제약조건 가진 컬럼 삭제


--2. 제약조건 활성화 및 비활성화
--거의 안씀


-----------------뷰 (VIEW)

--뷰 생성
create view emp80_vu
as select employee_id, last_name, salary
   from   employees
   where  department_id = 80;

--뷰 조회
select *
from   emp80_vu;

--뷰 생성
create view sal50_vu
as select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY --수식 들어가면 무조건 이름 지정.
   from   employees
   where  department_id = 50;
--뷰 조회
select *
from   sal50_vu;

--뷰 수정(or replace 명령어 사용)
create or replace view emp80_vu
   (id_number, name, sal, department_id)
as select employee_id, first_name || ' ' || last_name, salary, department_id
   from   employees
   where  department_id = 80;

select *
from   emp80_vu;

--뷰 생성
create or replace view dept_sum_vu
   (name, minsal, maxsal, avgsal)
as select   d.department_name, min(e.salary), max(e.salary), avg(e.salary)
   from     employees e join departments d
   on       (e.department_id = d.department_id)
   group by d.department_name;
   
select *
from dept_sum_vu;

select rownum, employee_id
from employees;

--5. 뷰를 통한 데이터 조작
commit;

select *
from   emp80_vu;

delete emp80_vu
where  id_number = 176;

select *
from   emp80_vu; --뷰에서 삭제 완.

select *
from employees; --뷰를 통해 삭제했지만, 원본 데이터도 같이 삭제됨.
------------
select *
from dept_sum_vu;

delete dept_sum_vu
where name = 'IT'; --뷰 안에 썸이 들어가있어서 삭제 불가.
--------------
create view test_vu
as
  select department_name
  from   departments;
  
select *
from test_vu;

insert into test_vu
values ('YD'); --디파트먼트 아이디는 프라이머리 키. 없어서 조작 안됨.


--6. 뷰의 제약조건

------기타 객체
--1. 인덱스

--2. 시퀀스
--2.2 시퀀스 생성
create sequence dept_deptid_seq
                increment by 10
                start with 120 
                maxvalue 9999
                nocache
                nocycle;
--시작값은 120, 증가값은 10, 최대값은 9999

insert into departments(department_id, department_name, location_id)
values      (dept_deptid_seq.NEXTVAL, 'Support', 2500);

select *
from departments;
-----
rollback;

select *
from departments; --아까까지 만든값 이후에서부터 다시 생성됨. =갭이 발생

--2.4 시퀀스 정보 확인

select dept_deptid_seq.CURRVAL
from dual; --시퀀스가 몇번까지 사용되었는지 확인..


---3. 동의어
--3.2 동의어 생성
create synonym d_sum
for dept_sum_vu;

select *
from d_sum;

select *
from dept_sum_vu;

--삭제 : drop synonym d_sum; 


-------데이터 제어(DCL)

--2. 시스템 권한

--시스템 권한 확인
select *
from system_privilege_map;

--사용자 계정 생성
--관리자 파일에서

----------------고급 SQL
--계층적 질의
--top down 방식
select level, employee_id, last_name, manager_id
from employees
start with manager_id is null
connect by prior employee_id = manager_id;
-- 같은 표현 connect by manager_id = prior employee_id;

--bottom down 방식
select level, employee_id, last_name, manager_id
from employees
start with manager_id is null
connect by prior manager_id = employee_id;

-------
select level,
       lpad(' ', 4*(level-1))||employee_id employee,
       last_name, manager_id
from employees
start with manager_id is null
connect by prior employee_id = manager_id;

------시험--------------------------------------------------------------------------
-- 1.
select    employee_id, last_name, salary, department_id
from      employees
where     salary between 7000 and 12000
and upper (last_name) like 'H%';

-- 2.
select employee_id, last_name, hire_date, salary*commission_pct as benefit
from   employees
where 
order by;

-- 3.
select employee_id, last_name, job_id, salary, department_id
from   employees
where  department_id in (select department_id
                         from   employees
                         where  department_id between 50 and 60)
and    salary > 5000;

-- 4.
select employee_id, last_name, deparmtnet_id, country
       case country when country_id = 20 then Canada
       case country when country_id = 80 then UK
       end
from   employees
where  location_id in (select location_id
                       from departments
                       where country_id);

-- 5.
select e.last_name, e.department_id, d.department_name
from   employees e, departments d
where  e.department_id = d.department_id(+);

-- 6.
select last_name, hire_date, employee_id
       case when hire_date >= 05 then 'New employee'
       end
       as "hire_date"
from  employees
where employee_id = &employee_id;

-- 7.
select last_name, salary, 
from   employees
where  employee_id = &employee_id;

-- 8. 
select d.department_id, d.department_name, l.city
from departments d, locations l
where d.location_id = l.location_id;

-- 9.
select employee_id, last_name, job_id
from   employees
where  department_id in (select department_id
                         from departments
                         where department_name = 'IT');

-- 10.
SELECT   department_id, COUNT(*), round(avg(salary))
FROM     employees
GROUP BY department_id;

-- 11.
-- 12.
-- 13.
-- 14.
-- 15.

