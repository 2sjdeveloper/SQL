--12월12일
--다중행, 다중열 서브쿼리

--단일행 복습 잠깐
--최저급여를 받는 사람의 이름, 직무, 급여 출력
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from   employees);

--50번 부서의 최저급여 받는 사람들보다 최저급여가 큰 부서만 출력
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                      from employees
                      where department_id = 50);
--group by, having절 참고 : https://jink1982.tistory.com/63

----------다중행 서브쿼리

select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--추가 설명 : <any == 서브쿼리에서 리턴되는 제일 큰 값보다 작은거
--서브쿼리에서 리턴되는 값은 9000, 6000, 4200 세개.

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--< all == 제일 작은 값보다 작은거.

--2.1 다중열 서브쿼리
--추가파일 설치 필요.
--오라클 설치 -> sql_laps 폴더에서 cre_empl 파일 열어서 F5 누르고, 인사관리로 실행.

select manager_id, department_id
from empl_demo
where first_name ='John';

--쌍비교
--3가지 경우의 수만 존재.
select employee_id, manager_id, department_id
from empl_demo
where (manager_id, department_id) in
                     (select manager_id, department_id
                      from empl_demo
                      where first_name = 'John')
and first_name != 'John';

---위 코드와 비슷해보이지만 문제 이해에 오류가 있는 경우. (비 쌍비교)
--경우의 수가 9가지가 나옴.
select employee_id, manager_id, department_id
from empl_demo
where manager_id in (select manager_id
                     from empl_demo
                     where first_name = 'John')
and department_id in (select department_id
                      from empl_demo
                      where first_name = 'John')
and first_name != 'John';

---------데이터 조작어
2. 데이터 삽입
2.2 insert 구문
--sql 설치 파일에서 cre_hrdata.spl 파일 설치, 열어서 F5 눌러서 인사관리로 실행.

insert into departments(department_id, department_name, manager_id, location_id)
values      (370, 'Public Relations', 100, 1700);
--아이디 370을 추가하고 거기에 새로운 데이터 추가
select *
from departments;

insert into departments
values      (371, 'Public Relations', 100, 1700);
--모든 컬럼에 데이러틀 다 입력할 때는 테이블명을 입력할 필요 없음.

insert into departments (department_id, department_name)
values (330, 'Purchasing');
--특정 컬럼에만 데이터를 입력하고자 할 때는 괄호해서 컬럼명 입력해야함.
--값이 입력되지 않은 컬럼에는 암시적으로 널값이 입력됨.

select *
from departments;
--조회하면 330 추가되어있음. 

insert into departments
values (400, 'Finance', null, null);
--컬럼명 입력 없이 데이터 넣을 때는 명시적으로 널값을 넣어줘야함.
--널 넣을때 'null' 로 넣으면 안됨. 문자로 입력하겠다는 의미가 되어서 오류.


insert into employees
values      (113, 'Louis', 'Popp', 'LPOPP', '515.124.4567', SYSDATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);
--hire_date 부분에 sysdate가 들어감.
select * 
from employees;

insert into employees
values      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561', to_date('FEB 3, 1999', 'MON DD, YYYY'),
             'SA_REP', 11000, 0.2, 100, 60);
--to_date로 입력된 날짜('FEB 3, 1999', 'MON DD, YYYY')를 시스템 상의 날짜표기법(99/02/03)으로 바꿔줌. 

insert into departments
values (100, 'Finance', '', null);
--null도 널값이고 '' <<이것도 널값으로 입력됨. 명시적으로 넣을때 한정.
select *
from departments;

insert into departments
            (department_id, department_name, location_id)
values (&department_id, '&department_name', &location);
--치환변수. 40, Human Resourcesl, 2500 순으로 입력

--sales_reps 파일 설치

select * 
from sales_reps;

select *
from copy_emp;

insert into sales_reps
select employee_id, last_name, salary, commission_pct
from employees
where job_id like '%REP%';
--데이터 삽입

insert into copy_emp
select *
from employees;

select *
from employees;

select * from departments;

insert into departments(department_name)
values ('Yedam');
--department_id 가 없어서 오류 발생. 기본키라서 값이 무조건 있어야됨.

insert into departments(department_id, department_name)
values (10, 'Yedam');
--department_id 는 유니크(원앤온니)해야됨. 10번 부서에 있음. 그래서 안들어감.

insert into departments(department_id, department_name)
values (120, 'Yedam');
--120은 없어서 들어감.

insert into departments(department_id)
values ('130');
--이것도 오류. department_name은 유니크 조건은 아니지만 not null 제약 조건이 걸려있음. 그래서 네임도 입력해야돼.

insert into departments(department_id, department_name, manager_id)
values (130, 'YD', 1);
--무결성 조건에 위배라고 뜸. manager_id가 임플로이 테이블에 있는 임플로이 아이디 값을 참고하는 포링?키
-- 거기에 있는 값만 입력해야됨.

insert into departments(department_id, department_name, manager_id)
values (130, 'YD', 100);
--이건 위 오류 해결되어서 데이터 삽입 됨.

--4. 데이터 변경 (update) (3.delete는 update 먼저 하고)

update employees --임플로이즈를 수정ㅈ하겠다. 
set department_id = 50  --어떻게? 디파트먼트 아이디를 50으로 수정하겠슴다.
where employee_id = 113; --임플로이 아이디가 113번인 것을 50번으로 수정하겠다.
--임플로이즈를 수정ㅈ하겠다. 어떻게? 디파트먼트 아이디를 50으로 수정하겠슴다. 임플로이 아이디가 113번인 것을 50번으로 수정하겠다.

select *
from employees
where employee_id = 113;

--51로는 수정 안됨. 무슨 포링키...?

update copy_emp
set department_id = 110;
--전체 수정됨.

select *
from copy_emp;

update employees
set job_id = 'IT_PROG', commission_pct = null
where employee_id = 114;
--수정

select *
from employees
where employee_id = 114;
--확인

rollback;
--지금까지 했던 dml 작업 취소하는거

select *
from copy_emp;


---3. 데이터 삭제(delete)

delete employees;
--차일드 레코드 발견이라는 오류 뜸. 

insert into copy_emp
   select *
   from employees;
   
select *
from copy_emp;

commit;

delete copy_emp;
--where절 없어서 전부 삭제됨.

rollback;
--커밋해놔서 롤백하면 지운게 다시 돌아옴.

--뭔지 모르겠지만 일단 적어둠.
--dml : 롤백 가능
--ddl : 롤백 불가.

delete from departments
where department_name = 'Finance';
--파이낸스 삭제하겠다.

select *
from departments;
--삭제된거 확인.

delete departments 
where department_id in (30, 40);
--from 안써도 삭제 가능.

select *
from departments;

rollback;

select *
from copy_emp;

delete copy_emp;

rollback;
--데이터 복구됨.

truncate table copy_emp;
--다 지워지고 없음.

rollback;
--롤백해도 안살아남.

--이게 ddl과 ddm 차이..

----------문제 sql.08.
-- 1. 다음과 같이 실습에 사용할 MY_EMPLOYEE 테이블을 생성하시오.
CREATE TABLE my_employee
  (id         NUMBER(4) NOT NULL,
   last_name  VARCHAR2(25),
   first_name VARCHAR2(25),
   userid     VARCHAR2(8),
   salary     NUMBER(9,2));

--2. MY_EMPLOYEE 테이블의 구조를 표시하여 열 이름을 식별하시오.
desc my_employee;

select *
from my_employee;

-- 3. 다음 예제 데이터를 MY_EMPLOYEE 테이블에 추가하시오.
ID	LAST_NAME 	FIRST_NAME 	USERID 	SALARY
1  	Patel 		Ralph 		Rpatel 	895
2 	Dancs 		Betty 		Bdancs 	860
3 	Biri 		Ben 		Bbiri 	1100

insert into my_employee
values (1, 'Patel', 'Ralph', 'Rpatel', 895);

insert into my_employee
values (2, 'Dancs', 'Betty', 'Bdancs', 860);

insert into my_employee
values (3, 'Biri', 'Ben', 'Bbiri', 1100);

--치환변수 활용
--insert into my_employee
--values (&id, '&last_name', '&first_name', '&userid', '&salary);

select *
from my_employee;

4. 테이블에 추가한 항목을 확인하시오.
select *
from my_employee;

6. 사원 3의 성을 Drexler로 변경하시오.
update my_employee
set last_name = 'Drexler'
where id = 3;

7. 급여가 900 미만인 모든 사원의 급여를 1000으로 변경하고 테이블의 변경 내용을 확인하시오.

update my_employee
set salary = 1000
where salary < 900;

select *
from my_employee;

8. MY_EMPLOYEE 테이블에서 사원 3을 삭제하고 테이블의 변경 내용을 확인하시오.
delete my_employee
where id = 3;

11. 테이블의 내용을 모두 삭제하고 테이블 내용이 비어 있는지 확인하시오.
delete my_employee; --dml문
--또는
truncate table my_employee; --ddl문


----------트랜잭션 제어

commit;

update employees
set salary = 99999
where employee_id = 176;

select *
from employees
where employee_id  = 176;

rollback;

commit;

truncate table aa; --ddl문 하나하나가 작은 커밋. 자동 커밋 됨.


---------데이터 정의어(DDL)- 객체 생성

--2.2 테이블 구분
--데이터 딕셔너리
select table_name
from user_tables;

select distinct object_type
from user_objects;

select *
from user_catalog;


--3. 테이블 생성
--3.1 개요
--3.3 디폴트 옵션

create table hire_dates
        (id         number(8),
         hire_date date default sysdate);
--디폴트값으로 시스데이터

insert into hire_dates(id)
values (35);

select *
from hire_dates;

insert into hire_dates
values (45, null);
--디폴트값에 널로 지정.

--3.4 테이블 생성
--dept 테이블
create table dept
        (deptno     number(2),
         dname      varchar2(14),
         loc        varchar2(13),
         create_date date default sysdate);
         
describe dept;
        
select table_name 
from user_tables;

--3.4 테이블 생성
--서브쿼리를 사용한 테이블 생성
create table dept80
as
select employee_id, last_name, 
       salary*12 ANNSAL, --수식이 들어갈 경우에는 반드시 수식명을 지정해줘야함. 수식명은 컬럼 이름이 될 수 없음.
       hire_date
from employees
where department_id = 80;

describe dept80;

--------데이터 정의어(DDL) - 객체 수정
--1. 테이블 수정
--1.1 열(column)추가

alter table dept80
add         (job_id VARCHAR2(9));
--job_id 컬럼 생성된거 확인
select *
from dept80; 

alter table dept80
add (hdate date default sysdate);
--디폴트값 생성. 지정 전에는 값이 널이었음.

select *
from dept80;

--1.2 열(column) 수정
alter table dept80
modify      (last_name varchar2(10));

alter table dept80
modify (job_id number(10));

alter table dept80
modify (last_name number(15)); --이건 안됨. 기존의 데이터 타입이랑 달라서

--1.3 열 삭제
alter table dept80
drop (job_id);

------2. set unused 옵션
--2.1
alter table dept80
set unused (last_name);

select *
from dept80; --last_name 컬럼이 조회 안됨.

alter table dept80
drop unused columns;


--------기타 데이터 정의어
--1. 테이블 삭제

drop table dept80;

select *
from user_recyclebin; --휴지통 기능
--여기 보면 방금 삭제한 dept80 파일 있음.

flashback table dept80 to before drop; 
--드랍하기 전 상태로 dept80 파일을 복구하겠다.

drop table dept80 purge;
--dept80을 휴지통에 삭제 안하고 바로 완전 삭제 하겠다.
--퍼지는 실제로는 쓰지마세용.

select *
from user_recyclebin;
--휴지통에 아무것도 없움.


--2. 객체 이름 변경
rename dept to dept80;

select *
from dept80;

--3. 테이블 절삭
truncate table dept80;





















