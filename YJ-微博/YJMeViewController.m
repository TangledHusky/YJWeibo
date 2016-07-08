//
//  YJMeViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJMeViewController.h"
#import "YJSearchBar.h"
#import "testObject.h"
#import "MyOrderVC.h"
#import "LoginOtherViewController.h"

@interface YJMeViewController ()    <UITableViewDataSource>
@property(nonatomic,strong) NSArray *arryAll;

@end

@implementation YJMeViewController

-(NSArray *)arryAll{
    if(_arryAll==nil){
        testObject *entity1=[[testObject alloc] init];
        entity1.title=@"个人信息";
        entity1.desc=@"以上是所有的个人信息";
        entity1.contentArray=@[@"我的信息",@"我的地址",@"第三方SSO授权登录"];
        
        testObject *entity2=[[testObject alloc] init];
        entity2.title=@"订单信息";
        entity2.desc=@"这些都是订单信息";
        entity2.contentArray=@[@"代收货",@"待确认",@"待评价"];
        
        testObject *entity3=[[testObject alloc] init];
        entity3.title=@"其他信息";
        entity3.desc=@"我会说其他信息就是设置么";
        entity3.contentArray=@[@"关于APP",@"意见反馈"];
        
        _arryAll=@[entity1,entity2,entity3];
    }
    return  _arryAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(right) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
   
    self.tableView.dataSource=self;
    
    self.tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}





-(void)right{
    NSLog(@"right");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arryAll.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        testObject *entity=self.arryAll[section];
    return entity.contentArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"setting";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    testObject *entity=self.arryAll[indexPath.section];
    cell.textLabel.text=entity.contentArray[indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    
    return  cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    testObject *entity=self.arryAll[section];
    return entity.title;
}



-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    testObject *entity=self.arryAll[section];
    return entity.desc;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    if (indexPath.section==1) {
        NSLog(@"123");
        MyOrderVC *myOrder=[[MyOrderVC alloc] init];
        [self.navigationController pushViewController:myOrder animated:YES];
        

    }else if (indexPath.section==0&&indexPath.row==2){
            LoginOtherViewController *loginVC=[[LoginOtherViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];

        
    }else{
            testObject *entity=self.arryAll[indexPath.section];
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:entity.contentArray[indexPath.row] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *comfirm=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:comfirm];
            [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

@end
