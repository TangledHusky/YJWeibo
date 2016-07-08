//
//  LeftSortsViewController.m
//  QQ侧拉栏的实现
//
//  Created by mac on 15/12/29.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "YJMeViewController.h"
#import "YJSliderNaviController.h"
#import "YJWeatherViewController.h"
#import "YJSearchViewController.h"
#import "YJGameViewController.h"
#import "YJOtherViewController.h"

@interface LeftSortsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView * imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    imageview.image = [UIImage imageNamed:@"leftBackImage.png"];
//    
//    [self.view addSubview:imageview];
    self.view.backgroundColor=YJColor(33, 30, 42);
    
    
    self.myTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _myTableview.dataSource = self;
    _myTableview.delegate = self;
    _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableview];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * cell_id = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;// 箭头
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"查看天气";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"百度搜索";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"手势解锁";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"本地存储";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate * tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [tempAppDelegate.LeftSlideVC closeLeftView];  // 关闭左侧抽屉
    
    
    if (indexPath.row == 0) {
         YJWeatherViewController *weatherV=[[YJWeatherViewController alloc] init];
        [self presentPage:weatherV];
    } else if (indexPath.row == 1) {
        YJSearchViewController *weatherV=[[YJSearchViewController alloc] init];
        [self presentPage:weatherV];
        
    } else if (indexPath.row == 2) {
        YJGameViewController *weatherV=[[YJGameViewController alloc] init];
        [self presentPage:weatherV];
    } else if (indexPath.row == 3) {
        YJOtherViewController *weatherV=[[YJOtherViewController alloc] init];
        [self presentPage:weatherV];
    } else if (indexPath.row == 4) {
      
        
    }

    
   
    
}

-(void)presentPage:(UIViewController *)vc{
      YJSliderNaviController *nav=[[YJSliderNaviController alloc] initWithRootViewController:vc];
  
    
    [self presentViewController:nav animated:YES completion:nil];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableview.bounds.size.width, 120)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
