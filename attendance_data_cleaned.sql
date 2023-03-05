CREATE TABLE IF NOT EXISTS attendance
(
	user_id  VARCHAR,
	first_name  VARCHAR,
	last_name  VARCHAR,
	location VARCHAR,
	date DATE,
	time TIME,
	timezone VARCHAR,
	"case" VARCHAR,
	source  VARCHAR
)

SELECT * FROM attendance

--DROP null columns--

ALTER TABLE attendance
DROP COLUMN first_name,
DROP COLUMN last_name
--DROP Column that is not needed--
ALTER TABLE attendance
DROP COLUMN location

ALTER TABLE attendance
DROP COLUMN source

SELECT user_id, date, time, timezone, "case", COUNT(*) as attendance_count
FROM attendance
GROUP BY user_id, date, time, timezone, "case"
HAVING COUNT(*) > 1

SELECT DISTINCT *
INTO attendance2
FROM attendance

DROP TABLE attendance

SELECT * FROM attendance2

ALTER TABLE attendance2
RENAME TO attendance

SELECT * FROM attendance