# showapi_sdk_ios

[![CI Status](http://img.shields.io/travis/bluedarker/ShowAPI_SDK.svg?style=flat)](https://travis-ci.org/bluedarker/ShowAPI_SDK)
[![Version](https://img.shields.io/cocoapods/v/ShowAPI_SDK.svg?style=flat)](http://cocoapods.org/pods/ShowAPI_SDK)
[![License](https://img.shields.io/cocoapods/l/ShowAPI_SDK.svg?style=flat)](http://cocoapods.org/pods/ShowAPI_SDK)
[![Platform](https://img.shields.io/cocoapods/p/ShowAPI_SDK.svg?style=flat)](http://cocoapods.org/pods/ShowAPI_SDK)

## Example

To run the test example project, clone the repo, and run `pod install` from the Example directory first.

Then run Tests/Tests.m in XCode


## Requirements

## Installation

ShowAPI_SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod "ShowAPI_SDK"
```

## Usage

### 首先需要导入“ShowAPI_SDK”

```objective-c
#import <ShowAPI_SDK/ShowAPIRequest.h>
```

### 普通方式请求showapi数据，这里以全球IP归属地查询为例

```objective-c
//创建请求实例
//这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/console#/myApp
ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"appid" andSign:@"secret" ];

//调用彩票开奖查询api
[request post:@"https://route.showapi.com/20-1"//IP归属地查询接入点的接口url，
timeout:20000//超时设置为20秒
params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"116.4.201.181",@"ip", nil]//传入ip
withCompletion:^(NSDictionary<NSString *,id> *result) {
//打印返回结果

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
// NSData转为NSString
NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

NSLog(@"返回结果为：%@",jsonStr);


}];
```

### 带上传文件方式请求showapi数据，这里以二维码识别为例

```objective-c
//文件需要换为你自己的测试文件
NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"showapi" withExtension:@"jpg"];
NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
//    NSLog(@"img is:%@",imgData);


//创建请求实例
//这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/console#/myApp
ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"appid" andSign:@"secret" ];

//验证码识别api
[request post:@"https://route.showapi.com/887-2"//二维码识别接口地址
timeout:20000//超时设置为20秒
params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"1",@"handleImg", nil] //普通传入参数
fileParams:[[NSDictionary<NSString*,NSData*> alloc] initWithObjectsAndKeys:imgData,@"img", nil] //文件参数
withCompletion:^(NSDictionary<NSString *,id> *result) {
//打印返回结果

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
// NSData转为NSString
NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

NSLog(@"返回结果为：%@",jsonStr);

} ];


```

### 上传文件使用base64编码文件post请求showapi数据，这里以二维码识别为例

```objective-c
//文件需要换为你自己的测试文件
NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"showapi" withExtension:@"jpg"];
NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
//    NSLog(@"img is:%@",imgData);

//base64编码文件为base64字符串
NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];

//创建请求实例
//这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/console#/myApp
ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"appid" andSign:@"secret" ];

//验证码识别api
[request post:@"https://route.showapi.com/887-4"//二维码识别接口地址
timeout:20000//超时设置为20秒
params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"1",@"handleImg",encodedImageStr,@"imgData", nil] //普通传入参数
withCompletion:^(NSDictionary<NSString *,id> *result) {
//打印返回结果

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
// NSData转为NSString
NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

NSLog(@"返回结果为：%@",jsonStr);

} ];


```

## Author

bluespring, wd_lan@showapi.com

## License

ShowAPI_SDK is available under the MIT license. See the LICENSE file for more info.
