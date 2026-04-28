-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.

SELECT
	emp.emp_id,
	emp.`name`,
	tie.title_code
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND tie.end_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.

SELECT
	emp.emp_id,
	emp.gender,
	sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL	
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.

SELECT
	emp.`name`,
	sal.salary,
	sal.start_at,
	sal.end_at
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE emp.emp_id = '10010'		
ORDER BY sal.start_at
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.

SELECT
	emp.emp_id,
	emp.`name`,
	dep.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL
	JOIN departments dep
		ON dee.dept_code = dep.dept_code
			AND dep.end_at IS NULL
	WHERE emp.fire_at IS NULL -- 필터링해서 쿼리 처리 시간 줄이기
	ORDER BY emp.emp_id       -- 순서대로 정렬
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.

SELECT
	emp.emp_id,
	emp.`name`,
	sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL 
ORDER BY salary DESC 
LIMIT 10 
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.

SELECT
	des.dept_name,
   emp.`name`,
   emp.hire_at
FROM departments des
	JOIN department_managers dem
		ON des.dept_code = dem.dept_code
			AND dem.end_at IS NULL
	JOIN employees emp
    	ON dem.emp_id = emp.emp_id
			AND des.end_at IS NULL
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.

SELECT
	AVG(sal.salary)
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND tie.end_at IS NULL	
	JOIN titles tit
		ON tie.title_code = tit.title_code
			WHERE tit.title = '부장'
				AND sal.end_at IS NULL
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균



-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.

SELECT
    emp.`name`,
    emp.hire_at,
    emp.emp_id,
    dem.dept_code
FROM employees emp
	JOIN department_managers dem
   	ON emp.emp_id = dem.emp_id;
	JOIN departments des
		ON dem.dept_code = des.dept_code
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 
--    평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.

SELECT
	tis.title,
	FLOOR(AVG(sal.salary))
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
	JOIN title_emps tie
		ON sal.emp_id = tie.emp_id
			AND tie.end_at IS NULL
	JOIN titles tis
		ON tie.title_code = tis.title_code
	GROUP BY tie.title_code, tis.title
	HAVING AVG(sal.salary) >= 60000000
	ORDER BY AVG(sal.salary) DESC
;	

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.

SELECT 
	emp.gender,
	tis.title,
	count(tis.title)
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
	JOIN titles tis
		ON tie.title_code = tis.title_code
	WHERE emp.gender = 'F'
	GROUP BY tis.title
;