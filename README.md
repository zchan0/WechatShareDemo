# WechatShareDemo

## Installation

这里的安装主要是一些前期准备，包括获取 AppID，集成微信的 WechatOpenSDK 等。

### Step 1

在[微信开放平台](https://open.weixin.qq.com/)注册应用程序ID，获得AppID。

>  *微信对新建的应用需要审核，审核需要7天，所以这里借用了[WeDemo](https://github.com/Tencent/WeDemo)的AppID*

### Step 2

1. 添加URL schemes为AppID，这样微信可以回调起你的app。

   ![](https://ww1.sinaimg.cn/large/006tNbRwgy1fea42f8zsjj318505gdgd.jpg)

2. 在info.plist中添加白名单，否则在没有安装微信的环境（比如模拟器）中会报错 `-canOpenURL: failed for URL`

   ![](https://ww4.sinaimg.cn/large/006tNbRwgy1fea42e7pg9j30mk01qdfx.jpg)

### Step 2

1. 通过 CocoaPods 集成微信 SDK

   ```
   pod 'WechatOpenSDK'
   ```

2. 添加 Objective-C Bridging Header 

   > 确认在Building setting - Swift Compiler - Code Generation 中添加了bridging header的路径。比如"“YourApp/YourApp-Bridging-Header.h”

3. 在 `YourApp-Bridging-Header.h` 中添加下面的代码

   ```objective-c
   #import “WXApi.h”
   ```

   然后不用`import`，就可以在Swift中使用相关方法了。

## Usage

1. 向微信终端程序注册第三方应用

   ```swift
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
           WXApi.registerApp("APP-ID")
           return true
   }
   ```

2. 发送请求到微信

   过程：创建多媒体消息(`WXMediaMessage`)或者富文本(`String`)消息，然后创建`SendMessageToWXReq`请求，最后通过`WXApi.send()`方法向微信发起请求。

   ```swift
   // 1. 创建多媒体消息(WXMediaMessage)或者富文本(String)消息
   class func message(_ title: String?, _ description: String?, _ mediaObject: Any, _ messageExt: String? = nil, _ messageAction: String? = nil, _ thumbImage: UIImage? = nil, _ tagName: String? = nil) -> WXMediaMessage {
       ...
   }

   // 2. 创建SendMessageToWXReq请求
   class func request(_ text: String?, _ message: WXMediaMessage?, _ bText: Bool, inScene scene: WXScene) -> SendMessageToWXReq {
       ...
   }

   // 3. 通过WXApi.send()方法向微信发起请求
   let message = WXMediaMessage.message(nil, nil, ext, messageExt, action, thumbImage, tagName)
   let request = SendMessageToWXReq.request(nil, message, false, inScene: scene)
   WXApi.send(request)
   ```

3. 处理微信的回应

   遵守 `WXApiDelegate` 协议，实现 `onResp` 方法

## Demo

Demo 简单封装了一个 `ShareManager`，并提供下面三种分享方式。

```swift
// 分享文字
ShareManager.shared.sendText(text, inScene: WXSceneSession)
// 分享图片
ShareManager.shared.sendImage(imageData, inScene: WXSceneTimeline)
// 分享网页链接
let url = "https://httpbin.org/get"
ShareManager.shared.sendLink(url, text, inScene: WXSceneSession)	
```

