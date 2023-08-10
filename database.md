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
  字段名2 字段类型 [字段约束] [注释]
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

# where关键字
`where <condition1> and <condition2>`
`where <col> = <val>`
`where <col> >= <val>`
`where <col> != <val>`
`where <col> in (<val1>, <val2>, ...)` (在固定多个值之中)
`where <col> between <val1> and <val2>`
`where <col> like <wildcard>`

# union关键字
`<select-sub1> union <select-sub2>`

# order by关键字
`order by <col1> [desc], <col2> [desc], ...`


查看创建语句：

```sql
show create database <db-name>
show create table <table>
```

查看数据库支持的字符集:
`show character set like '%utf8%'`

