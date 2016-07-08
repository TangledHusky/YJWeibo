//
//  YJEmotionListView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/4.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionListView.h"
#import "YJEmotionPageView.h"

#define YJEmotionPageSize 20            //每页显示表情个数


@interface YJEmotionListView()  <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,weak) UIScrollView *scrollView;


@end

@implementation YJEmotionListView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //添加pagecontrol
        UIPageControl *page=[[UIPageControl alloc] init];
        [self addSubview:page];
        self.pageControl=page;
        page.currentPageIndicatorTintColor=[UIColor orangeColor];
        page.pageIndicatorTintColor=[UIColor darkGrayColor];
        page.userInteractionEnabled=NO;
       
        
        //page.backgroundColor=randomColor;
        
        
        //添加scrollView
        UIScrollView *scrollView=[[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.delegate=self;
        scrollView.pagingEnabled=YES;

        [self addSubview:scrollView];
        self.scrollView=scrollView;
        scrollView.backgroundColor=randomColor;
    }
    return  self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置pageControl
    self.pageControl.width=self.width;
    self.pageControl.height=35;
    
    self.pageControl.x=0;
    self.pageControl.y=self.height-self.pageControl.height;


    //设置scrollView
    self.scrollView.width=self.width;
    self.scrollView.height=self.height-self.pageControl.height;
    self.scrollView.x=0;
    self.scrollView.y=0;
    
    
    //设置scrollView内部的每一页尺寸
    int count=self.scrollView.subviews.count;
    for (int i=0; i<count; i++) {
        YJEmotionPageView *emotionView=self.scrollView.subviews[i];
        emotionView.width=self.scrollView.width;
        emotionView.height=self.scrollView.height;
        emotionView.x=i*self.scrollView.width;
        emotionView.y=0;
        emotionView.backgroundColor=randomColor;
    }
    
    
    //设置scroll的contentsize
    self.scrollView.contentSize=CGSizeMake(count*self.scrollView.width, 0);
    

    
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions=emotions;
    
    //1.设置页数
    int count=(emotions.count+YJEmotionPageSize-1)/YJEmotionPageSize;
    self.pageControl.numberOfPages=count>1?count:0;
    
    //2.创建用来显示每一页表情的控件
    for (int i=0; i<count; i++) {
        YJEmotionPageView *emotionView=[[YJEmotionPageView alloc] init];
        NSRange range;
        range.location=i*YJEmotionPageSize;
        //这里要考虑最后一页，不满20个时的情况
        if (emotions.count-range.location<YJEmotionPageSize) {
            range.length=emotions.count-range.location;
            
        }else{
            range.length=YJEmotionPageSize;
        }
        
        emotionView.emotions=[emotions subarrayWithRange:range];
        [self.scrollView addSubview:emotionView];
        
    }
  }


#pragma  mark - UIScrollViewDelegate代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    double pageNo=scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(pageNo+0.5);
}

@end
