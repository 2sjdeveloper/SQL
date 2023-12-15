--12�� 11��--
--�׷��Լ�
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

--2.4 �׷� �Լ��� �ΰ�
select avg(NVL(commission_pct,0)), avg(commission_pct)
--�� ���� ������ 0���� ����. �ڿ��� �ΰ� ����.
from employees;

--������ �׷�ȭ--
--1. group by��
--���� ��α� : https://ajdahrdl.tistory.com/37
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

2. having ��
select department_id, max(salary)
from employees
group by department_id
having max(salary)>10000;

-- 2.3 ����
select job_id, sum(salary) PAYROLL --5
from employees --1
where job_id not like '%REP%' --2
group by job_id --3
having sum(salary) > 13000--4
order by sum(salary);--6

-- 3. �׷��Լ� ��ø
select max(avg(salary))
from employees
group by department_id;

select department_id, max(avg(salary)) 
from employees
group by department_id;
-- ���� ���� : �׷��Լ��� ��ø�� �� ��� ����Ʈ ������ � �Ϲ� �÷��� �� �� ����. 

�߿� : ���� �� ������ ��ȿ���� �Ǻ��Ͽ� True �Ǵ� False�� ���Ͻÿ�.
1. �׷� �Լ��� ���� �࿡ ����Ǿ� �׷� �� �ϳ��� ����� ����Ѵ�. true
2. �׷� �Լ��� ��꿡 ���� �����Ѵ�. false
3. WHERE ���� �׷� ��꿡 ��(row)�� ���Խ�Ű�� ���� ���� �����Ѵ�. true

4. ��� ����� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. 
�� ���̺��� ���� Maximum, Minimum, Sum �� Average�� �����ϰ� ����� ������ �ݿø��ϵ��� �ۼ��Ͻÿ�.

select max(salary) "Maximum", 
       min(salary) as "Minimum", 
       sum(salary) as "Sum", 
       round(avg(salary)) as "Average"
from employees;


5. ���� ���Ǹ� �����Ͽ� �� ���� ����(job_id)���� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. 

select job_id, max(salary) "Maximum", min(salary) as "Minimum", sum(salary) as "Sum", round(avg(salary)) as "Average"
from employees
group by job_id;


6. ������ ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.

select job_id, count (employee_id)
from employees
group by job_id;

7. ������ ���� Ȯ���Ͻÿ�. �� ���̺��� Number of Managers�� �����Ͻÿ�. (��Ʈ: MANAGER_ID ���� ���)

select count(distinct manager_id) "Number of Managers"
from employees;

8. �ְ� �޿��� ���� �޿��� ������ ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �� ���̺��� DIFFERENCE�� �����Ͻÿ�.

select max(salary)-min(salary) difference
from employees;

9. ������ ��ȣ �� �ش� �����ڿ� ���� ����� ���� �޿��� ǥ���Ͻÿ�. 
�����ڸ� �� �� ���� ��� �� ���� �޿��� 6,000 �̸��� �׷��� ���ܽ�Ű�� ����� �޿��� ���� ������������ �����Ͻÿ�.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000
order by min(salary) desc;

--���� ����Ŭ ����

select employee_id, last_name, department_id
from employees;

--1.2 
select last_name, department_name
from employees, departments;

select count(*)
from departments;

--2.2 equi join(��������)

select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select employee_id, last_name, e.department_id, d.department_id, location_id, department_name
from employees e, departments d
where e.department_id = d.department_id;
--���ξ� �����ص� ����� ���� ���� : ���ξ ���̸� �ش� ���̺��� �÷��� �������� �Ǵϱ� �ð� ��������� ���̺���� ���̴°� ����.
--�������� ���� ���̺��� ����� �ȵ�

select *
from locations;

select d.department_id, d.department_name,
       d.location_id, l.city
from   departments d, locations l
where  d.location_id = l.location_id;

--�߰����� ���� ���� and ���ָ� ��.
select d.department_id, d.department_name,
       d.location_id, l.city
from   departments d, locations l
where  d.location_id = l.location_id
and    d.department_id in (20, 50);

--2.3 non-equi join : =�� ������ ��� ���� ����

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

--���� - SQL - 1999���α���
--2.cross join
select last_name, department_name
from employees cross join departments;

--3. natural join
select department_id, department_name, location_id, city
from departments natural join locations;

desc departments;
desc locations;

--4. using ���� �����ϴ� ����
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
where location_id = 1400; --where���� d.�� ��� ���� ����� ����. ���̺� �˸��ƽ�? ����? 

--5. on���� �����ϴ� ����
select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from   employees e join departments d
            on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e
        join departments d
             on d.department_id = e.department_id
        join locations l
             on d.location_id = l.location_id;
             
--> ����Ŭ �������� �ٲٱ�
select employee_id, city, department_name
from   employees e, departments d, locations l
where  d.department_id = e.department_id
and    d.location_id = l.location_id;

--6. inner join �� outer join
--6.2 left outer join

select e.last_name, e.department_id, d.department_name
from   employees e left outer join departments d
           on (e.department_id = d.department_id);

-->����Ŭ �������� �ٲٱ�           
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--> right �ƿ��� �������� �ٲٱ�
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--6.5 �߰� ����

select e.manager_id, e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id)
and e.manager_id = 149;

--���� Ǯ��
1. LOCATIONS �� COUNTRIES ���̺��� ����Ͽ� ��� �μ��� �ּҸ� �����ϴ� query�� �ۼ��Ͻÿ�. 
��¿� ��ġID(location_id), �ּ�(street_address), ��/��(city), ��/��(state_province) �� ����(country_name)�� ǥ���Ͻÿ�.

--����Ŭ ����
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l, countries c
where  l.country_id = c.country_id;

--�Ⱦ�join
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l join countries c
                      on l.country_id = c.country_id;


DESC LOCATIONS;
DESC COUNTRIES;

2. ��� ����� �̸�, �Ҽ� �μ���ȣ �� �μ� �̸��� ǥ���ϴ� query�� �ۼ��Ͻÿ�.
desc employees;
--����Ŭ ����
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;
--�Ⱦ�����
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from   locations l join countries c
                   on l.country_id = c.country_id;


3. Toronto�� �ٹ��ϴ� ����� ���� ������ �ʿ�� �մϴ�. 
toronto���� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ� �̸��� ǥ���Ͻÿ�.
desc locations;
--����Ŭ ����
select e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id --�߰� "����" ����
and l.city = 'Toronto'; --�����͸� �������°Ϳ� ���� �߰� ����
--and lower(l.city) = 'toronto'; --��ҹ��� �𸦶� �ҹ��ڷ� �����ϰ� �����͸� �˻���.
--�Ⱦ�����
select e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e join departments d 
                 on e.department_id = d.department_id
                 join locations l
                 on d.location_id = l.location_id 
where lower(l.city) = 'toronto'; 


4. ����� �̸� �� ��� ��ȣ�� �ش� �������� �̸� �� ������ ��ȣ�� �Բ� ǥ���ϴ� ������ �ۼ��ϴµ�, 
�� ���̺��� ���� Employee, Emp#, Manager �� Mgr#���� �����Ͻÿ�. --��������

select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w, employees m
where w.manager_id = m.employee_id;

select *
from employees;

--�Ⱦ�����
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w join employees m
                     on w.manager_id = m.employee_id;


5. King�� ���� �ش� �����ڰ� �������� ���� ����� ǥ���ϵ��� 4�� ������ �����մϴ�. ��� ��ȣ������ ����� �����Ͻÿ�. 
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w, employees m
where w.manager_id = m.employee_id(+)
order by 2;

--�Ƚ�����
select w.last_name, w.employee_id, 
       m.last_name, m.employee_id
from   employees w left outer join employees m
                    on w.manager_id = m.employee_id
order by 2;

6. ���� ��� �� �޿��� ���� ������ �ʿ�� �մϴ�. 
���� JOB_GRADES ���̺��� ������ ǥ���� ���� ��� ����� �̸�, ����, �μ� �̸�, �޿� �� ����� ǥ���ϴ� query�� �ۼ��Ͻÿ�.

select e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
from employees e, departments d, job_grades j
where e.department_id = d.department_id
and e.salary between j.lowest_sal and j.highest_sal;

--�Ⱦ�����
select e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
from employees e join departments d
                   on e.department_id = d.department_id
                 join job_grades j
                   on e.salary between j.lowest_sal and j.highest_sal;
                   
                   
--�������� --

--�μ����� �ִ� �޿��� �޴� ����� �̸��� �޿��� ���. (������ ��������)
select last_name, salary
from   employees
where  salary in (select max(salary)
                 from employees
                 group by department_id);
--����������
select max(salary)
from employees
group by department_id;

1.3
-- 2. ������ ��������
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

--���� 141���� ���� ������ �ϴ� �������� �̸��� �� ���̵� ���. �� 141���� ����.
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

------------------------------������ �𸣴°�------------------------------------------------------------------

SELECT UPPER(last_name) "Upper Name", LENGTH(last_name) "Name Length"
FROM employees
WHERE UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'A', 'M')
ORDER BY 1;

--NVL2 �Լ�
--NVL2(expr1, expr2, expr3)
-- => 1 = ���� �ƴϸ� 2 / 1 = ���̸� 3
--2, 3�� ������ Ÿ�� �����ؾ� ��
SELECT last_name, salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees;

--NULLIF(expr1, expr2)
--�� ǥ���� �� => ������ NULL, �ٸ��� expr1 ��ȯ
SELECT first_name, LENGTH(first_name) "expr1",
       last_name, LENGTH(last_name) "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) as result
FROM employees;
-----
SELECT AVG(salary), MAX(salary), 
       MIN(salary), SUM(salary)
FROM   employees
WHERE  job_id LIKE '%REP%';
--like�� ���ڿ����� rep�� ���ԵǾ� �ִ°� ã�ڴٴ� ��.
--where�� : job_id���� %REP% ���ڿ��� ���Ե� ���� ã�ڴٴ� �ǹ�.

-----
--SELECT������ �׷��Լ� �ȿ� ���¿� => �ݵ�� GROUP BY���� ����(�ʼ�)
SELECT   department_id, AVG(salary)
FROM     employees
GROUP BY department_id;
--SELECT���� department_id���� �׷��Լ�(AVG) �ȿ� ����
-- => �ڡڡ�GROUP BY���� �ݵ�� �־������

--�ڡڡ�GROUP BY ���� �ִ� �� ����� SELECT���� �ȿ͵� ��(����)
SELECT   AVG(salary)
FROM     employees
GROUP BY department_id;
--salary : GROUP BY ���� ��� ��

select avg(NVL(commission_pct,0)), avg(commission_pct)
--�� ���� ������ 0���� ����. �ڿ��� �ΰ� ����.
from employees;

select job_id, sum(salary) PAYROLL --5
from employees --1
where job_id not like '%REP%' --2
group by job_id --3
having sum(salary) > 13000--4
order by sum(salary);--6