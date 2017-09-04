# ShowAPI_SDK

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

### 普通方式请求showapi数据，这里以彩票数据为例

```objective-c
//创建请求实例
//这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/app/editApp
ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"appid" andSign:@"secret" ];

//调用彩票开奖查询api
[request post:@"https://route.showapi.com/44-1"//最新开奖接入点的接口url，注意您需要先订购该接口免费套餐才能测试
timeout:20000//超时设置为20秒
params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"ssq",@"code", nil]//传入特定参数查询双色球最新开奖信息
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
//这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/app/editApp
ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"appid" andSign:@"secret" ];

//验证码识别api
[request post:@"https://route.showapi.com/887-2"//验证码识别接口地址，注意您需要先订购该接口免费套餐才能测试
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

## Author

bluedarker, bluedarker@gmail.com

## License

ShowAPI_SDK is available under the MIT license. See the LICENSE file for more info.
