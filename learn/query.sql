SELECT COUNT(*)
FROM test_user AS tu;


ALTER TABLE test_user ADD INDEX idx_username (username);
ALTER TABLE test_user DROP INDEX idx_username;

SELECT *
FROM test_user AS tu WHERE tu.username = ''
LIMIT 100;

DELETE FROM test_user AS tu;

truncate test_user;


