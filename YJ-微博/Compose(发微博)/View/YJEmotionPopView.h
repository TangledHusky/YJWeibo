//
//  YJEmotionPopView.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJEmotion,YJEmotionButton;

@interface YJEmotionPopView : UIView

+(instancetype)popView;


-(void)showFrom:(YJEmotionButton *)btn;

@end
