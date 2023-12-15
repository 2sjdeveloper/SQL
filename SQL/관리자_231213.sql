--사용자 계정 생성
create user skj
identified by test;

--
grant create session 
to skj;

--
GRANT create session, create table, create view
to    skj;

--2.4권한 철회
revoke create table, create view
from skj;

--2.5 비밀번호 변경
alter user skj
identified by lion;


--3. 롤(거의 안씀)

----
create user   yedam
identified by yedam
default tablespace users
temporary tablespace temp;

GRANT connect, dba -- 오라클에 미리 만들어져있는 롤
to    yedam;


--4. 객체권한
revoke select
on hr.employees
from yedam;
