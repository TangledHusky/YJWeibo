//
//  YJEmotionTextView.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJTextView.h"
@class YJEmotion;

@interface YJEmotionTextView : YJTextView

-(void)insertEmotion:(YJEmotion *)emotion;

-(NSString *)fullText;

@end
