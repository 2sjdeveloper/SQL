SET SERVEROUTPUT ON

DECLARE
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := .1;
BEGIN
    SELECT department_id
      INTO v_deptno
      FROM employees
     WHERE employee_id = &�����ȣ;
     
    INSERT INTO employees(employee_id, last_name, email, hire_date, job_id, department_id)
    VALUES (1000, 'Hong', 'hkd@google.com', sysdate, 'IT_PROG', v_deptno);
    
    UPDATE employees
    SET salary = (NVL(salary, 0) + 10000) * v_comm
    WHERE employee_id = 1000;

END;
/
rollback;

SELECT *
FROM employees
WHERE employee_id=1000;


BEGIN
    DELETE FROM employees
    WHERE employee_id = 1000;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('���� ����');    
    END IF;

END;
/




--1. �����ȣ�� �Է�(ġȯ�������&) �� ��� �����ȣ, ����̸�, �μ��̸��� ����ϴ� pl/sql�� �ۼ��Ͻÿ�.

--����Ǫ�� ����
-- 1) SQL�� �ۼ�
SELECT employee_id, last_name, department_name 
FROM employees JOIN departments
  ON employees.department_id = departments.department_id
WHERE employee_id = 100;

-- 2) PL/SQL��� �ۼ�     
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_deptname departments.department_name%TYPE;
BEGIN
    SELECT employee_id, last_name, department_name 
      INTO v_eid, v_ename, v_deptname
      FROM employees JOIN departments
        ON employees.department_id = departments.department_id
     WHERE employee_id = &�����ȣ;
     
     DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
     DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
     DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || v_deptname);
END;
/

-- PL/SQL�� ��� ������ ���) �ΰ��� 
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_deptname departments.department_name%TYPE;
    v_deptid departments.department_id%TYPE;
BEGIN
    SELECT employee_id, first_name, department_id
      INTO v_empid, v_ename, v_deptid
      FROM employees
     WHERE employee_id = &�����ȣ;
     
     SELECT department_id
       INTO v_deptid
       FROM departments
      WHERE department_id = v_deptid;
     
     DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
     DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
     DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || v_deptname);
END;
/


--2. �����ȣ�� �Է�(ġȯ�������&)�� ��� ����̸�, �޿�, ����->(�޿�*12+(nvl(�޿�,0)*nvl(Ŀ�̼��ۼ�Ʈ,0)*12)�� ����ϴ� pl/sql�� �ۼ��Ͻÿ�.
--1) sql��
SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual
FROM employees
WHERE employee_id = 100;

--2) PL/SQL ���
DECLARE
    v_ename employees.last_name%TYPE;
    v_sal employees.salary%TYPE;
    v_annual v_sal%TYPE;
BEGIN
    SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual
    INTO v_ename, v_sal, v_annual
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('���� : ' || v_annual);
END;
/

-- PL/SQL�� ��� ������ ���) ��������
DECLARE
    v_ename  employees.last_name%TYPE;
    v_sal    employees.salary%TYPE;
    v_comm   employees.commission_pct%TYPE;
    v_annual v_sal%TYPE;    
BEGIN
    SELECT last_name, salary, commission_pct
      INTO v_ename, v_sal, v_comm
      FROM employees
     WHERE employee_id = &�����ȣ;
    
    v_annual := (v_sal*12+(NVL(v_sal,0)*NVL(v_comm,0)*12));
    
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('���� : ' || v_annual);
END;
/


CREATE TABLE test_employees
AS
    SELECT *
    FROM employees;
    
SELECT *
FROM test_employees;


--�⺻ if��

BEGIN
    DELETE FROM test_employees
    WHERE employee_id=&�����ȣ;
    
    IF SQL %ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('��������');
        DBMS_OUTPUT.PUT_LINE('�����ȣȮ��');
    END IF;
END;
/

-- IF ~ ELSE �� : �ϳ��� ���ǽ�, ����� ���� ���� ����

DECLARE
    v_result NUMBER(4,0);
BEGIN
    SELECT COUNT(employee_id) -- COUNT : �׷��Լ� �߿� �����ϰ� �ο� ���� ����?
/*
���� SQL �������� ���� COUNT() �Լ��� �׷� �Լ� �� �ϳ��Դϴ�. �� �Լ��� ������ ���� �� ���� ���� �� ���˴ϴ�. �־��� ���ǿ� �ش��ϴ� Ư�� ���� ���� �� �������� ��ȯ�մϴ�.
�� �Լ��� �Ϲ������� �� ���� �ƴ� ���� ���� ������, �߿��� ���� ���̺��� Ư�� ���� ���� COUNT() �Լ��� ����� �� NULL ���� ���Ե��� �ʴ´ٴ� ���Դϴ�. ��, Ư�� ���� NULL ���� ���Ե� ���� COUNT �Լ��� ���� �������� �ʽ��ϴ�.
���� COUNT() �Լ��� �־��� ���ǿ� �ش��ϴ� ���� ���� ����, �ش� ���� ���� NULL�� ���� �����ϰ� �˴ϴ�.
*/
    INTO v_result
    FROM employees
    WHERE manager_id = &�����ȣ;
    
    IF v_result = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�Ϲݻ��');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('����');    
    END IF;
END;
/

SELECT employee_id
FROM employees
WHERE manager_id = 100;


-- IF ~ ELSIF ~ ELSE �� : ���� ���ǽ��� �ʿ�, ���� ���ó���� �ʿ�
-- ������ ���ϴ� ���� : TRUNC Ȱ��
SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12,0)
FROM employees;

DECLARE
    v_hyear NUMBER(2,0);
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12,0)
    INTO v_hyear
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    IF v_hyear < 5 THEN
        DBMS_OUTPUT.PUT_LINE('�Ի��� �� 5�� �̸�');    
    ELSIF v_hyear < 10 THEN
        DBMS_OUTPUT.PUT_LINE('�Ի��� �� 5�� �̻� 10�� �̸�');
    ELSIF v_hyear < 15 THEN
        DBMS_OUTPUT.PUT_LINE('�Ի��� �� 10�� �̻� 15�� �̸�');
    ELSIF v_hyear < 20 THEN
        DBMS_OUTPUT.PUT_LINE('�Ի��� �� 15�� �̻� 20�� �̸�');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('�Ի��� �� 20�� �̻�');    
    END IF;
END;
/

/*
3-1. 
�����ȣ�� �Է�(ġȯ�������&)�� ��� �Ի����� 2015�� ���� (2015�� ����)�̸� 'New employee' ���
2015�� �����̸� 'Career employee' ���
*/
-- 1)SQL��
SELECT TO_CHAR(hire_date, 'yyyy')
FROM employees
WHERE hire_date >= TO_DATE('2015-01-01', 'YYYY-MM-DD');


DECLARE
    v_hdate employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    -- IF v_hdate >= TO_DATE('2015-01-01', 'YYYY-MM-DD') THEN
    IF TO_CHAR(v_hdate, 'yyyy') >= '2015' THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Career employee');    
    END IF;
END;
/

SELECT TO_CHAR(TO_DATE('99/01/01', 'rr/MM/dd'), 'yyyy-MM-dd'),
       TO_CHAR(TO_DATE('99/01/01', 'yy/MM/dd'), 'yyyy-MM-dd')
FROM dual;       

/*
3-2. 
�����ȣ�� �Է�(ġȯ�������&)�� ��� �Ի����� 2015�� ���� (2015�� ����)�̸� 'New employee' ���
2015�� �����̸� 'Career employee' ���
��, DBMS_OUTPUT.PUT_LINE ~ �� �ѹ��� ���.
*/

DECLARE
    v_hdate employees.hire_date%TYPE;
    v_msg VARCHAR2(1000) := 'Career employee';
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &�����ȣ;

    IF TO_CHAR(v_hdate, 'yyyy') >= '2015' THEN
        v_msg := 'New employee';
    ELSE
        v_msg := 'Career employee';
    END IF;    
END;
/


/*
4.
�޿��� 5000 ���ϸ� �޿� 20% �λ�
�޿��� 10000 ���ϸ� �޿� 15% �λ�
�޿��� 15000 ���ϸ� �޿� 10% �λ�
�޿��� 15001 �̻��̸� �޿� �λ� ����.

�����ȣ�� �Է�(ġȯ����)�ϸ�
����̸�, �޿�, �λ�� �޿��� ��µǵ��� PL/SQL ����� �����Ͻÿ�.
*/

-- 1) SQL��
SELECT last_name, salary
FROM employees
WHERE employee_id = &�����ȣ;

-- 2) PL/SQL��
DECLARE
    v_ename employees.last_name%TYPE;  
    v_salary employees.salary%TYPE;  
    v_raise NUMBER(10,1);
    v_result v_salary%TYPE;
    
BEGIN
    SELECT last_name, salary
    INTO v_ename, v_salary
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    IF v_salary <=5000 THEN 
        v_raise := 20;
    ELSIF v_salary <=10000 THEN 
        v_raise := 15;
    ELSIF v_salary <=15000 THEN 
        v_raise := 10;
    ELSE
        v_raise := 0;
    END IF;
    v_result := v_salary + (v_salary * v_raise/100);
    
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('�λ��  : ' || v_result);
END;
/


-- �⺻ LOOP��
DECLARE
    v_num NUMBER(38) := 0;
BEGIN
    LOOP
        v_num := v_num +1;
        DBMS_OUTPUT.PUT_LINE(v_num);
        EXIT WHEN v_num > 10; -- ��������
    END LOOP;
END;
/


-- WHILE LOOP��
DECLARE
    v_num NUMBER(38,0) := 1;
BEGIN
    WHILE v_num < 5 LOOP -- �ݺ�����
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_num := v_num + 1;
    END LOOP;
END;
/

-- ���� : 1���� 10���� �������� ���� ���Ͻÿ�.
-- 1) �⺻ LOOP
DECLARE    
    v_sum NUMBER(3,0) := 0;
    v_num NUMBER(3,0) := 1;
BEGIN
    LOOP
        v_sum := v_sum + v_num;
        v_num := v_num + 1;
        EXIT WHEN v_num > 10; 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/
-- 2) WHILE LOOP
DECLARE
    v_num NUMBER(3,0) := 1;
    v_sum NUMBER(3,0) := 0;
BEGIN
    WHILE v_num <= 10 LOOP
        v_sum := v_sum + v_num;
        v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/

-- FOR LOOP
BEGIN
    FOR idx IN -10 .. 5 LOOP 
        IF MOD(idx,2) <> 0 THEN -- <>�� !=�� �ǹ̰� ����.
            DBMS_OUTPUT.PUT_LINE(idx);    
        END IF;
    END LOOP;
END;
/

-- ���ǻ��� 1) (�������� ���)

BEGIN
    FOR idx IN REVERSE -10 .. 5 LOOP 
        IF MOD(idx,2) <> 0 THEN -- <>�� !=�� �ǹ̰� ����.
            DBMS_OUTPUT.PUT_LINE(idx);    
        END IF;
    END LOOP;
END;
/

-- ���ǻ��� 2) ī����(counter)�� ���� �Ұ�
DECLARE
    v_num NUMBER(2,0) := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_num);
    v_num := v_num * 2;
    DBMS_OUTPUT.PUT_LINE('=========================================');
    FOR v_num IN 1 .. 10 LOOP
        -- v_num := v_num * 2;
        -- v_num := 0;
        DBMS_OUTPUT.PUT_LINE(v_num);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_num);
END;
/

-- ���� : 1���� 10���� �������� ���� ���Ͻÿ�.
-- 3) FOR LOOP
DECLARE
    -- ������ : 1~10 => FOR LOOP�� ī���ͷ� ó��
    -- �հ�
    v_total NUMBER(2, 0) := 0;
BEGIN
    FOR num IN 1 .. 10 LOOP
        v_total := v_total + num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_total);
END;
/

/*
1. ������ ���� ��µǵ��� �Ͻÿ�. (�⺻, FOR, WHILE LOOP ������ �ۼ�)
*
**
***
****
*****

*/

--1) �⺻ ����
DECLARE
    v_star VARCHAR2(10) := "*";
BEGIN
    LOOP
        v_star := "*";
        DBMS_OUTPUT.PUT_LINE(v_star);
        EXIT WHEN v_star > 5;
    END LOOP;
END;
/