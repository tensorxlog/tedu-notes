死磕Spring之IoC篇 - 深入了解Spring IoC（面试题）
该系列文章是本人在学习 Spring 的过程中总结下来的，里面涉及到相关源码，可能对读者不太友好，请结合我的源码注释 Spring 源码分析 GitHub 地址 进行阅读

Spring 版本：5.1.14.RELEASE

该系列其他文章请查看：《死磕 Spring 之 IoC 篇 - 文章导读》

1. 什么是 Spring Framework ？

官方文档：

Spring makes it easy to create Java enterprise applications. It provides everything you need to embrace the Java language in an enterprise environment, with support for Groovy and Kotlin as alternative languages on the JVM, and with the flexibility to create many kinds of architectures depending on an application’s needs.

这个问题很难回答，在 Spring 官方文档中的描述也很抽象，答案在于你对 Spring 是如何理解的，想必每个人都有自己的回答方式，以下是我个人对于 Spring 的理解：

整个 Spring 生态在涉及到 Java 的项目中被广泛应用，它提供了非常多的组件，能够让你在开发 Java 应用的过程变得更加容易，弹性地支持其他软件框架，可以比作一个“排插座”，其他软件框架简单地“插上”即可结合 Spring 一起使用，给开发人员带来了非常多的便利。Spring 底层 IoC 容器的设计实现也是非常完美的，在整个 Spring 应用上下文的生命周期和 Spring Bean 的生命周期的许多阶段提供了相应的扩展点，供开发者自行扩展，使得框架非常的灵活。

2. Spring Framework 的优势和不足？

优势：Spring 面向模块进行开发，根据不同的功能进行划分，根据需求引入对应的模块即可，对于开发人员非常友好。例如 Spring IoC 容器，将我们的 Java 对象作为 Spring Bean 进行管理，管理着 Bean 的整个生命周期；Spring MVC 提供“模型-视图-控制器”（Model-View-Controller）架构和随时可用的组件，用于开发灵活且松散耦合的 Web 应用程序；Spring AOP 提供面向切面编程的接口，可以很方便的使用；还有许多其他的功能模块，就不一一讲述了。

不足：整个 Spring 体系比较复杂，对于开发人员需要一定的学习成本，遇到相关问题时需要对底层实现有充分的了解，这也就需要开发人员投入更多的时间和精力去学习。当然，如今 Spring 体系整合了 Java 生态非常多的东西，为开发人员带来的便利远大于这些不足，我觉得是有必要对 Spring 进行充分的学习，去了解 Spring 的贡献者们的设计思路，对自身也会有很大的提升，从中可以学习到许多的东西。

3. 你对 IoC 的理解？

Inversion of Control（IoC）是面向对象中的一种编程思想或原则。可以先回到传统方式，当我依赖一个对象，我需要主动去创建它并进行属性赋值，然后我才能去使用这个对象。对于 IoC 这种方式来说，它使得对象或者组件的创建更为透明，你不需要过多地关注细节，如创建对象、属性赋值，这些工作交都由 IoC 容器来完成，已达到解耦的目的。

IoC 控制反转，简单来理解其实就是把获取依赖对象的方式，交由 IoC 容器来实现，由“主动拉取”变为“被动获取”。

4. 为什么需要 IoC ？

实际上，IoC 是为了屏蔽构造细节。例如 new 出来的对象的生命周期中的所有细节对于使用端都是知道的，如果在没有 IoC 容器的前提下，IoC 是没有存在的必要，不过在复杂的系统中，我们的应用更应该关注的是对象的运用，而非它的构造和初始化等细节。

5. IoC 和 DI 的区别？

DI 依赖注入不完全等同于 IoC，更应该说 DI 依赖注入是 IoC 的一种实现方式或策略。

依赖查找和依赖注入都是 IoC 的实现策略。依赖查找就是在应用程序里面主动调用 IoC 容器提供的接口去获取对应的 Bean 对象，而依赖注入是在 IoC 容器启动或者初始化的时候，通过构造器、字段、setter 方法或者接口等方式注入依赖。依赖查找相比于依赖注入对于开发者而言更加繁琐，具有一定的代码入侵性，需要借助 IoC 容器提供的接口，所以我们总是强调后者。依赖注入在 IoC 容器中的实现也是调用相关的接口获取 Bean 对象，只不过这些工作都是在 IoC 容器启动时由容器帮你实现了，在应用程序中我们通常很少主动去调用接口获取 Bean 对象。

6. IoC 容器的职责？

主要有以下职责：

依赖处理，通过依赖查找或者依赖注入

管理托管的资源（Java Bean 或其他资源）的生命周期

管理配置（容器配置、外部化配置、托管的资源的配置）

IoC 容器有非常多，例如 JDK 的 Java Beans，Java EE 的 EJB，Apache Avalon，Google guice，Spring，其中 Spring 是最成功的的一个，目前被广泛应用。

其中 Spring 借鉴了 JDK 的 Java Beans 设计思想，也使用到其中相关类（例如 java.beans.PropertyEditor 属性编辑器），开发过 IDE 的 GUI 界面的伙伴应该对 Java Beans 比较熟悉。

7. 什么是 Spring IoC 容器？

Spring 框架是一个 IoC 容器的实现，DI 依赖注入是它的实现的一个原则，提供依赖查找和依赖注入两种依赖处理，管理着 Bean 的生命周期。Spring 还提供了 AOP 抽象、事件抽象、事件监听机制、SPI 机制、强大的第三方整合、易测试性等其他特性。

8. 构造器注入和 Setter 注入

构造器注入：通过构造器的参数注入相关依赖对象

Setter 注入：通过 Setter 方法注入依赖对象，也可以理解为字段注入

对于两种注入方式的看法：

构造器注入可以避免一些尴尬的问题，比如说状态不确定性地被修改，在初始化该对象时才会注入依赖对象，一定程度上保证了 Bean 初始化后就是不变的对象，这样对于我们的程序和维护性都会带来更多的便利；

构造器注入不允许出现循环依赖，因为它要求被注入的对象都是成熟态，保证能够实例化，而 Setter 注入或字段注入没有这样的要求；

构造器注入可以保证依赖的对象能够有序的被注入，而 Setter 注入或字段注入底层是通过反射机制进行注入，无法完全保证注入的顺序；

如果构造器注入出现比较多的依赖导致代码不够优雅，我们应该考虑自身代码的设计是否存在问题，是否需要重构代码结构。

除了上面的注入方式外，Spring 还提供了接口回调注入，通过实现 Aware 接口（例如 BeanNameAware、ApplicationContextAware）可以注入相关对象，Spring 在初始化这类 Bean 时会调用其 setXxx 方法注入对象，例如注入 beanName、ApplicationContext

9. BeanFactory 和 ApplicationContext 谁才是 Spring IoC 容器？

BeanFactory 是 Spring 底层 IoC 容器，ApplicationContext 是 BeanFactory 的子接口，是 BeanFactory 的一个超集，提供 IoC 容器以外更多的功能。ApplicationContext 除了扮演 IoC 容器角色，还提供了这些企业特性：面向切面（AOP）、配置元信息、资源管理、事件机制、国际化、注解、Environment 抽象等。我们一般称 ApplicationContext 是 Spring 应用上下文，BeanFactory 为 Spring 底层 IoC 容器。

10. Spring Bean 的生命周期？

生命周期：

Spring Bean 元信息配置阶段，可以通过面向资源（XML 或 Properties）、面向注解、面向 API 进行配置

Spring Bean 元信息解析阶段，对上一步的配置元信息进行解析，解析成 BeanDefinition 对象，该对象包含定义 Bean 的所有信息，用于实例化一个 Spring Bean

Spring Bean 元信息注册阶段，将 BeanDefinition 配置元信息 保存至 BeanDefinitionRegistry 的 ConcurrentHashMap 集合中

Spring BeanDefinition 合并阶段，定义的 Bean 可能存在层次性关系，则需要将它们进行合并，存在相同配置则覆盖父属性，最终生成一个 RootBeanDefinition 对象

Spring Bean 的实例化阶段，首先的通过类加载器加载出一个 Class 对象，通过这个 Class 对象的构造器创建一个实例对象，构造器注入在此处会完成。在实例化阶段 Spring 提供了实例化前后两个扩展点（InstantiationAwareBeanPostProcessor 的 postProcessBeforeInstantiation、postProcessAfterInstantiation 方法）

Spring Bean 属性赋值阶段，在 Spring 实例化后，需要对其相关属性进行赋值，注入依赖的对象。首先获取该对象所有属性与属性值的映射，可能已定义，也可能需要注入，在这里都会进行赋值（反射机制）。提示一下，依赖注入的实现通过 CommonAnnotationBeanPostProcessor（@Resource、@PostConstruct、@PreDestroy）和 AutowiredAnnotationBeanPostProcessor（@Autowired、@Value）两个处理器实现的。

Aware 接口回调阶段，如果 Spring Bean 是 Spring 提供的 Aware 接口类型（例如 BeanNameAware、ApplicationContextAware），这里会进行接口的回调，注入相关对象（例如 beanName、ApplicationContext）

Spring Bean 初始化阶段，这里会调用 Spring Bean 配置的初始化方法，执行顺序：@PostConstruct 标注方法、实现 InitializingBean 接口的 afterPropertiesSet() 方法、自定义初始化方法。在初始化阶段 Spring 提供了初始化前后两个扩展点（BeanPostProcessor 的 postProcessBeforeInitialization、postProcessAfterInitialization 方法）

Spring Bean 初始化完成阶段，在所有的 Bean（不是抽象、单例模式、不是懒加载方式）初始化后，Spring 会再次遍历所有初始化好的单例 Bean 对象，如果是 SmartInitializingSingleton 类型则调用其 afterSingletonsInstantiated() 方法，这里也属于 Spring 提供的一个扩展点

Spring Bean 销毁阶段，当 Spring 应用上下文关闭或者你主动销毁某个 Bean 时则进入 Spring Bean 的销毁阶段，执行顺序：@PreDestroy 注解的销毁动作、实现了 DisposableBean 接口的 Bean 的回调、destroy-method 自定义的销毁方法。这里也有一个销毁前阶段，也属于 Spring 提供的一个扩展点，@PreDestroy 就是基于这个实现的

Spring 垃圾收集（GC）

总结：

上面 1、2、3 属于 BeanDefinition 配置元信息阶段，算是 Spring Bean 的前身，想要生成一个 Bean 对象，需要将这个 Bean 的所有信息都定义好；

其中 4、5 属于实例化阶段，想要生成一个 Java Bean 对象，那么肯定需要根据 Bean 的元信息先实例化一个对象；

接下来的 6 属于属性赋值阶段，实例化后的对象还是一个空对象，我们需要根据 Bean 的元信息对该对象的所有属性进行赋值；

后面的 7、8 、9 属于初始化阶段，在 Java Bean 对象生成后，可能需要对这个对象进行相关初始化工作才予以使用；

最后面的 10、11 属于销毁阶段，当 Spring 应用上下文关闭或者主动销毁某个 Bean 时，可能需要对这个对象进行相关销毁工作，最后等待 JVM 进行回收。

11. BeanDefinition 是什么？

BeanDefinition 是 Spring Bean 的“前身”，其内部包含了初始化一个 Bean 的所有元信息，在 Spring 初始化一个 Bean 的过程中需要根据该对象生成一个 Bean 对象并进行一系列的初始化工作。

12. Spring 内建的 Bean 作用域有哪些？

来源	说明
singleton	默认 Spring Bean 作用域，一个 BeanFactory 有且仅有一个实例
prototype	原型作用域，每次依赖查找和依赖注入生成新 Bean 对象
request	将 Spring Bean 存储在 ServletRequest 上下文中
session	将 Spring Bean 存储在 HttpSession 中
application	将 Spring Bean 存储在 ServletContext 中
13. BeanPostProcessor 与 BeanFactoryPostProcessor 的区别？

BeanPostProcessor 提供 Spring Bean 初始化前和初始化后的生命周期回调，允许对关心的 Bean 进行扩展，甚至是替换，其相关子类也提供 Spring Bean 生命周期中其他阶段的回调。

BeanFactoryPostProcessor 提供 Spring BeanFactory（底层 IoC 容器）的生命周期的回调，用于扩展 BeanFactory（实际为 ConfigurableListableBeanFactory），BeanFactoryPostProcessor 必须由 Spring ApplicationContext 执行，BeanFactory 无法与其直接交互。

14. 依赖注入和依赖查找的来源是否相同？

否，依赖查找的来源仅限于 Spring BeanDefinition 以及单例对象，而依赖注入的来源还包括 Resolvable Dependency（Spring 应用上下文定义的可已处理的注入对象，例如注入 BeanFactory 注入的是 ApplicationContext 对象）以及 @Value 所标注的外部化配置

15. 如何基于 Extensible XML authoring 扩展 Spring XML 元素？

Spring XML 扩展

编写 XML Schema 文件（XSD 文件）：定义 XML 结构

自定义 NamespaceHandler 实现：定义命名空间的处理器

自定义 BeanDefinitionParser 实现：绑定命名空间下不同的 XML 元素与其对应的解析器

注册 XML 扩展（META-INF/spring.handlers 文件）：命名空间与命名空间处理器的映射

编写 Spring Schema 资源映射文件（META-INF/spring.schemas 文件）：XML Schema 文件通常定义为网络的形式，在无网的情况下无法访问，所以一般在本地的也有一个 XSD 文件，可通过编写 spring.schemas 文件，将网络形式的 XSD 文件与本地的 XSD 文件进行映射，这样会优先从本地获取对应的 XSD 文件

Mybatis 对 Spring 的集成项目中的 <mybatis:scan /> 标签就是这样实现的，可以参考：NamespaceHandler、MapperScannerBeanDefinitionParser、XSD 等文件

具体实现逻辑参考后续《解析自定义标签（XML 文件）》一文

16. Java 泛型擦写发生在编译时还是运行时？

运行时。编译时，泛型参数类型还是存在的，运行时会忽略。

17. 简述 Spring 事件机制原理？

主要有以下几个角色：

Spring 事件 - org.springframework.context.ApplicationEvent，实现了 java.util.EventListener 接口

Spring 事件监听器 - org.springframework.context.ApplicationListener，实现了 java.util.EventObject 类

Spring 事件发布器 - org.springframework.context.ApplicationEventPublisher

Spring 事件广播器 - org.springframework.context.event.ApplicationEventMulticaster

Spring 内建的事件：

ContextRefreshedEvent：Spring 应用上下文就绪事件
ContextStartedEvent：Spring 应用上下文启动事件
ContextStoppedEvent：Spring 应用上下文停止事件
ContextClosedEvent：Spring 应用上下文关闭事件
Spring 应用上下文就是一个 ApplicationEventPublisher 事件发布器，其内部有一个 ApplicationEventMulticaster 事件广播器（被观察者），里面保存了所有的 ApplicationListener 事件监听器（观察者）。Spring 应用上下文发布一个事件后会通过 ApplicationEventMulticaster 事件广播器进行广播，能够处理该事件类型的 ApplicationListener 事件监听器则进行处理。

18. @EventListener 的工作原理？

@EventListener 用于标注在方法上面，该方法则可以用来处理 Spring 的相关事件。

Spring 内部有一个处理器 EventListenerMethodProcessor，它实现了 SmartInitializingSingleton 接口，在所有的 Bean（不是抽象、单例模式、不是懒加载方式）初始化后，Spring 会再次遍历所有初始化好的单例 Bean 对象时会执行该处理器对该 Bean 进行处理。在 EventListenerMethodProcessor 中会对标注了 @EventListener 注解的方法进行解析，如果符合条件则生成一个 ApplicationListener 事件监听器并注册。

19. Spring 提供的注解有哪些？

核心注解有以下：

Spring 模式注解
Spring 注解	场景说明	起始版本
@Repository	数据仓储模式注解	2.0
@Component	通用组件模式注解	2.5
@Service	服务模式注解	2.5
@Controller	Web 控制器模式注解	2.5
@Configuration	配置类模式注解	3.0
Spring 模式注解都是 @Component 的派生注解，Spring 为什么会提供这么多派生注解？

@Component 注解是一个通用组件注解，标注这个注解后表明你需要将其作为一个 Spring Bean 进行使用，而其他注解都有各自的作用，例如 @Controller 及其派生注解用于 Web 场景下处理 HTTP 请求，@Configuration 注解通常会将这个 Spring Bean 作为一个配置类，也会被 CGLIB 提供，帮助实现 AOP 特性。这也是领域驱动设计中的一种思想。

领域驱动设计：Domain-Driven Design，简称 DDD。过去系统分析和系统设计都是分离的，这样割裂的结果导致需求分析的结果无法直接进行设计编程，而能够进行编程运行的代码却扭曲需求，导致客户运行软件后才发现很多功能不是自己想要的，而且软件不能快速跟随需求变化。DDD 则打破了这种隔阂，提出了领域模型概念，统一了分析和设计编程，使得软件能够更灵活快速跟随需求变化。

装配注解
Spring 注解	场景说明	起始版本
@ImportResource	替换 XML 元素 <import>	2.5
@Import	导入 Configuration 类	2.5
@ComponentScan	扫描指定 package 下标注 Spring 模式注解的类	3.1
依赖注入注解
Spring 注解	场景说明	起始版本
@Autowired	Bean 依赖注入，支持多中依赖查找方式	2.5
@Qualifier	细粒度的 @Autowired 依赖查找	2.5
@Enable 模块驱动
Spring 注解	场景说明	起始版本
@EnableWebMvc	启动整个 Web MVC 模块	3.1
@EnableTransactionManagement	启动整个事务管理模块	3.1
@EnableCaching	启动整个缓存模块	3.1
@EnableAsync	启动整个异步处理模块	3.1
@Enable 模块驱动是以 @Enable 为前缀的注解驱动编程模型。所谓“模块”是指具备相同领域的功能组件集合，组合所形成一个独立的单元。比如 Web MVC 模块、AspectJ 代理模块、Caching（缓存）模块、JMX（Java 管理扩展）模块、Async（异步处理）模块等。

这类注解底层原理就是通过 @Import 注解导入相关类（Configuration Class、 ImportSelector 接口实现、ImportBeanDefinitionRegistrar 接口实现），来实现引入某个模块或功能。

条件注解
Spring 注解	场景说明	起始版本
@Conditional	条件限定，引入某个 Bean	4.0
@Profile	从 Spring 4.0 开始，@Profile 基于 @Conditional 实现，限定 Bean 的 Spring 应用环境	4.0
20. 简述 Spring Environment ？

统一 Spring 配置属性的存储，用于占位符处理和类型转换，还支持更丰富的配置属性源（PropertySource）；

通过 Environment Profiles 信息，帮助 Spring 容器提供条件化地装配 Bean。

21. Environment 完整的生命周期是怎样的？

在 Spring 应用上下文进入刷新阶段之前，可以通过 setEnvironment(Environment) 方法提前设置 Environment 对象，在刷新阶段如果没有 Environment 对象则会创建一个新的 Environment 对象

22. Spring 应用上下文的生命周期？

Spring 应用上下文就是 ApplicationContext，生命周期主要体现在 org.springframework.context.support.AbstractApplicationContext#refresh() 方法中，大致如下：

Spring 应用上下文启动准备阶段，设置相关属性，例如启动时间、状态标识、Environment 对象

BeanFactory 初始化阶段，初始化一个 BeanFactory 对象，加载出 BeanDefinition 们；设置相关组件，例如 ClassLoader 类加载器、表达式语言处理器、属性编辑器，并添加几个 BeanPostProcessor 处理器

BeanFactory 后置处理阶段，主要是执行 BeanFactoryPostProcessor 和 BeanDefinitionRegistryPostProcessor 的处理，对 BeanFactory 和 BeanDefinitionRegistry 进行后置处理，这里属于 Spring 应用上下文的一个扩展点

BeanFactory 注册 BeanPostProcessor 阶段，主要初始化 BeanPostProcessor 类型的 Bean（依赖查找），在 Spring Bean 生命周期的许多节点都能见到该类型的处理器

初始化内建 Bean，初始化当前 Spring 应用上下文的 MessageSource 对象（国际化文案相关）、ApplicationEventMulticaster 事件广播器对象、ThemeSource 对象

Spring 事件监听器注册阶段，主要获取到所有的 ApplicationListener 事件监听器进行注册，并广播早期事件

BeanFactory 初始化完成阶段，主要是初始化所有还未初始化的 Bean（不是抽象、单例模式、不是懒加载方式）

Spring 应用上下文刷新完成阶段，清除当前 Spring 应用上下文中的缓存，例如通过 ASM（Java 字节码操作和分析框架）扫描出来的元数据，并发布上下文刷新事件

Spring 应用上下文启动阶段，需要主动调用 AbstractApplicationContext#start() 方法，会调用所有 Lifecycle 的 start() 方法，最后会发布上下文启动事件

Spring 应用上下文停止阶段，需要主动调用 AbstractApplicationContext#stop() 方法，会调用所有 Lifecycle 的 stop() 方法，最后会发布上下文停止事件

Spring 应用上下文关闭阶段，发布当前 Spring 应用上下文关闭事件，销毁所有的单例 Bean，关闭底层 BeanFactory 容器；注意这里会有一个钩子函数（Spring 向 JVM 注册的一个关闭当前 Spring 应用上下文的线程），当 JVM “关闭” 时，会触发这个线程的运行

总结：

上面的 1、2、3、4、5、6、7、8 都属于 Sping 应用上下文的刷新阶段，完成了 Spring 应用上下文一系列的初始化工作；

9 属于 Spring 应用上下文启动阶段，和 Lifecycle 生命周期对象相关，会调用这些对象的 start() 方法，最后发布上下文启动事件；

10 属于 Spring 应用上下文停止阶段，和 Lifecycle 生命周期对象相关，会调用这些对象的 stop() 方法，最后发布上下文停止事件；

11 属于 Spring 应用上下文关闭阶段，发布上下文关闭事件，销毁所有的单例 Bean，关闭底层 BeanFactory 容器。

23. Spring 应用上下文生命周期有哪些阶段？

参考Spring 应用上下文的生命周期：

刷新阶段 - ConfigurableApplicationContext#refresh()
启动阶段 - ConfigurableApplicationContext#start()
停止阶段 - ConfigurableApplicationContext#stop()
关闭阶段 - ConfigurableApplicationContext#close()
24. 简述 ObjectFactory？

ObjectFactory（或 ObjectProvider） 可关联某一类型的 Bean，仅提供一个 getObject() 方法用于返回目标 Bean 对象，ObjectFactory 对象被依赖注入或依赖查找时并未实时查找到关联类型的目标 Bean 对象，在调用 getObject() 方法才会依赖查找到目标 Bean 对象。

根据 ObjectFactory 的特性，可以说它提供的是延迟依赖查找。通过这一特性在 Spring 处理循环依赖（字段注入）的过程中就使用到了 ObjectFactory，在某个 Bean 还没有完全初始化好的时候，会先缓存一个 ObjectFactory 对象（调用其 getObject() 方法可返回当前正在初始化的 Bean 对象），如果初始化的过程中依赖的对象又依赖于当前 Bean，会先通过缓存的 ObjectFactory 对象获取到当前正在初始化的 Bean，这样一来就解决了循环依赖的问题。

注意这里是延迟依赖查找而不是延迟初始化，ObjectFactory 无法决定是否延迟初始化，而需要通过配置 Bean 的 lazy 属性来决定这个 Bean 对象是否需要延迟初始化，非延迟初始化的 Bean 在 Spring 应用上下文刷新过程中就会初始化。

提示：如果是 ObjectFactory（或 ObjectProvider）类型的 Bean，在被依赖注入或依赖查找时返回的是 DefaultListableBeanFactory#DependencyObjectProvider 私有内部类，实现了 ObjectProvider<T> 接口，关联的类型为 Object。

25. 简述 FactoryBean？

FactoryBean 关联一个 Bean 对象，提供了一个 getObject() 方法用于返回这个目标 Bean 对象，FactoryBean 对象在被依赖注入或依赖查找时，实际得到的 Bean 就是通过 getObject() 方法获取到的目标类型的 Bean 对象。如果想要获取 FactoryBean 本身这个对象，在 beanName 前面添加 & 即可获取。

我们可以通过 FactoryBean 帮助实现复杂的初始化逻辑，例如在 Spring 继集成 MyBatis 的项目中，Mapper 接口没有实现类是如何被注入的？其实 Mapper 接口就是一个 FactoryBean 对象，当你注入该接口时，实际的到的就是其 getObject() 方法返回的一个代理对象，关于数据库的操作都是通过该代理对象来完成。

26. ObjectFactory、FactoryBean 和 BeanFactory 的区别？

根据其名称可以知道其字面意思分别是：对象工厂，工厂 Bean

ObjectFactory、FactoryBean 和 BeanFactory 均提供依赖查找的能力。

ObjectFactory 提供的是延迟依赖查找，想要获取某一类型的 Bean，需要调用其 getObject() 方法才能依赖查找到目标 Bean 对象。ObjectFactory 就是一个对象工厂，想要获取该类型的对象，需要调用其 getObject() 方法生产一个对象。

FactoryBean 不提供延迟性，在被依赖注入或依赖查找时，得到的就是通过 getObject() 方法拿到的实际对象。FactoryBean 关联着某个 Bean，可以说在 Spring 中它就是某个 Bean 对象，无需我们主动去调用 getObject() 方法，如果想要获取 FactoryBean 本身这个对象，在 beanName 前面添加 & 即可获取。

BeanFactory 则是 Spring 底层 IoC 容器，里面保存了所有的单例 Bean，ObjectFactory 和 FactoryBean 自身不具备依赖查找的能力，能力由 BeanFactory 输出。

27. @Bean 的处理流程是怎样的？

Spring 应用上下文生命周期，在 BeanDefinition（@Component 注解、XML 配置）的加载完后，会执行所有 BeanDefinitionRegistryPostProcessor 类型的处理器，Spring 内部有一个 ConfigurationClassPostProcessor 处理器，它会对所有的配置类进行处理，解析其内部的注解（@PropertySource、@ComponentScan、@Import、@ImportResource、@Bean），其中 @Bean 注解标注的方法会生成对应的 BeanDefinition 对象并注册。详细步骤可查看后续文章：《死磕 Spring 之 IoC 篇 - @Bean 等注解的实现原理》

28. BeanFactory 是如何处理循环依赖？

前言，下面的“循环依赖”换成“循环依赖注入”比较合适，在 Spring 中通过 depends-on 配置的依赖对象如果出现循环依赖会抛出异常

说明：这里的循环依赖指的是单例模式下的 Bean 字段注入时出现的循环依赖。构造器注入对于 Spring 无法自动解决（应该考虑代码设计是否有问题），可通过延迟初始化来处理。Spring 只解决单例模式下的循环依赖。

在 Spring 底层 IoC 容器 BeanFactory 中处理循环依赖的方法主要借助于以下 3 个 Map 集合：

singletonObjects（一级 Map），里面保存了所有已经初始化好的单例 Bean，也就是会保存 Spring IoC 容器中所有单例的 Spring Bean；
earlySingletonObjects（二级 Map），里面会保存从 三级 Map 获取到的正在初始化的 Bean
singletonFactories（三级 Map），里面保存了正在初始化的 Bean 对应的 ObjectFactory 实现类，调用其 getObject() 方法返回正在初始化的 Bean 对象（仅实例化还没完全初始化好），如果存在则将获取到的 Bean 对象并保存至 二级 Map，同时从当前 三级 Map 移除该 ObjectFactory 实现类。
当通过 getBean 依赖查找时会首先依次从上面三个 Map 获取，存在则返回，不存在则进行初始化，这三个 Map 是处理循环依赖的关键。

例如两个 Bean 出现循环依赖，A 依赖 B，B 依赖 A；当我们去依赖查找 A，在实例化后初始化前会先生成一个 ObjectFactory 对象（可获取当前正在初始化 A）保存在上面的 singletonFactories 中，初始化的过程需注入 B；接下来去查找 B，初始 B 的时候又要去注入 A，又去查找 A ，由于可以通过 singletonFactories 直接拿到正在初始化的 A，那么就可以完成 B 的初始化，最后也完成 A 的初始化，这样就避免出现循环依赖。

问题一：为什么需要上面的 二级 Map ？

因为通过 三级 Map获取 Bean 会有相关 SmartInstantiationAwareBeanPostProcessor#getEarlyBeanReference(..) 的处理，避免重复处理，处理后返回的可能是一个代理对象

例如在循环依赖中一个 Bean 可能被多个 Bean 依赖， A -> B（也依赖 A） -> C -> A，当你获取 A 这个 Bean 时，后续 B 和 C 都要注入 A，没有上面的 二级 Map的话，三级 Map 保存的 ObjectFactory 实现类会被调用两次，会重复处理，可能出现问题，这样做在性能上也有所提升

问题二：为什么不直接调用这个 ObjectFactory#getObject() 方法放入 二级Map 中，而需要上面的 三级 Map？

对于不涉及到 AOP 的 Bean 确实可以不需要 singletonFactories（三级 Map），但是 Spring AOP 就是 Spring 体系中的一员，如果没有singletonFactories（三级 Map），意味着 Bean 在实例化后就要完成 AOP 代理，这样违背了 Spring 的设计原则。Spring 是通过 AnnotationAwareAspectJAutoProxyCreator 这个后置处理器在完全创建好 Bean 后来完成 AOP 代理，而不是在实例化后就立马进行 AOP 代理。如果出现了循环依赖，那没有办法，只有给 Bean 先创建代理对象，但是在没有出现循环依赖的情况下，设计之初就是让 Bean 在完全创建好后才完成 AOP 代理。

提示：AnnotationAwareAspectJAutoProxyCreator 是一个 SmartInstantiationAwareBeanPostProcessor 后置处理器，在它的 getEarlyBeanReference(..) 方法中可以创建代理对象。所以说对于上面的问题二，如果出现了循环依赖，如果是一个 AOP 代理对象，那只能给 Bean 先创建代理对象，设计之初就是让 Bean 在完全创建好后才完成 AOP 代理。

为什么 Spring 的设计是让 Bean 在完全创建好后才完成 AOP 代理？

因为创建的代理对象需要关联目标对象，在拦截处理的过程中需要根据目标对象执行被拦截的方法，所以这个目标对象最好是一个“成熟态”，而不是仅实例化还未初始化的一个对象。

29. Spring 中几种初始化方法的执行顺序？

有以下初始化方式：

Aware 接口：实现了 Spring 提供的相关 XxxAware 接口，例如 BeanNameAware、ApplicationContextAware，其 setXxx 方法会被回调，可以注入相关对象

@PostConstruct 注解：该注解是 JSR-250 的标准注解，Spring 会调用该注解标注的方法

InitializingBean 接口：实现了该接口，Spring 会调用其 afterPropertiesSet() 方法

自定义初始化方法：通过 init-method 指定的方法会被调用

在 Spring 初始 Bean 的过程中上面的初始化方式的执行顺序如下：

Aware 接口的回调

JSR-250 @PostConstruct 标注的方法的调用

InitializingBean#afterPropertiesSet 方法的回调

init-method 初始化方法的调用

30. 通过 @Bean 注解定义在方法上面注入一个 Spring Bean，每次调用该方法所属的 Bean 的这个方法，得到的是同一个对象吗？

举个例子，大多数情况下，@Configuration Class 会通过 @Bean 注解为 Bean 定义，比如 @Bean User user() { return new User(); }，那这样是不是每次主动调用这个方法都会返回一个新的 User 对象呢？

不是的，@Configuration Class 在得到 CGLIB 提升后，会设置一个拦截器专门对 @Bean 方法进行拦截处理，通过依赖查找的方式从 IoC 容器中获取 Bean 对象，如果是单例 Bean，那么每次都是返回同一个对象，所以当主动调用这个方法时获取到的都是同一个 User 对象。

__EOF__

