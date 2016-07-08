//
//  YJEmotionTabbarButton.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/4.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionTabbarButton.h"

@implementation YJEmotionTabbarButton
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        
        //设置文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:13];

    }
    
    return  self;
}


-(void)setHighlighted:(BOOL)highlighted{
    //do nothing
    
}
@end
