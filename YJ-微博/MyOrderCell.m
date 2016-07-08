//
//  MyOrderCell.m
//  YJ-微博
//
//  Created by MACBOOK on 16/3/25.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell{
    NSMutableArray *array;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:self options:nil] firstObject];
        self.frame=frame;
        
        _tableViewOrder.delegate=self;
        _tableViewOrder.dataSource=self;
        
        array=[NSMutableArray array];
    }
    
    return self;
}

-(void)setOrderIndex:(int)orderIndex{
    _orderIndex=orderIndex;
    
    [array removeAllObjects];
    NSLog(@"jinru  %d",orderIndex);
    for (int i=0; i<10; i++) {
        [array addObject:[NSString stringWithFormat:@"=======这是第%d个=======",orderIndex]];
    }
    
    [_tableViewOrder reloadData];
    
}

#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"orderTableViewID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.textLabel.text=array[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
    if ([self.delegateCell respondsToSelector:@selector(MyOrderCellDidSelected:withIndex:)]) {
        [self.delegateCell MyOrderCellDidSelected:self withIndex:indexPath.row];
    }
    
    
}


@end
