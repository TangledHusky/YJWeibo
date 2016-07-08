//
//  YJTitleMenuViewControl.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/7.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJTitleMenuViewControl.h"

@implementation YJTitleMenuViewControl


-(void)viewDidLoad{
    [super viewDidLoad];
    
}



#pragma mark - tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  6;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"titleMenu";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSArray *dict=[[NSArray alloc] initWithObjects:@"好友",@"明星",@"同学",@"朋友",@"陌生人",@"黑名单", nil];
   
   
    cell.textLabel.text=dict[indexPath.row];
    cell.backgroundColor=randomColor;
    cell.height=30;
   
    
    
    return  cell;
}


@end
