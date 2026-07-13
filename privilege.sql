select * from system_users;

select * from system_user_role;

INSERT INTO ruoyi.system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 1, 2, '1', '2022-05-12 20:39:29', '1', '2022-05-12 20:39:29', false, 1);


select * from system_role;

select * from system_role_menu where role_id = '1';

select * from system_menu;