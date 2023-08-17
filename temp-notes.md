---
猎才MySQL文档URL：
https://yscp0bp3g6.feishu.cn/docx/Dv0kdkOmdofUhDx53VNch8mpnHg
https://gitee.com/houyworking/mysqlproject/tree/master

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
- m: show operations
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


