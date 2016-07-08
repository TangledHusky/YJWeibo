//
//  YJHomeViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJDropdownMenu.h"
#import "YJUserAccountTool.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YJUser.h"
#import "YJStatuses-WeiBo.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YJStatusCell.h"
#import "YJStatusFrame.h"
#import "XMShareView.h"
#import "YJTitleMenuViewControl.h"

#import "AppDelegate.h"

@interface YJHomeViewController () <YJDropdownMenuDelegate>
@property (nonatomic,strong) NSMutableArray  *statusFrameArry;
@property (nonatomic, strong) XMShareView *shareView;
@end

@implementation YJHomeViewController

#pragma mark - 懒加载
-(NSMutableArray *)statusFrameArry{
    if(_statusFrameArry==nil){
        _statusFrameArry=[[NSMutableArray alloc] init];
    }
    return  _statusFrameArry;
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor=YJColorWithDecimal(0.85, 0.85, 0.85);  
    //1.创建导航栏控件
    [self createNavButton];
    
    //2.获取用户昵称并显示
    [self showUserInfo];
    
    //3.获取最新微博
    //[self getNewStatuses];
    //改成首页加载时，用刷新加载数据，显示加载效果
    
    //4.下拉刷新
    [self refreshStatusesDown];
    
    //5.上拉加载数据
    [self refreshStatusesUp];
    
    //6.给予定时器，用来监听用户未读取微博数量，用以下面显示小图标
    NSTimer *time= [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getUnreadStatuses) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate * tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


#pragma mark - 加载微博数据

-(void)getUnreadStatuses{
   
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    userAccount *account=[YJUserAccountTool getAccount];
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=account.access_token;
    parms[@"uid"]=account.uid;
    
    [manage GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int count=[responseObject[@"status"] intValue];
        if (count>0) {
               NSString *str=[NSString stringWithFormat:@"%d",count];
            //显示到tabbar栏首页右上侧
            self.tabBarItem.badgeValue=str;
            //显示到app图标右上侧
            [UIApplication sharedApplication].applicationIconBadgeNumber=count;

        }
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"获取最新未读微博失败");
        
    }];

    
    
}

-(void)refreshStatusesDown{
    //清除图标右上角数量
    self.tabBarItem.badgeValue=nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
   
    //1.创建刷新控件
    UIRefreshControl *refresh=[[UIRefreshControl alloc] init];
    
    [refresh addTarget:self action:@selector(setRefreshDown:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    
    
    //执行刷新
    [refresh beginRefreshing];
    [self setRefreshDown:refresh];
    
}


-(void)refreshStatusesUp{
    
    //上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    
}

-(void)loadMoreStatuses{
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    
    //1.从沙盒获取uid：document路径下
    userAccount *account=[YJUserAccountTool getAccount];
    
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=account.access_token;
    //parms[@"count"]=@20;
    YJStatusFrame *last=[self.statusFrameArry lastObject];
    
    
    if (last) {
        parms[@"max_id"]=last.status.idstr;
    }
    YJLog(@"%@---",last.status.idstr);
    
    [manage GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将获取的新数据，加到arry头部，也就是插入到最上面
        //YJStatuses_WeiBo *newStatus=[YJStatuses_WeiBo objectWithKeyValues:responseObject[@"statuses"]];
        NSArray *newStatus=[YJStatuses_WeiBo objectArrayWithKeyValuesArray:responseObject[@"statuses"]] ;
        
        YJLog(@"加载更多success---%d",newStatus.count);
        
        NSArray *arrtFrame=[self stausFramesWithStatuses:newStatus];
        [self.statusFrameArry addObjectsFromArray:arrtFrame];
        
        //重新加载tableview
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView footerEndRefreshing];
        
        //显示刷新结果
        //[self showrefreshResult:newStatus.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"加载更多error");
        [self.tableView footerEndRefreshing];
        
    }];
    

    
}


-(void)setRefreshDown:(UIRefreshControl *)refresh{
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    
    //1.从沙盒获取uid：document路径下
    userAccount *account=[YJUserAccountTool getAccount];
    
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=account.access_token;
    //parms[@"count"]=@20;
    YJStatusFrame *first=[self.statusFrameArry firstObject];
    
    if (first) {
        parms[@"since_id"]=first.status.idstr;
    }
   
    
    [manage GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        //将获取的新数据，加到arry头部，也就是插入到最上面
        NSArray *newStatus=[YJStatuses_WeiBo objectArrayWithKeyValuesArray:responseObject[@"statuses"]] ;
       
        //YJLog(@"%@",responseObject[@"statuses"]);
        
        NSArray *frameArry=[self stausFramesWithStatuses:newStatus];
        
        NSRange range=NSMakeRange(0, frameArry.count);
        NSIndexSet *index=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrameArry insertObjects:frameArry atIndexes:index];
        //重新加载tableview
        [self.tableView reloadData];
        
        //结束刷新
        [refresh endRefreshing];
        
 
        //显示刷新结果
        [self showrefreshResult:newStatus.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"刷新error");
        [refresh endRefreshing];
        
    }];
    
}

-(void)showrefreshResult:(int)count{
    //创建label
    UILabel *lbl=[[UILabel alloc] init];
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.font=[UIFont systemFontOfSize:17];
    lbl.textColor=[UIColor whiteColor];
    lbl.backgroundColor=[UIColor orangeColor];
    lbl.width=[UIScreen mainScreen].bounds.size.width;
    lbl.height=35;
    lbl.y=64-lbl.height;
    
   
    
    if (count==0) {
        lbl.text=@"没有最新的微博数据";
    }else{
        lbl.text=[NSString stringWithFormat:@"共有%d条最新微博数据",count];
    }
    //把label加到nav中
    [self.navigationController.view insertSubview:lbl belowSubview:self.navigationController.navigationBar];
    
    
    [UIView animateWithDuration:1.0 animations:^{
        lbl.transform=CGAffineTransformMakeTranslation(0, lbl.height);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            lbl.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [lbl removeFromSuperview];
        }];
    }];
    
}

-(void)createNavButton
{
    
    //添加首页下拉框
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.width=180;
    btn.height=30;
    
    //每次打开，显示上一次登陆的昵称
    NSString *name=[YJUserAccountTool getAccount].name;
    [btn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    //这里偏移距离要根据名字的长度计算
    //CGFloat nameC=btn.titleLabel.width;
    CGFloat scale=[UIScreen mainScreen].scale;
    NSDictionary *dict=[NSDictionary dictionary];
    CGFloat nameC=[btn.currentTitle sizeWithAttributes:dict].width*scale;
    CGFloat imageC=btn.imageView.width*scale;
    
    //YJLog(@"文字长度：%f   图片长度：%f",nameC,imageC);
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, nameC, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    
    [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView=btn;
    
    //创建左右两侧的按钮
    self.navigationItem.leftBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(addPeaple) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" ];
    
    self.navigationItem.rightBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(homeAction) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];

    
    

}

-(void)addPeaple{
    YJLog(@"点击了首页左侧导航栏");
    
    AppDelegate * tempAppDelegate = [[UIApplication sharedApplication]delegate];
    if (tempAppDelegate.LeftSlideVC.closed) {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }

}


-(void)homeAction{
    YJLog(@"点击了首页右侧导航栏");
    if(!self.shareView){
        
        self.shareView = [[XMShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.shareView.alpha = 0.0;
        
        self.shareView.shareTitle = NSLocalizedString(@"分享标题", nil);
        
        self.shareView.shareText = NSLocalizedString(@"分享内容", nil);
        
        self.shareView.shareUrl = @"http://amonxu.com";
        
        [self.view addSubview:self.shareView];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
    }

  
    
    
}



-(void)showUserInfo{
    //1.从沙盒获取uid：document路径下
    userAccount *account=[YJUserAccountTool getAccount];
    
    //2.根据uid调用接口获取用户信息，返回dictionary
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=account.access_token;
    parms[@"uid"]=account.uid;
    
    [manage GET:@"https://api.weibo.com/2/users/show.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        YJLog(@"success----%@",responseObject[@"name"]);
        
        //3.将获取的信息显示
        UIButton *btn=(UIButton *)self.navigationItem.titleView;
        btn.titleLabel.text=responseObject[@"name"];
        
        //保存进沙盒
        account.name=responseObject[@"name"];
        [YJUserAccountTool saveAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"error-----%@",error);
    }];
    
}

-(void)getNewStatuses{
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    
    //1.从沙盒获取uid：document路径下
    userAccount *account=[YJUserAccountTool getAccount];
    
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=account.access_token;
    parms[@"count"]=@20;
    
    [manage GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //YJLog(@"success----%@",responseObject);
        //处理获取的数据json
        NSArray *arry=[self stausFramesWithStatuses:[YJStatuses_WeiBo objectArrayWithKeyValuesArray:responseObject[@"statuses"]]];

        [self.statusFrameArry addObjectsFromArray:arry];
        
        
        //重新加载数据
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"error");
        
        //结束刷新
        
    }];
    
    
}

/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (YJStatuses_WeiBo *status in statuses) {
        YJStatusFrame *frame=[[YJStatusFrame alloc] init];
        frame.status=status;
        [frames addObject:frame];
    }
    return frames;
}

-(void)titleClick:(UIButton *)titleBtn{
   
    //1.创建控件
    YJDropdownMenu *menu=[YJDropdownMenu menu];
    menu.delegate=self;
    
    YJTitleMenuViewControl *table=[[YJTitleMenuViewControl alloc] init];
    
    //2.设置大小
    table.view.height=200;
    table.view.width=150;
    menu.contentController=table;
    
    //3.显示
    [menu showFrom:titleBtn];

    
    
}

#pragma mark - YJDropdownMenuDelegate
-(void)dropdownMenuDidDismiss:(YJDropdownMenu *)menu{
    
    //销毁时设置下拉箭头变为向下
    UIButton *btn=(UIButton *)self.navigationItem.titleView;
    
    //[btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    btn.selected=NO;
}

-(void)dropdownMenuDidShow:(YJDropdownMenu *)show{
    
    
    //点击时设置下拉箭头变为向上
    UIButton *btn=(UIButton *)self.navigationItem.titleView;
    btn.selected=YES;
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    

}


#pragma mark - Table view data source




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrameArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    YJStatusCell *cell=[YJStatusCell cellWithTableView:tableView];
    
   
    YJStatusFrame *frame=self.statusFrameArry[indexPath.row];

    
    cell.statusFrame=frame;
    
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YJStatusFrame *statusF=self.statusFrameArry[indexPath.row];
    return  statusF.cellHeight;
}

@end
