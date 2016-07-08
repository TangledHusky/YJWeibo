//
//  YJTabBar.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/23.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJTabBar.h"
@interface YJTabBar()
@property (nonatomic,strong) UIButton *plusBtn;
@end

@implementation YJTabBar

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //
        
        UIButton *plusBtn=[[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size=plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.plusBtn=plusBtn;
        
        [self addSubview: plusBtn];

    }
    return  self;
}


//因为self present 只能在viewControl，因此用代理实现
-(void)plusBtnClick{
  
    //通知代理
    //如果代理有这个方法
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
    
    
}

-(void)layoutSubviews{
    //先系统自己排布
    [super layoutSubviews];
    //1.设置加号的位置
    self.plusBtn.centerX=self.width*0.5;
    self.plusBtn.centerY=self.height*0.5;
    
    
    
    //覆盖排布
    
    CGFloat tabbarWidth=self.width/5;
    CGFloat index=0;
    int count=self.subviews.count;
    
    //YJLog(@"%@",self.subviews);
    for (int i=0; i<count; i++) {
      
        UIView *view=self.subviews[i];
        Class class=NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width=tabbarWidth;
            view.x=index*tabbarWidth;
            index++;
            if (index==2) {
                index++;
            }
            
            //YJLog(@"%d--%f",i,index);
        }
    }
    
    
}
@end
