//
//  YJEmotionPopView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionPopView.h"
#import "YJEmotionButton.h"
#import "YJEmotion.h"

@interface YJEmotionPopView()
@property (weak, nonatomic) IBOutlet YJEmotionButton *emotionButton;



@end


@implementation YJEmotionPopView
+(instancetype)popView{
    return  [[[NSBundle mainBundle] loadNibNamed:@"YJEmotionPopView" owner:nil options:nil] lastObject];
    
}



-(void)showFrom:(YJEmotionButton *)btn{
    if(!btn) return;
    
    self.emotionButton.emotion=btn.emotion;
    
    //这里不能直接添加到pageview窗口，应该加到主窗口
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //转换坐标系,将自己左上角转换为主窗口的左上角，计算出被点击按钮在window中的frame
    CGRect btnframe= [btn convertRect:btn.bounds toView:window];
    
    
    
    self.y=CGRectGetMidY(btnframe)-self.height;
    self.centerX=CGRectGetMidX(btnframe);

    
}
@end
