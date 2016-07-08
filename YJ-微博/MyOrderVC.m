//
//  MyOrderVC.m
//  YJ-微博
//
//  Created by MACBOOK on 16/3/25.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderTitle.h"
#import "MyOrderCell.h"
#import "MyOrderDetail.h"

@interface MyOrderVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyOrderTitleDelegate,MyOrderCellDelegate>
{
    UICollectionView *myCollectionView;
    MyOrderTitle *title;
}

@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"我的订单";
    
    title=[[MyOrderTitle alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 36)];
    title.delegate=self;
    [self.view addSubview:title];
    
    
    [self addScrollView];
    
    
    
}

- (void)addScrollView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing=0;
    flowLayout.itemSize=CGSizeMake(kScreenWidth, kScreenHeight);
    
    myCollectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    myCollectionView.frame=CGRectMake(0, 100, kScreenWidth, kScreenHeight-100);
    myCollectionView.delegate=self;
    myCollectionView.dataSource=self;
    myCollectionView.bounces=NO;
    myCollectionView.pagingEnabled=YES;
    myCollectionView.showsVerticalScrollIndicator=NO;
    myCollectionView.showsHorizontalScrollIndicator=NO;
    myCollectionView.backgroundColor=[UIColor whiteColor];
    [myCollectionView registerClass:[MyOrderCell class] forCellWithReuseIdentifier:@"MyOrderCellID"];
    [self.view addSubview:myCollectionView];
    
    
}


#pragma  mark -collectionView代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"MyOrderCellID";
    MyOrderCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.delegateCell=self;
    if (!cell) {
        cell=[[MyOrderCell alloc] init];
    }
    
    cell.orderIndex=indexPath.item;
    
    return cell;
    
}


#pragma  mark - 按钮点击代理
-(void)MyOrderTitleDidClick:(MyOrderTitle *)myOrderTitle withClickIndex:(NSInteger)index{

    
    [myCollectionView setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int indexPath=myCollectionView.contentOffset.x/kScreenWidth;
    [title btnClick:[title viewWithTag:indexPath+1]];
    
}



#pragma mark - cell点击
-(void)MyOrderCellDidSelected:(MyOrderCell *)MyOrderCell withIndex:(NSInteger)index{
    NSLog(@"为什么获取不到点击代理");
    MyOrderDetail *detail=[[MyOrderDetail alloc] init];
    detail.index=index;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
