-- 查看 MySQL 服务器的系统配置参数（系统变量）
SHOW VARIABLES;
-- 像 MySQL、Oracle 这样的数据库管理系统，为了进一步减少磁盘 I/O 次数并优化内存管理（Buffer Pool），会在操作系统之上再抽象出一层“页（Page）”。
-- MySQL InnoDB： 默认的页大小是 16 KB（相当于 4 个 OS 块）。
-- getconf PAGESIZE 看os page size 
SHOW session VARIABLES LIKE 'innodb_page_size'; -- 会话
SHOW global VARIABLES LIKE 'innodb_page_size'; -- 全局 服务器 

SHOW VARIABLES LIKE 'max_connections';

-- slow_query_log slow_query_log_file
SHOW VARIABLES LIKE 'slow_query_%';

--  慢查询阈值
SHOW VARIABLES LIKE 'long_query_time';

-- 所有的死锁历史都会被记录在 mysqld.log 里
SHOW VARIABLES LIKE 'innodb_print_all_deadlocks';
