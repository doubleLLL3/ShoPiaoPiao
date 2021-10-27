# ShoPiaoPiao

> An App, like TaoPiaoPiao, called ShoPiaoPiao, takes you start to study iOS.
>
> 一个类似淘票票的《虾票票》App，带你入门iOS～

## Outline 系列大纲

![大纲](https://cdn.jsdelivr.net/gh/doubleLLL3/blogImgs@main/img/image-20211023233448103.png)

1. [定位与目标](https://mp.weixin.qq.com/s?__biz=Mzg3MzU3ODIxNg==&mid=2247484201&idx=1&sn=bbc328b36d7bcd5737d6508dcc2a03b2&chksm=cedca8aef9ab21b8bb10a5cc04e349c58b257e6a24886255c19373dac7265bd0dc7356f82636&scene=178&cur_album_id=2056906778021298177#rd)
2. [iOS简史与工程创建](https://mp.weixin.qq.com/s?__biz=Mzg3MzU3ODIxNg==&mid=2247484230&idx=1&sn=5570b91784500b2da61e7779d095a302&chksm=cedca8c1f9ab21d72ed3368e9613e25a385ae37ff1840834f6ef5ddd24caeff4ffb2700ff153&scene=178&cur_album_id=2056906778021298177#rd)
3. [iOS常用UI组件](https://mp.weixin.qq.com/s?__biz=Mzg3MzU3ODIxNg==&mid=2247484310&idx=1&sn=4c16825fb9ea40f1cc0c012b22929dba&chksm=cedca811f9ab21075ab9109acc686e9ab206c8bb1d0694e29004381df1f051c94e6e0895bedc&scene=178&cur_album_id=2056906778021298177#rd)
4. [Xcode调试](https://mp.weixin.qq.com/s?__biz=Mzg3MzU3ODIxNg==&mid=2247484371&idx=1&sn=2f1e8cb8f074114ed548f4da3bc9f77d&chksm=cedca854f9ab2142ad67c2a76ab2774fb26f6fbf14bddedaef093eff753016983b84022de47c&scene=178&cur_album_id=2056906778021298177#rd)
5. [CocoaPods介绍与使用](https://mp.weixin.qq.com/s?__biz=Mzg3MzU3ODIxNg==&mid=2247484399&idx=1&sn=e8850b7ec6b0da4e61293385cfcc72b8&chksm=cedca868f9ab217e4182a3ddc9dbbde30cb97ae3f20ca570343d99cedd59561a51d79dfa2f7a&scene=178&cur_album_id=2056906778021298177#rd)

## Example 示例

To run the example project, `clone`  the repo, and run `pod install` from the Example directory first.

如果想跑下面的Demo，首先 `clone` 这个仓库，并在Example目录下运行 `pod install` 命令。

<br>

⚠️：在运行工程的同时还需要在**本地**开启**后端服务**，提供首页的**电影列表数据**：

1）`cd` 到PythonServices目录下

2）运行 `python -m SimpleHTTPServer 8888` ，注意请求时的地址和端口号为 0.0.0.0 和 8888

*相关代码*：

./ShoPiaoPiao/Classes/BKEHomePage/Controller/**BKEHomeViewController.m**：

```objective-c
#define kRequestURLForMovieBasicWithIndex @"http://0.0.0.0:8888/data%ld.json"
```

PS：

- 首页的**电影列表数据**来自本地服务，详情页的**电影详细数据**来自网络。

- http协议的网址默认不能被访问，请确认是否设置了权限。

<br>

![虾票票V1.0](./ShoPiaoPiaoV1.0.gif)

**核心代码结构**：

```
ShoPiaoPiao
└── Classes
    ├── BKEDetailPage                       # 详情页
    │   ├── Controller
    │   │   ├── BKEIntroViewController.h
    │   │   └── BKEIntroViewController.m
    │   ├── Model
    │   │   ├── BKEMovieDetailModel.h
    │   │   └── BKEMovieDetailModel.m
    │   └── View
    │       ├── BKEDetailTableViewCell.h
    │       ├── BKEDetailTableViewCell.m    ## 详细介绍单元
    │       ├── BKEInfoTableViewCell.h
    │       ├── BKEInfoTableViewCell.m      ## 基本信息单元
    │       ├── BKEPurchaseTableViewCell.h
    │       └── BKEPurchaseTableViewCell.m  ## 购买单元
    └── BKEHomePage                         # 主页
        ├── Controller
        │   ├── BKEHomeViewController.h
        │   └── BKEHomeViewController.m
        ├── Model
        │   ├── BKEMovieBasicModel.h
        │   └── BKEMovieBasicModel.m
        └── View
            ├── BKEHomeTableViewCell.h
            └── BKEHomeTableViewCell.m      ## 电影条目单元
```

## Welcome to issue! 

欢迎交流！

## Author 作者

doubleLLL3, doubleliu3@gmail.com
