CREATE TABLE IF NOT EXISTS schedules
(
 	type VARCHAR,
	dates VARCHAR,
	time_start TIME,
	time_end TIME,	
	timezone VARCHAR,	
	time_planned INT,
	break_time INT,
	leave_type VARCHAR,
	user_id VARCHAR
)

SELECT * FROM schedules

SELECT type, UNNEST(string_to_array(dates,', '))::DATE as dates,time_start, time_end,
		timezone, time_planned, break_time, leave_type, user_id
INTO schedules2
FROM schedules

DROP TABLE schedules

SELECT type, dates,time_start, time_end,
		timezone, time_planned, break_time, leave_type, 
		UNNEST(string_to_array(user_id, ',')):: VARCHAR AS user_id
INTO schedules
FROM schedules2

SELECT * FROM schedules

UPDATE schedules
SET user_id = replace(replace(user_id, '{', ''), '}', '')

SELECT type, dates,time_start, time_end,
		timezone, time_planned, break_time, leave_type,user_id, COUNT(*) as count
FROM schedules
GROUP BY type,dates,time_start, time_end,
		timezone, time_planned, break_time, leave_type,user_id
HAVING COUNT(*) > 1

SELECT DISTINCT *
INTO schedules2
FROM schedules

DROP TABLE schedules

ALTER TABLE schedules2
RENAME TO schedules

UPDATE schedules
SET
  time_start = CASE
    WHEN timezone = '+07:00' THEN time_start + interval '1 hour'
    WHEN timezone = '+06:00' THEN time_start + interval '2 hours'
    WHEN timezone = '+04:00' THEN time_start + interval '4 hours'
    WHEN timezone = '+00:00' THEN time_start + interval '8 hours'
    ELSE time_start
  END,
  time_end = CASE
    WHEN timezone = '+07:00' THEN time_end + interval '1 hour'
    WHEN timezone = '+06:00' THEN time_end + interval '2 hours'
    WHEN timezone = '+04:00' THEN time_end + interval '4 hours'
    WHEN timezone = '+00:00' THEN time_end + interval '8 hours'
    ELSE time_end
  END,
  timezone = CASE
    WHEN timezone = '+08:00' THEN '+08:00'
    WHEN timezone = '' THEN NULL
    ELSE '+08:00'
  END
WHERE timezone IN ('+07:00', '+06:00', '+04:00', '+00:00', '+08:00', '')

SELECT * FROM schedules
WHERE type = 'fake'

DELETE FROM schedules
WHERE type = 'fake'

ALTER TABLE schedules
ADD COLUMN day TEXT,
ADD COLUMN day_of_week TEXT,
ADD COLUMN month TEXT,
ADD COLUMN year TEXT

SELECT * FROM schedules

UPDATE schedules
SET day_of_week = INITCAP(TO_CHAR(dates, 'DAY'))

UPDATE schedules
SET month = INITCAP(TO_CHAR(dates, 'MONTH'))

UPDATE schedules
SET year = TO_CHAR(dates, 'YYYY')  

ALTER TABLE schedules
DROP COLUMN day