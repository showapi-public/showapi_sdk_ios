//
//  ShowAPIRequest.h
//  Pods
//
//  Created by bluespring on 2017/4/20.
//
//

#ifndef ShowAPIRequest_h
#define ShowAPIRequest_h

@interface ShowAPIRequest : NSObject{
    NSString *showapi_appid;
    NSString *showapi_sign;
    
    
}
-(id)initWithAppid:(NSString*)appid andSign:(NSString*)sign;

-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params fileParams:(NSDictionary<NSString*,NSData*>*) fileParams withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion;
-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params  withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion;

@end


#endif /* ShowAPIRequest_h */
