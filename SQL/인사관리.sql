desc departments;

-- �⺻���� ������ ��ȸ
-- 1. SQL ����


--���̺� ��ȸ
select *
from employees;

select department_id, location_id
from   departments;


select location_id, department_id
from   departments; --����Ʈ���� ������ ������� ������ �̷���. ���̺� �ִ� �÷��� ������ �ǹ̰� ����.

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

select last_name AS �̸� , commission_pct ���ʽ�
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

-- 1�� ����. departmentments ���̺��� ������ ǥ���ϰ� ���̺��� ��� �����͸� ��ȸ�Ͻÿ�.
desc departments;

select *
from departments;

-- 2�� ����. employees ���̺��� ������ ǥ��. �����ȣ�� ���� �տ� ���� �̾ �� ����� �̸�, �����ڵ�, �Ի����� ������ �ۼ�.
-- hire_date���� startdate ��� ��Ī ����

select department_id, last_name, job_id, hire_date as "StartDate"
from employees;

-- 3�� ����. ���÷��� ���̺��� �����ڵ带 �ߺ����� �ʰ� ǥ��.
select distinct job_id
from employees;

-- 4�� ����.2���� ��ɹ� ���� �� �̸� ����.
select department_id as "Emp #" , last_name as "Employee" , job_id as "Job" , hire_date as "Hire Date"
from   employees;

-- 5�� ����.
select job_id || ' , ' || last_name as "Employee and Title" --���鶧���� ū����ǥ.
from   employees;


--������ ���� �� ����--

-- 1. where��
-- 1.1 ����
select employee_id, last_name, job_id, department_id
from   employees
where  department_id = 90;

-- 1.2 ���ڿ� �� ��¥
select last_name, job_id, department_id
from employees
where last_name = 'Whalen' ; -- whale �� �����Ͷ� ��ҹ��� ���� ��.

select last_name
from employees
where hire_date = '05/10/10'; --��¥�� ���� �� ���������. ��/��/��/

--2. �񱳿�����
select last_name, salary
from employees
where salary <= 3000; -- : from -> where -> select ������ �ؼ�.

--���� : ����� �Ի����� 2005�� ������ �Ի��� ������� �̸�(last_name), �Ի���(hire_date)�� ����Ͻÿ�.
select *
from employees;

select last_name, hire_date
from employees
where hire_date < '05/01/01';

--3. SQL ������
--3.1 between ������
select last_name, salary
from employees
where salary between 2500 and 3500; --2500 �̻�, 3500 ����. (�� �� ����)
-- where salary between 3500 and 2500; --������ �ƴϳ� ���� ���� �ʾƼ� �����Ⱚ�� ��. = ���� ����

--3.2 in ������
select employee_id, last_name, salary, manager_id
from employees
where manager_id in (100, 101, 201);

--3.3 like ������
select first_name
from employees
where first_name like'S%';

--���� : ����� �� ����̸�(last_name)�� �����ڿ� �ҹ���'s'�� ���� ����� last_name�� ���
select last_name
from employees
where last_name like '%s';

select last_name
from employees
where last_name like '_o%'; -- _�� ���� �ϳ��� ��ü. last_name���� �ι�° ���ڿ� o�� �ִ� ����� ã��.

--�̽������� ����
--����� �� job_id�� "_"�� ����ִ� ������� employee_id, last_name, job_id ���
select employee_id, last_name, job_id
from employees
where job_id like '%SA_%'; --������ ������ SA�� �� ����鸸 ��µǴ� ����. _ �� �ʼ� ���� �˻�� �ƴ϶� ��ü���ڷ� �ν���.

select employee_id, last_name, job_id
from employees
where job_id like '%SA\_%' escape'\'; -- \ �ڸ��� �ƹ��ų� ���ָ� ��. �׸��� escape ���ְ� �׷� �̽������� ���ڷ� �ν���. 

select last_name, hire_date
from employees
where hire_date like'05%'; --�츮���� ��¥ �ý����̶� %�� 05(=2005��) �ڿ� �;ߵ�.

--3.4 is null ������
select *
from employees
where commission_pct is null;


--4. ��������
--4.1 AND ������
select employee_id, last_name, job_id, salary
from   employees
where  salary >= 10000
and    job_id like '%MAN%';

--4.2 OR ������
select employee_id, last_name, job_id, salary
from   employees
where  salary >= 10000
or     job_id like '%MAN%'; --and �� or �� and �� �켱������ �� ����.


--4.3 NOT ������
select last_name, job_id
from   employees
where  job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

--5. ������ �켱���� ��Ģ
select last_name, job_id, salary
from employees
where job_id = 'SA_REP'
or job_id = 'AD_PRES'
and salary > 15000;

--���Ʒ� �ΰ� ��(��ȣ�� ���� ����� �޶���)

select last_name, job_id, salary
from employees
where (job_id = 'SA_REP'
or job_id = 'AD_PRES')
and salary > 15000;

--select from where ��.
--���� 6. �޿��� 12,000 �Ѵ� ����̸�, �޿� ǥ��.
select last_name, salary
from employees
where salary >= 12000;

--���� 7. �����ȣ�� 176�� ����� �̸��� �μ���ȣ�� ǥ��
select *
from employees;

select employee_id, last_name, department_id
from employees
where employee_id in 176; --in ��� = �� ����.

--���� 8. �޿��� 5,000���� 12,000 ���̿� ���Ե��� �ʴ� ��� ����� �̸��� �޿��� ǥ��
select last_name, salary
from employees
where salary not between 5000 and 12000;

--6. �޿��� 5000���� 12000�����̰�, �μ���ȣ�� 20�Ǵ� 50������ ����̸��� �޿��� ����. �� ���̺��� ���� ����.
select last_name "Employee" , salary "Monthly Salary"
from employees
where salary between 5000 and 12000
      and department_id in (20, 50);

-- 7. 2005�⿡ �Ի��� ��� ����� �̸��� �Ի����� ǥ���Ͻÿ�.
select *
from employees;

select last_name, hire_date
from employees
where hire_date like '05%';
-- where hire_date between '05/01/01' and '05/12/31';


-- 8. �����ڰ� ���� ��� ����� �̸��� ������ ǥ���Ͻÿ�.
select last_name, job_id
from employees
where manager_id is null;


-- 10. �̸��� ����° ���ڰ� a�� ��� ����� �̸��� ǥ���Ͻÿ�.
select last_name
from employees
where last_name like '__a%';


-- 11. �̸��� a�� e�� �ִ� ��� ����� �̸��� ǥ���Ͻÿ�.
select last_name
from employees
where last_name like '%a%' 
      and last_name like '%e%';

-- 12. ������ ���� ���(SA_REP) �Ǵ� �繫��(ST_CLERK)�̸鼭 
    �޿��� 2,500, 3,500, 7,000�� �ƴ� ��� ����� �̸�, ���� �� �޿��� ǥ���Ͻÿ�.
select last_name, job_id, salary
from employees
where job_id in ('SA_REP' , 'ST_CLERK') --�����ʹϱ� ��ҹ��� ����.
      and salary not in (2500, 2500, 7000);

-- 13. Ŀ�̼� ����(commission_pct)�� 20%�� ��� ����� �̸�, �޿� �� Ŀ�̼��� ǥ���ϵ��� 
    ��ɹ��� �ۼ��Ͽ� �����Ͻÿ�. 
select last_name, salary, commission_pct
from employees
where commission_pct = 0.2;

--12�� 8�� �ݿ���
-- 6. order by ��

select last_name, job_id, department_id, hire_date
from   employees
order by hire_date; --�������� ����

select last_name, job_id, department_id, hire_date
from   employees
order by hire_date desc; --�������� ����

--6.4 �� ��Ī ���� 
select employee_id, last_name, salary*12 annsal -- �������� *12 ���ְ� �� ����� annsal�� �ְ�. (������*12 �� annsal ���̿� as ����)
from employees
order by annsal; -- �� annsal �������� ����

select last_name, job_id, department_id, hire_date
from employees
order by 3; --����° department_id �� �������� �������� ����

select last_name, department_id, salary
from employees
order by department_id, salary desc; -- �������� �÷��� �������� ����. ����, �������� �ٸ��� ��µ�.

select employee_id, salary
from employees
order by hire_date; --���ĵȰ���. ����Ʈ ���� ���� �÷��̴��� �ش� ���̺� ������ �� �÷� �������� ���ĵ�.

--6.6 ġȯ ����(&, &&)(���ȿ��� ����. ����Ŭ ���� 1�� 113��) 
select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

--������ �Է��ϸ� �Ľ� ������ΰ� �ƴ϶� ������ �Ʒ���.
select employee_id, last_name, job_id, &column_name
from employees;
where &condition
order by &order_column;

--&& �� �Է��ϸ� �Է°��� �޸𸮿� ���������� �����.
select   employee_id, last_name, job_id, &&id
from     employees
order by &id;

select   employee_id, last_name, job_id
from     employees
order by &id;
/
undefine id;

-- ����(set) ������
select * from job_history; -- �ߺ� 3�� ���� 10��

-- 2.1 union
select employee_id --�����ȣ�� 107��
from employees
union
select employee_id
from job_history; --�ߺ��� �����ϸ� 7��. �׷��� 114�� ���

-- 2.2 union all
select employee_id --�����ȣ�� 107��
from employees
union all
select employee_id
from job_history
order by employee_id; --�ߺ��� ���� ���� ����. �׷��� 117 ���.

--2.4 intersect (������)
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

--2.3 minus (������)
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

--�����Լ� I

-- 2.dual ���̺�
desc dual;

select *
from dual;

select sysdate
from dual;

--4. �����Լ�
--4.2 ��ҹ��� �����Լ�
select 'The job id for ' || upper(last_name)|| ' is ' ||lower(job_id) as "EMPLOYEE DETAILS"
from employees;

select employee_id, last_name, department_id
from employees
where lower(last_name) = 'higgins';

--�����Լ� II
--1.2 ���������Լ�

--SUBSTR
select last_name, substr(last_name, -3, 2) --�ڿ��� ����°���� 2����.
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


--�����Լ��� ��¥�Լ�
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

--����Ǯ��
1. ���� ��¥�� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �� ���̺��� Date�� �����Ͻÿ�.
select sysdate "Date"
from dual;

2. �� ����� ���� ��� ��ȣ, �̸�, �޿� �� 15% �λ�� �޿��� ������ ǥ���Ͻÿ�. �λ�� �޿� ���� ���̺��� New Salary�� �����Ͻÿ�. 
select *
from employees;

select employee_id, last_name, salary, round(salary*1.15) as "New Salary"
from employees;

3. 2�� ���Ǹ� �����Ͽ� �� �޿����� ���� �޿��� ���� �� ���� �߰��ϰ� ���̺��� Increase�� �����ϰ� ������ ���Ǹ� �����Ͻÿ�.
select employee_id, last_name, salary, round(salary*1.15) as "New Salary", round(salary*1.15)-salary as "Increase"
from employees;

4. �̸��� J, A �Ǵ� M���� �����ϴ� ��� ����� �̸�(�빮�� ǥ��) �� �̸� ���̸� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ������ ������ ���̺��� �����Ͻÿ�. ����� ����� �̸��� ���� �����Ͻÿ�.
select upper(last_name) as "name", length(last_name) as "name_length"
from employees
where upper (substr(last_name, 1, 1)) in ('J', 'A', 'M')
order by 1;

--2. ��¥�Լ�
select sysdate
from dual;

--2.2 ��¥ ����
select last_name, (sysdate-hire_date)/7 as weeks
from employees
where department_id = 90;

--2.3 ��¥ �Լ�
select employee_id, hire_date,
       months_between (sysdate, hire_date) tenure,
       add_months(hire_date, 6) review,
       next_day(hire_date, '��'),
       last_day(hire_date)
from   employees;

select round(sysdate, 'YEAR'), --7��1��0�� �������� �⵵ �ݿø�
       round(sysdate, 'MONTH'), --16�� 0�� �������� �� �ݿø�
       round(sysdate, 'DAY'), --������ �� 12�� �������� ������ �ݿø�
       round(sysdate, 'DD') --�� 12�� �������� �Ϸ� �ݿø�
from dual;
       
select trunc(sysdate, 'YEAR'), 
       trunc(sysdate, 'MONTH'),
       trunc(sysdate, 'DAY'),
       trunc(sysdate, 'DD')
from dual;


---��ȯ�Լ� I
--1. ������ ���� ��ȯ
--�Ͻ��� ������ ���� ��ȯ

select*
from employees
where employee_id = '101';

--2.1 ��¥�� to_char �Լ� ���

alter session set
nls_date_language = american;

select employee_id, to_char(hire_date, ' MM/YY') month_hired --���� ������ yy/mm/dd �ε� mm/yy�� ���� ����
from employees;

select last_name, to_char(hire_date, 'fm DD MONTH YYYY') --fm �� �ְ� ���� ����� �ٸ�.
from employees;

select last_name, to_char(hire_date, 'fm Ddspth "of" Month YYYY fmHH:MI:SS AM') --am, pm �ƹ��ų� �ᵵ ��. "���� �ݺ�"�� ū����ǥ
from employees;

--2.2 ���ڿ� to_char �Լ� ���
select to_char(salary, '$99,999.00') salary
from employees;


--��ȯ�Լ� II

select to_number('$3,400', '$99,999')
from dual;

--2. to_date
select to_date('2010��, 02��', 'YYYY"��", MM"��"')
from dual;

--����� �߿��� 2005�� 7�� 1�� ���o�� �Ի��� ����� �̸��� �Ի����� ���.
select last_name, hire_date
from employees
where hire_date > to_date('2005�� 07�� 01��', 'YYYY"��" MM"��" DD"��"');

select last_name, hire_date
from employees
where hire_date > to_date('05/07/01', 'fxYY/MM/DD'); --fx�� ���̸� ���� ���Ĺ��� ������ ���� �������� ������ߵ�. �ƴϸ� YY-MM-DD �� ��.


--�Ϲ� �Լ��� ��ø �Լ�
--1. nvl �Լ�
select last_name, salary, nvl(commission_pct, 0),
       (salary*12) + (salary*12*nvl(commission_pct, 0)) as an_sal
from employees;

select last_name, salary, nvl(commission_pct, '���ʽ� ����') --(commission_pct, '���ʽ� ����') �� �ΰ� Ÿ���� ����, ����Ÿ������ �޶� ���� �ȵ�.
from employees;

select last_name, salary, nvl(to_char (commission_pct), '���ʽ� ����') -- Ÿ�� ��ġ������. 
from employees;

--2. nvl2 �Լ�
select last_name, salary, commission_pct,
       nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

--3. nullif �Լ�
select first_name, length(first_name) "expr1",
       last_name, length(last_name) "expr2",
       nullif(length(first_name), length(last_name)) result
from employees;

--5. ����ǥ����
select last_name, job_id, salary,
       case job_id when 'IT_PROG'  then 1.10*salary
                   when 'ST_CLERK' then 1.15*salary
                   when 'SA_REP'   then 1.20*salary
                --when job_id='SA_REP'   then 1.20*salary �̷��Ե� ����.
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

-- 5.3 decode �Լ�
select last_name, job_id, salary,
       decode(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
                                  salary)
        REVISE_SALARY
from employees;


--6. ��ø�Լ�

--���� 5. �� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �� ��)�� ����Ͽ� �� ���̺��� MONTHS_WORKED�� �����Ͻÿ�.
--      ����� ������ �ݿø��Ͽ� ǥ���Ͻÿ�.
select last_name, round((sysdate - hire_date)/30) as MONTHS_WORKED
from employees;

--6. ��� ����� �� �� �޿��� ǥ���ϱ� ���� query�� �ۼ��մϴ�. �޿��� 15�� ���̷� ǥ�õǰ� ���ʿ� $ ��ȣ�� ä�������� ������ �����Ͻÿ�. 
--�� ���̺��� SALARY �� �����մϴ�.
select last_name, LPAD(salary, 15, '$')
from employees;

--7. �μ� 90�� ��� ����� ���� ��(last_name) �� ���� �Ⱓ(�� ����)�� ǥ���ϵ��� query �� �ۼ��Ͻÿ�. 
�ָ� ��Ÿ���� ���� ���� ���̺�� TENURE�� �����ϰ� �ָ� ��Ÿ���� ���� ���� ������ ��Ÿ���ÿ�.
select last_name, round((sysdate - hire_date)/7) as TENURE
from employees
where department_id=90;

--1. �� ����� ���� ���� �׸��� �����ϴ� ���Ǹ� �ۼ��ϰ� �� ���̺��� Dream Salaries�� �����Ͻÿ�.
--<employee last_name> earns <salary> monthly but wants <3 times salary>. 
--<����> Matos earns $2,600.00 monthly but wants $7,800.00.


2. ����� �̸�, �Ի��� �� �޿� �������� ǥ���Ͻÿ�. �޿� �������� ���� ���� ����� �� ù��° �������Դϴ�. �� ���̺��� REVIEW�� �����ϰ� ��¥�� "2010.03.31 ������"�� ���� �������� ǥ�õǵ��� �����Ͻÿ�.

3. �̸�, �Ի��� �� ���� ���� ������ ǥ���ϰ� �� ���̺��� DAY�� �����Ͻÿ�. �������� �������� �ؼ� ������ �������� ����� �����Ͻÿ�.

4. ����� �̸��� Ŀ�̼��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. Ŀ�̼��� ���� �ʴ� ����� ��� ��No Commission���� ǥ���Ͻÿ�. �� ���̺��� COMM���� �����Ͻÿ�.

5. DECODE �Լ��� CASE ������ ����Ͽ� ���� �����Ϳ� ���� JOB_ID ���� ���� �������� ��� ����� ����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.

����         ���
AD_PRES     A
ST_MAN      B
IT_PROG     C
SA_REP      D
ST_CLERK    E
�׿�         0

