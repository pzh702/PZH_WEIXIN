//
//  SYHttp.h
//  SYSDK
//
//  Created by 4399 on 2019/12/6.
//  Copyright © 2019 4399. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//NS_ASSUME_NONNULL_BEGIN

@interface SYHttp : NSObject

+ (void)httpPost:(NSString *_Nonnull)url
      data:(NSDictionary *_Nullable)data
parameters:(NSDictionary *_Nullable)parameters
retryTimes:(NSUInteger)retryTimes
   success:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nonnull object))success
   failure:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

+ (void)httpGet:(NSString *_Nonnull)url
      data:(NSDictionary *_Nullable)data
parameters:(NSDictionary *_Nullable)parameters
retryTimes:(NSUInteger)retryTimes
   success:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nonnull object))success
   failure:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

@end

//NS_ASSUME_NONNULL_END
