---
猎才MySQL文档URL：
https://yscp0bp3g6.feishu.cn/docx/Dv0kdkOmdofUhDx53VNch8mpnHg
https://it38nc4nte.feishu.cn/docx/SbB1dOAaJofDS2xHPPMcmyEWnEc
https://gitee.com/houyworking/mysqlproject/tree/master

Spring:
https://gitee.com/houyworking/JSD2306spring6

MySQL:
undo log, redo log, bin log
MVCC
SQL: union / union all


SSM teacher:
https://gitee.com/teduwang/jsd2306-ssm-teacher
截图软件：
Snipaste

https://gitee.com/IvanLiuGB/jsd-06-weibo.git

---
lie-cai code temp:

`nio/Demo01.java`

GY:
遍历SelectionKey，根据事件类型来进行相应的操作(ACCEPT, WRITE, READ操作)

DT:
使用Selector来选出准备好的channels，将它们交给GY方法来处理


---
jdk1.8之后arraylist初始容量变为0，第一次添加才增加到10

"./"表示项目的根目录

类加载路径（classpath）是以当前类（class文件）为依据，定位的是当前类所在包的最上级包的上一级路径。

Maven项目中的src/main下有两个路径：java和resources，前者保存所有包和java文件，后者保存其他文件。在编译后java和resources下的文件会合并保存到target/classes路径下。


---
使用asList将数组转为List时，对该List元素进行操作其实就是对于原数组进行操作。因此不能对该List添加元素，不然会报"UnsupportedOperationException"。

其实这样得到的ArrayList只是Arrays的一个内部类，为了将其转为通常的ArrayList，可以使用 `new ArrayList<String>(Arrays.asList(...)))`来获得。

---
使用asList将数组转为List时，对该List元素进行操作其实就是对于原数组进行操作。因此不能对该List添加元素，不然会报"UnsupportedOperationException"。
jdk1.8之后arraylist初始容量变为0，第一次添加才增加到10

---
使用asList将数组转为List时，对该List元素进行操作其实就是对于原数组进行操作。因此不能对该List添加元素，不然会报"UnsupportedOperationException"。
"./"表示项目的根目录

---
jdk1.8之后arraylist初始容量变为0，第一次添加才增加到10

---
"./"表示项目的根目录

---
使用asList将数组转为List时，对该List元素进行操作其实就是对于原数组进行操作。因此不能对该List添加元素，不然会报"UnsupportedOperationException"。
类加载路径（classpath）是以当前类（class文件）为依据，定位的是当前类所在包的最上级包的上一级路径。

Maven项目中的src/main下有两个路径：java和resources，前者保存所有包和java文件，后者保存其他文件。在编译后java和resources下的文件会合并保存到target/classes路径下。

---
获取当前类(class文件)所在路径：
```
URI currPackageDir = <ClassName>.class.getResource(".").toURI();
```

Maven项目中获取classpath目录：
```
URI classpath = <ClassName>.class.getClassLoader().getResource(".").toURI();
```

---
一种控制反转的例子：
DispatcherServlet中调用Controller的业务方法时不是在service方法中

---
HashMap知识点:
底层数据结构
添加元素和删除元素的机制（包括计算键值对对应的数组下标，equals方法，扩容，装载因子，rehash，链表，何时转为红黑树，何时从红黑树转为链表）
当hashmap中容量达到64，链表长度达到8时会将链表转为红黑树，当红黑书长度降为6时变为链表。


# java.util.concurrent
## BlockingQueue
BlockingQueue接口表示线程放入和取出元素的队列。通常用于一个线程生产对象，另一个线程消费对象的场景。队列满了后负责生产的线程会发生阻塞，直到队列中有对象被消费掉；空了后负责消费的线程会发生阻塞，直到有对象被生产出来

当请求的操作不能立刻执行时，BlockingQueue各个方法的表现如下：
--- | --- | --- | --- | ---
 | 抛异常 | 特定值 | 阻塞 | 超时等待
插入 | add(o) | offer(o) | put(o) | offer(o, timeout, timeunit)
移除 | remove(o) | poll(o) | take(o) | poll(timeout, timeunit)
检查 | element(o) | peek(o) | |

BlockingQueue的实现类：
- ArrayBlockingQueue (内部使用数组来存储，有界)
- DelayQueue
- LinkedBlockingQueue (内部使用链表来存储，可以设定初始值，如果不设定，长度默认为`Integer.MAX_VALUE`)
- PriorityBlockingQueue (无界队列，底层数据结构是数组，但是用到了平衡二叉树的算法？其元素需要实现Comparable接口，排序取决于Comparable实现，对于优先级相同的元素，其顺序没有特定规律；使用其Iterator来遍历时遍历的顺序不一定和队列中元素的排序相同)
- SynchronousBlockingQueue (内部只能存储单个元素)

## ConcurrentMap

ConcurrentMap是可以进行并发读写的Map，它是一个接口，其实现类ConcurrentHashMap和HashTable类似，但是在读写时只会锁住读写的部分，所以效率比HahsTable高。在使用迭代器遍历时，即使ConcurrentHashMap被改动，也不会报ConcurrentModificationExceptin



特定值通常是true/false
---
使用Socket发送数据时数据会缓存到网卡里(大概几MB缓存？)，所以即使服务端没有读取数据，客户端也可以发送数据，但当达到缓存最大值时，就会产生阻塞。同样的，如果客户端没有发送数据，网卡缓存是空的，那么服务端在读取时会产生阻塞。

# tpope/vim-dadbod

usage: first visual-select the sql statements in the current file, then execute the command `DB mysql://<user>@<host>[/<database>]` to execute these statements.


---
利用Java函数在数据库中传入当前时间：
`preparedStatement.setDate(1, new java.sql.Date(System.currentTimeMillis()));`

---
由于数据库连接底层使用TCP协议，所以连接时会有三次握手。

---
将component或是controller、service等打上注解后利用ApplicationContext的getBean方法获得Bean的原理是什么

---
Maven优先从本地仓库查找jar包，找不到时从远程仓库拉取。有时候本地仓库由于网路等原因下载下的是不完整的结果，导致JVM找不到某些class文件，这时候将其删了重新下载即可。

Maven的配置路径为`C:\Users\Administrator\.m2\settings.xml`或者`C\Users\<username>\.m2\settings.xml`。

在`settings.xml`的`<localRepository>...</localRepository>`中可以配置本地仓库路径，在Idea的`Settings - Build, Execution, Depoloyment - Maven`中可以更改所使用的Maven的settings.xml配置文件以及其本地仓库的位置。

# NERDTree

Vim中设置`let g:NERDTreeChDirMode = 2`会使得在nerdtree中进入某个路径时working directory也相应变化。这对于更新git项目是有用的，因为可以先使用快捷键定位到projects文件夹，然后使用nerdtree打开某个项目文件来更改working directory，然后打开terminal就可以在项目路径下进行操作。

---
改进操作：
在内置terminal中cd到某个项目的路径：
- 先在nerdtree中通过bookmark进入projects路径
- 然后选中目标project并使用快捷键cd将其设为working directory
- 然后按q关闭nerdtree，再打开内置terminal即可。

还有一个在当前文件路径下打开terminal的vim设置：
`map <C-S-CR> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>`

类似于Ranger的LF似乎可以在Windows上面安装： https://github.com/gokcehan/lf

## nerdtree shortcuts:

### navigation

- P: go to root (the directory shown at the top)
- p: go to parent
- CD: go to working directory
- cd: set the selected directory as working directory
- C: set the selected directory as root
- J: go to the last sibling
- K: go to the first sibling

### open file

- o: open file
- go: open file (silently)
- i: open split
- gi: open split (silently)
- s: open vsplit
- gs: open vsplit (silently)

### miscellaneous

- F: toggle show only directories
- m: show operations for the selected node
    - o: open with default program
    - r: reveal in file manager
    - m: rename (or move)
    - d: delete
    - p: copy path
    - q: quick-look
    - l: show file info
- B: show/hide bookmarks
- D: delete bookmark
- Bookmark <bookmark-name>: bookmark the selected node
- u: move root up a directory
- I: toggle hidden files
- e: explore selected directory
- o: open or close the directory node
- O: recursively open the directory node
- t: open the selected file in new tab
- R: refresh current root
- r: refresh current directory
- A: maximize/minimize the nerdtree window

---
为什么使用`ApplicationContext context = new AnnotationConfigApplicationContext("cn.tedu.spring");`(而非`ApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);`)来创建ApplicationContext也会创建SpringConfig?

---
测试依赖注入是否只能注入singleton作用域的bean

---
最大连接数：
`show variables like '%max_connections%';`
`set global max_connections=160;`

是否支持缓存
`show variables like '%have_query_cache%';`
是否开启缓存
`show variables like '%query_cache_type%';`

查看数据库支持的引擎：
`show engines;`
修改表使用的引擎
`alter table <table> engine=<engine>;`


---
show open ports using cmd:
`netstat -ano | findstr LISTENING`
using powershell:
`Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" }`


---
Concepts in git:

Working directory:

Working directory is the local copy of the repository that one interacts with directly. When he edits files, add new ones, or delete existing ones, these changes are made in the working directory, but not automatically tracked by Git for inclusion in the next commit.

Staging area (index):

The staging area is an intermediate step between the working directory and a commit, which is like a snapshot of what the next commit will look like.

Check out:

Check out" refers to the process of retrieving a specific version of a file or a set of files from a repository. It involves copying the files from the repository to your working directory so that you can work on or examine that particular version.

We can check out a branch: `git checkout <branch>`, or check out a commit: `git checkout <commit-hash>`, or check out a file: `git checkout <commit-hash> -- <filename>`.

---
Intellij Idea中，module的设置存储在.iml文件中。

某个module所依赖的JDK版本以及jar包都罗列在`Project Structure (cmd + ;) - Modules - Dependencies`下面，有时候由于pom.xml没有被识别，idea没有将pom.xml中指定的依赖添加到classpath中，这时候可以右键pom.xml文件，选择"add as maven project"。

在`Project Structure (cmd + ;) - Modules - Sources`中可以指定module的language level，即编辑器的代码辅助功能相关设置（一般应该要跟JDK版本保持一致吧？）。

---
Maven是一个Java项目的管理和构建工具，在Maven中声明一个依赖项(由groupId，artifactId和version唯一定位)可以自动下载并导入classpath。

Maven项目结构:

maven-project
├── pom.xml
├── src
│   ├── main
│   │   ├── java
│   │   └── resources
│   └── test
│       ├── java
│       └── resources
└── target

其中pom.xml类似于下面这样：
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>{group-id}</groupId>
    <artifactId>{artifact-id}</artifactId>
    <version>{version}</version>

    <name>{project-name}</name>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.3.1</version>
        </dependency>
    </dependencies>
</project>
```
其中，groupId类似于Java的包名，通常是公司或组织名称，artifactId类似于Java的类名，通常是项目名称，再加上version，一个Maven工程就是由groupId，artifactId和version作为唯一标识。我们在引用其他第三方库的时候，也是通过这3个变量确定。

在依赖项的`<scope></scope>`中可以指定什么时候使用依赖：
- compile: 编译时需要用到该jar包（默认）
- runtime: 编译时不需要，但运行时需要用到
- test: 编译Test时需要用到该jar包
- provided: 编译时需要用到，但运行时不需要(因为运行时由JDK或某个服务器提供)

---
SQL和Java数据类型的对比：
SQL数据类型 | Java数据类型
--- | --- 
BIT, BOOL | boolean
INTEGER | int
BIGINT | long
REAL | float
FLOAT, DOUBLE | double
CHAR, VARCHAR | String
DECIMAL | BigDecimal
DATE | java.sql.Date, LocalDate
TIME | java.sql.Time, LocalTime

---
Mybatis常见异常：

org.apache.ibatis.binding.BindingException: Invalid bound statement (not found)
该异常指明Mybatis在调用Mapper接口中的某个方法时找不到xml文件中相应的sql语句，一些可能的原因如下:
- application.properties中mybatis.mapper-locations属性配置错误
- xml文件中的namespace错了
- xml文件中sql语句所对应的id跟接口中的方法名不一致

org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'sqlSessionFactory' defined in class path resource [org/mybatis/spring/boot/autoconfigure/MybatisAutoConfiguration.class]
该异常跟xml文件的语法错误有关，一些可能的原因如下:
- resultType类型错误 (注意，要写类的全限定名或基本类型)，此时在错误信息中向下找可以找到`ClassNotFoundException`，并找到产生错误的类
- sql的id重复，此时可以在错误信息中找到IllegalArgumentException并找到出错的id
其他可能的原因还有很多，但最终可定位的出错原因似乎都在错误信息的最下方，因此直接拉到最下面即可。

---
Spring框架的好处：
- 可以自动创建对象，维护对象之间的依赖关系。项目中往往涉及到很多只需要单个实例的对象，如果手动，比如说，使用单例模式去创建，就太不方便了，也难以维护。

---
使git正确显示中文：
`$ git config --global core.quotepath false`

---
Replacement within visual selection:
`:'<,'>s/\%V{pattern}/{replacement}/g`

---
Dash shortcuts:
opt + up/down: navigate through table of contents (also, we can use cmd + f to search in toc)

---
list available services in brew:
`brew services list`

---
idea snipet: vdata for 
`
data() {
    return {
        ...
    }
}
`
---
How to use UltiSnips:
After installing the vim plugin, create the directory `~/.vim/UltiSnips`, then open a file with the target type and use the command `UltiSnipsEdit` to open the configuration file for the this file type.

---
Show dns resolvers used by the system:
`scutil --dns`

---
rename tab in iTerm2:
cmd + i, type the name, esc

---
htop shortcuts:

- P: sort by cpu usage
- M: sort by memory usage
- u: filter processes owned by a particular user
- space: tag a process
- c: tag a process and its child processes
- U: remove all tags
- F: highlight and follow a process

---
docker:
install docker image:
`docker pull centos`
run centos container:
`docker run -it centos`
exit container:
`exit`
remove container:
`docker rm <container_id_or_name>`

Docker中安装完CentOS 8后的配置:
```
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum -y install  epel-release
```

---
为文件名或其他用途生成随机字符串：
```java
UUID.randomUUID()
```

格式化日期：
```java
new SimpleDateFormat("/yyyy/MM/dd/")
```

---
对于上传的图片，spring mvc可以用MultipartFile类型来接收，常用方法
- `String getOriginalFilename()`: 返回文件在客户端的文件系统上的名称
- `void transferTo(File dest)`: 将接收到的文件保存到本地

---
常见难发现bug之一：
变量名错写成一个非常类似的名称

---
mac自定快捷键：
合并所有窗口: ctrl + shift + cmd + u
