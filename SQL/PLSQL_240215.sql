SET SERVEROUTPUT ON

/*

1. 다음과 같이 출력되도록 하시오.
*       -- 첫번째 줄, '*'가 하나  
**      -- 두번째 줄, '*'가 둘  
***     -- 세번째 줄, '*'가 셋  
****    -- 네번째 줄, '*'가 넷 
*****   -- 다섯번째 줄, '*'가 다섯  

 LOOP문과 ||
*/

-- 기본 LOOP
DECLARE
    v_tree VARCHAR2(6 char) := ''; -- 각 줄에 출력할 *
    v_count NUMBER(1,0) := 0;      -- LOOP문 종료조건에 사용할 변수 : 1 ~ 5
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
    v_tree VARCHAR2(6 char) := ''; -- 각 줄에 출력할 *
    v_count NUMBER(1,0) := 0;      -- LOOP문 종료조건에 사용할 변수
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
    FOR counter IN 1..5 LOOP  -- 몇번재 줄
        FOR i IN 1..counter LOOP -- * 
            DBMS_OUTPUT.PUT('*');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');    
    END LOOP;
END;
/

/*
2. 치환변수(&)를 사용하면 숫자를 입력하면 
해당 구구단이 출력되도록 하시오.
예) 2 입력시
2 * 1 = 2
2 * 2 = 4
...
=> 치환변수 : 변수, 단을 입력
=> 곱하는 수 : 1에서 9까지, 정수값 ==> LOOP문
*/
-- 기본 LOOP => 조건과 관련된 변수 필수!
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &단;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
        
        v_num := v_num + 1;
        EXIT WHEN v_num > 9; 
    END LOOP;
END;
/

-- WHILE LOOP => 조건과 관련된 변수
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &단;
    v_num NUMBER(2,0) := 1; -- 범위 : 1 ~ 9, 정수 모두
BEGIN
    WHILE v_num <= 9  LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num));
        v_num := v_num + 1;
    END LOOP;
END;
/

-- FOR LOOP => 변수를 요구하지 않음
DECLARE
    v_dan CONSTANT NUMBER(2,0) := &단;
BEGIN
    FOR num IN 1 .. 9 LOOP -- 특정 범위에 존재하는 정수 값을 내부 변수
        DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || num || ' = ' || (v_dan * num));    
    END LOOP;
END;
/

/*
3. 구구단 2~9단까지 출력되도록 하시오.
 2 ~ 9 사이의 정수 => 반복문
 각 단별로 곱하는수, 1 ~9 사이의 정수 => 반복문
*/

-- FOR LOOP
BEGIN
    FOR dan IN 2..9 LOOP -- 단 : 2 ~ 9, 정수
        FOR num IN 1..9 LOOP -- 곱하는 수 : 1 ~ 9, 정수
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || (dan * num)  || ' ');
        END LOOP;
    END LOOP;
END;
/

BEGIN
    FOR num IN 1..9 LOOP -- 곱하는 수 : 1 ~ 9, 정수
        FOR dan IN 2..9 LOOP -- 단 : 2 ~ 9, 정수        
            DBMS_OUTPUT.PUT(dan || ' * ' || num || ' = ' || (dan * num) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- WHILE LOOP => 반복조건과 관련된 변수 
DECLARE
    v_dan NUMBER(2,0) := 2; -- 2 ~ 9 => 반복조건
    v_num NUMBER(2,0) := 1; -- 1 ~ 9 => 반복조건
BEGIN
    WHILE v_dan <= 9 LOOP -- 단
        v_num := 1;
        WHILE v_num <= 9 LOOP -- 곱하는수
            DBMS_OUTPUT.PUT_LINE(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num)  || ' ');
            v_num := v_num + 1;
        END LOOP;
        v_dan := v_dan + 1;
    END LOOP;
END;
/
DECLARE
    v_dan NUMBER(2,0) := 2; -- 2 ~ 9 => 반복조건
    v_num NUMBER(2,0) := 1; -- 1 ~ 9 => 반복조건
BEGIN
    WHILE v_num <= 9 LOOP -- 곱하는수   
        v_dan := 2;
        WHILE v_dan <= 9 LOOP -- 단
            DBMS_OUTPUT.PUT(v_dan || ' * ' || v_num || ' = ' || (v_dan * v_num)  || ' ');
            v_dan := v_dan + 1;            
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        v_num := v_num + 1;
    END LOOP;
END;
/

-- 기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 2;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP -- 단
        v_num := 1;
        LOOP -- 곱하는 수
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
4. 구구단 1~9단까지 출력되도록 하시오.
   (단, 홀수단 출력)
*/

-- FOR LOOP + IF문
BEGIN
    FOR v_dan IN 1..9 LOOP -- 특정 단을 1~9까지 반복하는 LOOP문
        IF MOD(v_dan, 2) <> 0 THEN
            FOR v_num IN 1..9 LOOP -- 특정 단의 1~9까지 곱하는 LOOP문
                DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));  
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/

-- FOR LOOP + IF문
BEGIN
    FOR v_dan IN 1..9 LOOP -- 특정 단을 1~9까지 반복하는 LOOP문
        IF MOD(v_dan, 2) = 0 THEN 
            CONTINUE;
        END IF;
        
        FOR v_num IN 1..9 LOOP -- 특정 단의 1~9까지 곱하는 LOOP문
            DBMS_OUTPUT.PUT_LINE(v_dan || ' X ' || v_num || ' = ' || ( v_dan * v_num ));  
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- 기본 LOOP
DECLARE
    v_dan NUMBER(2,0) := 1;
    v_num NUMBER(2,0) := 1;
BEGIN
    LOOP -- 단
        IF MOD(v_dan, 2) <> 0 THEN
            v_num := 1;
            LOOP -- 곱하는 수
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
    -- 1) 정의
    TYPE emp_record_type IS RECORD
        (empno NUMBER(6,0),
         ename employees.last_name%TYPE,
         sal employees.salary%TYPE := 0);
        
    -- 2) 변수 선언
    v_emp_info emp_record_type;
    v_emp_record emp_record_type;
BEGIN
    
    SELECT employee_id, first_name, salary
    INTO v_emp_info
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.empno);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINe(', 급여 : ' || v_emp_info.sal);
    
    SELECT department_id, job_id, commission_pct
    INTO v_emp_info
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT('사원번호 : ' || v_emp_info.empno);
    DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', 급여 : ' || v_emp_info.sal);
END;
/

-- TABLE
DECLARE
    -- 1) 정의
    TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    -- 2) 변수 선언
    v_num_info num_table_type;
BEGIN
    v_num_info(-1000) := 10000;
    
    DBMS_OUTPUT.PUT_LINE('현재 인덱스 -1000 : ' || v_num_info(-1000));
END;
/

-- 2의 배수 10개를 담는 예제 : 2, 4, 6, 8, 10, 13, 14, ...
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
    
    DBMS_OUTPUT.PUT_LINE('총 갯수 : ' || v_num_ary.COUNT);
    DBMS_OUTPUT.PUT_LINE('누적합 : ' || v_result);
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
    
    DBMS_OUTPUT.PUT_LINE('총 갯수 : ' || v_emps.COUNT);
    DBMS_OUTPUT.PUT_LINE(v_emps(100).last_name);
END;
/


-- 10개의 테이터 출력하기
DECLARE
    v_min employees.employee_id%TYPE; -- 최소 사원번호
    v_max employees.employee_id%TYPE; -- 최대 사원번호
    v_result NUMBER(1,0);             -- 사원의 존재유무를 확인
    v_emp_record employees%ROWTYPE;     -- Employees 테이블의 한 행에 대응
    
    TYPE emp_table_type IS TABLE OF v_emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    v_emp_table emp_table_type;
BEGIN
    -- 최소 사원번호, 최대 사원번호
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    FOR eid IN v_min .. v_max LOOP
        SELECT COUNT(*) -- null 값도 0으로 카운트 함.
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


-- 커서(CURSOR)
DECLARE
    -- 커서를 선언
    CURSOR emp_cursor IS
        SELECT employee_id, last_name
        FROM employees
        WHERE employee_id = 0;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    OPEN emp_cursor;
    
    FETCH emp_cursor INTO v_eid, v_ename;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);    
    
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
        
        -- 실제 연산 진행
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

-- 커서를 사용해 최대 데이터를 확인하는법?
DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, job_id
        FROM employees
        WHERE department_id = &부서번호;
    
    v_emp_info emp_dept_cursor%ROWTYPE;
    
BEGIN
    -- 1) 해당 부서 소속 사원의 정보 출력
    OPEN emp_dept_cursor;
    LOOP
        FETCH emp_dept_cursor INTO v_emp_info;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        
        -- ROWCOUNT 사용 가능한 곳 첫번째(LOOP문 안) : 몇번째 행을 출력하는지 보여줌.
        DBMS_OUTPUT.PUT_LINE('첫번째 : ' || emp_dept_cursor%ROWCOUNT);
        
        DBMS_OUTPUT.PUT(v_emp_info.employee_id || ', ');
        DBMS_OUTPUT.PUT(v_emp_info.last_name || ', ');
        DBMS_OUTPUT.PUT_LINE(v_emp_info.job_id);
    END LOOP;
    
    -- ROWCOUNT 사용 가능한 곳 두번째(LOOP문 종료 후) : 실질적으로 현재 커서의 실제 데이터 총 갯수를 체크함.
    DBMS_OUTPUT.PUT_LINE('두번째 : ' || emp_dept_cursor%ROWCOUNT);
    -- 2) 해당 부서 소속 사원이 없는 경우 '해당부서 소속직원 없음' 메세지 출력.
    IF emp_dept_cursor%ROWCOUNT = 0 THEN    
        DBMS_OUTPUT.PUT_LINE('해당 부서 소속 직원 없음');
    
    END IF;
    
    CLOSE emp_dept_cursor;
END;
/


-- 1) 모든 사원의 사원번호, 이름, 부서이름 출력
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

-- 2) 부서번호가 50이거나 80인 사원들의 사원이름, 급여, 연봉 출력
-- 연봉 : (급여 * 12) + (NVL(급여, 0) * NVL(커미션,0) *12)

-- SQL문
SELECT last_name, salary, commission_pct
FROM employees
WHERE department_id IN (50, 80);

-- PL/SQL문        
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
        DBMS_OUTPUT.PUT(', 사원이름 : ' || v_emp_info.last_name);
        DBMS_OUTPUT.PUT(', 급여 : ' || v_emp_info.salary);
        DBMS_OUTPUT.PUT_LINE(', 연봉 : ' || v_annual);
    END LOOP;
    
    CLOSE emp_dept_cursor;
END;
/