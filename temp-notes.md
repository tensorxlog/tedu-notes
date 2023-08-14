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


