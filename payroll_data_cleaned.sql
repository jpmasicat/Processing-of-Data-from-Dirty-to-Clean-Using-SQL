CREATE TABLE IF NOT EXISTS payroll
(
	user_id	 VARCHAR,
	first_name  VARCHAR	,
	last_name  VARCHAR,	
	date_start  DATE,	
	date_end DATE,	
	ctc	NUMERIC,
	net_pay	NUMERIC,
	gross_pay	NUMERIC,
	data_salary_basic_rate VARCHAR,
	data_salary_basic_type VARCHAR,
	currency  VARCHAR,	
	status	 VARCHAR,
	created_at  TIMESTAMP
)
SELECT * FROM payroll

ALTER TABLE payroll
DROP COLUMN first_name,
DROP COLUMN last_name,
DROP COLUMN ctc,
DROP COLUMN gross_pay,
DROP COLUMN currency,
DROP COLUMN created_at
