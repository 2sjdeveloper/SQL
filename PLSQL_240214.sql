SET SERVEROUTPUT ON

DECLARE
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := .1;
BEGIN
    SELECT department_id
      INTO v_deptno
      FROM employees
     WHERE employee_id = &사원번호;
     
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
        DBMS_OUTPUT.PUT_LINE('삭제 실패');    
    END IF;

END;
/




--1. 사원번호를 입력(치환변수사용&) 할 경우 사원번호, 사원이름, 부서이름을 출력하는 pl/sql을 작성하시오.

--문제푸는 순서
-- 1) SQL문 작성
SELECT employee_id, last_name, department_name 
FROM employees JOIN departments
  ON employees.department_id = departments.department_id
WHERE employee_id = 100;

-- 2) PL/SQL블록 작성     
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_deptname departments.department_name%TYPE;
BEGIN
    SELECT employee_id, last_name, department_name 
      INTO v_eid, v_ename, v_deptname
      FROM employees JOIN departments
        ON employees.department_id = departments.department_id
     WHERE employee_id = &사원번호;
     
     DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
     DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
     DBMS_OUTPUT.PUT_LINE('부서이름 : ' || v_deptname);
END;
/

-- PL/SQL의 경우 가능한 방법) 두개의 
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_deptname departments.department_name%TYPE;
    v_deptid departments.department_id%TYPE;
BEGIN
    SELECT employee_id, first_name, department_id
      INTO v_empid, v_ename, v_deptid
      FROM employees
     WHERE employee_id = &사원번호;
     
     SELECT department_id
       INTO v_deptid
       FROM departments
      WHERE department_id = v_deptid;
     
     DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
     DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
     DBMS_OUTPUT.PUT_LINE('부서이름 : ' || v_deptname);
END;
/


--2. 사원번호를 입력(치환변수사용&)할 경우 사원이름, 급여, 연봉->(급여*12+(nvl(급여,0)*nvl(커미션퍼센트,0)*12)을 출력하는 pl/sql을 작성하시오.
--1) sql문
SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual
FROM employees
WHERE employee_id = 100;

--2) PL/SQL 블록
DECLARE
    v_ename employees.last_name%TYPE;
    v_sal employees.salary%TYPE;
    v_annual v_sal%TYPE;
BEGIN
    SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual
    INTO v_ename, v_sal, v_annual
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || v_annual);
END;
/

-- PL/SQL의 경우 가능한 방법) 별도연산
DECLARE
    v_ename  employees.last_name%TYPE;
    v_sal    employees.salary%TYPE;
    v_comm   employees.commission_pct%TYPE;
    v_annual v_sal%TYPE;    
BEGIN
    SELECT last_name, salary, commission_pct
      INTO v_ename, v_sal, v_comm
      FROM employees
     WHERE employee_id = &사원번호;
    
    v_annual := (v_sal*12+(NVL(v_sal,0)*NVL(v_comm,0)*12));
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || v_annual);
END;
/


CREATE TABLE test_employees
AS
    SELECT *
    FROM employees;
    
SELECT *
FROM test_employees;


--기본 if문

BEGIN
    DELETE FROM test_employees
    WHERE employee_id=&사원번호;
    
    IF SQL %ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('삭제실패');
        DBMS_OUTPUT.PUT_LINE('사원번호확인');
    END IF;
END;
/

-- IF ~ ELSE 문 : 하나의 조건식, 결과는 참과 거짓 각각

DECLARE
    v_result NUMBER(4,0);
BEGIN
    SELECT COUNT(employee_id) -- COUNT : 그룹함수 중에 유일하게 널에 대응 가능?
/*
위의 SQL 쿼리에서 사용된 COUNT() 함수는 그룹 함수 중 하나입니다. 이 함수는 지정된 열의 행 수를 세는 데 사용됩니다. 주어진 조건에 해당하는 특정 열의 값이 몇 개인지를 반환합니다.
이 함수는 일반적으로 널 값이 아닌 행의 수를 세지만, 중요한 점은 테이블의 특정 열에 대해 COUNT() 함수를 사용할 때 NULL 값이 포함되지 않는다는 것입니다. 즉, 특정 열에 NULL 값이 포함된 행은 COUNT 함수에 의해 세어지지 않습니다.
따라서 COUNT() 함수는 주어진 조건에 해당하는 행의 수를 세되, 해당 열의 값이 NULL인 행은 무시하게 됩니다.
*/
    INTO v_result
    FROM employees
    WHERE manager_id = &사원번호;
    
    IF v_result = 0 THEN
        DBMS_OUTPUT.PUT_LINE('일반사원');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('팀장');    
    END IF;
END;
/

SELECT employee_id
FROM employees
WHERE manager_id = 100;


-- IF ~ ELSIF ~ ELSE 문 : 다중 조건식이 필요, 각각 결과처리가 필요
-- 연차를 구하는 공식 : TRUNC 활용
SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12,0)
FROM employees;

DECLARE
    v_hyear NUMBER(2,0);
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12,0)
    INTO v_hyear
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF v_hyear < 5 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 미만');    
    ELSIF v_hyear < 10 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 5년 이상 10년 미만');
    ELSIF v_hyear < 15 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 10년 이상 15년 미만');
    ELSIF v_hyear < 20 THEN
        DBMS_OUTPUT.PUT_LINE('입사한 지 15년 이상 20년 미만');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('입사한 지 20년 이상');    
    END IF;
END;
/

/*
3-1. 
사원번호를 입력(치환변수사용&)할 경우 입사일이 2015년 이후 (2015년 포함)이면 'New employee' 출력
2015년 이전이면 'Career employee' 출력
*/
-- 1)SQL문
SELECT TO_CHAR(hire_date, 'yyyy')
FROM employees
WHERE hire_date >= TO_DATE('2015-01-01', 'YYYY-MM-DD');


DECLARE
    v_hdate employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &사원번호;
    
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
사원번호를 입력(치환변수사용&)할 경우 입사일이 2015년 이후 (2015년 포함)이면 'New employee' 출력
2015년 이전이면 'Career employee' 출력
단, DBMS_OUTPUT.PUT_LINE ~ 은 한번만 사용.
*/

DECLARE
    v_hdate employees.hire_date%TYPE;
    v_msg VARCHAR2(1000) := 'Career employee';
BEGIN
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &사원번호;

    IF TO_CHAR(v_hdate, 'yyyy') >= '2015' THEN
        v_msg := 'New employee';
    ELSE
        v_msg := 'Career employee';
    END IF;    
END;
/


/*
4.
급여가 5000 이하면 급여 20% 인상
급여가 10000 이하면 급여 15% 인상
급여가 15000 이하면 급여 10% 인상
급여가 15001 이상이면 급여 인상 없음.

사원번호를 입력(치환변수)하면
사원이름, 급여, 인상된 급여가 출력되도록 PL/SQL 블록을 생성하시오.
*/

-- 1) SQL문
SELECT last_name, salary
FROM employees
WHERE employee_id = &사원번호;

-- 2) PL/SQL문
DECLARE
    v_ename employees.last_name%TYPE;  
    v_salary employees.salary%TYPE;  
    v_raise NUMBER(10,1);
    v_result v_salary%TYPE;
    
BEGIN
    SELECT last_name, salary
    INTO v_ename, v_salary
    FROM employees
    WHERE employee_id = &사원번호;
    
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
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('인상된  : ' || v_result);
END;
/


-- 기본 LOOP문
DECLARE
    v_num NUMBER(38) := 0;
BEGIN
    LOOP
        v_num := v_num +1;
        DBMS_OUTPUT.PUT_LINE(v_num);
        EXIT WHEN v_num > 10; -- 종료조건
    END LOOP;
END;
/


-- WHILE LOOP문
DECLARE
    v_num NUMBER(38,0) := 1;
BEGIN
    WHILE v_num < 5 LOOP -- 반복조건
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_num := v_num + 1;
    END LOOP;
END;
/

-- 예제 : 1에서 10까지 정수값의 합을 구하시오.
-- 1) 기본 LOOP
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
        IF MOD(idx,2) <> 0 THEN -- <>는 !=와 의미가 같음.
            DBMS_OUTPUT.PUT_LINE(idx);    
        END IF;
    END LOOP;
END;
/

-- 주의사항 1) (내림차순 출력)

BEGIN
    FOR idx IN REVERSE -10 .. 5 LOOP 
        IF MOD(idx,2) <> 0 THEN -- <>는 !=와 의미가 같음.
            DBMS_OUTPUT.PUT_LINE(idx);    
        END IF;
    END LOOP;
END;
/

-- 주의사항 2) 카운터(counter)는 변경 불가
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

-- 예제 : 1에서 10까지 정수값의 합을 구하시오.
-- 3) FOR LOOP
DECLARE
    -- 정수값 : 1~10 => FOR LOOP의 카운터로 처리
    -- 합계
    v_total NUMBER(2, 0) := 0;
BEGIN
    FOR num IN 1 .. 10 LOOP
        v_total := v_total + num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_total);
END;
/

/*
1. 다음과 같이 출력되도록 하시오. (기본, FOR, WHILE LOOP 세개로 작성)
*
**
***
****
*****

*/

--1) 기본 루프
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