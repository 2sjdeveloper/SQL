--����� ���� ����
create user skj
identified by test;

--
grant create session 
to skj;

--
GRANT create session, create table, create view
to    skj;

--2.4���� öȸ
revoke create table, create view
from skj;

--2.5 ��й�ȣ ����
alter user skj
identified by lion;


--3. ��(���� �Ⱦ�)

----
create user   yedam
identified by yedam
default tablespace users
temporary tablespace temp;

GRANT connect, dba -- ����Ŭ�� �̸� ��������ִ� ��
to    yedam;


--4. ��ü����
revoke select
on hr.employees
from yedam;
