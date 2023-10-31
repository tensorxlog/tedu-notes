# 各阶段git地址

## 第二阶段，王伟超

notes:
jsd2306-ssm-teacher
https://gitee.com/teduwang/jsd2306-ssm-teacher.git

## 第三阶段，刘国斌

notes:
jsd-06-03-teacher
https://gitee.com/IvanLiuGB/jsd-06-03-teacher.git

2306-vue-baking-teacher
https://gitee.com/IvanLiuGB/2306-vue-baking-teacher.git

## 第四阶段，成恒

notes:
jsd2306-tmall-server-teacher
https://gitee.com/chengheng2022/jsd2306-tmall-server-teacher.git

jsd2306-tmall-client-admin-teacher
https://gitee.com/chengheng2022/jsd2306-tmall-client-admin-teacher.git

tmall-server-repo
https://gitee.com/chengheng2022/tmall-server-repo.git

tmall-client-front-repo
https://gitee.com/chengheng2022/tmall-client-front-repo.git

tmall-client-admin-repo
https://gitee.com/chengheng2022/tmall-client-admin-repo.git

## 第五阶段，肖旭伟

notes:
jsd2306-notes
https://gitee.com/xiaolaoshi2021/jsd2306-notes.git

jsd2306-luban-demo
https://gitee.com/xiaolaoshi2021/jsd2306-luban-demo.git

## 智能充电桩项目

张九军
13691481018

notes:
https://gitee.com/jiujun/jsdtn2306.git

---
讲台电脑ftp地址：ftp://176.17.0.25


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
├── mvnw
├── mvnw.cmd
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

temp
---
服务器收到请求后将其交给DispatcherServlet进行处理，DispatcherSevlet会调用HandlerMapping来根据请求路径找到对应的handler,HandlerMapping将handler执行链(简单版是controller,什么是handler执行链?)返回给DispatcherServlet，
然后DispatcherServlet调用HandlerAdapter，让其执行handler，而HandlerAdapter会调用Handler去执行handler(为什么不是HandlerAdapter或者Handler直接执行handler？)，
Handler执行完后返回一个ModelAndView(什么是ModelAndView以及View?)，然后DispatcherServlet让ViewResolver去解析视图，并返回View，然后再让模板引擎去渲染视图，最后返回响应。

handler指可以处理请求的组件,可以是controller，也可以是带@RequestMapping等注解的方法。
HandlerExecutionChain包含一个handler以及多个拦截器构成的执行链。
拦截器可以在请求被handler处理前进行预处理或者请求被handler处理后进行额外处理，其进行的处理包括授权，日志记录以及修改请求和响应等。

HandlerAdapter使用了适配器模式，它有几个子类，每个子类都是适配某一种类型的控制器，有了HandlerAdapter，你只需要调用handle方法，屏蔽了不一致的细节，否则在DispatcherServlet里面要if else if else了


HandlerMapping根据请求路径找到handler（handler method?）然后将执行链返回给DispatcherServlet，但由于有多种多样的handler，调用它们的接口各不相同，所以并不是由DispatcherServlet直接调用handler的方法，而是使用了适配器模式，为每种handler定义一个HandlerAdapter适配器，于是DispatcherServlet根据handler的类型找到合适的HandlerAdapter来执行handler。

View接口使用render来渲染页面：
void render(@Nullable Map<String,?> model, HttpServletRequest request, HttpServletResponse response)

ModelAndView中封装了view以及Map<String, ?>类型的model

---
设计模式：

简单工厂模式：
简单工厂模式是在工厂类的静态方法中根据不同参数返回不同对象，这些对象的类型可以是继承自同一个类的不同子类。

工厂模式：
工厂模式提供了一个用于创建对象的接口，不同的实现类有不同的创建对象的方式，每个实现类相当于一个简单工厂。

单例模式：
单例模式是指对于某个类，在程序运行期间只允许创建它的一个对象，并且提供一个公有的静态方法来获取该对象。
在实现单例模式时需要进行以下操作：
- 将构造方法变为私有的
- 有一个静态的私有字段用于保存单例
- 创建一个公有的静态方法用于返回单例

适配器模式：
适配器模式是指将一个接口，比如说A接口，的对象转换为B接口，并且仍旧拥有它原先的功能，这样就可以适配那些需要B接口的场合。
实现方式如下：
- 实现目标接口
- 内部持有一个待转换接口的引用
- 在目标接口的实现方法内部，调用待转换接口的方法


---
Vim删除空行：
```
:g/^$/d
```
---
面试的时候一般会分为四个阶段来问：

- 你知道 xxx 吗？你用过 xxx 吗？（一问看你有没有接触过，一般没接触过就不会问这个方向了）
- 你在日常开发的过程中是如何使用 xxx 的呢？（再次判断你有没有接触过，如果你能回答上来应用场景，才会继续向下问，不然面试官就认为你在扯皮）
- 那你知道 xxx 的原理吗？（问你原理就是判断你私下来有没有研究过这个东西，可以回答 xxx 的工作机制是怎样的，比如线程池的原理，你就可以回答线程池的工作机制）
- 最后还可能会问你更细一些的问题，比如 HashMap 的 put 过程是怎样的？（这个就需要熟悉源码了）

---
Intellij Idea中用JavaDoc生成文档：Tools -> Generate JavaDoc...
如果出现中文乱码问题，可以在对话框的“Command line arguments”部分加上该参数：`-encoding utf-8 -charset utf-8`.

---
通用的策略：
使用缓存（比如数据库缓存、磁盘复制文件用缓存、浏览器缓存、CPU缓存、IO缓冲流、StringBuilder相当于使用了缓存）
使用有序结构的二分查找进行搜索（比如数据库页目录对数组使用了二分法）
如果数据在物理上无法按照合理的顺序来排列，可以将每个数据封装为一个链表的节点，使用链表来记录它们的顺序（比如MySQL的InnoDB引擎中页内的记录以及各个页都是通过链表按照主键顺序进行连接的）

---
MySQL中同时导入多个sql：
`mysql tea_mall -uroot -p < *.sql`

---
Find all Java versions:
`/usr/libexec/java_home -V`

---
vim-fugitive:

Diff between current file and the index
:Gdiff :0

Diff between current file and current file 3 commits ago:
:Gdiff ~3

---
Use `git stash` to stash the current changes before pulling from remote and use `git stash pop` to add the stash back in to the working directory after pulling from remote.

---
适配器模式在SpringSecurity应用中的一种使用：
SecurityContext中的Authentication的实现类UsernamePasswordAuthenticationToken的构造方法的第三个参数类型是`Collection<? extends GrantedAuthority>`，如果自定义的权限列表类型是`List<String>`，那么就需要进行类型转换，而SpringSecurity提供了SimpleGrantedAuthority实现类，可以将字符串传入该类的构造方法获取转换后的对象，这里就应该是用到了适配器模式。

---
摘自MyBatis文档，提到了request scope：
If you're using a web framework of any sort, consider the SqlSession to follow a similar scope to that of an HTTP request. In other words, upon receiving an HTTP request, you can open a SqlSession, then upon returning the response, you can close it.

Dependency Injection frameworks can create thread safe, transactional SqlSessions and mappers and inject them directly into your beans so you can just forget about their lifecycle. You may want to have a look at MyBatis-Spring or MyBatis-Guice sub-projects to know more about using MyBatis with DI frameworks.

---
10-09串讲讲了依赖注入等

---
对controller方法的参数加上validation框架的约束时（比如@Range(...)），knife4j中显示会有问题，此时可以在参数前再加上@RequestParam来解决。

---
session的缺点：
- 不适合存储大量数据
- 不适合用于集群和分布式系统
- 不适合长时间保存数据

---
Tomcat（Spring MVC默认使用Tomcat作为Web服务器）中HttpSession的标准实现类是StandardSession，其内部用一个ConcurrentHashMap存储数据。而管理session的接口是Manager，其标准实现类是StandardManager（继承自抽象类ManagerBase。ManagerBase是Manager接口的minimal implementation，不支持将session持久化或者应用到分布式系统），用一个ConcurrentHashMap存储所有的session，map的键即session id，值为session。

---
经常说的“List有序”是指List（实现类）具有某种线性的结构（内存中按相邻的地址排列、链表中由一个节点指向另一个节点等等），而不是指其中的元素按大小顺序来排列。这种有序性是在List接口中规定的，比如List#toArray()方法要求返回的元素按它们原先的指标顺序排列，而Set接口并没有这种要求，所以经常可以听到“Set是无序的”这种说法。Set的这种说法其实是不准确的，严格的表述应该是“Set不需要是有序的”。另外，“List的元素可以重复”这种说法也是不准确的，因为List接口本身没有这种强制规定，只能说在通常情况下List的元素是可以重复，但也可以自己实现一个禁止重复元素的实现类（比如在检测到重复元素时抛出异常）。

---
为什么权限放在redis：如果根据JWT中的ID去数据库查找权限的话速度太慢，如果直接放到JWT中的话JWT的数据太大，而且不安全，并且其中保存的有些数据可能会由于被修改过而已经过期了（相应的，这种情况Redis的优势在与它是跟关系型数据库进行同步的）。

---
类DefaultListableBeanFactory内部用一个ConcurrentHashMap来存储Bean:
```java
	/** Map of bean definition objects, keyed by bean name. */
	private final Map<String, BeanDefinition> beanDefinitionMap = new ConcurrentHashMap<>(256);
```

- 对于ClassPathXmlApplicationContext，其DefaultListableBeanFactory是存储在它的一个父类AbstractRefreshableApplicationContext里的
- 对于AnnotationConfigApplicationContext，其DefaultListableBeanFactory是存储在其父类GenericApplicationContext里的

---
axios框架发送请求时默认不会携带请求头，如果需要配置请求头，使用
```javascript
let newAxios = axios.create({
        'headers': {
            ...
        }
});
```

----
UserService#login:
验证用户名和密码并返回用户的信息,如验证通过，将账号禁用状态和用户权限存入redis


---
Mac上安装Java 8:
`brew install --cask homebrew/cask-versions/adoptopenjdk8`

---
Maven中配置模块的JDK版本（这样配置后就无法通过IDEA的UI界面来更改JDK的版本）：
```xml
<properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

---
idea中对于同一个项目在不同端口开启多个实例的方法：
编辑"Run/Debug Configurations" (可通过双击shift搜索)，选中模块名称，点击"Modify options"，在下拉列表中勾选"Override configuration properties"，然后在"Override configuration properties"处配置端口号：
name: server.port
value: <port>

---
RPC远程调用：假设客户端想调用服务端的Service接口实现类ServiceImpl的remoteMethod方法，那么客户端处需要先创建一个Service接口的实现类，然后在remoteMethod方法中将参数传给服务器，服务器收到参数后调用ServiceImpl的remoteMethod方法并将结果返回给客户端，客户端再将该结果作为Service实现类的remoteMethod方法的返回值。

---
Spring Gateway过滤器官方文档：
https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-stripprefix-gatewayfilter-factory

---
duplicate a mysql database:
```shell
$ mysqldump original-database-name -u user -ppassword > dump.sql
$ echo "create database target-database-name" | mysql -u user -ppassword
$ mysql target-database-name -u user -ppassword < dump.sql
```
---
对于某个知识点的理解可以参考我对于JDK、JRE的理解

---
rocketmq相关程序启动命令：
rocketmq服务器：
```shell
$ mqnamesrv
```
mqbroker:
```shell
$ mqbroker
```

仪表盘：
```shell
$ java -jar rocketmq-dashboard-1.0.1-SNAPSHOT.jar --server.port=9999 --rocketmq.config.namesrvAddr=localhost:9876
```

