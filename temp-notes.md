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
使用asList将数组转为List时，对该List元素进行操作其实就是对于原数组进行操作。因此不能对该List添加元素，不然会报"UnsupportedOperationException"。
类加载路径（classpath）是以当前类（class文件）为依据，定位的是当前类所在包的最上级包的上一级路径。

Maven项目中的src/main下有两个路径：java和resources，前者保存所有包和java文件，后者保存其他文件。在编译后java和resources下的文件会合并保存到target/classes路径下。
