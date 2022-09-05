<!-- TOC -->
* [整体架构](#)
    * [1.软件后台架构](#1)
    * [2.软件前台架构](#2)
* [数据流传递](#)
<!-- TOC -->

# 整体架构

### 1.软件后台架构

采用标准的三层架构：

- Models层用于底层获取数据和对应的序列化过程

- Service层用于包装数据提供接口

- Controller层用于提供良好易用的接口

后台采用Python语言的fastapi框架编写，数据采用request库请求再用beautifulsoup库解析得到（网络爬虫获得）。

### 2.软件前台架构

如下图：

![img](https://vfchdrh6q6.feishu.cn/space/api/box/stream/download/asynccode/?code=Yzc3OTg1MzQwOGE0YTVjYzEyZDliYTc1ZjAwZDJkZjVfUGlib2dBRzdXVkMydWY5MDJpaFdHVVV6YzFybUVDV0FfVG9rZW46Ym94Y25paHZRcjlKNGdwQld1b1ppV05zdnJoXzE2NjIzNTY0NDE6MTY2MjM2MDA0MV9WNA)

整个前台采用跨平台方案flutter框架进行编写

界面如下：

![img](https://vfchdrh6q6.feishu.cn/space/api/box/stream/download/asynccode/?code=ZGFiNDJlNTMyNGE3MzAwN2VjNmY4NWU4ZTg3NTJlYjlfSVlRVkl2cmVYYkx3RDJPbG9tZDNvMXRSS2wxWVZwOURfVG9rZW46Ym94Y255bzFwRU5BekRTNlpialc5b3V6V3FiXzE2NjIzNTY0NDE6MTY2MjM2MDA0MV9WNA)

# 数据流传递

1. 从Api网络调用层级请求得到对应的Future数据 。

1. 传递Future到Service层级。

1. **Service**根据UI的需求返回对应的 `Future<QuestionResponse>` ，且封装默认数据（用于不存在的时的数据）。

1. 在UI层的 `MyHomePage` 主界面点击按钮后，通过await同步得到Future里的 `QuestionResponse` 数据并将该数据用于构建一个新的 `QuestionPage` 界面。

1. `QuestionPage` 中通过封装好各个方法通过对应的动作来操作数据生成新的界面。比如题目通过更新 `_index` 下标再 `setState` 来实现重建，答案则通过 `showAnswer` 这个bool标志来判断是否需要显示...

1. 由于每次答案都是得到的Future数据，所以可以在界面中使用 `FutureBuilder` 来实现数据的展示。

**坑点：**

- 注意Future数据不能在底层进行await同步，否则界面层进行调用时数据会得不到，所以网络数据最好是直接传毒Future或者Stream。

- 注意每个异常的处理，否则它将会导致处理数据的底层完全崩溃（异常不被处理将不再往下走，UI界面表现正常，但是数据无），Flutter很多地方都很容易发生异常，比如类型的强制转化不成功将导致异常（如int转Int64），或者空安全将导致异常（采用?则表示断言会告诉你出现错误的地方，而如果采用!则表示一定不为空，则直接抛出异常很难察觉发生在哪）。
