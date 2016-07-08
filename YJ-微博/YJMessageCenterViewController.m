//
//  YJMessageCenterViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJMessageCenterViewController.h"
#import "YJWeatherViewController.h"
#import "YJSearchViewController.h"
#import "YJGameViewController.h"
#import "YJOtherViewController.h"
#import "YJNavigationController.h"



typedef enum{
    ButtonTypeWeather,      //天气
     ButtonTypeSearch,     //搜索
     ButtonTypeGame,     //游戏
     ButtonTypeOther,     //其他
    
}ButtonType;

@interface YJMessageCenterViewController ()



@end

@implementation YJMessageCenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initWeather];
    
    
}





//初始化
-(void)initWeather{

    CGSize size=[UIScreen mainScreen].bounds.size;
    CGFloat leftrightMargin=20;
    CGFloat bottomMargin=20;
    CGFloat topMargin=64+bottomMargin;
    CGFloat middleMargin=50;
    CGFloat viewWidth=(size.width-2*leftrightMargin-middleMargin)*0.5;
    CGFloat viewHight=(size.height-44-topMargin-bottomMargin-middleMargin)*0.5;
    
    //第一个的frame
    CGRect weatherFrame=CGRectMake(leftrightMargin, topMargin, viewWidth, viewHight);
     CGRect searchGrame=CGRectMake(leftrightMargin+viewWidth+middleMargin, topMargin, viewWidth, viewHight);
     CGRect gameFrame=CGRectMake(leftrightMargin, topMargin+viewHight+middleMargin, viewWidth, viewHight);
     CGRect otherFrame=CGRectMake(leftrightMargin+viewWidth+middleMargin, topMargin+viewHight+middleMargin, viewWidth, viewHight);
    
    
    self.view.backgroundColor=YJColorWithDecimal(0.85, 0.95, 0.95);
    
    //天气
    UIButton *weather=[[UIButton alloc] init];
    [weather setTitle:@"天气" forState:UIControlStateNormal];
    weather.tag=ButtonTypeWeather;
    weather.frame=weatherFrame;
    weather.backgroundColor=randomColor;
    [self.view addSubview:weather];
    [weather addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //搜索
    UIButton *search=[[UIButton alloc] init];
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    search.tag=ButtonTypeSearch;
    search.frame=searchGrame;
    search.backgroundColor=randomColor;
    [self.view addSubview:search];
     [search addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //游戏
    UIButton *game=[[UIButton alloc] init];
    [game setTitle:@"手势解锁" forState:UIControlStateNormal];
    game.tag=ButtonTypeGame;
    game.frame=gameFrame;
    game.backgroundColor=randomColor;
    [self.view addSubview:game];
     [game addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //其他
    UIButton *other=[[UIButton alloc] init];
    [other setTitle:@"本地存储" forState:UIControlStateNormal];
    other.tag=ButtonTypeOther;
    other.frame=otherFrame;
    other.backgroundColor=randomColor;
    [self.view addSubview:other];
     [other addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];


    
}


-(void)btnClick:(UIButton *)btn{
    
    
    switch (btn.tag) {
        case ButtonTypeWeather:{
           
            
            YJLog(@"天气");
       
            YJWeatherViewController *vcWeather=[[YJWeatherViewController alloc] init];       [self.navigationController pushViewController:vcWeather animated:YES];
            break;}

        case ButtonTypeSearch:{
            YJLog(@"搜索");
            
            YJSearchViewController *vcSearch=[[YJSearchViewController alloc] init];
          [self.navigationController pushViewController:vcSearch animated:YES];            break;
        }
        case ButtonTypeGame:{
            YJLog(@"游戏");
            YJGameViewController *vcGame=[[YJGameViewController alloc] init];
         [self.navigationController pushViewController:vcGame animated:YES];
            break;
        }
        case ButtonTypeOther:{
            
             YJLog(@"其他");
            
            YJOtherViewController *vcOther=[[YJOtherViewController alloc] init];
           [self.navigationController pushViewController:vcOther animated:YES];
            break;}

        default:
            break;
    }
    
}

//modal跳转
//-(void)PresentVC:(UIViewController *)vc{
// 
//    YJNavigationController *nav=[[YJNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
//
//}

@end
