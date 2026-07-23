CREATE TABLE user_simple (
  id bigint PRIMARY KEY,
  name varchar(20),
  age int,
  hire_date DATE
);

create index idx_name on user_simple(name);
create index idx_age on user_simple(age);
create index idx_hire_date on user_simple(hire_date);

INSERT INTO user_simple (id, name, age,hire_date) VALUES 
(1, '张伟', 28,'2026-07-11'),
(2, '王芳', 32,'2026-07-13'),
(3, '李娜', 24,'2026-07-13'),
(4, '刘洋', 19,'2026-07-13'),
(5, '陈静', 45,'2026-07-13');


CREATE TABLE `test_user` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    `age` INT DEFAULT NULL COMMENT '年龄',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 表 1：有显式主键 (Clustered Key = id)
CREATE TABLE t_primary (
    id INT PRIMARY KEY,
    name VARCHAR(10)
) ENGINE=InnoDB;

-- 表 2：无主键，但有 UNIQUE NOT NULL (Clustered Key = u_code)
CREATE TABLE t_unique (
    id INT,
    u_code INT NOT NULL,
    name VARCHAR(10),
    UNIQUE KEY idx_ucode (u_code)
) ENGINE=InnoDB;

-- 表 3：既无主键，也无唯一索引 (Clustered Key = 隐式 RowID)
CREATE TABLE t_implicit (
    id INT,
    name VARCHAR(10)
) ENGINE=InnoDB;
