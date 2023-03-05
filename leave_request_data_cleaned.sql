CREATE TABLE IF NOT EXISTS leave_requests
(
	user_id VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	leave_type VARCHAR,
	type VARCHAR,
	dates VARCHAR,
	time_start VARCHAR,
	time_end VARCHAR,
	time_zone VARCHAR,
	status VARCHAR,
	created_at TIMESTAMP
)

SELECT * FROM leave_requests

ALTER TABLE leave_requests
DROP COLUMN first_name,
DROP COLUMN last_name,
DROP COLUMN time_start,
DROP COLUMN time_end,
DROP COLUMN time_zone,
DROP COLUMN created_at

SELECT user_id, type, leave_type, UNNEST(string_to_array(dates, ', '))::date AS date, status
FROM leave_requests

SELECT * FROM leave_requests
WHERE user_id IS NULL OR (status = 'pending' OR status = 'rejected')

DELETE FROM leave_requests
WHERE user_id IS NULL OR (status = 'pending' OR status = 'rejected')

SELECT user_id, type, leave_type, UNNEST(string_to_array(dates, ', '))::date AS dates, status
INTO leave_request2
FROM leave_requests

DROP TABLE leave_requests

ALTER TABLE leave_request2
RENAME TO leave_requests


