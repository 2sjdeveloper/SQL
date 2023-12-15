select *
from   hr.employees;

create table aaa(
   aa number(2));

insert into aaa
values (1);
insert into aaa
values (2);

commit;

grant select
on    aaa
to    skj;