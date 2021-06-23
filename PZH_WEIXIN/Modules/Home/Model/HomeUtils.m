//
//  HomeUtils.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "HomeUtils.h"

static NSArray *imgArr;
static NSArray *nameArr;
static NSArray *messageArr;
static NSArray *timeArr;

@implementation HomeUtils

+ (HomeModel *)getRandomData
{
    HomeModel *model = [HomeModel new];
    
    int randomIndex = arc4random_uniform((int)[self getImgs].count);
    model.imgName = [self getImgs][randomIndex];
    
    randomIndex = arc4random_uniform((int)[self getNames].count);
    model.name = [self getNames][randomIndex];
    
    randomIndex = arc4random_uniform((int)[self getTimes].count);
    model.time = [self getTimes][randomIndex];
    
    randomIndex = arc4random_uniform((int)[self getMessages].count);
    model.message = [self getMessages][randomIndex];
    
    return model;
}

+ (NSArray *)getImgs
{
    if (!imgArr) {
        NSMutableArray *temp = [NSMutableArray new];
        for (NSInteger i = 0; i < 24; i++) {
            NSString *iconName = [NSString stringWithFormat:@"%ld.jpg", (long)i];
            [temp addObject:iconName];
        }
        imgArr = [temp copy];
    }
    return imgArr;
}

+ (NSArray *)getNames
{
    if (!nameArr) {
        nameArr = @[@"安度因",@"雷诺",@"铜须",@"布莱恩",@"阿尔萨斯",@"乔巴",@"蔡徐坤",@"孙笑川",@"亚索",@"牛顿",@"特朗普",@"孙杨"];
    }
    return nameArr;
}

+ (NSArray *)getTimes
{
    if (!timeArr) {
        timeArr = @[@"昨天下午",@"11:20",@"3月1日",@"21:03",@"3月15日",@"刚刚",@"1分钟前",@"10分钟前",@"今天"];
    }
    return timeArr;
}

+ (NSArray *)getMessages
{
    if (!messageArr) {
        messageArr = @[@"安度因：圣光，会赐予我胜利✌️。",
        @"雷诺：我们要发财了！",
        @"铜须：天知道我们会发现什么样的大秘密！",
        @"布莱恩：冒险怎能少了我？",
        @"阿尔萨斯：炉石传说真尼玛好玩。",
        @"乔巴：shjgsdjkkgagiurggadsg。",
        @"蔡徐坤：我是练习时长两年半的个人练习生。",
        @"孙笑川：你说你🐎呢？",
        @"亚索：只要我e的够快，队友的问号就追不上我。",
        @"牛顿：其实我是个胖子。",
        @"特朗普：身在美国🇺🇸心在汉。",
        @"孙杨：霍顿是傻逼。",
        @"布莱恩：你谁？？？🐎🐎🐎🐎",
        @"阿尔萨斯：。。。。。。",
        @"孙杨：春晚太难看啦，妈蛋的🐎🐎🐎🐎🐎🐎🐎🐎",
        @"雷诺：好好好~~~",
        @"雷诺：约起",
        @"牛顿：寒假过得真快",
        @"特朗普：有木有人儿？",
        @"孙笑川：你要我一直笑吗？对不起做不到。",
        @"亚索：面对疾风吧",
        @"牛顿：我不理解",
        @"蔡徐坤：有人要打篮球吗？",
        @"亚索：有人要开黑吗？"];
    }
    return messageArr;
}


@end
