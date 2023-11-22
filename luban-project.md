已完成
-------------------------------

# 上传附件功能
AttachController#uploadAttachInfo(文件MultipartFile)
填写入驻信息，上传图片时调用该方法。生成一个随机的UUID作为文件名，将图片存到磁盘，并将图片信息存到数据库，相应数据库表的字段包括图片uuid，图片原文件名，`business_id`、`business_type`等，其中`business_id`和`business_type`此时还未知，所以其值为null；返回的数据包括图片id、uuid和路径，这些图片信息会由前端发给`worker-server`服务器。

# 师傅入驻功能
WorkerController#createWorker(姓名，手机号，身份证号，图片地址，区域id，类型id)

-> 直接调用WorkerService#create (加了事务: @Transactional(rollbackFor = Exception.class)):
- 对上传的图片进行初步验证，检测身份证的名字是否和用户提交的名字一致（如何识别图片中的文字？），不一致则直接返回业务异常
- 从SecurityContext中获取用户ID，并从传入的参数中读取其他用户信息，将这些信息存储到数据库，然后调用RPC接口更新相应图片的`business_id`和`business_type`的值。
- 将服务区域信息保存到数据库
- 将服务种类信息保存到数据库

# 查询师傅详情
WorkerController#workerDetail

-> 直接调用WorkerService#getWorkerDetail:
- 查询服务区域、服务种类、附件（调用RPC）、账户（调用RPC）、审核通过信息



待整理
-------------------------------

passport模块自定义了一个SecurityContext，里面封装一个ThreadLocal，用以存储登录用户的信息，它对于同一个线程中的所有方法而言是共享的

# 查询师傅相关信息时进行缓存

缓存存放
- worker
- area
- category

为了让repository实现类与缓存的框架解耦，在其中不是直接调用框架的API，而是使用一个缓存的接口：
interface CacheEntry<T>:
方法：
- exists
- saveCache (存储String类型数据)
- saveCaches （存储列表类型数据）
- getCache
- getCaches
其中保存缓存的方法可以定义重载的方法设置超时时间

再定义一个类使用Redis缓存方式实现这些方法：
RedisCacheEntry<T> implements CacheEntry<T>

对于需要存储的各种类型，分别定义各自的类，通过调用RedisCacheEntry的跟缓存操作相关的通用方法定义各自的业务方式:
- WorkerRepoImpl extends RedisCacheEntry<WorkerBO>
- WorkerAreaBO extends RedisCacheEntry<WorkerAreaBO>
- WorkerCategoryBO extends RedisCacheEntry<WorkerCategoryBO>

为了避免缓存击穿问题，对于热点数据的查询，令其在查询之前先获取到分布式锁，如果没有获取到，则等待一定时间。这样当一个请求成功抢到锁并读取后，查询的数据就会被读取到缓存中，所以加锁对性能的影响并不大。

# 记录

git:
- 师傅入驻：`师傅入驻基本搭建` -> `师傅入驻 完成`
- 师傅查询：`师傅详情查询-业务层` -> HEAD


# 师傅审核功能
相应的类：
com.tarena.tp.luban.worker.admin.service.WorkerAdminService

启动项目所需启动的程序：
- Nacos
- passport jar
- GatewayApplication
- luban-admin-front
- com.tarena.tp.luban.worker.admin.WorkerAdminApplication

WorkerAdminService#getAreaDetails:
获取地区详情

WorkerAdminService#getCategoryDetails:
获取分类详情

WorkerAdminService#auditList:
查询师傅列表，包括id，分类详情，地区详情

WorkerAdminService#auditDetail:
获取师傅基本信息，服务区域，服务类型，审核日志，身份认证图片等信息以供审核

WorkerAdminService#getAttachList:
使用RPC (com.tarena.tp.attach.server.client.AttachApi) 获取附件（图片）信息

WorkerAdminService#auditAdd:
审核人员通过师傅的审核后会触发该方法，该方法提交审核信息，然后通过RPC创建账号


# 抢需求单并创建订单

OrderController#create(需求单编号、类型、价格，用户姓名、手机等):
远程调用RequestOrderApi接口创建订单，抢单失败抛出相应异常，成功则生成订单（包括在orderParam中绑定用户ID（从SecurityContext中获取），生成订单编号，写入订单状态，然后将orderParam中的数据存入数据库），然后再生成日志（根据用户ID，订单编号，订单状态创建orderLogParam，然后将其中的数据存入数据库）

-> OrderService#create
通过RPC调用RequestOrderApi远程接口进行抢单，如果抢到了，从SecurityContext中获取用户ID，生成随机的UUID作为订单编号，设置订单状态，然后将订单写入数据库并生成日志。

-> DemandRpcImpl implements RequestOrderApi#grabOrder(需求单编号)
DemandRpcImpl使用CAS方式
使用CAS更新数据库：表格中有一个version字段，更新前先获取version，更新时需要将当前version与之前查到的version进行比较，相等时才更新数据，更新时同时将version加1。这种方式只适合少量并发的场景（因为所有线程都会执行SQL语句，只不过只有一个能修改成功）。

-> DemandService#grabOrder(需求单编号)


# gateway (com.tarena.tp.luban.gateway)

通过解析JWT验证用户的登录信息，主要的类为AuthenticationFilter:
从JWT获取用户信息，转化为JSON字符串后存入请求头并向后传递；如果对于需要验证JWT的请求解析JWT出错，则响应相应的错误信息

# RPC

RPC接口：
com.tarena.tp.attach.server.client.AttachApi
添加、获取、删除附件信息

实现类：
com.tarena.tp.attach.server.provider.service.AttachRpcService
调用普通的Service类（com.tarena.tp.attach.server.manager.AttachService）来实现接口的方法


RPC接口：
AccountApi:
师傅入驻的审核通过后在平台创建账户，查询账户，向账号打款

实现类：
AccountRpcImpl:
调用普通的Service类（AccountService）来实现接口方法，create方法具有幂等性（通过相应的repository方法获取账号信息，如果accountBO为null或者账号的余额为null，则意味着账号不存在）

---




查询当前用户的订单列表:
OrderService#orderList
通过SecurityContext获取当前用户的ID，然后通过ID查询其名下的所有订单

查询订单详情：
OrderService#orderDetail
首先通过参数查询订单是否存在，如果存在则根据订单编号和业务类型通过RPC查询与其绑定的图片，如果图片列表非空则将图片列表存入订单信息对应的结果对象（图片并没有包含在通过订单编号查询出来的订单信息中，而是存在单独的表中）。

到达现场后签到：
OrderService#sign
首先通过参数查询订单是否存在以及流转状态是否正常，如果正常的话更改订单状态为已签到，记录订单日志

上传施工图片：
OrderService#confirm
首先通过参数查询订单是否存在以及流转状态是否正常，如果正常的话且图片数量不为0的话，则对图片进行业务绑定，绑定订单ID，然后更改订单状态为"正在施工并上传施工图片"，最后记录订单日志

施工完成后结算
OrderService#finish

首先通过参数查询订单是否存在以及流转状态是否正常，如果正常的话更改订单状态为已完成待结算，记录订单日志，并发送消息给结算中心进行结算。

---
发送消息的业务接口定义在domain层，而实现类定义在adapter层
完成订单后发送结算的消息给结算中心

