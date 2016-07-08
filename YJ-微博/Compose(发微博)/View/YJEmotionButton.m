//
//  YJEmotionButton.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionButton.h"
#import "YJEmotion.h"
#import "NSString+Emoji.h"

@implementation YJEmotionButton

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //
        [self setup];

        
    }
    return  self;
}


//从xib出来的view，不会调用initWithFrame,而是调用initWithCoder

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        //
        [self setup];
    }
    return  self;
    
}

//初始化方法
-(void)setup{
     self.titleLabel.font=[UIFont systemFontOfSize:32];
    
    //按钮高亮时，不要调整图片为灰色----//或者重写sethighlighted方法
    self.adjustsImageWhenHighlighted=NO;
}

-(void)setEmotion:(YJEmotion *)emotion{
    _emotion=emotion;
    
    
    if (emotion.code) {
        //设置emoji（emoji不是图片，是文字转换的）
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
      
        
    }else{
        //设置表情
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }

    
}


@end
