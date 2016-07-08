//
//  YJCityWeather.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 yajun.li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJCityWeather : NSObject

/*  城市名称    */
@property (nonatomic,copy) NSString *currentCity;

/*  pm25    */
@property (nonatomic,copy) NSString *pm25;

/*  适宜描述，如洗车等    */
@property (nonatomic,strong) NSArray *index;

/*  天气详情    */
@property (nonatomic,strong) NSArray *weather_data;
@end
