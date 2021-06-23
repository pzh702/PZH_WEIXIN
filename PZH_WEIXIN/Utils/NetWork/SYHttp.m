//
//  SYHttp.m
//  SYSDK
//
//  Created by 4399 on 2019/12/6.
//  Copyright © 2019 4399. All rights reserved.
//

#import "SYHttp.h"
#import "SYNetwork.h"
#import "SYNetworkUtil.h"

//NS_ASSUME_NONNULL_BEGIN

@interface SYHttp()

@end

@implementation SYHttp

+ (void)httpPost:(NSString *_Nonnull)url
      data:(NSDictionary *_Nullable)data
parameters:(NSDictionary *_Nullable)parameters
retryTimes:(NSUInteger)retryTimes
   success:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nonnull object))success
   failure:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure{
    if (!retryTimes) {
        retryTimes = 3;
    }
    NSString *queryStr = [SYNetworkUtil buildHttpQueryStr: data];
    NSString *urlStr;
    NSRange range = [url rangeOfString: @"?"];
    if(range.location == NSNotFound){
        urlStr = [NSString stringWithFormat: @"%@?%@", url, queryStr];
    }else{
        urlStr = [NSString stringWithFormat: @"%@&%@", url, queryStr];
    }
    [[SYNetwork sharedInstance] POST:urlStr parameters:parameters headers:nil retry:retryTimes success:success failure:failure];
}

+ (void)httpGet:(NSString *_Nonnull)url
      data:(NSDictionary *_Nullable)data
parameters:(NSDictionary *_Nullable)parameters
retryTimes:(NSUInteger)retryTimes
   success:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nonnull object))success
   failure:(void(^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure
{
    if (!retryTimes) {
        retryTimes = 3;
    }
    NSString *queryStr = [SYNetworkUtil buildHttpQueryStr: data];
    NSString *urlStr;
    NSRange range = [url rangeOfString: @"?"];
    if(range.location == NSNotFound){
        urlStr = [NSString stringWithFormat: @"%@?%@", url, queryStr];
    }else{
        urlStr = [NSString stringWithFormat: @"%@&%@", url, queryStr];
    }
    [[SYNetwork sharedInstance] GET:urlStr parameters:parameters headers:nil retry:retryTimes success:success failure:failure];
}

@end

//NS_ASSUME_NONNULL_END
