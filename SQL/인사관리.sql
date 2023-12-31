desc departments;

-- 기본적인 데이터 조회
-- 1. SQL 문법


--테이블 조회
select *
from employees;

select department_id, location_id
from   departments;


select location_id, department_id
from   departments; --셀렉트절에 나열된 순서대로 리턴이 이뤄짐. 테이블에 있는 컬럼의 순서는 의미가 없다.

select department_id, department_id
from   departments;

select last_name, salary, salary + 300
from   employees;

select last_name, salary, 12*salary+100
from   employees;

select last_name, salary, 12*(salary+100)
from   employees;

select last_name, job_id, salary, commission_pct
from   employees;

select last_name, 12*salary*commission_pct
from   employees;

select last_name, 12*salary*nvl(commission_pct, 1)
from   employees;

select last_name as name, commission_pct comm
from   employees;

select last_name "Name" , salary*12 "Annual Salary"
from   employees;

select last_name AS 이름 , commission_pct 보너스
from   employees;

select last_name || job_id as "Employees"
from   employees;

select last_name ||' is a '|| job_id as "Employee Details"
from   employees;

select department_id
from employees;

select distinct department_id
from employees;

select distinct department_id, job_id
from employees;

-- 1번 문제. departmentments 테이블의 구조를 표시하고 테이블의 모든 데이터를 조회하시오.
desc departments;

select *
from departments;

-- 2번 문제. employees 테이블의 구조를 표시. 사원번호가 가장 앞에 오고 이어서 각 사원의 이름, 업무코드, 입사일이 오도록 작성.
-- hire_date열에 startdate 라는 별칭 지정

select department_id, last_name, job_id, hire_date as "StartDate"
from employees;

-- 3번 문제. 임플로이 테이블의 업무코드를 중복되지 않게 표시.
select distinct job_id
from employees;

-- 4번 문제.2번의 명령문 복사 후 이름 변경.
select department_id as "Emp #" , last_name as "Employee" , job_id as "Job" , hire_date as "Hire Date"
from   employees;

-- 5번 문제.
select job_id || ' , ' || last_name as "Employee and Title" --공백때문에 큰따옴표.
from   employees;


--데이터 제한 및 정렬--

-- 1. where절
-- 1.1 구문
select employee_id, last_name, job_id, department_id
from   employees
where  department_id = 90;

-- 1.2 문자열 및 날짜
select last_name, job_id, department_id
from employees
where last_name = 'Whalen' ; -- whale 은 데이터라 대소문자 구분 함.

select last_name
from employees
where hire_date = '05/10/10'; --날짜는 형식 모델 맞춰줘야함. 년/월/일/

--2. 비교연산자
select last_name, salary
from employees
where salary <= 3000; -- : from -> where -> select 순으로 해석.

--문제 : 사원중 입사일이 2005년 이전에 입사한 사원들의 이름(last_name), 입사일(hire_date)를 출력하시오.
select *
from employees;

select last_name, hire_date
from employees
where hire_date < '05/01/01';

--3. SQL 연산자
--3.1 between 연산자
select last_name, salary
from employees
where salary between 2500 and 3500; --2500 이상, 3500 이하. (둘 다 포함)
-- where salary between 3500 and 2500; --오류는 아니나 논리에 맞지 않아서 쓰레기값이 뜸. = 논리적 오류

--3.2 in 연산자
select employee_id, last_name, salary, manager_id
from employees
where manager_id in (100, 101, 201);

--3.3 like 연산자
select first_name
from employees
where first_name like'S%';

--퀴즈 : 사원들 중 사원이름(last_name)의 끝문자에 소문자's'가 들어가는 사원의 last_name을 출력
select last_name
from employees
where last_name like '%s';

select last_name
from employees
where last_name like '_o%'; -- _는 문자 하나와 대체. last_name에서 두번째 글자에 o가 있는 사람을 찾음.

--이스케이프 문자
--사원들 중 job_id에 "_"가 들어있는 사원들의 employee_id, last_name, job_id 출력
select employee_id, last_name, job_id
from employees
where job_id like '%SA_%'; --엄밀히 따지면 SA가 들어간 사원들만 출력되는 쿼리. _ 는 필수 포함 검색어가 아니라 대체문자로 인식함.

select employee_id, last_name, job_id
from employees
where job_id like '%SA\_%' escape'\'; -- \ 자리에 아무거나 써주면 됨. 그리고 escape 써주고 그럼 이스케이프 문자로 인식함. 

select last_name, hire_date
from employees
where hire_date like'05%'; --우리나라 날짜 시스템이라서 %가 05(=2005년) 뒤에 와야됨.

--3.4 is null 연산자
select *
from employees
where commission_pct is null;


--4. 논리연산자
--4.1 AND 연산자
select employee_id, last_name, job_id, salary
from   employees
where  salary >= 10000
and    job_id like '%MAN%';

--4.2 OR 연산자
select employee_id, last_name, job_id, salary
from   employees
where  salary >= 10000
or     job_id like '%MAN%'; --and 와 or 중 and 가 우선순위가 더 높음.


--4.3 NOT 연산자
select last_name, job_id
from   employees
where  job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

--5. 연산자 우선순위 규칙
select last_name, job_id, salary
from employees
where job_id = 'SA_REP'
or job_id = 'AD_PRES'
and salary > 15000;

--위아래 두개 비교(괄호에 따라 결과가 달라짐)

select last_name, job_id, salary
from employees
where (job_id = 'SA_REP'
or job_id = 'AD_PRES')
and salary > 15000;

--select from where 절.
--문제 6. 급여가 12,000 넘는 사원이름, 급여 표시.
select last_name, salary
from employees
where salary >= 12000;

--문제 7. 사원번호가 176인 사원의 이름과 부서번호를 표시
select *
from employees;

select employee_id, last_name, department_id
from employees
where employee_id in 176; --in 대신 = 도 가능.

--문제 8. 급여가 5,000에서 12,000 사이에 포함되지 않는 모든 사원의 이름과 급여를 표시
select last_name, salary
from employees
where salary not between 5000 and 12000;

--6. 급여가 5000에서 12000사이이고, 부서번호가 20또는 50사이인 사원이름과 급여를 나열. 열 레이블을 변경 지정.
select last_name "Employee" , salary "Monthly Salary"
from employees
where salary between 5000 and 12000
      and department_id in (20, 50);

-- 7. 2005년에 입사한 모든 사원의 이름과 입사일을 표시하시오.
select *
from employees;

select last_name, hire_date
from employees
where hire_date like '05%';
-- where hire_date between '05/01/01' and '05/12/31';


-- 8. 관리자가 없는 모든 사원의 이름과 업무를 표시하시오.
select last_name, job_id
from employees
where manager_id is null;


-- 10. 이름의 세번째 문자가 a인 모든 사원의 이름을 표시하시오.
select last_name
from employees
where last_name like '__a%';


-- 11. 이름에 a와 e가 있는 모든 사원의 이름을 표시하시오.
select last_name
from employees
where last_name like '%a%' 
      and last_name like '%e%';

-- 12. 업무가 영업 사원(SA_REP) 또는 사무원(ST_CLERK)이면서 
    급여가 2,500, 3,500, 7,000이 아닌 모든 사원의 이름, 업무 및 급여를 표시하시오.
select last_name, job_id, salary
from employees
where job_id in ('SA_REP' , 'ST_CLERK') --데이터니까 대소문자 구분.
      and salary not in (2500, 2500, 7000);

-- 13. 커미션 비율(commission_pct)이 20%인 모든 사원의 이름, 급여 및 커미션을 표시하도록 
    명령문을 작성하여 실행하시오. 
select last_name, salary, commission_pct
from employees
where commission_pct = 0.2;

--12월 8일 금요일
-- 6. order by 절

select last_name, job_id, department_id, hire_date
from   employees
order by hire_date; --오름차순 정렬

select last_name, job_id, department_id, hire_date
from   employees
order by hire_date desc; --내림차순 정렬

--6.4 열 별칭 정렬 
select employee_id, last_name, salary*12 annsal -- 샐러리에 *12 해주고 그 결과를 annsal에 넣고. (샐러리*12 와 annsal 사이에 as 생략)
from employees
order by annsal; -- 그 annsal 기준으로 정렬

select last_name, job_id, department_id, hire_date
from employees
order by 3; --세번째 department_id 를 기준으로 오름차순 정렬

select last_name, department_id, salary
from employees
order by department_id, salary desc; -- 여러개의 컬럼을 기준으로 정렬. 오름, 내림차순 다르게 출력됨.

select employee_id, salary
from employees
order by hire_date; --정렬된거임. 셀렉트 절에 없는 컬럼이더라도 해당 테이블에 있으면 그 컬럼 기준으로 정렬됨.

--6.6 치환 변수(&, &&)(교안에는 없음. 오라클 교재 1권 113쪽) 
select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

--여러개 입력하면 파싱 순서대로가 아니라 위에서 아래로.
select employee_id, last_name, job_id, &column_name
from employees;
where &condition
order by &order_column;

--&& 를 입력하면 입력값이 메모리에 영구적으로 저장됨.
select   employee_id, last_name, job_id, &&id
from     employees
order by &id;

select   employee_id, last_name, job_id
from     employees
order by &id;
/
undefine id;

-- 집합(set) 연산자
select * from job_history; -- 중복 3개 포함 10개

-- 2.1 union
select employee_id --사원번호는 107개
from employees
union
select employee_id
from job_history; --중복값 제거하면 7개. 그래서 114개 출력

-- 2.2 union all
select employee_id --사원번호는 107개
from employees
union all
select employee_id
from job_history
order by employee_id; --중복값 제거 없이 인출. 그래서 117 출력.

--2.4 intersect (교집합)
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

select employee_id, job_id
from job_history
intersect
select employee_id, job_id
from employees;

--2.3 minus (차집합)
select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;

select employee_id, job_id
from   job_history
minus
select employee_id, job_id
from   employees;

--문자함수 I

-- 2.dual 테이블
desc dual;

select *
from dual;

select sysdate
from dual;

--4. 문자함수
--4.2 대소문자 조작함수
select 'The job id for ' || upper(last_name)|| ' is ' ||lower(job_id) as "EMPLOYEE DETAILS"
from employees;