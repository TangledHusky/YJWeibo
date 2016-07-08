//
//  YJEmotionTool.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJEmotion;
@interface YJEmotionTool : NSObject
+(void)addEmotion:(YJEmotion *)emotion;

+(NSArray *)recentEmotions;

@end
