//
//  YJStatusCell.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/28.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatusCell.h"
#import "YJStatusFrame.h"
#import "YJUser.h"
#import "YJStatuses-WeiBo.h"
#import "YJPhotos.h"
#import "YJStatusToolbar.h"
#import "YJStatusPhotosView.h"
#import "YJIconView.h"

@interface YJStatusCell()

/** 原创微博整体  */
@property (nonatomic,weak) UIView *originalView;
/** 头像 */
@property (nonatomic,weak) YJIconView *iconView;
/** 会员图标   */
@property (nonatomic,weak) UIImageView *vipView;
/**	配图 */
@property (nonatomic,weak) YJStatusPhotosView *photosView;
/**	昵称   */
@property (nonatomic,weak) UILabel *nameLabel;
/**	时间  */
@property (nonatomic,weak) UILabel *timeLabel;
/** 来源    */
@property (nonatomic,weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic,weak) UILabel *contentLabel;

/** 转发微博 整体   */
@property (nonatomic,strong) UIView  *retweetView;
/**	转发微博正文   */
@property (nonatomic,weak) UILabel *retweetContentLabel;
/**	转发微博 配图  */
@property (nonatomic,weak) YJStatusPhotosView *retweetPhotosView;

/** 工具条 整体   */
@property (nonatomic,weak) YJStatusToolbar *toolbar;

@end


@implementation YJStatusCell



+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID=@"status";
    YJStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[YJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    
    return  cell;
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        //清除选中效果
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
//        //重新赋值选中颜色。
//        UIView *bg=[[UIView alloc] init];
//        bg.backgroundColor=[UIColor blueColor];
//        self.selectedBackgroundView=bg;
        

        //设置原创微博
        [self setupOriginalView];
       
        //设置转发微博
        [self setupRetweetView];
        
        //设置工具条
        [self setupToobar];
        
    }
    
    return  self;
    
    
}

//设置工具条
-(void)setupToobar{
    YJStatusToolbar *toolbar=[YJStatusToolbar toolbar];
    //toolbar.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:toolbar];
    self.toolbar=toolbar;
    
}

//设置转发微博
-(void)setupRetweetView{
    //转发微博整体
    UIView *retweetView=[[UIView alloc] init];
    retweetView.backgroundColor=YJColor(240, 240, 240);
    [self.contentView addSubview:retweetView];
    self.retweetView=retweetView;
    
    /** 转发微博 正文 */
    UILabel *retweetContentLabel=[[UILabel alloc] init];
    retweetContentLabel.font=YJStatusRetweetContentFont;
    retweetContentLabel.numberOfLines=0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel=retweetContentLabel;
    
    /**	转发微博配图 */
    YJStatusPhotosView *retweetPhotoView=[[YJStatusPhotosView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotosView=retweetPhotoView;
    

}

//设置原创微博
-(void)setupOriginalView{
    /** 原创微博整体  */
    UIView *originalView=[[UIView alloc] init];
    originalView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView=originalView;
    
    /** 头像 */
    YJIconView *iconView=[[YJIconView alloc] init];
    [self.originalView addSubview:iconView];
    self.iconView=iconView;
    
    /** 会员图标   */
    UIImageView *vipView=[[UIImageView alloc] init];
    vipView.contentMode=UIViewContentModeCenter;
    [self.originalView addSubview:vipView];
    self.vipView=vipView;
    
    /**	配图 */
    YJStatusPhotosView *photoView=[[YJStatusPhotosView alloc] init];
    [self.originalView addSubview:photoView];
    self.photosView=photoView;
    
    /**	昵称   */
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.font=YJStatusNameFont;
    [self.originalView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    /**	时间  */
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.textColor=[UIColor orangeColor];
    timeLabel.font=YJStatusTimeFont;
    [self.originalView addSubview:timeLabel];
    self.timeLabel=timeLabel;
    
    /** 来源    */
    UILabel *sourceLabel=[[UILabel alloc] init];
    sourceLabel.font=YJStatusSourceFont;
    sourceLabel.textColor=[UIColor grayColor];
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel=sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel=[[UILabel alloc] init];
    contentLabel.font=YJStatusContentFont;
    contentLabel.numberOfLines=0;
    [self.originalView addSubview:contentLabel];
    self.contentLabel=contentLabel;
}

-(void)setStatusFrame:(YJStatusFrame *)statusFrame{
    _statusFrame=statusFrame;
   
    YJStatuses_WeiBo *statuses=statusFrame.status;
    YJUser *user=statuses.user;
    
    /** 原创微博整体  */
    self.originalView.frame=statusFrame.originalViewF;
    //self.originalView.backgroundColor=[UIColor redColor];
    
    /** 头像 */
    self.iconView.frame=statusFrame.iconViewF;
    self.iconView.user=user;
    
    
    /**	昵称   */
    self.nameLabel.frame=statusFrame.nameLabelF;
    self.nameLabel.text=user.name;

   
    /** 会员图标   */
    if (user.isVip) {
        self.vipView.hidden=NO;
        self.vipView.frame=statusFrame.vipViewF;
        NSString *rank=[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image=[UIImage imageNamed:rank];
        self.nameLabel.textColor=[UIColor orangeColor];
    }else{
        self.vipView.hidden=YES;
        self.nameLabel.textColor =[UIColor blackColor];
    }
   
    /**	配图 */
    if (statusFrame.status.pic_urls.count) {
        
        self.photosView.frame=statusFrame.photosViewF;
        self.photosView.photos=statuses.pic_urls;
       
        self.photosView.hidden=NO;
    }else{
        self.photosView.hidden=YES;
    }
    
    /**	时间  */
    //时间可能会变，frame也要跟着改变适应才行
    NSString *createDate=statuses.created_at;
    CGSize timeSize=[createDate sizeWithFont:YJStatusTimeFont];
    self.timeLabel.frame=CGRectMake(statusFrame.timeLabelF.origin.x, statusFrame.timeLabelF.origin.y, timeSize.width, timeSize.height);
    self.timeLabel.text=createDate;
    
    /** 来源    */
    NSString *sour=statuses.source;
    CGSize sourceSize=[sour sizeWithFont:YJStatusSourceFont];
    self.sourceLabel.frame=CGRectMake(CGRectGetMaxX(self.timeLabel.frame)+10, statusFrame.sourceLabelF.origin.y, sourceSize.width, sourceSize.height);
    self.sourceLabel.text=sour;


    /** 正文 */
    self.contentLabel.frame=statusFrame.contentLabelF;
    self.contentLabel.attributedText=statuses.attributeText;

    
    //转发微博部分
    YJStatuses_WeiBo *retweetStatus=statusFrame.status.retweeted_status;
    YJUser *retweetStatusUser=retweetStatus.user;
    self.retweetView.frame=statusFrame.retweetViewF;
    /**	正文 */
//    NSString *retweetContentText=[NSString stringWithFormat:@"@%@: %@",retweetStatusUser.name,retweetStatus.text];
//    self.retweetContentLabel.text=retweetContentText;
    self.retweetContentLabel.attributedText=statuses.retweetedAttributeText;
    self.retweetContentLabel.frame=statusFrame.retweetContentLabelF;
    
    /**	配图 */
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotosView.frame=statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.hidden=NO;
        self.retweetPhotosView.photos= retweetStatus.pic_urls ;
       
    }else{
        self.retweetPhotosView.hidden=YES;
    }
    
    
    //工具条
    self.toolbar.frame=statusFrame.toolbarF;
    
    
    
}


@end
