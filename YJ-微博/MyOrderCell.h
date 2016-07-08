//
//  MyOrderCell.h
//  YJ-微博
//
//  Created by MACBOOK on 16/3/25.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderCell;

@protocol  MyOrderCellDelegate <NSObject>

-(void)MyOrderCellDidSelected:(MyOrderCell *)MyOrderCell withIndex:(NSInteger)index;

@end

@interface MyOrderCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewOrder;


@property (nonatomic,assign) int  orderIndex;

@property (nonatomic,weak) id<MyOrderCellDelegate>  delegateCell;

@end
