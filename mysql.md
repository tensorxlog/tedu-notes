# 数据库操作

显示所有数据库：
`show databases`

切换至某个数据库：
`use <database>`

创建数据库:
`
create [or replace] {database | schema} [if not exists] <database-name> [create-specifications]
`
```
create-specification:  

[default] character set [=] <character-set> 
[default] collate [=] <collation-name> 
comment [=] 'comment'
```

删除数据库:
`drop {database | schema} [if exisits] <database-name>`

# 表格操作 

查看所有的表：
`show tables`

创建表格：
```sql
create table <table> 
(
  字段名1 字段类型 [字段约束] [注释],
  字段名2 字段类型 [字段约束] [注释],

  primary key (<col1>),

  index <index1> (<col2>),
  unique index <index2> (<col3>)


);
```

删除表格：
`drop table <table>`

修改表格:
`alter table <table> {alter-specifications}`

alter-specifications:
- `add <col> [after <col>]` 
- `drop <col>`
- `change <col-old> <col-new> <datatype>`
- `add <line>` (其中`<line>`跟`create table`中可以写的行一样)

修改表的名称：
`rename table <old-name> <new-name>`

# NoName

查询字段：
`select <col1>, <col2>, ... from <table>`

向表中插入数据：
`insert into <table>(<col1>, <col2>, ...) values(<val11>, <val12>, ...), (val21, val22, ...)`

更新数据：
`update <table> set <col1> = <val1>, <col2> = <val2>, ... [where <condition>]`

删除数据：
`delete from <table> [where <condition>]`

创建外键：
```
[CONSTRAINT <外键名>] FOREIGN KEY 字段名 [，字段名2，…]
REFERENCES <主表名> 主键列1 [，主键列2，…]
```

查看系统信息：
`select version()` (查看数据库版本)
`select now()` (查看系统时间)
`select user()` (查看当前用户)

# select

```sql
<select>
<from>
<join>
<where>
<group by>
<having>
<order by>
<limit>
```

## join关键字

`<table1> join <table2> on <condition>`

## where关键字

`where <condition1> and <condition2>`
`where <col> = <val>`
`where <col> >= <val>`
`where <col> != <val>`
`where <col> in (<val1>, <val2>, ...)` (在固定多个值之中)
`where <col> between <val1> and <val2>`
`where <col> like <wildcard>`

## group by关键字

`group by <col>`
按指定列进行分组，以对每组使用聚合函数进行某些操作。和`partition by`不同，`group by`最后每组只显示一条记录。

## having关键字

`having <condition>`
接在`group by`之后对分组后的结果进行额外的筛选。

## order by关键字

`order by <col1> [asc|desc], <col2> [asc|desc], ...`

## limit关键字:

`limit [<offset>,] <row-count>`
`limit <row-count> offset <offset>`

limit子句底层执行原理是先取出`offset + row_count`条记录,然后再将offset前面的记录扔掉，这里会存在一个性能问题(网上称之为深度分页问题),后续我们学了嵌套查询,多表关联查询时再解决这个问题.

# union关键字

`<select-sub1> union <select-sub2>`

# 常用函数

显示包含内置函数的表格(该表格似乎没有包含`sum`, `avg`之类的聚合函数，就只有一条"Aggregate Functions as Window Functions"):
```sql
use mysql;

SELECT help_category.name as category, help_topic.name as function_name 
FROM help_topic JOIN help_category 
    ON help_category.help_category_id = help_topic.help_category_id 
WHERE help_category.help_category_id IN (
    SELECT help_category_id FROM help_category 
    WHERE parent_category_id=37
) ORDER BY 2;
```

## 不依赖于任何行的函数

- `now()`
- `current_timestamp()`

## 标量函数(依赖于单行)

- `lower(<col>)`: 将字母转为小写
- `substr(<col>, <begin-index>)`: 获取字符子串
- `concat(<col1>|<str1>, <col2>|<str2>, ...)`
- `round(<col>[, <num>])`: 四舍五入，保留至`<num>`位小数
- `floor(<col>)`: 向下取整
- `ceiling(<col>)`: 向上取整
- `year(<col>)`:


## 聚合函数(依赖于多行且返回单个值)

- `min(<col>)`: 求最小值
- `max(<col>)`: 求最大值
- `sum(<col>)`: 求和
- `avg(<col>)`: 求平均值
- `count(<col>)`: 统计非null行数

## 窗口函数(依赖于多行且为每行单独返回一个值)

- `rank() over (partition by <col1> order by <col2>[ desc])`:
- `dense_rank() over (partition by <col1> order by <col2>[ desc])`:
- `row_number() over (partition by <col1> order by <col2>[ desc])`:

示例：
有一个员工表dept_emp简况如下:
emp_no dept_no from_date to_date
10001	d001 1986-06-26	9999-01-01
10002	d001 1996-08-03	9999-01-01
10003	d002 1996-08-03	9999-01-01

有一个薪水表salaries简况如下:
emp_no salary from_date to_date
10001 88958	2002-06-22 9999-01-01
10002 72527	2001-08-02 9999-01-01
10003 92527	2001-08-02	9999-01-01

获取每个部门中当前员工薪水最高的相关信息，给出dept_no, emp_no以及其对应的salary，按照部门编号dept_no升序排列，以上例子输出如下:
dept_no emp_no maxSalary
d001	10001 88958
d002	10003 92527

解答：
```sql
select dept_no, emp_no, salary as maxSalary from (
select dept_no, e.emp_no, salary, dense_rank() over (partition by dept_no order by salary desc) as ranking
from dept_emp e join salaries s
on e.emp_no = s.emp_no
) as t
where ranking = 1
order by dept_no
```

如何删除某个字段重复的记录?

命名窗口:
```sql
select <window-function> over <window-name> from <table>
window <window-name> as (partition by <col1> order by <col2>[ desc])
```

## 控制流函数

- `ifnull(<expr1>, <expr2>)`: 如果`<expr1>`的结果不为null，则返回它的值，否则返回`<expr2>`的值。
- `if(<condition>, <expr1>, <expr2>)`: 如果`<condition>`成立，则返回`<expr1>`，否则返回`<expr2>`。
- case语句:
```sql
case when <condition1> then
    <expr1>
when <condition2> then
    <expr2>
...
else
    <exprn>
end
```

# 多表关联查询

内联(只显示双方都有的记录):
`<table1> [inner ]join <table2> on <condition>`

左外联(左边表格的记录都显示，右边表格不满足条件的记录显示为null):
`<table1> left [outer ]join <table2> on <condition>`
右外联(右边表格的记录都显示，左边表格不满足条件的记录显示为null):
`<table1> right [outer ]join <table2> on <condition>`

# 嵌套查询

子查询可接在以下关键字之后:
- select
- from
- where
- having
- ...

# View (视图)

视图是某条查询语句所对应的虚拟表，它本身只存储由查询语句所确定的表结构，而不存储数据，只有在调用视图进行查询时才会从真实的表中实时请求数据。视图可以像普通表格一样被调用。

视图的作用:
- 在复杂查询中简化SQL语句的编写
- 对外不直接暴露表的操作,提高表的安全性

创建视图:
`create view <view-name> as <query-statement>`

删除视图:
`drop view <view-name>`



# NoName

查看创建语句：

```sql
show create database <db-name>
show create table <table>
```

查看数据库支持的字符集:
`show character set like '%utf8%'`

查看表所包含的索引：
`show index from <table>`
创建表时添加索引:
```sql
create table <table> (
    ......
    index <index-name> (<col>);
);
```
修改表时添加索引：
`alter table <table> add index <index> (<col>)`
修改表时去掉索引：
`alter table <table> drop index <index>`
`drop index <index> on <table>`

查看当前事务提交模式：
`show variables like '%autocommit%';`

设置事务提交模式为手动：
`set autocommit=0;`
设置事务提交模式为自动：
`set autocommit=1;`

手动提交事务的语法：
```sql
set autocommit=0;
begin [transaction];
<statements1>
savepoint p;
<statements2>
rollback to p;
<statements3>
rollback;
commit;
```

查询当前会话中事务的隔离级别：
`select @@tx_isolation;`
隔离级别设置为提交读：
`set tx_isolation='read-committed'`


