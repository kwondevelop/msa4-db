-- -----------
-- Transaction
-- -----------

-- Transaction 시작
START TRANSACTION;

INSERT INTO employees (
	`name`,
	birth,
	gender,
	hire_at
)

VALUES (
	'조은혜',
	'1900-01-01',
	'F',
	NOW()
)
;

COMMIT;