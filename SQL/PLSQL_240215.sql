SET SERVEROUTPUT ON

/*

1. ������ ���� ��µǵ��� �Ͻÿ�.
*       -- ù��° ��, '*'�� �ϳ�  
**      -- �ι�° ��, '*'�� ��  
***     -- ����° ��, '*'�� ��  
****    -- �׹�° ��, '*'�� �� 
*****   -- �ټ���° ��, '*'�� �ټ�  

 LOOP���� ||
*/

-- �⺻ LOOP
DECLARE
    v_tree VARCHAR2(6 char) := ''; -- �� �ٿ� ����� *
    v_count NUMBER(1,0) := 0;      -- LOOP�� �������ǿ� ����� ���� : 1 ~ 5
BEGIN
    LOOP
        v_tree := v_tree || '*';
        DBMS_OUTPUT.PUT_LINE(v_tree);
        
        v_count := v_count + 1;
        EXIT WHEN v_count > 5;
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    v_tree VARCHAR2(6 char) := ''; -- �� �ٿ� ����� *
    v_count NUMBER(1,0) := 0;      -- LOOP�� �������ǿ� ����� ����
BEGIN
    WHILE v_count <= 5 LOOP
        v_tree := v_tree || '*';
        DBMS_OUTPUT.PUT_LINE(v_tree);
        
        v_count := v_count + 1;
    END LOOP;
END;
/

-- FOR LOOP
BEGIN
    FOR counter IN 1..5 LOOP  -- ����� ��
        FOR i IN 1..counter LOOP -- * 
            DBMS_OUTPUT.PUT('*');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');    
    END LOOP;
END;
/

/*
2. ġȯ����(&)�� ����ϸ� ���ڸ� �Է��ϸ� 
�ش� �������� ��µǵ��� �Ͻÿ�.
��) 2 �Է½�
2 * 1 = 2
2 * 2 = 4
...
=> ġȯ���� : ����, ���� �Է�
=> ���ϴ� �� : 1���� 9����, ������ ==> LOOP��
*/
-- �⺻ LOOP => ���ǰ� ���õ� ���� �ʼ�!
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &��;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
        
        v_num := v_num + 1;
        EXIT WHEN v_num > 9; 
    END LOOP;
END;
/

-- WHILE LOOP => ���ǰ� ���õ� ����
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &��;
    v_num NUMBER(2,0) := 1; -- ���� : 1 ~ 9, ���� ���
BEGIN
    WHILE v_num <= 9  LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
        v_num := v_num + 1;
    END LOOP;
END;
/

-- FOR LOOP => ������ �䱸���� ����
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &��;
BEGIN
    FOR num IN 1 .. 9 LOOP -- Ư�� ������ �����ϴ� ���� ���� ���� ����
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || num || ' = ' || (v_dan * num));    
    END LOOP;
END;
/

/*
3. ������ 2~9�ܱ��� ��µǵ��� �Ͻÿ�.
 2 ~ 9 ������ ���� => �ݺ���
 �� �ܺ��� ���ϴ¼�, 1 ~9 ������ ���� => �ݺ���
*/

-- FOR LOOP
BEGIN
    FOR dan IN 2..9 LOOP -- �� : 2 ~ 9, ����
        FOR num IN 1..9 LOOP -- ���ϴ� �� : 1 ~ 9, ����
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || (dan * num)  || ' ');
        END LOOP;
    END LOOP;
END;
/

BEGIN
    FOR num IN 1..9 LOOP -- ���ϴ� �� : 1 ~ 9, ����
        FOR dan IN 2..9 LOOP -- �� : 2 ~ 9, ����        
            DBMS_OUTPUT.PUT(dan || ' * ' || num || ' = ' || (dan * num) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- WHILE LOOP => �ݺ����ǰ� ���õ� ���� 
DECLARE
    v_dan NUMBER(2,0) := 2; -- 2 ~ 9 => �ݺ�����
    v_num NUMBER(2,0) := 1; -- 1 ~ 9 => �ݺ�����
BEGIN
    WHILE v_dan <= 9 LOOP -- ��
        v_num := 1;
        WHILE v_num <= 9 LOOP -- ���ϴ¼�
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num)  || ' ');
            v_num := v_num + 1;
        END LOOP;
        v_dan := v_dan + 1;
    END LOOP;
END;
/
DECLARE
    v_dan NUMBER(2,0) := 2; -- 2 ~ 9 => �ݺ�����
    v_num NUMBER(2,0) := 1; -- 1 ~ 9 => �ݺ�����
BEGIN
    WHILE v_num <= 9 LOOP -- ���ϴ¼�   
        v_dan := 2;
        WHILE v_dan <= 9 LOOP -- ��
            DBMS_OUTPUT.PUT(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num)  || ' ');
            v_dan := v_dan + 1;            
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        v_num := v_num + 1;
    END LOOP;
END;
/

-- �⺻ LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP -- ��
        v_num := 1;
        LOOP -- ���ϴ� ��
            DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));
            v_num := v_num + 1;
            EXIT WHEN v_num > 9;
        END LOOP;
        v_dan := v_dan + 1;
        EXIT WHEN v_dan > 9;
    END LOOP;    
END;
/
/*
4. ������ 1~9�ܱ��� ��µǵ��� �Ͻÿ�.
   (��, Ȧ���� ���)
*/

-- FOR LOOP + IF��
BEGIN
    FOR v_dan IN 1..9 LOOP -- Ư�� ���� 1~9���� �ݺ��ϴ� LOOP��
        IF MOD(v_dan, 2) <> 0 THEN
            FOR v_num IN 1..9 LOOP -- Ư�� ���� 1~9���� ���ϴ� LOOP��
                DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));  
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/

-- FOR LOOP + IF��
BEGIN
    FOR v_dan IN 1..9 LOOP -- Ư�� ���� 1~9���� �ݺ��ϴ� LOOP��
        IF MOD(v_dan, 2) = 0 THEN 
            CONTINUE;
        END IF;
        
        FOR v_num IN 1..9 LOOP -- Ư�� ���� 1~9���� ���ϴ� LOOP��
            DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));  
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- �⺻ LOOP
DECLARE
    v_dan NUMBER(2,0) := 1;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP -- ��
        IF MOD(v_dan, 2) <> 0 THEN
            v_num := 1;
            LOOP -- ���ϴ� ��
                DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));
                v_num := v_num + 1;
                EXIT WHEN v_num > 9;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        
        v_dan := v_dan + 1;
        EXIT WHEN v_dan > 9;
    END LOOP;    
END;
/

-- RECORD
DECLARE
    -- 1) ����
    TYPE emp_record_type IS RECORD
        (empno NUMBER(6,0),
         ename employees.last_name%TYPE,
         sal employees.salary%TYPE := 0);
        
    -- 2) ���� ����
    v_emp_info emp_record_type;
    v_emp_record emp_record_type;
BEGIN
    
    SELECT employee_id, first_name, salary
    INTO v_emp_info
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT('�����ȣ : ' || v_emp_info.empno);
    DBMS_OUTPUT.PUT(', ����̸� : ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINe(', �޿� : ' || v_emp_info.sal);
    
    SELECT department_id, job_id, commission_pct
    INTO v_emp_info
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT('�����ȣ : ' || v_emp_info.empno);
    DBMS_OUTPUT.PUT(', ����̸� : ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', �޿� : ' || v_emp_info.sal);
END;
/

-- TABLE
DECLARE
    -- 1) ����
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    -- 2) ���� ����
    v_num_info num_table_type;
BEGIN
    v_num_info(-1000) := 10000;
    
    DBMS_OUTPUT.PUT_LINE('���� �ε��� -1000 : ' || v_num_info(-1000));
END;
/

-- 2�� ��� 10���� ��� ���� : 2, 4, 6, 8, 10, 13, 14, ...
DECLARE
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;        
    v_num_ary num_table_type;
    v_result NUMBER(4,0) := 0;
BEGIN 
    FOR idx IN 1..10 LOOP
        v_num_ary(idx * 5) := idx * 2;
    END LOOP;
    
    FOR i IN v_num_ary.FIRST .. v_num_ary.LAST LOOP
        IF v_num_ary.EXISTS(i) THEN
            DBMS_OUTPUT.PUT(i || ' : ');
            DBMS_OUTPUT.PUT_LINE(v_num_ary(i));
            v_result := v_result + (v_num_ary(i));
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('�� ���� : ' || v_num_ary.COUNT);
    DBMS_OUTPUT.PUT_LINE('������ : ' || v_result);
END;
/

-- TABLE + RECORD
SELECT *
FROM employees;

DECLARE
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY PLS_INTEGER;

    v_emps emp_table_type;
    v_emp_info employees%ROWTYPE;
BEGIN
    FOR eid IN 100 .. 104 LOOP
        SELECT *
        INTO v_emp_info
        FROM employees
        WHERE employee_id = eid;
        
        v_emps(eid) := v_emp_info;
    END LOOP;    
    
    DBMS_OUTPUT.PUT_LINE('�� ���� : ' || v_emps.COUNT);
    DBMS_OUTPUT.PUT_LINE(v_emps(100).last_name);
END;
/


-- 10���� ������ ����ϱ�
DECLARE
    v_min employees.employee_id%TYPE; -- �ּ� �����ȣ
    v_max employees.employee_id%TYPE; -- �ִ� �����ȣ
    v_result NUMBER(1,0);             -- ����� ���������� Ȯ��
    v_emp_record employees%ROWTYPE;     -- Employees ���̺��� �� �࿡ ����
    
    TYPE emp_table_type IS TABLE OF v_emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    v_emp_table emp_table_type;
BEGIN
    -- �ּ� �����ȣ, �ִ� �����ȣ
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    FOR eid IN v_min .. v_max LOOP
        SELECT COUNT(*) -- null ���� 0���� ī��Ʈ ��.
        INTO v_result
        FROM employees
        WHERE employee_id = eid;
        
        IF v_result = 0 THEN
            CONTINUE;
        END IF;
        
        SELECT *
        INTO v_emp_record
        FROM employees
        WHERE employee_id = eid;
        
        v_emp_table(eid) := v_emp_record;     
    END LOOP;
    
    FOR eid IN v_emp_table.FIRST .. v_emp_table.LAST LOOP
        IF v_emp_table.EXISTS(eid) THEN
            DBMS_OUTPUT.PUT(v_emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT(v_emp_table(eid).last_name || ', ');
            DBMS_OUTPUT.PUT_LINE(v_emp_table(eid).hire_date);
        END IF;
    END LOOP;    
END;
/


-- Ŀ��(CURSOR)
DECLARE
    -- Ŀ���� ����
    CURSOR emp_cursor IS
        SELECT employee_id, last_name
        FROM employees
        WHERE employee_id = 0;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    OPEN emp_cursor;
    
    FETCH emp_cursor INTO v_eid, v_ename;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);    
    
    CLOSE emp_cursor;
END;
/


DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, job_id
        FROM employees;
        
    v_emp_record emp_cursor%ROWTYPE;    
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- ���� ���� ����
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ', ');
        DBMS_OUTPUT.PUT_LINE(v_emp_record.last_name);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/


DECLARE
    CURSOR emp_cursor IS
        SELECT *
        FROM employees;
        
    v_emp_record employees%ROWTYPE;
    
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY PLS_INTEGER;
    
    v_emp_table emp_table_type;

BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO v_emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        v_emp_table(v_emp_record.employee_id) := v_emp_record;
    END LOOP;
    
    CLOSE emp_cursor;
    
    FOR eid IN v_emp_table.FIRST .. v_emp_table.LAST LOOP
        IF v_emp_table.EXISTS(eid) THEN
            DBMS_OUTPUT.PUT(v_emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT(v_emp_table(eid).last_name || ', ');
            DBMS_OUTPUT.PUT_LINE(v_emp_table(eid).hire_date);
        END IF;
    END LOOP;  
END;
/

-- Ŀ���� ����� �ִ� �����͸� Ȯ���ϴ¹�?
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, job_id
        FROM employees
        WHERE department_id = &�μ���ȣ;
    
    v_emp_info emp_dept_cursor%ROWTYPE;
    
BEGIN
    -- 1) �ش� �μ� �Ҽ� ����� ���� ���
    OPEN emp_dept_cursor;
    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        
        -- ROWCOUNT ��� ������ �� ù��°(LOOP�� ��) : ���° ���� ����ϴ��� ������.
        DBMS_OUTPUT.PUT_LINE('ù��° : ' || emp_dept_cursor%ROWCOUNT);
        
        DBMS_OUTPUT.PUT(v_emp_info.employee_id || ', ');
        DBMS_OUTPUT.PUT(v_emp_info.last_name || ', ');
        DBMS_OUTPUT.PUT_LINE(v_emp_info.job_id);
    END LOOP;
    
    -- ROWCOUNT ��� ������ �� �ι�°(LOOP�� ���� ��) : ���������� ���� Ŀ���� ���� ������ �� ������ üũ��.
    DBMS_OUTPUT.PUT_LINE('�ι�° : ' || emp_dept_cursor%ROWCOUNT);
    -- 2) �ش� �μ� �Ҽ� ����� ���� ��� '�ش�μ� �Ҽ����� ����' �޼��� ���.
    IF emp_dept_cursor%ROWCOUNT = 0 THEN    
        DBMS_OUTPUT.PUT_LINE('�ش� �μ� �Ҽ� ���� ����');
    
    END IF;
    
    CLOSE emp_dept_cursor;
END;
/


-- 1) ��� ����� �����ȣ, �̸�, �μ��̸� ���
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id eid, last_name ename, department_name dept_name
        FROM employees e
            LEFT OUTER JOIN departments d
            ON e.department_id = d.department_id;
            -- ON employees.department_id = departments.department_id;            
    v_emp_info emp_dept_cursor%ROWTYPE;
    
BEGIN
    OPEN emp_dept_cursor;
    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;    

    DBMS_OUTPUT.PUT(v_emp_info.eid || ', ');
    DBMS_OUTPUT.PUT(v_emp_info.ename || ', ');
    DBMS_OUTPUT.PUT_LINE(v_emp_info.dept_name);
    DBMS_OUTPUT.PUT_LINE('=========================');
    END LOOP;
    CLOSE emp_dept_cursor;
END;
/

-- 2) �μ���ȣ�� 50�̰ų� 80�� ������� ����̸�, �޿�, ���� ���
-- ���� : (�޿� * 12) + (NVL(�޿�, 0) * NVL(Ŀ�̼�,0) *12)

-- SQL��
SELECT last_name, salary, commission_pct
FROM employees
WHERE department_id IN (50, 80);

-- PL/SQL��        
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT last_name,
               salary,
               commission_pct
        FROM employees
        WHERE department_id IN (50, 80);
    
    v_emp_info emp_dept_cursor%ROWTYPE;
    v_annual employees.salary%TYPE;
BEGIN
    OPEN emp_dept_cursor;
    
    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;  
        
        v_annual := (v_emp_info.salary*12+(NVL(v_emp_info.salary, 0) * NVL(v_emp_info.commission_pct, 0) * 12));
        DBMS_OUTPUT.PUT(', ����̸� : ' || v_emp_info.last_name);
        DBMS_OUTPUT.PUT(', �޿� : ' || v_emp_info.salary);
        DBMS_OUTPUT.PUT_LINE(', ���� : ' || v_annual);
    END LOOP;
    
    CLOSE emp_dept_cursor;
END;
/