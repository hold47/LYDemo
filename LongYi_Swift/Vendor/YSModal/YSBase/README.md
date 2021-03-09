# YSBase
常用的一些基类

## 环境
swift5.0、iOS10.0

## 使用步骤 
1、导入框架

```swift
pod 'YSBase'
```

2、导入命名空间

```swift
import YSBase
```

## 简单介绍
抽取了1个控制器基类：YSBaseVC

抽取了6个cell的基类：YSBaseCell_colv_headerFooter、YSBaseCell_colv、YSBaseCell_tbv_default、YSBaseCell_tbv_subtitle、YSBaseCell_tbv_value1、YSBaseCell_tbv_value2

抽取了1个视图基类：YSBaseV_loadingIndicator

## 功能介绍
6个cell的基类：功能异常简单，不再做过多描述，仅仅提供了2个方法：setupProperty、setupUI，直接点进头文件查看即可。

1个视图基类：需要有loading效果的视图可以继承YSBaseV_loadingIndicator，里面提供了如下方法：
```swift

/// 创建loading子视图，默认已实现，需要自定义的时候重写此方法
open func ys_createLoadingIndicatorView() -> YSLoadingIndicatorView

/// loading子视图开启，需要开启时直接调用此方法即可
public func ys_startLoadingIndicatorView(){

/// loading子视图结束，需要结束时直接调用此方法即可
public func ys_stopLoadingIndicatorView(){
```

1个控制器基类：基类提供以下6个只读属性供子类访问：ys_alias、viewWillAppear_first、viewDidAppear_first、viewWillDisappear_first、viewDidDisappear_first、viewDidLayoutSubviews_first。注意：使用的时候请先调用 super.相应方法()。

此外，还提供一个方法 init_execute ，即初始化后执行的方法。子类如果有需要在初始化后执行一些代码，如添加监听通知，直接重写 init_execute ，在 init_execute 里面书写代码即可。

别外，还提供了loading效果，实现方式和上面的视图基类的完全一样，照葫芦画瓢即可。
