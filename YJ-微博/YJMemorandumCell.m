//
//  YJMemorandumCell.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJMemorandumCell.h"
#import "YJMemorandum.h"






@interface YJMemorandumCell(){
    UILabel *title;     //标题
    UILabel *time;      //时间
    UILabel *attach;    //附加信息
    UIView *line;
    
}

@end

@implementation YJMemorandumCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title=[[UILabel alloc] initWithFrame:CGRectZero];
        title.font=[UIFont fontWithName:@"HelveTica" size:15];
        [self.contentView addSubview:title];
        
        time=[[UILabel alloc] initWithFrame:CGRectZero];
        time.font=[UIFont systemFontOfSize:13];
        time.textColor=YJColor(102, 102, 102);
        [self.contentView addSubview:time];
        
        attach=[[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:attach];
        
        line=[[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor=YJColor(199, 199, 199);
        [self.contentView addSubview:line];
        
        
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    title.frame = CGRectMake(10 * kWidthRatio, 10 * kHeightRatio, kWindowWidth - 30 * kWidthRatio, 17);
    time.frame = CGRectMake(10 * kWidthRatio, title.bottom + 5 * kHeightRatio, 100 * kWidthRatio, 17);
    attach.frame = CGRectMake(time.right + 10 * kWidthRatio, time.y, kWindowWidth - time.right - 10 * kWidthRatio, 17);
    line.frame = CGRectMake(10 * kWidthRatio, time.bottom + 10 * kHeightRatio, kWindowWidth - 10 * kWidthRatio, 0.5);
}

- (NSString *)getTodayDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/MM/dd";
    NSString *nowStr = [dateFormatter stringFromDate:now];
    return nowStr;
}

-(void)setNoteData:(YJMemorandum *)model{
    NSString *timeStr=[model.noteTime substringToIndex:10];
    if (![timeStr isEqualToString:[self getTodayDate]]) {
        time.text=timeStr;
    }else{
        //今日编辑
        NSString *todayTime=[model.noteTime substringWithRange:NSMakeRange(11, 5)];
        time.text=todayTime;
    }
    
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc] initWithString:time.text];;
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-Oblique" size:13.0] range:NSMakeRange(0, time.text.length)];
    time.attributedText=attrStr;
    
    title.text=model.noteContent;
    
}

@end
