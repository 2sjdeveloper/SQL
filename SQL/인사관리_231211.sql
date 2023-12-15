--12월 11일--
--그룹함수
--
select AVG(salary), MAX(salary), MIN(salary), SUM(salary)
from employees
where job_id like '%REP%';

select min(hire_date), max(hire_date)
from employees;

select min(last_name), max(last_name)
from employees;

--2.1 count
select count(*)
from employees;

select count(*)
from departments;

select count(*)
from departments
where department_id = 50;

select count(commission_pct)
from employees
where department_id = 80;

select count(distinct department_id),
       count(department_id)
from employees;

select distinct department_id
from employees;

--2.4 그룹 함수와 널값
select avg(NVL(commission_pct,0)), avg(commission_pct)
--널 값을 강제로 0으로 포함. 뒤에껀 널값 제외.
from employees;

--데이터 그룹화--
--1. group by절
--참고 블로그 : https://ajdahrdl.tistory.com/37
select department_id, count(department_id), avg(salary)
from employees
group by department_id;

select avg(salary)
from employees
group by department_id;

select department_id, job_id, sum(salary), count(salary)
from employees
group by department_id, job_id
order by job_id;

select department_id, job_id, sum(salary)
from employees
where department_id > 40
group by department_id, job_id
order by department_id;

2. having 절
select department_id, max(salary)
from employees
group by department_id
having max(salary)>10000;

-- 2.3 예시
select job_id, sum(salary) PAYROLL --5
from employees --1
where job_id not like '%REP%' --2
group by job_id --3
having sum(salary) > 13000--4
order by sum(salary);--6

-- 3. 그룹함수 중첩
select max(avg(salary))
from employees
group by department_id;

select department_id, max(avg(salary)) 
from employees
group by department_id;
-- 에러 이유 : 그룹함수를 중첩을 할 경우 셀렉트 절에는 어떤 일반 컬럼도 올 수 없다. 

중요 : 다음 세 문장의 유효성을 판별하여 True 또는 False로 답하시오.
1. 그룹 함수는 여러 행에 적용되어 그룹 당 하나의 결과를 출력한다. true
2. 그룹 함수는 계산에 널을 포함한다. false
3. WHERE 절은 그룹 계산에 행(row)을 포함시키기 전에 행을 제한한다. true

4. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 
열 레이블을 각각 Maximum, Minimum, Sum 및 Average로 지정하고 결과를 정수로 반올림하도록 작성하시오.

select max(salary) "Maximum", 
       min(salary) as "Minimum", 
       sum(salary) as "Sum", 
       round(avg(salary)) as "Average"
from employees;


5. 위의 질의를 수정하여 각 업무 유형(job_id)별로 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 

select job_id, max(salary) "Maximum", min(salary) as "Minimum", sum(salary) as "Sum", round(avg(salary)) as "Average"
from employees
group by job_id;


6. 업무별 사원 수를 표시하는 질의를 작성하시오.

select job_id, count (employee_id)
from employees
group by job_id;

7. 관리자 수를 확인하시오. 열 레이블은 Number of Managers로 지정하시오. (힌트: MANAGER_ID 열을 사용)

select count(distinct manager_id) "Number of Managers"
from employees;

8. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 열 레이블을 DIFFERENCE로 지정하시오.

select max(salary)-min(salary) difference
from employees;

9. 관리자 번호 및 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 
관리자를 알 수 없는 사원 및 최저 급여가 6,000 미만인 그룹은 제외시키고 결과를 급여에 대한 내림차순으로 정렬하시오.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000
order by min(salary) desc;

--조인 오라클 구문

select employee_id, last_name, department_id
from employees;

--1.2 
select last_name, department_name
from employees, departments;

select count(*)
from departments;

--2.2 equi join(동등조인)

select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select employee_id, last_name, e.department_id, d.department_id, location_id, department_name
from employees e, departments d
where e.department_id = d.department_id;
--접두어 생략해도 결과가 같은 이유 : 접두어를 붙이면 해당 테이블의 컬럼을 가져오면 되니까 시간 단축되지만 테이블명은 붙이는걸 권장.
--생략하지 않은 테이블은 지우면 안됨

select *
from locations;

select d.department_id, d.department_name,
       d.location_id, l.city
from   departments d, locations l
where  d.location_id = l.location_id;

--추가조건 붙일 때는 and 써주면 됨.
select d.department_id, d.department_name,
       d.location_id, l.city
from   departments d, locations l
where  d.location_id = l.location_id
and    d.department_id in (20, 50);

--2.3 non-equi join : =을 제외한 모든 조인 구문

select * 
from job_grades;

select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where e.salary
      between j.lowest_sal and j.highest_sal;
      
--2.4 outer join
--right outer join
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--left outer join
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--2.5 self join
select employee_id, last_name, manager_id
from   employees;

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;

--조인 - SQL - 1999조인구문
--2.cross join
select last_name, department_name
from employees cross join departments;

--3. natural join
select department_id, department_name, location_id, city
from departments natural join locations;

desc departments;
desc locations;

--4. using 절을 포함하는 조인
select employee_id, last_name, location_id, department_id
from employees join departments
                    using(department_id);

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400; --where절에 d.가 없어서 정상 결과가 나옴. 테이블 알리아스? 때문? 

--5. on절을 포함하는 조인
select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from   employees e join departments d
            on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e
        join departments d
             on d.department_id = e.department_id
        join locations l
             on d.location_id = l.location_id;
             
--> 오라클 조인으로 바꾸기
select employee_id, city, department_name
from   employees e, departments d, locations l
where  d.department_id = e.department_id
and    d.location_id = l.location_id;

--6. inner join 과 outer join
--6.2 left outer join

select e.last_name, e.department_id, d.department_name
from   employees e left outer join departments d
           on (e.department_id = d.department_id);

-->오라클 조인으로 바꾸기           
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--> right 아우터 조인으로 바꾸기
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--6.5 추가 조건

select e.manager_id, e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id)
and e.manager_id = 149;

--문제 풀기
1. LOCATIONS 및 COUNTRIES 테이블을 사용하여 모든 부서의 주소를 생성하는 query를 작성하시오. 
출력에 위치ID(location_id), 주소(street_address), 구/군(city), 시/도(state_province) 및 국가(country_name)를 표시하시오.

--오라클 조인
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l, countries c
where  l.country_id = c.country_id;

--안씨join
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l join countries c
                      on l.country_id = c.country_id;


DESC LOCATIONS;
DESC COUNTRIES;

2. 모든 사원의 이름, 소속 부서번호 및 부서 이름을 표시하는 query를 작성하시오.
desc employees;
--오라클 조인
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;
--안씨조인
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l join countries c
                   on l.country_id = c.country_id;


3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. 
toronto에서 근무하는 모든 사원의 이름, 직무, 부서번호 및 부서 이름을 표시하시오.
desc locations;
--오라클 조인
select e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id --추가 "조인" 조건
and l.city = 'Toronto'; --데이터를 가져오는것에 대한 추가 조건
--and lower(l.city) = 'toronto'; --대소문자 모를때 소문자로 지정하고 데이터를 검색함.
--안씨조인
select e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e join departments d 
                 on e.department_id = d.department_id
                 join locations l
                 on d.location_id = l.location_id 
where lower(l.city) = 'toronto'; 


4. 사원의 이름 및 사원 번호를 해당 관리자의 이름 및 관리자 번호와 함께 표시하는 보고서를 작성하는데, 
열 레이블을 각각 Employee, Emp#, Manager 및 Mgr#으로 지정하시오. --셀프조인

select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w, employees m
where w.manager_id = m.employee_id;

select *
from employees;

--안씨조인
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w join employees m
                     on w.manager_id = m.employee_id;


5. King과 같이 해당 관리자가 지정되지 않은 사원도 표시하도록 4번 문장을 수정합니다. 사원 번호순으로 결과를 정렬하시오. 
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w, employees m
where w.manager_id = m.employee_id(+)
order by 2;

--안시조인
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w left outer join employees m
                    on w.manager_id = m.employee_id
order by 2;

6. 직무 등급 및 급여에 대한 보고서를 필요로 합니다. 
먼저 JOB_GRADES 테이블의 구조를 표시한 다음 모든 사원의 이름, 직무, 부서 이름, 급여 및 등급을 표시하는 query를 작성하시오.

select e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
from employees e, departments d, job_grades j
where e.department_id = d.department_id
and e.salary between j.lowest_sal and j.highest_sal;

--안씨조인
select e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
from employees e join departments d
                   on e.department_id = d.department_id
                 join job_grades j
                   on e.salary between j.lowest_sal and j.highest_sal;
                   
                   
--서브쿼리 --

--부서별로 최대 급여를 받는 사원의 이름과 급여를 출력. (다중행 서브쿼리)
select last_name, salary
from   employees
where  salary in (select max(salary)
                 from employees
                 group by department_id);
--서브쿼리문
select max(salary)
from employees
group by department_id;

1.3
-- 2. 단일행 서브쿼리
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

--문제 141번과 같은 업무를 하는 직원들의 이름과 잡 아이디 출력. 단 141번은 제외.
select employee_id, last_name, job_id
from employees
where job_id = (select job_id
                from employees
                where employee_id = 141)
and employee_id != 141;

--
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Abel')
and salary > (select salary
             from employees
             where last_name = 'Abel');

select last_name
from employees
where last_name = 'Taylor';

------------------------------복습때 모르는거------------------------------------------------------------------

SELECT UPPER(last_name) "Upper Name", LENGTH(last_name) "Name Length"
FROM employees
WHERE UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M')
ORDER BY 1;

--NVL2 함수
--NVL2(expr1, expr2, expr3)
-- => 1 = 널이 아니면 2 / 1 = 널이면 3
--2, 3의 데이터 타입 통일해야 함
SELECT last_name, salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees;

--NULLIF(expr1, expr2)
--두 표현식 비교 => 같으면 NULL, 다르면 expr1 반환
SELECT first_name, LENGTH(first_name) "expr1",
       last_name, LENGTH(last_name) "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) as result
FROM employees;
-----
SELECT AVG(salary), MAX(salary), 
       MIN(salary), SUM(salary)
FROM   employees
WHERE  job_id LIKE '%REP%';
--like는 문자열에서 rep가 포함되어 있는걸 찾겠다는 거.
--where절 : job_id에서 %REP% 문자열이 포함된 것을 찾겠다는 의미.

-----
--SELECT절에서 그룹함수 안에 없는열 => 반드시 GROUP BY절에 포함(필수)
SELECT   department_id, AVG(salary)
FROM     employees
GROUP BY department_id;
--SELECT절의 department_id열은 그룹함수(AVG) 안에 없음
-- => ★★★GROUP BY절에 반드시 넣어줘야함

--★★★GROUP BY 절에 있는 열 목록은 SELECT절에 안와도 됨(선택)
SELECT   AVG(salary)
FROM     employees
GROUP BY department_id;
--salary : GROUP BY 절에 없어도 됨

select avg(NVL(commission_pct,0)), avg(commission_pct)
--널 값을 강제로 0으로 포함. 뒤에껀 널값 제외.
from employees;

select job_id, sum(salary) PAYROLL --5
from employees --1
where job_id not like '%REP%' --2
group by job_id --3
having sum(salary) > 13000--4
order by sum(salary);--6