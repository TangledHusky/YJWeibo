//
//  UITableView+Extension.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

-(void)tabeViewDisplayWithMsg:(NSString *)msg ifNecessaryForRowCount:(NSUInteger)rowCount{
    if (rowCount==0) {
        //没数据的时候，用label显示提示
        
        UILabel *msgLabel=[UILabel new];
        msgLabel.text=msg;
        msgLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        msgLabel.textColor=[UIColor lightGrayColor];
        msgLabel.textAlignment=NSTextAlignmentCenter;
        [msgLabel sizeToFit];
        
        self.backgroundView=msgLabel;
        self.separatorStyle=UITableViewCellSelectionStyleNone;
        
    }else {
        
        self.backgroundView=nil;
        self.separatorStyle=UITableViewCellSelectionStyleNone;
    }
    
}

@end
