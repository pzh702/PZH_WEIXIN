//
//  SYNetwork.h
//  SYSDK
//
//  Created by 4399 on 2019/12/6.
//  Copyright © 2019 4399. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYNetwork : AFHTTPSessionManager

//默认超时为60，progress为nil

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
     parameters:(nullable id)parameters
        headers:(nullable NSDictionary<NSString *, NSString *> *)headers
          retry:(NSUInteger)times
        success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
        failure:(nullable void (^)(NSURLSessionDataTask *_Nullable task, NSError *error))failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
     parameters:(nullable id)parameters
        headers:(nullable NSDictionary<NSString *, NSString *> *)headers
          retry:(NSUInteger)times
        success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
        failure:(nullable void (^)(NSURLSessionDataTask *_Nullable task, NSError *error))failure;

+ (instancetype) sharedInstance;

@end

NS_ASSUME_NONNULL_END
