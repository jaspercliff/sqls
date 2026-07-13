-- InnoDB 内部有死锁检测机制（Deadlock Protection），一旦发现死锁，它会选择受影响最小的那个事务进行强制回滚，从而解开死锁

BEGIN;
-- 1
UPDATE test_user SET username = 'test_users_1' WHERE id = 1;
-- 3
UPDATE test_user SET username = 'test_users_2' WHERE id = 2;

COMMIT;


SELECT *
FROM test_user AS tu WHERE tu.id = '1'
LIMIT 100;

SHOW ENGINE INNODB STATUS;
