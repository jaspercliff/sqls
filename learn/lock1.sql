BEGIN;

-- 2
UPDATE test_user SET username = 'test_users_1' WHERE id = 2;
-- 4
UPDATE test_user SET username = 'test_users_2' WHERE id = 1;

COMMIT;