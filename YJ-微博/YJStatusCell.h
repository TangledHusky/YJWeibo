//
//  YJStatusCell.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/28.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJStatusFrame;

@interface YJStatusCell : UITableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)  YJStatusFrame *statusFrame;

@end
