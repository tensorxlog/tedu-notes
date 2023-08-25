# to-do:

- 理解Bean生命周期
- 熟悉mini HTTP服务器的整个项目结构(并理解它与springmvc执行流程的关系)
- 整理数据库和Spring笔记(mysql.xmind, ssm.xmind, 检查思维导图中每一条是否完善，有时间时检查思维导图是否已包含所有知识点)
- 看猎才mysql文档
- 理解NIO: Channel，Selector，如何连接，发送和接收
- 熟悉RPC代码
- 看廖雪峰网站上JDBC相关补充至思维导图
- 跟着廖雪峰教程手写Spring
- 根据illustration.xmind进行讲解练习
- 熟练使用代码实现各种排序算法
- 使用嵌套循环和外联内联的不同场合
- k8s

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

