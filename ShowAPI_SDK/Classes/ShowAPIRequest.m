#import "ShowAPIRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#define CC_MD5_DIGEST_LENGTH 16

@interface ShowAPIRequest()
- (NSString*)createSecretParam:(NSDictionary*) params;
- (NSString*)md5:(NSString*)secret;

@end

@implementation ShowAPIRequest

-(id)initWithAppid:(NSString*)appid andSign:(NSString*)sign
{
    if(self=[super init])
    {
        showapi_appid=appid;
        showapi_sign=sign;
        
    }
    return self;
}



-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params fileParams:(NSDictionary<NSString*,NSData*>*) fileParams withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion{
    
    bool hasFile=!(fileParams==nil||[fileParams count]==0);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    manager.requestSerializer.timeoutInterval=timeout;
        
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"text/html", nil];
    
   
    if(hasFile){
        [manager POST:url parameters:[self createSecretParam:params] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            for(NSString *key in fileParams){
                
                [formData appendPartWithFileData:fileParams[key] name:key fileName:key mimeType:@"image/*"];
            }
            
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        NSLog(@"post成功 %@", responseObject);
            completion(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            //        NSLog(@"post失败 %@", error);
            completion([[NSDictionary<NSString*,id> alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:-1],@"showapi_res_code",[error debugDescription],@"showapi_res_error", nil]);
        }];
    }else{
        [manager POST:url parameters:[self createSecretParam:params]
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  //        NSLog(@"post成功 %@", responseObject);
                  completion(responseObject);
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  //        NSLog(@"post失败 %@", error);
                  completion([[NSDictionary<NSString*,id> alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:-1],@"showapi_res_code",[error debugDescription],@"showapi_res_error", nil]);
              }];
    }
}

-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params  withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion{
    [self post:url timeout:timeout params:params fileParams:nil withCompletion:completion];
}

-(void)response:(id*)responseObj   withCompletion:(void (^)(NSDictionary<NSString*,NSString*>*))completion{
    
}

- (NSDictionary*)createSecretParam:(NSDictionary*) params
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    
    NSMutableDictionary *d=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self->showapi_appid,@"showapi_appid",[format stringFromDate:[NSDate date]],@"showapi_timestamp", nil];
    if(params!=nil){
        for(NSString *key in params){
            [d setObject:params[key] forKey:key];
        }
    }
    
    NSArray *sortedArray = [d.allKeys sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"排序后:%@",sortedArray);
    NSMutableString * str = [[NSMutableString alloc] init];
    for(NSString *obj in sortedArray){
        NSString *v=[d objectForKey:obj];
        if(!(v==nil||[v isEqualToString:@""])){
            [str appendString:obj];
            [str appendString:v];
        }
    }
//    NSLog(@"连接后的参数：%@",str);
    [str appendString:self->showapi_sign];
    
    [d setObject:[self md5:str] forKey:@"showapi_sign"];
    
//    NSLog(@"签名后的参数:%@",d);
    
    return d;
}

- (NSString*)md5:(NSString*)secret{
    const char* original_str=[secret UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString]; }

int main() {
    NSLog(@"Hello, World!");
    return 0;
}
@end






