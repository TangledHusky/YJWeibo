//
//  YJEmotionAttachment.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionAttachment.h"
#import "YJEmotion.h"

@implementation YJEmotionAttachment

-(void)setEmotion:(YJEmotion *)emotion{
    _emotion=emotion;
    
    
    self.image=[UIImage imageNamed:emotion.png];
       
}

@end
