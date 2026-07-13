# 用来查看 MySQL 服务器的实时运行状态（计数器和统计信息） 的
SHOW GLOBAL STATUS;
SHOW GLOBAL STATUS LIKE 'Threads_connected';

-- 看到当前 MySQL 数据库中所有正在执行的线程
SHOW FULL PROCESSLIST;

-- 当前有哪些事务正在运行、它们是什么时候开始的、执行的 SQL 是什么、这个事务有没有在等别人释放锁（trx_state = 'LOCK WAIT'）
SELECT * FROM information_schema.INNODB_TRX;

SELECT * FROM information_schema.INNODB_LOCKS;


SHOW ENGINE INNODB STATUS;


-- 测试mysql 慢查询日志
SELECT SLEEP(5);