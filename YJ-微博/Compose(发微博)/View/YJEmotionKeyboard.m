//
//  YJEmotionKeyboard.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/4.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionKeyboard.h"
#import "YJEmotionTabBar.h"
#import "YJEmotionListView.h"
#import "MJExtension.h"
#import "YJEmotion.h"
#import "YJEmotionTool.h"

@interface YJEmotionKeyboard()  <YJEmotionTabBarDelegate>

/* 切换栏  */
@property(nonatomic,weak) YJEmotionTabBar *tabBar;
/* 用来容纳表情的view*/
@property (nonatomic,weak) YJEmotionListView *showingListView;

/*  4个表情栏view*/
@property(nonatomic,strong) YJEmotionListView *recentListView;
@property(nonatomic,strong) YJEmotionListView *defaultListView;
@property(nonatomic,strong) YJEmotionListView *emojiListView;
@property(nonatomic,strong) YJEmotionListView *lxhListView;

@property (nonatomic,weak) NSString *name;

@end

@implementation YJEmotionKeyboard

#pragma mark - 懒加载
-(YJEmotionListView *)recentListView{
    if(_recentListView==nil){
        self.recentListView=[[YJEmotionListView alloc] init];
        //加载沙盒的数据
        self.recentListView.emotions=[YJEmotionTool recentEmotions];
        
    }
    return  _recentListView;
}

-(YJEmotionListView *)defaultListView{
    if(_defaultListView==nil){
        self.defaultListView=[[YJEmotionListView alloc] init];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        
        //保证array里存放模型，而非字典
        NSArray *defaultEmotion= [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.emotions=defaultEmotion;

        
    }
    return  _defaultListView;
}

-(YJEmotionListView *)emojiListView{
    if(_emojiListView==nil){
        self.emojiListView=[[YJEmotionListView alloc] init];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        
        //保证array里存放模型，而非字典
        NSArray *emojiEmotion= [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.emotions=emojiEmotion;
        
    }
    return  _emojiListView;
}

-(YJEmotionListView *)lxhListView{
    if(_lxhListView==nil){
        self.lxhListView=[[YJEmotionListView alloc] init];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        
        //保证array里存放模型，而非字典
        NSArray *lxhEmotion= [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.emotions=lxhEmotion;
        
    }
    return  _lxhListView;
}


#pragma  mark - 初始化
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //添加切换栏
        YJEmotionTabBar *tabbar=[[YJEmotionTabBar alloc] init];
        [self addSubview:tabbar];
        self.tabBar=tabbar;
        tabbar.delegate=self;
     
      
        
    }
    
    return  self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //切换栏
    self.tabBar.width=self.width;
    self.tabBar.height=35;
    self.tabBar.x=0;
    self.tabBar.y=self.height-self.tabBar.height;
    
    //表情
    self.showingListView.width=self.width;
    self.showingListView.height=self.tabBar.y;
    self.showingListView.x=0;
    self.showingListView.y=0;
    
    
}


-(void)emotionTabBar:(YJEmotionTabBar *)tabbar didSelectButton:(YJEmotionTabbarButtonType)buttonType{
    
    //先清除其他的listview
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case YJEmotionTabbarButtonTypeRecent:   //最近
            YJLog(@"最近");
             [self addSubview:self.recentListView];
            self.showingListView=self.recentListView;

            break;

        case YJEmotionTabbarButtonTypeDefault:   //默认
            YJLog(@"默认");
             [self addSubview:self.defaultListView];
               self.showingListView=self.defaultListView;
            break;

        case YJEmotionTabbarButtonTypeEmoji:   //Emoji
            YJLog(@"Emoji");
             [self addSubview:self.emojiListView];
               self.showingListView=self.emojiListView;
            break;

        case YJEmotionTabbarButtonTypeLxh:   //浪小花
            YJLog(@"小花");
            [self addSubview:self.lxhListView];
               self.showingListView=self.lxhListView;
            break;

    }
    
    //重新计算子控件的frame
    [self setNeedsLayout];
  
    
    
    
}
@end
