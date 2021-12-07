# file-upload-download && file-online-preview

[toc]

## 概述

fork 大佬的 [kkFileView](https://github.com/kekingcn/kkFileView) 开源项目（感谢大佬感谢开源），该项目为文件文档在线预览项目解决方案，支持主流办公文档的在线预览，但是原来的项目对我有三点不足，因此做了一些改进：

1. 上传下载感觉不完善，可视化的时候需要一些限制（如url中需要有文件名）
2. 缺少数据管理，个人认为应该将数据的元数据入库进行更好的管理
3. 缺少地理数据的可视化（我是学 gis 的，加了一些可视化的方法）

## 项目原始资源

[官网](https://kkfileview.keking.cn)    [GitHub](https://github.com/kekingcn/kkFileView)

## 文档预览效果

#### 1. 文本预览

支持所有类型的文本文档预览， 由于文本文档类型过多，无法全部枚举，默认开启的类型如下 txt,html,htm,asp,jsp,xml,json,properties,md,gitignore,log,java,py,c,cpp,sql,sh,bat,m,bas,prg,cmd
文本预览效果如下
[![文本预览效果如下](D:/NNU/%E7%AC%94%E8%AE%B0/picture/68747470733a2f2f6b6b66696c65766965772e6b656b696e672e636e2f696d672f707265766965772f707265766965772d746578742e706e67)](https://camo.githubusercontent.com/512f7943d4f2321d010a4598d985a00d386dc663830689580d0f5a8a8c93f9e4/68747470733a2f2f6b6b66696c65766965772e6b656b696e672e636e2f696d672f707265766965772f707265766965772d746578742e706e67)

#### 2. 图片预览

支持jpg，jpeg，png，gif等图片预览（翻转，缩放，镜像），预览效果如下
[![图片预览](D:/NNU/%E7%AC%94%E8%AE%B0/picture/68747470733a2f2f6b6b66696c65766965772e6b656b696e672e636e2f696d672f707265766965772f707265766965772d696d6167652e706e67)](https://camo.githubusercontent.com/c685314b9f12dec2b2fdd0383a93feb6761dab96e758d3d629e057be03312ba7/68747470733a2f2f6b6b66696c65766965772e6b656b696e672e636e2f696d672f707265766965772f707265766965772d696d6167652e706e67)

#### 3. word文档预览
支持doc，docx文档预览，word预览有两种模式：一种是每页word转为图片预览，另一种是整个word文档转成pdf，再预览pdf。两种模式的适用场景如下  
* 图片预览：word文件大，前台加载整个pdf过慢
* pdf预览：内网访问，加载pdf快
图片预览模式预览效果如下  
![word文档预览1](https://kkfileview.keking.cn/img/preview/preview-doc-image.png)  
pdf预览模式预览效果如下  
![word文档预览2](https://kkfileview.keking.cn/img/preview/preview-doc-pdf.png)  

#### 4. ppt文档预览
支持ppt，pptx文档预览，和word文档一样，有两种预览模式  
图片预览模式预览效果如下  
![ppt文档预览1](https://kkfileview.keking.cn/img/preview/preview-ppt-image.png)  
pdf预览模式预览效果如下  
![ppt文档预览2](https://kkfileview.keking.cn/img/preview/preview-ppt-pdf.png)  

#### 5. pdf文档预览
支持pdf文档预览，和word文档一样，有两种预览模式   
图片预览模式预览效果如下  
![pdf文档预览1](https://kkfileview.keking.cn/img/preview/preview-pdf-image.png)  
pdf预览模式预览效果如下   
![pdf文档预览2](https://kkfileview.keking.cn/img/preview/preview-pdf-pdf.png)    

#### 6. excel文档预览
支持xls，xlsx文档预览，预览效果如下  
![excel文档预览](https://kkfileview.keking.cn/img/preview/preview-xls.png)  

#### 7. 压缩文件预览
支持zip,rar,jar,tar,gzip等压缩包，预览效果如下  
![压缩文件预览1](https://kkfileview.keking.cn/img/preview/preview-zip.png)  
可点击压缩包中的文件名，直接预览文件，预览效果如下  
![压缩文件预览2](https://kkfileview.keking.cn/img/preview/preview-zip-inner.png)  

#### 8. 多媒体文件预览
理论上支持所有的视频、音频文件，由于无法枚举所有文件格式，默认开启的类型如下  
mp3,wav,mp4,flv  
视频预览效果如下  
![多媒体文件预览1](https://kkfileview.keking.cn/img/preview/preview-video.png)  
音频预览效果如下  
![多媒体文件预览2](https://kkfileview.keking.cn/img/preview/preview-audio.png)  

#### 9. CAD文档预览
支持CAD dwg文档预览，和word文档一样，有两种预览模式  
图片预览模式预览效果如下  
![cad文档预览1](https://kkfileview.keking.cn/img/preview/preview-cad-image.png)  
pdf预览模式预览效果如下  
![cad文档预览2](https://kkfileview.keking.cn/img/preview/preview-cad-pdf.png)  
考虑说明篇幅原因，就不贴其他格式文件的预览效果了，感兴趣的可以参考下面的实例搭建下

### 快速开始
> 项目使用技术
- spring boot： [spring boot开发参考指南](http://www.kailing.pub/PdfReader/web/viewer.html?file=springboot)
- freemarker
- redisson 
- jodconverter
> 依赖外部环境
- redis (可选，默认不用)
- OpenOffice 或者 LibreOffice( Windows 下已内置，Linux 脚本启动模式会自动安装，Mac OS 下需要手动安装)

1. 第一步：pull 项目 https://github.com/kekingcn/file-online-preview.git

3. 第二步：运行 ServerMain 的 main 方法，服务启动后，访问 http://localhost:8012/
会看到如下界面，代表服务启动成功
   

![输入图片说明](https://gitee.com/uploads/images/2017/1213/100221_ea15202e_492218.png "屏幕截图.png")

https://starchart.cc/kekingcn/kkFileView)