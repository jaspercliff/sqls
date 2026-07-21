-- InnoDB 内部有死锁检测机制（Deadlock Protection），一旦发现死锁，它会选择受影响最小的那个事务进行强制回滚，从而解开死锁
SELECT version();
-- 记录了当前 InnoDB 引擎中“正在活着”的所有事务信息 mariadb 任然是这张表
SELECT *
FROM information_schema.innodb_lock_waits;

-- mysql 8.0+ 代替了innodb_lock_waits 
SELECT *
FROM performance_schema.data_lock_waits
LIMIT 100;


-- ============== 排查死锁

SELECT 
    r.trx_id AS waiting_trx_id,
    r.trx_mysql_thread_id AS waiting_thread,
    r.trx_query AS waiting_query,
    b.trx_id AS blocking_trx_id,
    b.trx_mysql_thread_id AS blocking_thread,
    b.trx_query AS blocking_query,
    b.trx_rows_modified as '修改了多少行数据'
FROM       information_schema.innodb_lock_waits w
INNER JOIN information_schema.innodb_trx r ON w.requesting_trx_id = r.trx_id
INNER JOIN information_schema.innodb_trx b ON w.blocking_trx_id = b.trx_id;

kill 16; 

-- mysql 8.0
SELECT 
    r.trx_id AS '被卡住的事务ID',
    r.trx_mysql_thread_id AS '被卡住的线程ID(受害者)',
    r.trx_query AS '被卡住的SQL',
    b.trx_id AS '拿着锁的事务ID',
    b.trx_mysql_thread_id AS '拿着锁的线程ID(真凶)',
    b.trx_query AS '真凶当前执行的SQL'
FROM performance_schema.data_lock_waits w
INNER JOIN information_schema.innodb_trx r ON w.requesting_engine_transaction_id = r.trx_id
INNER JOIN information_schema.innodb_trx b ON w.blocking_engine_transaction_id = b.trx_id;

-- =================== 

SELECT 
    OBJECT_SCHEMA AS db,
    OBJECT_NAME AS table_name,
    INDEX_NAME,
    LOCK_TYPE,
    LOCK_MODE,  -- 重点看这里，会显示 GAP, REC_NOT_GAP, X, S 等
    LOCK_STATUS, -- GRANTED(已获得) 或 WAITING(等待中)
    ENGINE_TRANSACTION_ID AS trx_id
FROM performance_schema.data_locks;