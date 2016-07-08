//
//  MyOrderTitle.m
//  YJ-微博
//
//  Created by MACBOOK on 16/3/25.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "MyOrderTitle.h"


@implementation MyOrderTitle{
    UIButton *currentBtn;
    
    __weak IBOutlet UIView *line;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       
        self=[[[NSBundle mainBundle] loadNibNamed:@"MyOrderTitle" owner:self options:nil] firstObject];
        self.frame=frame;
        self.backgroundColor=[UIColor whiteColor];
        
        [self btnClick:[self viewWithTag:1]];
    }
    
    return self;
}


- (IBAction)btnClick:(UIButton *)sender {
    if (currentBtn) {
        currentBtn.selected=NO;
    }
    sender.selected=YES;
    currentBtn=sender;
    
    //横线
    [UIView animateWithDuration:0.3 animations:^{
        line.x=(sender.tag-1)*kScreenWidth/5;
        line.width=kScreenWidth/5;
    }];
    
    if ([self.delegate respondsToSelector:@selector(MyOrderTitleDidClick:withClickIndex:)]) {
        [self.delegate MyOrderTitleDidClick:self withClickIndex:sender.tag-1];
    }
}



@end
