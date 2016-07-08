//
//  YJComposeKeyboardTool.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJComposeKeyboardTool.h"
@interface YJComposeKeyboardTool()

@property (nonatomic,strong) UIButton *btn;

@end

@implementation YJComposeKeyboardTool

-(UIButton *)btn{
    if(_btn==nil){
        UIButton *btn=[[UIButton alloc] init];
        _btn=btn;
        self.btn=btn;
    }
    return  _btn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //设置背景
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupButtonWith:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:YJKeyboardButtonTypeCamel];
        
          [self setupButtonWith:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:YJKeyboardButtonTypePhoto];
          [self setupButtonWith:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:YJKeyboardButtonTypeHt];
          [self setupButtonWith:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:YJKeyboardButtonTypeAT];
          [self setupButtonWith:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:YJKeyboardButtonTypeEmotion];
        
    }
    
    return  self;
}

-(void)setupButtonWith:(NSString *)image highImage:(NSString *)highImage type:(YJKeyboardButtonType)type{
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag=type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}

-(void)layoutSubviews{
    
    int count=self.subviews.count;
    CGFloat btnW=self.width/count;
    //遍历subviews，分配位置
    for (int i=0; i<count; i++) {
       self.btn=self.subviews[i];
        self.btn.x=i*btnW;
        self.btn.y=0;
        self.btn.width=btnW;
        self.btn.height=self.height;
        
        
    }
    
}


-(void)btnClick:(UIButton *)btn{
   
    if ([self.delegate respondsToSelector:@selector(KeyboardTool:DidClcikButton:)]) {
        [self.delegate KeyboardTool:self DidClcikButton:btn.tag];
    }
}


-(void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard=showKeyboard;
    
    if (showKeyboard) {
        
        [self.btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
         [self.btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
    }else{
        [self.btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];

    }
    
}
@end
