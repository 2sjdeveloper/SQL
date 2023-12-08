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

select employee_id, last_name, department_id
from employees
where lower(last_name) = 'higgins';

--문자함수 II
--1.2 문자조작함수

--SUBSTR
select last_name, substr(last_name, -3, 2) --뒤에서 세번째부터 2글자.
from employees
where department_id = 90;


select employee_id, concat(first_name, last_name) name, job_id, length (last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where substr(job_id, 4) = 'REP';

--LTMRIM
select ltrim('yyedaymy', 'yea')
from dual;

--RTRIM
select rtrim('yyedaymy', 'yea')
from dual;


--숫자함수와 날짜함수
select round(345.678) as round1,
       round(345.678, 0) as round2,
       round(345.678, 1) as round3,
       round(345.678, -1) as round4
from dual;

select trunc(345.678) as trunc1,
       trunc(345.678, 0) as trunc2,
       trunc(345.678, 1) as trunc3,
       trunc(345.678, -1) as trunc4
from dual;

select last_name, salary, mod(salary, 5000)
from employees;

--문제풀기
1. 현재 날짜를 표시하는 질의를 작성하고 열 레이블을 Date로 지정하시오.
select sysdate "Date"
from dual;

2. 각 사원에 대해 사원 번호, 이름, 급여 및 15% 인상된 급여를 정수로 표시하시오. 인상된 급여 열의 레이블을 New Salary로 지정하시오. 
select *
from employees;

select employee_id, last_name, salary, round(salary*1.15) as "New Salary"
from employees;

3. 2번 질의를 수정하여 새 급여에서 이전 급여를 빼는 새 열을 추가하고 레이블을 Increase로 지정하고 수정한 질의를 실행하시오.
select employee_id, last_name, salary, round(salary*1.15) as "New Salary", round(salary*1.15)-salary as "Increase"
from employees;

4. 이름이 J, A 또는 M으로 시작하는 모든 사원의 이름(대문자 표시) 및 이름 길이를 표시하는 질의를 작성하고 각열에 적합한 레이블을 지정하시오. 결과를 사원의 이름에 따라 정렬하시오.
select upper(last_name) as "name", length(last_name) as "name_length"
from employees
where upper (substr(last_name, 1, 1)) in ('J', 'A', 'M')
order by 1;

--2. 날짜함수
select sysdate
from dual;

--2.2 날짜 연산
select last_name, (sysdate-hire_date)/7 as weeks
from employees
where department_id = 90;

--2.3 날짜 함수
select employee_id, hire_date,
       months_between (sysdate, hire_date) tenure,
       add_months(hire_date, 6) review,
       next_day(hire_date, '금'),
       last_day(hire_date)
from   employees;

select round(sysdate, 'YEAR'), --7월1일0시 기준으로 년도 반올림
       round(sysdate, 'MONTH'), --16일 0시 기준으로 월 반올림
       round(sysdate, 'DAY'), --수요일 낮 12시 기준으로 일주일 반올림
       round(sysdate, 'DD') --낮 12시 기준으로 하루 반올림
from dual;
       
select trunc(sysdate, 'YEAR'), 
       trunc(sysdate, 'MONTH'),
       trunc(sysdate, 'DAY'),
       trunc(sysdate, 'DD')
from dual;


---변환함수 I
--1. 데이터 유형 변환
--암시적 데이터 유형 변환

select*
from employees
where employee_id = '101';

--2.1 날짜에 to_char 함수 사용

alter session set
nls_date_language = american;

select employee_id, to_char(hire_date, ' MM/YY') month_hired --원래 형식은 yy/mm/dd 인데 mm/yy로 형식 변경
from employees;

select last_name, to_char(hire_date, 'fm DD MONTH YYYY') --fm 이 있고 없고 결과가 다름.
from employees;

select last_name, to_char(hire_date, 'fm Ddspth "of" Month YYYY fmHH:MI:SS AM') --am, pm 아무거나 써도 됨. "문자 반복"은 큰따옴표
from employees;

--2.2 숫자에 to_char 함수 사용
select to_char(salary, '$99,999.00') salary
from employees;


--변환함수 II

select to_number('$3,400', '$99,999')
from dual;

--2. to_date
select to_date('2010년, 02월', 'YYYY"년", MM"월"')
from dual;

--사원들 중에서 2005년 7월 1일 이훟에 입사한 사원의 이름과 입사일을 출력.
select last_name, hire_date
from employees
where hire_date > to_date('2005년 07월 01일', 'YYYY"년" MM"월" DD"일"');

select last_name, hire_date
from employees
where hire_date > to_date('05/07/01', 'fxYY/MM/DD'); --fx를 붙이면 앞의 형식문과 무조건 같은 형식으로 적어줘야됨. 아니면 YY-MM-DD 도 됨.


--일반 함수와 중첩 함수
--1. nvl 함수
select last_name, salary, nvl(commission_pct, 0),
       (salary*12) + (salary*12*nvl(commission_pct, 0)) as an_sal
from employees;

select last_name, salary, nvl(commission_pct, '보너스 없음') --(commission_pct, '보너스 없음') 이 두개 타입이 숫자, 문자타입으로 달라서 실행 안됨.
from employees;

select last_name, salary, nvl(to_char (commission_pct), '보너스 없음') -- 타입 일치시켜줌. 
from employees;

--2. nvl2 함수
select last_name, salary, commission_pct,
       nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

--3. nullif 함수
select first_name, length(first_name) "expr1",
       last_name, length(last_name) "expr2",
       nullif(length(first_name), length(last_name)) result
from employees;

--5. 조건표현식
select last_name, job_id, salary,
       case job_id when 'IT_PROG'  then 1.10*salary
                   when 'ST_CLERK' then 1.15*salary
                   when 'SA_REP'   then 1.20*salary
                --when job_id='SA_REP'   then 1.20*salary 이렇게도 가능.
                   else salary
       end "REVISED_SALARY" --
from employees;

select last_name, salary,
       case when salary<5000  then 'Low'
            when salary<10000 then 'Medium'
            when salary<20000 then 'Good'
                              else 'Excellent'
       end qualified_salary
from employees;

-- 5.3 decode 함수
select last_name, job_id, salary,
       decode(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
                                  salary)
        REVISE_SALARY
from employees;


--6. 중첩함수

--문제 5. 각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달 수)를 계산하여 열 레이블을 MONTHS_WORKED로 지정하시오.
--      결과는 정수로 반올림하여 표시하시오.
select last_name, round((sysdate - hire_date)/30) as MONTHS_WORKED
from employees;

--6. 모든 사원의 성 및 급여를 표시하기 위한 query를 작성합니다. 급여가 15자 길이로 표시되고 왼쪽에 $ 기호가 채워지도록 형식을 지정하시오. 
--열 레이블을 SALARY 로 지정합니다.
select last_name, LPAD(salary, 15, '$')
from employees;

--7. 부서 90의 모든 사원에 대해 성(last_name) 및 재직 기간(주 단위)을 표시하도록 query 를 작성하시오. 
주를 나타내는 숫자 열의 레이블로 TENURE를 지정하고 주를 나타내는 숫자 값을 정수로 나타내시오.
select last_name, round((sysdate - hire_date)/7) as TENURE
from employees
where department_id=90;

--1. 각 사원에 대해 다음 항목을 생성하는 질의를 작성하고 열 레이블을 Dream Salaries로 지정하시오.
--<employee last_name> earns <salary> monthly but wants <3 times salary>. 
--<예시> Matos earns $2,600.00 monthly but wants $7,800.00.


2. 사원의 이름, 입사일 및 급여 검토일을 표시하시오. 급여 검토일은 여섯 달이 경과한 후 첫번째 월요일입니다. 열 레이블을 REVIEW로 지정하고 날짜는 "2010.03.31 월요일"과 같은 형식으로 표시되도록 지정하시오.

3. 이름, 입사일 및 업무 시작 요일을 표시하고 열 레이블을 DAY로 지정하시오. 월요일을 시작으로 해서 요일을 기준으로 결과를 정렬하시오.

4. 사원의 이름과 커미션을 표시하는 질의를 작성하시오. 커미션을 받지 않는 사원일 경우 “No Commission”을 표시하시오. 열 레이블은 COMM으로 지정하시오.

5. DECODE 함수와 CASE 구문을 사용하여 다음 데이터에 따라 JOB_ID 열의 값을 기준으로 모든 사원의 등급을 표시하는 질의를 작성하시오.

업무         등급
AD_PRES     A
ST_MAN      B
IT_PROG     C
SA_REP      D
ST_CLERK    E
그외         0

