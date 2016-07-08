//
//  YJNewFeatureController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/24.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJNewFeatureController.h"
#import "YJTabbarViewController.h"
#import "AppDelegate.h"

#define newFeatureCount 4
@interface YJNewFeatureController() <UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;
@end


@implementation YJNewFeatureController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1.创建scrollview
    UIScrollView *scroll=[[UIScrollView alloc] init];
    
    //2.设置scroll的大小及其他属性
    scroll.frame=self.view.bounds;
    scroll.bounces=NO;      //弹簧设置NO
    scroll.pagingEnabled=YES;
    [scroll setShowsHorizontalScrollIndicator:NO];      //去除底部滚动条
    
    scroll.delegate=self;
    
    CGFloat scrollW=self.view.width;
    CGFloat scrollH=self.view.height;
    
    scroll.contentSize=CGSizeMake(newFeatureCount*scrollW, 0);
    [self.view addSubview:scroll];
    
    //3.添加4张图片
    for (int i=0; i<newFeatureCount; i++) {
        NSString *str=[NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:str]];
        image.width=scrollW;
        image.height=scrollH;
        image.x=i*scrollW;
        
        //如果是最后一张，添加说明及跳转连接
        if (i==newFeatureCount-1) {
            
            [self setLastImage:image];
           
        }
        
        [scroll addSubview:image];
    }
    
    
    //4.添加分页
    UIPageControl *page=[[UIPageControl alloc] init];
    page.numberOfPages=newFeatureCount;
//    page.width=100;
//    page.height=50;
    page.centerX=scrollW*0.5;
    page.centerY=scrollH-50;
    [page setPageIndicatorTintColor:YJColorWithDecimal(0.81, 0.9, 0.7)];
    [page setCurrentPageIndicatorTintColor:YJColor(18, 22, 222)];
    
  
    self.pageControl=page;
    [self.view addSubview: page];
}


-(void)shareClick:(UIButton *)btn{
    btn.selected=!btn.isSelected;
    
}

-(void)setLastImage:(UIImageView *)image{
    
    image.userInteractionEnabled=YES;
    
    UIButton *btn1=[[UIButton alloc] init];
    [btn1 setTitle:@"使用新体验" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    btn1.titleLabel.font=[UIFont systemFontOfSize:14];
    
  
    //这里犯错，位置老不对，是因为设置butn必须先设置大小属性，在设置位置属性
    btn1.width=120;
    btn1.height=30;
    btn1.centerX=image.width*0.5;
    btn1.centerY=image.height*0.65;
    
    btn1.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    
    [btn1 addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:btn1];
    
    UIButton *btnTurn=[[UIButton alloc] init];
    [btnTurn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btnTurn setTitle:@"开始使用" forState:UIControlStateNormal];
     btnTurn.size=btnTurn.currentBackgroundImage.size;
    btnTurn.centerY=image.height*0.75;
    btnTurn.centerX=btn1.centerX;
   
    
    [btnTurn addTarget:self action:@selector(turnClick) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:btnTurn];
}

-(void)turnClick{
//    YJLog(@"turnClick");
    //进入tabbar界面
    //这里使用替换window跟控制器，避免使用push和modal方式跳转页面。
    
    //跳转新的主页
    AppDelegate *dele=[[UIApplication sharedApplication]delegate];
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=dele.LeftSlideVC;
    
    //modal方式,这样会导致新特新页面一致存在在内存内
//    YJTabbarViewController *tab=[[YJTabbarViewController alloc] init];
//    [self presentViewController:tab animated:YES completion:nil];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //YJLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
  
    double scrollX=scrollView.contentOffset.x/scrollView.width;
    
    //这里x+0.5再四舍五入更准确
    self.pageControl.currentPage=(int)(scrollX+0.5);
    
}

@end
