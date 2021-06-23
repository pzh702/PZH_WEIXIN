//
//  WeatherViewController.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/4/11.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherViewController : BaseViewController

@end

@interface WeatherModel : NSObject

kAssign NSInteger code_day;
kAssign NSInteger high;
kAssign NSInteger low;
kAssign NSInteger rainfall;
kCopy NSString *text_day;
kCopy NSString *text_night;
kCopy NSString *wind_direction;
kCopy NSString *date;

//"code_day" = 15;
//"code_night" = 10;
//date = "2020-04-11";
//high = 26;
//humidity = 88;
//low = 15;
//precip = "";
//rainfall = "27.4";
//"text_day" = "\U5927\U96e8";
//"text_night" = "\U9635\U96e8";
//"wind_direction" = "\U5317";
//"wind_direction_degree" = 0;
//"wind_scale" = 4;
//"wind_speed" = "25.20";

@end

NS_ASSUME_NONNULL_END
