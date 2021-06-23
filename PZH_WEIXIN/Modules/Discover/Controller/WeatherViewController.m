//
//  WeatherViewController.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/4/11.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "WeatherViewController.h"
#import <AFNetworking.h>
#import <NSObject+YYModel.h>

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initSubViews
{
    _textField.layer.cornerRadius = 5;
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = KGrayColor.CGColor;
}

- (IBAction)clickSearchBtn:(id)sender {
    NSString *url = [NSString stringWithFormat:@"https://api.thinkpage.cn/v3/weather/daily.json?key=osoydf7ademn8ybv&location=%@&language=zh-Hans&start=0&days=3",self.textField.text];
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *resultArray = responseObject[@"results"];
        NSDictionary *todayDic = (NSDictionary *)resultArray[0][@"daily"][0];
        WeatherModel *model = [WeatherModel modelWithDictionary:todayDic];
        NSLog(@"%@", todayDic);
        NSLog(@"%@", model);
        
        self.textView.text = [NSString stringWithFormat:@"今天是：%@\n天气：%@\n气温：%ld-%ld摄氏度\n风向：%@",model.date,model.text_day,(long)model.low,(long)model.high,model.wind_direction];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.textView.text =[NSString stringWithFormat:@"错误信息：%@",error.localizedDescription];
    }];
}

@end


@implementation WeatherModel

@end
