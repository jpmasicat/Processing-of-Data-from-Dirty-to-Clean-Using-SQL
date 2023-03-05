CREATE TABLE IF NOT EXISTS users
(
	user_id VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	date_birth DATE,
	date_hire DATE,
	date_leave DATE,
	employment VARCHAR,
	"position" VARCHAR,
	"location" VARCHAR,
	department VARCHAR,
	created_at TIMESTAMP
)

SELECT * FROM users

ALTER TABLE users
DROP COLUMN first_name,
DROP COLUMN last_name,
DROP COLUMN "location"

UPDATE users
SET "position" = (
	CASE "position"
		WHEN 'Dokter' THEN 'Doctor'
		WHEN 'Perawat' THEN 'Nurse'
		WHEN 'Bidan' THEN 'Midwife'
		WHEN 'Asisten Apoteker' THEN 'Pharmacy Assistant'
		WHEN 'Direktur Utama' THEN 'Chief Executive Officer'
		WHEN 'Direktur Pengembangan' THEN 'Development Director'
		WHEN 'IT Spv' THEN 'IT Supervisor'
		WHEN 'Apoteker' THEN 'Pharmacist'
		WHEN 'Admin Bisnis' THEN 'Business Administrator'
	    ELSE "position"
	END
)

UPDATE users
SET position = 'Warehouse Staff'
WHERE department = 'PBF'

UPDATE users
SET position = 'Pharmacist'
WHERE user_id = '146182'

UPDATE users
SET department = 'Support Centre'
WHERE position = 'Business Administrator'

UPDATE users
SET department = 'Medical'
WHERE user_id IN ('125748',
'126082',
'129675',
'132484',
'138225',
'146166',
'157916'
)

ALTER TABLE users
DROP COLUMN employment,
DROP COLUMN created_at
