-- INSERT문
-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리
-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...)]
-- VALUES (값1, 값2...emp_id);
INSERT INTO employees (
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at 
)
VALUES 
(
	'미어캣', '1990-02-23', 'M', NOW(), NULL, NULL, NOW(), NOW()
), 
(
	'미어캣', '2002-05-29', 'F', NOW(), NULL, NULL, NOW(), NOW()
);

SELECT *
FROM employees
ORDER BY emp_id DESC
LIMIT 10; 

INSERT INTO title_emps (
	emp_id,
	title_code,
	start_at,
	end_at,
	created_at,
	updated_at,
	deleted_at
)
SELECT
	MAX(emp_id),
	'T001',
	NOW(),
	NULL,
	NOW(),
	NOW(),
	null
FROM employees
;