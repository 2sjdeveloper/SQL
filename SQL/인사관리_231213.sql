--12�� 13��
--�������� Ȱ��

--1. NOT NULL

--���̺� ����
create table emp_test(empid NUMBER(5),
                      empname VARCHAR2(10) not null,
                      duty VARCHAR2(9),
                      sal NUMBER(7,2),
                      bonus NUMBER(7,2),
                      mgr NUMBER(5),
                      hire_date DATE,
                      deptid NUMBER(2));
--�ΰ� �Է� : ����
insert into emp_test(empid, empname)
values (10, null);
--���ΰ� �Է� : ���� ����
insert into emp_test(empid, empname)
values (10,'YD');
            
            
--2. UNIQUE

create table dept_test(deptid NUMBER(2),
                       dname VARCHAR2(14),
                       loc VARCHAR2(13),
                       UNIQUE(dname));

insert into dept_test(deptid, dname)
values (10, null); -- �ΰ� �Է� ����
insert into dept_test(deptid, dname)
values (20, 'YD');
insert into dept_test(deptid, dname)
values (20, 'YD'); --�ߺ����̶� ���� ��.


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
values (20, 'YD2', 'Daegu'); --�ߺ��� �Է� ����
insert into dept_test
values (NULL, 'YD3', 'Daegu'); --�ΰ� �Է� ����


--4. FOREIGN KEY
drop table emp_test;
--���̺� �������� ����
create table emp_test(empid     NUMBER(5),
                      empname   VARCHAR2(10) not null,
                      duty      VARCHAR2(9),
                      sal       NUMBER(7,2),
                      bonus     NUMBER(7,2),
                      mgr       NUMBER(5),
                      hire_date DATE,
                      deptid    NUMBER(2),
 FOREIGN KEY(deptid) REFERENCES dept_test(deptid) on delete set null); --���̺� �������� ����
--on delete set null : �θ� ���̺� ������ �ڽ� ���̺� ������ null������ ��ȯ 
--�÷� �������� ���� : deptid    NUMBER(2) REFERENCES dept_test(deptid));

insert into emp_test(empid, empname, deptid)
values (100, 'YD1', 10);
insert into emp_test(empid, empname, deptid)
values (200, 'YD2', null);
insert into emp_test(empid, empname, deptid)
values (300, 'YD3', 30); --�θ�Ű ã�� �� ��� ����.

select *
from   emp_test;

drop table emp_test;

delete dept_test
where  deptid = 10; --�θ� ������ deptid ���̺��� 10�� ����

select *
from   dept_test; --�ڽĿ����� ������.

--5. CHECK ��������
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
 
 
 -----------�������� ���� �� ����
 --1.1 �������� �߰�
 alter table emp_test
 add    primary key(empid); --�����̸Ӹ� Ű ����
 
 alter table emp_test
 add         foreign key(mgr) references emp_test(empid); --�����̸Ӹ� Ű �߰�..?
 
 alter table emp_test
 modify (duty not null); --�� �� �������� �߰�
--modify (duty VARCHAR2(9) not null); : ��Ģ.

--1.2 �������� ����

--�������� Ȯ��
desc user_cons_columns;

select constratint_name, contraint_type, search_condition
from   user_constraints;

select constraint_name, column_name, table_name
from   user_cons_columns --sys c �� �����ϴ� �͵��� �츮�� ���� ��������
where  table_name = 'EMP_TEST';

--�������� ����
alter table emp_test
drop constraint sys_c007022; --sys_c007022 �� �������� ���� �÷� ����


--2. �������� Ȱ��ȭ �� ��Ȱ��ȭ
--���� �Ⱦ�


-----------------�� (VIEW)

--�� ����
create view emp80_vu
as select employee_id, last_name, salary
   from   employees
   where  department_id = 80;

--�� ��ȸ
select *
from   emp80_vu;

--�� ����
create view sal50_vu
as select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY --���� ���� ������ �̸� ����.
   from   employees
   where  department_id = 50;
--�� ��ȸ
select *
from   sal50_vu;

--�� ����(or replace ��ɾ� ���)
create or replace view emp80_vu
   (id_number, name, sal, department_id)
as select employee_id, first_name || ' ' || last_name, salary, department_id
   from   employees
   where  department_id = 80;

select *
from   emp80_vu;

--�� ����
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

--5. �並 ���� ������ ����
commit;

select *
from   emp80_vu;

delete emp80_vu
where  id_number = 176;

select *
from   emp80_vu; --�信�� ���� ��.

select *
from employees; --�並 ���� ����������, ���� �����͵� ���� ������.
------------
select *
from dept_sum_vu;

delete dept_sum_vu
where name = 'IT'; --�� �ȿ� ���� ���־ ���� �Ұ�.
--------------
create view test_vu
as
  select department_name
  from   departments;
  
select *
from test_vu;

insert into test_vu
values ('YD'); --����Ʈ��Ʈ ���̵�� �����̸Ӹ� Ű. ��� ���� �ȵ�.


--6. ���� ��������

------��Ÿ ��ü
--1. �ε���

--2. ������
--2.2 ������ ����
create sequence dept_deptid_seq
                increment by 10
                start with 120 
                maxvalue 9999
                nocache
                nocycle;
--���۰��� 120, �������� 10, �ִ밪�� 9999

insert into departments(department_id, department_name, location_id)
values      (dept_deptid_seq.NEXTVAL, 'Support', 2500);

select *
from departments;
-----
rollback;

select *
from departments; --�Ʊ���� ���簪 ���Ŀ������� �ٽ� ������. =���� �߻�

--2.4 ������ ���� Ȯ��

select dept_deptid_seq.CURRVAL
from dual; --�������� ������� ���Ǿ����� Ȯ��..


---3. ���Ǿ�
--3.2 ���Ǿ� ����
create synonym d_sum
for dept_sum_vu;

select *
from d_sum;

select *
from dept_sum_vu;

--���� : drop synonym d_sum; 


-------������ ����(DCL)

--2. �ý��� ����

--�ý��� ���� Ȯ��
select *
from system_privilege_map;

--����� ���� ����
--������ ���Ͽ���

----------------��� SQL
--������ ����
--top down ���
select level, employee_id, last_name, manager_id
from employees
start with manager_id is null
connect by prior employee_id = manager_id;
-- ���� ǥ�� connect by manager_id = prior employee_id;

--bottom down ���
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

------����--------------------------------------------------------------------------
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

