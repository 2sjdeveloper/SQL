--12��12��
--������, ���߿� ��������

--������ ���� ���
--�����޿��� �޴� ����� �̸�, ����, �޿� ���
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from   employees);

--50�� �μ��� �����޿� �޴� ����麸�� �����޿��� ū �μ��� ���
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                      from employees
                      where department_id = 50);
--group by, having�� ���� : https://jink1982.tistory.com/63

----------������ ��������

select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--�߰� ���� : <any == ������������ ���ϵǴ� ���� ū ������ ������
--������������ ���ϵǴ� ���� 9000, 6000, 4200 ����.

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--< all == ���� ���� ������ ������.

--2.1 ���߿� ��������
--�߰����� ��ġ �ʿ�.
--����Ŭ ��ġ -> sql_laps �������� cre_empl ���� ��� F5 ������, �λ������ ����.

select manager_id, department_id
from empl_demo
where first_name ='John';

--�ֺ�
--3���� ����� ���� ����.
select employee_id, manager_id, department_id
from empl_demo
where (manager_id, department_id) in
                     (select manager_id, department_id
                      from empl_demo
                      where first_name = 'John')
and first_name != 'John';

---�� �ڵ�� ����غ������� ���� ���ؿ� ������ �ִ� ���. (�� �ֺ�)
--����� ���� 9������ ����.
select employee_id, manager_id, department_id
from empl_demo
where manager_id in (select manager_id
                     from empl_demo
                     where first_name = 'John')
and department_id in (select department_id
                      from empl_demo
                      where first_name = 'John')
and first_name != 'John';

---------������ ���۾�
2. ������ ����
2.2 insert ����
--sql ��ġ ���Ͽ��� cre_hrdata.spl ���� ��ġ, ��� F5 ������ �λ������ ����.

insert into departments(department_id, department_name, manager_id, location_id)
values      (370, 'Public Relations', 100, 1700);
--���̵� 370�� �߰��ϰ� �ű⿡ ���ο� ������ �߰�
select *
from departments;

insert into departments
values      (371, 'Public Relations', 100, 1700);
--��� �÷��� ���̷�Ʋ �� �Է��� ���� ���̺���� �Է��� �ʿ� ����.

insert into departments (department_id, department_name)
values (330, 'Purchasing');
--Ư�� �÷����� �����͸� �Է��ϰ��� �� ���� ��ȣ�ؼ� �÷��� �Է��ؾ���.
--���� �Էµ��� ���� �÷����� �Ͻ������� �ΰ��� �Էµ�.

select *
from departments;
--��ȸ�ϸ� 330 �߰��Ǿ�����. 

insert into departments
values (400, 'Finance', null, null);
--�÷��� �Է� ���� ������ ���� ���� ��������� �ΰ��� �־������.
--�� ������ 'null' �� ������ �ȵ�. ���ڷ� �Է��ϰڴٴ� �ǹ̰� �Ǿ ����.


insert into employees
values      (113, 'Louis', 'Popp', 'LPOPP', '515.124.4567', SYSDATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);
--hire_date �κп� sysdate�� ��.
select * 
from employees;

insert into employees
values      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561', to_date('FEB 3, 1999', 'MON DD, YYYY'),
             'SA_REP', 11000, 0.2, 100, 60);
--to_date�� �Էµ� ��¥('FEB 3, 1999', 'MON DD, YYYY')�� �ý��� ���� ��¥ǥ���(99/02/03)���� �ٲ���. 

insert into departments
values (100, 'Finance', '', null);
--null�� �ΰ��̰� '' <<�̰͵� �ΰ����� �Էµ�. ��������� ������ ����.
select *
from departments;

insert into departments
            (department_id, department_name, location_id)
values (&department_id, '&department_name', &location);
--ġȯ����. 40, Human Resourcesl, 2500 ������ �Է�

--sales_reps ���� ��ġ

select * 
from sales_reps;

select *
from copy_emp;

insert into sales_reps
select employee_id, last_name, salary, commission_pct
from employees
where job_id like '%REP%';
--������ ����

insert into copy_emp
select *
from employees;

select *
from employees;

select * from departments;

insert into departments(department_name)
values ('Yedam');
--department_id �� ��� ���� �߻�. �⺻Ű�� ���� ������ �־�ߵ�.

insert into departments(department_id, department_name)
values (10, 'Yedam');
--department_id �� ����ũ(���ؿ´�)�ؾߵ�. 10�� �μ��� ����. �׷��� �ȵ�.

insert into departments(department_id, department_name)
values (120, 'Yedam');
--120�� ��� ��.

insert into departments(department_id)
values ('130');
--�̰͵� ����. department_name�� ����ũ ������ �ƴ����� not null ���� ������ �ɷ�����. �׷��� ���ӵ� �Է��ؾߵ�.

insert into departments(department_id, department_name, manager_id)
values (130, 'YD', 1);
--���Ἲ ���ǿ� ������ ��. manager_id�� ���÷��� ���̺� �ִ� ���÷��� ���̵� ���� �����ϴ� ����?Ű
-- �ű⿡ �ִ� ���� �Է��ؾߵ�.

insert into departments(department_id, department_name, manager_id)
values (130, 'YD', 100);
--�̰� �� ���� �ذ�Ǿ ������ ���� ��.

--4. ������ ���� (update) (3.delete�� update ���� �ϰ�)

update employees --���÷���� �������ϰڴ�. 
set department_id = 50  --���? ����Ʈ��Ʈ ���̵� 50���� �����ϰڽ���.
where employee_id = 113; --���÷��� ���̵� 113���� ���� 50������ �����ϰڴ�.
--���÷���� �������ϰڴ�. ���? ����Ʈ��Ʈ ���̵� 50���� �����ϰڽ���. ���÷��� ���̵� 113���� ���� 50������ �����ϰڴ�.

select *
from employees
where employee_id = 113;

--51�δ� ���� �ȵ�. ���� ����Ű...?

update copy_emp
set department_id = 110;
--��ü ������.

select *
from copy_emp;

update employees
set job_id = 'IT_PROG', commission_pct = null
where employee_id = 114;
--����

select *
from employees
where employee_id = 114;
--Ȯ��

rollback;
--���ݱ��� �ߴ� dml �۾� ����ϴ°�

select *
from copy_emp;


---3. ������ ����(delete)

delete employees;
--���ϵ� ���ڵ� �߰��̶�� ���� ��. 

insert into copy_emp
   select *
   from employees;
   
select *
from copy_emp;

commit;

delete copy_emp;
--where�� ��� ���� ������.

rollback;
--Ŀ���س��� �ѹ��ϸ� ����� �ٽ� ���ƿ�.

--���� �𸣰����� �ϴ� �����.
--dml : �ѹ� ����
--ddl : �ѹ� �Ұ�.

delete from departments
where department_name = 'Finance';
--���̳��� �����ϰڴ�.

select *
from departments;
--�����Ȱ� Ȯ��.

delete departments 
where department_id in (30, 40);
--from �Ƚᵵ ���� ����.

select *
from departments;

rollback;

select *
from copy_emp;

delete copy_emp;

rollback;
--������ ������.

truncate table copy_emp;
--�� �������� ����.

rollback;
--�ѹ��ص� �Ȼ�Ƴ�.

--�̰� ddl�� ddm ����..

----------���� sql.08.
-- 1. ������ ���� �ǽ��� ����� MY_EMPLOYEE ���̺��� �����Ͻÿ�.
CREATE TABLE my_employee
  (id         NUMBER(4) NOT NULL,
   last_name  VARCHAR2(25),
   first_name VARCHAR2(25),
   userid     VARCHAR2(8),
   salary     NUMBER(9,2));

--2. MY_EMPLOYEE ���̺��� ������ ǥ���Ͽ� �� �̸��� �ĺ��Ͻÿ�.
desc my_employee;

select *
from my_employee;

-- 3. ���� ���� �����͸� MY_EMPLOYEE ���̺� �߰��Ͻÿ�.
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

--ġȯ���� Ȱ��
--insert into my_employee
--values (&id, '&last_name', '&first_name', '&userid', '&salary);

select *
from my_employee;

4. ���̺� �߰��� �׸��� Ȯ���Ͻÿ�.
select *
from my_employee;

6. ��� 3�� ���� Drexler�� �����Ͻÿ�.
update my_employee
set last_name = 'Drexler'
where id = 3;

7. �޿��� 900 �̸��� ��� ����� �޿��� 1000���� �����ϰ� ���̺��� ���� ������ Ȯ���Ͻÿ�.

update my_employee
set salary = 1000
where salary < 900;

select *
from my_employee;

8. MY_EMPLOYEE ���̺��� ��� 3�� �����ϰ� ���̺��� ���� ������ Ȯ���Ͻÿ�.
delete my_employee
where id = 3;

11. ���̺��� ������ ��� �����ϰ� ���̺� ������ ��� �ִ��� Ȯ���Ͻÿ�.
delete my_employee; --dml��
--�Ǵ�
truncate table my_employee; --ddl��


----------Ʈ����� ����

commit;

update employees
set salary = 99999
where employee_id = 176;

select *
from employees
where employee_id  = 176;

rollback;

commit;

truncate table aa; --ddl�� �ϳ��ϳ��� ���� Ŀ��. �ڵ� Ŀ�� ��.


---------������ ���Ǿ�(DDL)- ��ü ����

--2.2 ���̺� ����
--������ ��ųʸ�
select table_name
from user_tables;

select distinct object_type
from user_objects;

select *
from user_catalog;


--3. ���̺� ����
--3.1 ����
--3.3 ����Ʈ �ɼ�

create table hire_dates
        (id         number(8),
         hire_date date default sysdate);
--����Ʈ������ �ý�������

insert into hire_dates(id)
values (35);

select *
from hire_dates;

insert into hire_dates
values (45, null);
--����Ʈ���� �η� ����.

--3.4 ���̺� ����
--dept ���̺�
create table dept
        (deptno     number(2),
         dname      varchar2(14),
         loc        varchar2(13),
         create_date date default sysdate);
         
describe dept;
        
select table_name 
from user_tables;

--3.4 ���̺� ����
--���������� ����� ���̺� ����
create table dept80
as
select employee_id, last_name, 
       salary*12 ANNSAL, --������ �� ��쿡�� �ݵ�� ���ĸ��� �����������. ���ĸ��� �÷� �̸��� �� �� ����.
       hire_date
from employees
where department_id = 80;

describe dept80;

--------������ ���Ǿ�(DDL) - ��ü ����
--1. ���̺� ����
--1.1 ��(column)�߰�

alter table dept80
add         (job_id VARCHAR2(9));
--job_id �÷� �����Ȱ� Ȯ��
select *
from dept80; 

alter table dept80
add (hdate date default sysdate);
--����Ʈ�� ����. ���� ������ ���� ���̾���.

select *
from dept80;

--1.2 ��(column) ����
alter table dept80
modify      (last_name varchar2(10));

alter table dept80
modify (job_id number(10));

alter table dept80
modify (last_name number(15)); --�̰� �ȵ�. ������ ������ Ÿ���̶� �޶�

--1.3 �� ����
alter table dept80
drop (job_id);

------2. set unused �ɼ�
--2.1
alter table dept80
set unused (last_name);

select *
from dept80; --last_name �÷��� ��ȸ �ȵ�.

alter table dept80
drop unused columns;


--------��Ÿ ������ ���Ǿ�
--1. ���̺� ����

drop table dept80;

select *
from user_recyclebin; --������ ���
--���� ���� ��� ������ dept80 ���� ����.

flashback table dept80 to before drop; 
--����ϱ� �� ���·� dept80 ������ �����ϰڴ�.

drop table dept80 purge;
--dept80�� �����뿡 ���� ���ϰ� �ٷ� ���� ���� �ϰڴ�.
--������ �����δ� ����������.

select *
from user_recyclebin;
--�����뿡 �ƹ��͵� ����.


--2. ��ü �̸� ����
rename dept to dept80;

select *
from dept80;

--3. ���̺� ����
truncate table dept80;





















