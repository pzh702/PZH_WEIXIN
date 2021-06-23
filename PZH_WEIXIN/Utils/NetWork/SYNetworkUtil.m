//
//  SYNetworkUtil.m
//  SYNetwork
//
//  Created by 4399 on 2019/12/18.
//  Copyright © 2019 4399. All rights reserved.
//

#import "SYNetworkUtil.h"

@implementation SYNetworkUtil

+ (NSString *)  buildHttpQueryStr: (NSDictionary *) data
{
    NSString *str = @"";
    NSArray *keys;
    NSUInteger i, count;
    id key, value;
    keys = [data allKeys];
    count = [keys count];
    for (i = 0; i < count; i++){
        key = [keys objectAtIndex: i];
        value = [data objectForKey: key];
        NSString *k  = [self urlencode: key];
        NSString *v  = [self urlencode: value];
        if(![str isEqualToString:@""]){
            str = [str stringByAppendingString:@"&"];
        }
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@", k, v]];
    }
    return str;
}

+ (NSString *) urlencode:(NSString *)str
{
    NSCharacterSet *chars = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSMutableCharacterSet *mutableChars = [chars mutableCopy];
    [mutableChars removeCharactersInString: @":#[]@!$&'()*+,;=/ "];
    NSString *urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters: mutableChars];
    return urlStr;
}

@end
