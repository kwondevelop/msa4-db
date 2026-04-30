-- 뷰 생성하기

CREATE VIEW view_avg_salary_by_dept
AS 

-- 부서별 현재 연봉 평균 구해
-- 부서명(한글), 평균 연봉 출력

	SELECT
		dep.dept_name,
		AVG(sal.salary)
	FROM departments dep
		JOIN department_emps dee
			ON dep.dept_code = dee.dept_code
				AND dep.end_at IS NULL	
				AND dee.end_at IS NULL	
		JOIN employees emp
			ON dee.emp_id = emp.emp_id
				AND emp.fire_at IS NULL	
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
				AND sal.end_at IS NULL 
	GROUP BY dep.dept_name
	ORDER BY dep.dept_name
	;

-- 뷰 조회하기
SELECT *
FROM view_avg_salary_by_dept
WHERE 
	avg_salary >= 44000000
;

-- VIEW 삭제하기
DROP VIEW view_avg_salary_by_dept
;