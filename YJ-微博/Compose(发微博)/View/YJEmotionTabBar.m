//
//  YJEmotionTabBar.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/4.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionTabBar.h"
#import "YJEmotionTabbarButton.h"

@interface YJEmotionTabBar()
@property (nonatomic,weak) YJEmotionTabbarButton *selectedBtn;
@end

@implementation YJEmotionTabBar

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //设置按钮
        [self setupButton:@"最近" buttonType:YJEmotionTabbarButtonTypeRecent];
        [self setupButton:@"默认" buttonType:YJEmotionTabbarButtonTypeDefault];
     
        [self setupButton:@"Emoji" buttonType:YJEmotionTabbarButtonTypeEmoji];
        [self setupButton:@"浪小花" buttonType:YJEmotionTabbarButtonTypeLxh];

    }
    return  self;
}

-(YJEmotionTabbarButton *)setupButton:(NSString *)title buttonType:(YJEmotionTabbarButtonType)buttonType{
    YJEmotionTabbarButton *btn=[[YJEmotionTabbarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag=buttonType;
    [self addSubview:btn];

    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
       
    //设置背景颜色
    NSString *image=@"compose_emotion_table_mid_normal";
    NSString *selectImage=@"compose_emotion_table_mid_selected";
    if (buttonType==YJEmotionTabbarButtonTypeRecent) {
        image=@"compose_emotion_table_left_normal";
        selectImage=@"compose_emotion_table_left_selected";
        
    }else if(buttonType==YJEmotionTabbarButtonTypeLxh){
        image=@"compose_emotion_table_right_normal";
        selectImage=@"compose_emotion_table_right_selected";
        
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    
    return  btn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    int count=self.subviews.count;
    CGFloat btnW=self.width/count;
    for (int i=0; i<count; i++) {
        YJEmotionTabbarButton *btn=self.subviews[i];
        btn.width=btnW;
        btn.height=self.height;
        btn.x=i*btnW;
        btn.y=0;
    }
    
}


-(void)btnClick:(YJEmotionTabbarButton *)btn{
    self.selectedBtn.enabled=YES;
    
    self.selectedBtn=btn;
    btn.enabled=NO;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
    
}

//重写delegate
-(void)setDelegate:(id<YJEmotionTabBarDelegate>)delegate{
    _delegate=delegate;
    
    [self btnClick:(YJEmotionTabbarButton *)[self viewWithTag:YJEmotionTabbarButtonTypeDefault]];
    
    
}


@end
