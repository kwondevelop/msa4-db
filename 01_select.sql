-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
SELECT 
	`name`
	, gender
	, emp_id
FROM employees;

-- 테이블 전체 컬럼 조회 : *(Asterisk)
SELECT *
FROM employees;

-- WHERE 절 : 특정 컬럼의 값이 일치한 데이터만 조회
SELECT *
FROM employees
WHERE emp_id = 10009;

SELECT *
FROM employees
WHERE `name` = '권민재';

SELECT *
FROM employees
WHERE birth >= '1990-01-01';

SELECT *
FROM employees
WHERE fire_at IS NULL;

SELECT *
FROM employees
WHERE fire_at IS NOT NULL;


-- 출생년도가 1990년인 사람만 조회해봐라
SELECT *
FROM employees
WHERE
		birth >= '1990-01-01'
AND	birth <= '1990-12-31'

-- 이름이 '조은혜' 또는 '정유리'인 사람을 찾아라
SELECT *
FROM employees
WHERE
	`name` = '조은혜'
OR `name` = '정유리'
;

-- 1990년 출생이거나, 이름이 '정유리'인 사람을 찾아라
-- 그냥 AND만 들어가면 조건이 3개가 되어버려서
-- 소괄호를 사용하여 AND 부분을 하나로 묶어줌
SELECT *
FROM employees
WHERE
(
		birth >= '1990-01-01'
AND 	birth <= '1990-12-31'
)
and `name` = '정유리'
;

-- BETWEEN을 사용하여 문장 길이를 줄일 수 있음
SELECT *
FROM employees
WHERE
-- 예시 : BETWEEN A AND B
birth BETWEEN '1990-01-01' AND '1990-12-31' ;

-- 사원 번호가 10005, 10010인 사람
SELECT *
FROM employees
WHERE 
emp_id = 10005 OR emp_id = 10010 
;

-- {♥} ?

-- 또는 (IN 연산자 사용)
SELECT *
FROM employees
WHERE
emp_id IN (10005, 10010) ;

-- LIKE 절 :
-- 문자열의 내용을 조회
-- % :
-- 글자 수와 상관 없이 조회할 경우 사용
SELECT *
FROM employees
WHERE
`name` LIKE '%우'
;

-- _(언더 바) :
-- 언더 바의 개수만큼 글자 수를 허용해서 조회
SELECT *
FROM employees
WHERE
NAME LIKE '권__'
;

-- ORDER BY 절 :
-- 데이터를 정렬
-- ASC : 오름차순
-- DESC : 내림차순
SELECT *
FROM employees
ORDER BY `name`, birth DESC
;

-- LIMIT 키워드, OFFSET 키워드
-- 출력 개수를 제한
-- 사번 오름차순으로 정렬된 상위 10명을 조회하라
SELECT *
FROM employees
ORDER BY emp_id
LIMIT 10
;

-- emp_id 21번째부터 10명을 조회
SELECT *
FROM employees
ORDER BY emp_id
-- LIMIT 10 OFFSET 20 => 이걸 쓰는게 안전
LIMIT 20, 10 -- MySQL 문법
;

-- 집계 함수
-- SUM(컬럼) : 해당 컬럼의 합계를 출력
-- MAX(컬럼) : 해당 컬럼의 값 중 최대 값을 출력
-- MIN(컬럼) : 해당 컬럼의 값 중 최소 값을 출력
-- AVG(컬럼) : 해당 컬럼의 평균을 출력
SELECT 
	SUM(salary) -- sum_sal
	MAX(salary) -- max_sal
	MIN(salary) -- min_sal
	AVG(salary) -- avg_sal
FROM salaries
-- WHERE
-- 	end_at IS null
;

-- COUNT(컬럼 || *) : 검색 결과의 레코드 수를 출력
-- * : 총 레코드 수를 반환
-- 컬럼명 : 
--	조회 결과 중, 해당 컬럼의 값이 
-- NULL이 아닌 레코드의 총 수를 출력
SELECT
	COUNT(*)
FROM employees
;

-- 현재 받고 있는 급여 중
-- 가장 많이 받는 급여, 가장 적게 받는 급여를 출력
SELECT
	MAX(salary),
	MIN(salary)
FROM salaries
WHERE 
end_at IS NOT NULL
;

-- DISTINCT 키워드 :
-- 조회 결과에서 중복되는 레코드 없이 조회
SELECT DISTINCT
emp_id
FROM salaries
;

-- GROUP BY 절, HAVING 절
-- 그룹으로 묶어서 조회
-- 직책별 사원 수
SELECT
-- SELECT 절에 작성하는 컬럼은
-- GROUP BY 절에서 사용한 컬럼과
-- 집계 합수만 작성(표준 문법)
	title_code
	, COUNT(*) AS cnt
FROM title_emps
WHERE
	end_at IS null
GROUP BY title_code
;

-- 직책 코드에 `02`가 포함된 직책별 사원 수
SELECT
	title_code
	,COUNT(*)
FROM title_emps
WHERE
	end_at IS NULL 
GROUP BY title_code
HAVING title_code LIKE '%02'
;

-- 직책별 사원 수 중, 10000명 이상인 직책의 사원 수 출력
SELECT
	title_code
	,COUNT(*) AS cnt
FROM title_emps
WHERE
	end_at IS NULL 
GROUP BY title_code
HAVING cnt > 10000
;