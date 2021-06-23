//
//  SYNetworkUtil.h
//  SYNetwork
//
//  Created by 4399 on 2019/12/18.
//  Copyright © 2019 4399. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYNetworkUtil : NSObject

+ (NSString *)  buildHttpQueryStr: (NSDictionary *) data;

+ (NSString *) urlencode:(NSString *)str;

@end
