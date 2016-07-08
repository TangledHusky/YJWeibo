//
//  YJEmotionPageView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/5.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionPageView.h"
#import "YJEmotion.h"
#import "NSString+Emoji.h"
#import "YJEmotionPopView.h"
#import "YJEmotionButton.h"
#import "YJEmotionTool.h"

#define YJEmotionShowRowCount 3            //表情显示行数
#define YJEmotionShowColCount 7            //表情显示列数

#define YJEmotionButtonMarginLeft 10        //表情按钮左间距

@interface YJEmotionPageView()
//点击表情的提示放大表情
@property (nonatomic,strong) YJEmotionPopView *popView;
//删除按钮
@property (nonatomic,weak) UIButton  *deleteBtn;

@end

@implementation YJEmotionPageView

-(YJEmotionPopView *)popView{
    if(_popView==nil){
        self.popView=[YJEmotionPopView popView];
    }
    return  _popView;
}


-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //1.删除按钮
        UIButton *deleteBtn=[[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteEmotion) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:deleteBtn];
         self.deleteBtn=deleteBtn;
        
        //2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    
    return self;
    
}

//长按手势,处理操作
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer{
    //获得手指所在位置(即落在哪个表情上)
    CGPoint location= [recognizer locationInView:recognizer.view];
    
    //选中表情
    YJEmotionButton *btnSelected=[self emotionButtonWithLocation:location];

    //手势状态结束或意外结束取消
    if (recognizer.state==UIGestureRecognizerStateEnded||recognizer.state==UIGestureRecognizerStateCancelled) {
        //手指不再触摸
        [self.popView removeFromSuperview];
        
        //如果手指还在按钮上
        if(btnSelected){
            //发通知
            [self selectEmotion:btnSelected];
            
        }
      
        
    }else if (recognizer.state==UIGestureRecognizerStateBegan)
    {
        //手势开始
        
        
    }else if(recognizer.state==UIGestureRecognizerStateChanged){
        //手势改变
        
        //找到就点击
        [self.popView showFrom:btnSelected];
        

       
    }
}


//根据位置找到所处的表情按钮
-(YJEmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    
    
    int count=self.emotions.count;
    for (int i=0; i<count; i++) {
        YJEmotionButton *btn=self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame, location)) {
           
            return btn;
        }
    }
    return  nil;
    
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions=emotions;
    
    int count=emotions.count;
    for (int i=0; i<count; i++) {
        YJEmotionButton *btn=[[YJEmotionButton alloc] init];
        btn.backgroundColor=randomColor;
        [self addSubview:btn];
        
        btn.emotion=emotions[i];
        
        //添加按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}


-(void)layoutSubviews{
    int count=self.emotions.count;
    
    CGFloat btnW=(self.width-2*YJEmotionButtonMarginLeft)/YJEmotionShowColCount;
    CGFloat btnH=(self.height-YJEmotionButtonMarginLeft)/YJEmotionShowRowCount;
    
    for (int i=0; i<count; i++) {
        int row=i/YJEmotionShowColCount;
        int col=i%YJEmotionShowColCount;
        UIButton *btn=self.subviews[i+1];       //i+1是排除删除按钮
        btn.width=btnW;
        btn.height=btnH;
        btn.x=col*btnW+YJEmotionButtonMarginLeft;
        btn.y=row*btnH+YJEmotionButtonMarginLeft;
    }
    
    //删除按钮
    self.deleteBtn.width=btnW;
    self.deleteBtn.height=btnH;
    self.deleteBtn.x=self.width-YJEmotionButtonMarginLeft-btnW;
    self.deleteBtn.y=self.height-btnH;
    
}


//删除表情
-(void)deleteEmotion{
    
    [YJNotification postNotificationName:YJDeleteEmotionKey object:nil];
}


//点击表情
-(void)btnClick:(YJEmotionButton *)btn{
    //显示表情按钮
    [self.popView showFrom:btn];
       
    //等会儿让popview消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.popView removeFromSuperview];
    });
    
    [self selectEmotion:btn];
   
}


-(void)selectEmotion:(YJEmotionButton *)btn{
    
    //选中表情，发送通知
    //夸很多层，不用代理，用通知
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[YJSelectEmotionKey]=btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:YJEmotioDidSelectNotification object:nil userInfo:dict];
    
    //保持表情到沙盒
    [YJEmotionTool addEmotion:btn.emotion];
    
}

@end
