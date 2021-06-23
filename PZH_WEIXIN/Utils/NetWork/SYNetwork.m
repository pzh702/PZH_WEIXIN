//
//  SYNetwork.m
//  SYSDK
//
//  Created by 4399 on 2019/12/6.
//  Copyright © 2019 4399. All rights reserved.
//

#import "SYNetwork.h"

#define SY_SHAREDINSTANCE \
({static id sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[self alloc] init]; \
}); \
sharedInstance; \
})

@implementation SYNetwork

+ (instancetype) sharedInstance{
    return SY_SHAREDINSTANCE;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        self.operationQueue.maxConcurrentOperationCount = 10;
        self.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    }
    return self;
}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
parameters:(nullable id)parameters
   headers:(nullable NSDictionary<NSString *, NSString *> *)headers
     retry:(NSUInteger)times
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
   failure:(nullable void (^)(NSURLSessionDataTask *_Nullable task, NSError *error))failure {
    __block NSInteger retryTimes = times;
    __weak typeof(self) weakSelf = self;
    return [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        retryTimes--;
        if (!task.response) {
            if (retryTimes == 0) {
                if (failure) {
                    failure(task,error);
                }
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),
                             dispatch_get_main_queue(), ^{
                  [weakSelf GET:URLString
                     parameters:parameters
                        headers:headers
                          retry:retryTimes
                        success:success
                        failure:failure];
                             });
            }
        } else{
            if (failure) {
                failure(task,error);
            }
        }

    }];
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
parameters:(nullable id)parameters
   headers:(nullable NSDictionary<NSString *, NSString *> *)headers
     retry:(NSUInteger)times
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
   failure:(nullable void (^)(NSURLSessionDataTask *_Nullable task, NSError *error))failure {
    __block NSInteger retryTimes = times;
    __weak typeof(self) weakSelf = self;
    return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        retryTimes--;
        if (!task.response) {
            if (retryTimes == 0) {
                if (failure) {
                    failure(task,error);
                }
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),
                             dispatch_get_main_queue(), ^{
                  [weakSelf POST:URLString
                     parameters:parameters
                        headers:headers
                          retry:retryTimes
                        success:success
                        failure:failure];
                             });
            }
        } else{
            if (failure) {
                failure(task,error);
            }
        }
    }];
}



@end
