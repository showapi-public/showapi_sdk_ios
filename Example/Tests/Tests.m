//
//  ShowAPI_SDKTests.m
//  ShowAPI_SDKTests
//
//  Created by bluedarker on 04/20/2017.
//  Copyright (c) 2017 bluedarker. All rights reserved.
//

@import XCTest;
#import <ShowAPI_SDK/ShowAPIRequest.h>

@interface Tests : XCTestCase

@property NSString* appid;

@property NSString* secret;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    //这里需要替换为您自己的appid和secret，您可以在这里找到https://www.showapi.com/app/editApp
    self.appid=@"";
    self.secret=@"";
    
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNormalPost
{
    XCTestExpectation * expectation = [self expectationWithDescription:@"post timeout exception"];
    
    //创建请求实例
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:self.appid andSign:self.secret ];
    
    //调用彩票开奖查询api
    [request post:@"https://route.showapi.com/44-1"//最新开奖接入点的接口url，注意您需要先订购该接口免费套餐才能测试
          timeout:20000//超时设置为20秒
           params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"ssq",@"code", nil]//传入特定参数查询双色球最新开奖信息
   withCompletion:^(NSDictionary<NSString *,id> *result) {
       //打印返回结果
       
        NSLog(@"返回结果为：%@",result);
        
        [expectation fulfill];
    } ];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        //Do something when time out
    }];
}

- (void)testFilePost
{
    XCTestExpectation * expectation = [self expectationWithDescription:@"post timeout exception"];
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"showapi" withExtension:@"jpg"];
    NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
//    NSLog(@"img is:%@",imgData);
    
    //创建请求实例
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:self.appid andSign:self.secret ];
    
    //验证码识别api
    [request post:@"https://route.showapi.com/887-2"//验证码识别接口地址，注意您需要先订购该接口免费套餐才能测试
          timeout:20000//超时设置为20秒
           params:[[NSDictionary<NSString*,NSString*> alloc] initWithObjectsAndKeys:@"1",@"handleImg", nil]     fileParams:[[NSDictionary<NSString*,NSData*> alloc] initWithObjectsAndKeys:imgData,@"img", nil]
   withCompletion:^(NSDictionary<NSString *,id> *result) {
       //打印返回结果
       
       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
       // NSData转为NSString
       NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
       
       NSLog(@"返回结果为：%@",jsonStr);
       
       [expectation fulfill];
   } ];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        //Do something when time out
    }];
}

@end

