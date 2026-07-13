EXPLAIN SELECT * FROM user_simple AS us WHERE us.age = 24;
-- ============================================================ 聚簇索引：索引和行数据在一起 
EXPLAIN SELECT * FROM user_simple AS us WHERE us.id = 1;

SELECT id, _rowid FROM t_primary;
SELECT u_code, _rowid FROM t_unique;
SELECT id, _rowid FROM t_implicit;-- 这个 RowID 是完全封锁在引擎内部的

-- ============================================================ 二级索引：b+ 对应的数据是聚簇索引 name ->id 
-- 这里会发生回表 name-> id -> data b+ tree search twice
EXPLAIN SELECT * FROM user_simple AS us where us.name='Tom'; 

-- ============================================================ 覆盖索引 不会回表 
-- Using index（好现象）： 触发了覆盖索引。说明查询需要的字段全在索引树里，不需要回表（回到主表查其他字段），性能非常好
-- Using where（中性）： 意味着 MySQL 服务器在收到存储引擎返回的数据后，还需要进行一次条件过滤
EXPLAIN SELECT
  id
FROM
  user_simple 
WHERE
  name = 'Tom';
-- ============================================================ 联合索引 
-- ALTER TABLE `test_user` ADD INDEX `idx_age_level_score` (`age`, `level`, `score`);


-- Optimizer 会自己调整顺序
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND `level`= 2 AND `score` = 80;
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND  `score` = 80 AND  `level`= 2;

-- 缺失最左列 不走索引 
EXPLAIN SELECT * FROM `test_user` WHERE  `score` = 80 AND  `level`= 2;

-- ========================部分匹配 

-- key_len = 4 只有age走了索引 
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND  `score` = 80;

-- >, <, BETWEEN, LIKE 'xxx%' 范围查询阻断了 停止匹配 
-- Using index condition 索引下推  key_len = 8 一个int 4个字节  只有age和level生效了 
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND `level` > 2 AND `score` = 80;


-- ============================================================ 索引失效 

-- =====对索引列使用函数
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.hire_date = '2026-07-13';
EXPLAIN SELECT *
FROM user_simple AS us WHERE year(us.hire_date) = '2026';

-- =====对索引列进行计算
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.age+1 = '25';

-- =====隐式类型转换 
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.name = 123
LIMIT 100;
-- 有效
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.name = '123'
LIMIT 100;

-- ===== like %xxx
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.name like '%tom'
LIMIT 100;
EXPLAIN SELECT *
FROM user_simple AS us WHERE us.name like 'tom%'
LIMIT 100;

-- =====  联合索引失效

EXPLAIN SELECT * FROM `test_user` WHERE  `score` = 80 AND  `level`= 2;

-- 部分匹配 
-- key_len = 4 只有age走了索引 
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND  `score` = 80;

-- >, <, BETWEEN, LIKE 'xxx%' 范围查询阻断了 停止匹配 
-- Using index condition 索引下推  key_len = 8 一个int 4个字节  只有age和level生效了 
EXPLAIN SELECT * FROM `test_user` WHERE `age` = 18 AND `level` > 2 AND `score` = 80;


-- =====  or  可以使用 UNION ALL 代替 OR

EXPLAIN SELECT *
FROM test_user AS tu WHERE tu.username = 'test_user_1' or tu.age = '37'
LIMIT 100;

EXPLAIN SELECT *
FROM test_user AS tu WHERE tu.username = 'test_user_1'
UNION ALL 
SELECT *
FROM test_user AS tu WHERE tu.age = '37'


