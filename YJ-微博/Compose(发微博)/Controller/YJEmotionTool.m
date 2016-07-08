//
//  YJEmotionTool.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionTool.h"
#import "YJEmotion.h"

#define YJRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

@implementation YJEmotionTool
+(void)addEmotion:(YJEmotion *)emotion{
    NSMutableArray *emotions=(NSMutableArray *)[self recentEmotions];
    if (emotions==nil) {
        emotions=[NSMutableArray array];
    }
    
    //如果已存在，删除，移到第一个
    for (int i=0; i<emotions.count; i++) {
        YJEmotion *emo=emotions[i];
        if ([emo.chs isEqual:emotion.chs]) {
            YJLog(@"zhaodao %d--%@",emotions.count,emotion.chs);
            [emotions removeObject:emo];
            break;
        }
    }
 
    

    //将表情插入第一个
    [emotions insertObject:emotion atIndex:0];
    
    //将所有表情存入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:YJRecentEmotionPath];
    
}


+(NSArray *)recentEmotions{
    
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:YJRecentEmotionPath];
}

@end
