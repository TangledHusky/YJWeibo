//
//  YJStatusFrame.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/28.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatusFrame.h"
#import "YJStatuses-WeiBo.h"
#import "YJUser.h"
#import "YJStatusPhotosView.h"


#define marginLeft 10
#define marginTop 10
#define marginPadding 10



@implementation YJStatusFrame



-(void)setStatus:(YJStatuses_WeiBo *)status{
    
    _status=status;
    
    YJUser *user=status.user;
    
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width;
    
    //设置头像
    CGFloat iconX=marginLeft;
    CGFloat iconY=marginTop;
    CGFloat iconWH=45;
    self.iconViewF=CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //设置昵称
    CGFloat nameX=CGRectGetMaxX(self.iconViewF)+marginPadding;
    CGSize nameSize=[user.name sizeWithFont:YJStatusNameFont];
    self.nameLabelF=(CGRect){{nameX,iconY},nameSize};
    
    
    
    //设置会员图标
    if (user.isVip) {
        
        CGFloat vipX=CGRectGetMaxX(self.nameLabelF)+marginPadding;
        CGFloat vipW=14;
        self.vipViewF=CGRectMake(vipX, iconY, vipW, nameSize.height);

    }
    
    //设置时间
    CGFloat timeX=nameX;
    CGFloat timeY=CGRectGetMaxY(self.nameLabelF)+marginPadding;
    CGSize timeSize=[status.created_at sizeWithFont:YJStatusSourceFont];
    self.timeLabelF=(CGRect){{timeX,timeY},timeSize};

    //设置来源
    CGFloat sourceX=CGRectGetMaxX(self.timeLabelF)+marginPadding;
    CGSize sourceSize=[status.source sizeWithFont:YJStatusSourceFont];
    self.sourceLabelF=(CGRect){{sourceX,timeY},sourceSize};
    
    
    
    //正文
    CGFloat contentY=MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.sourceLabelF))+marginPadding;
    CGFloat contentMaxW=cellW-marginPadding*2;
    CGSize contentSize=[status.text sizeWithFont:YJStatusContentFont maxW:contentMaxW];
    self.contentLabelF=(CGRect){{iconX,contentY},contentSize};
    
    //配图
    CGFloat cellH=0;
    if (status.pic_urls.count) {
        CGFloat photosX=iconX;
        CGFloat photosY=CGRectGetMaxY(self.contentLabelF)+marginPadding;
        CGSize photosSize=[YJStatusPhotosView SizeWithCount:status.pic_urls.count];
        self.photosViewF=CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        cellH=CGRectGetMaxY(self.photosViewF)+marginPadding;
        
    }else{
        cellH=CGRectGetMaxY(self.contentLabelF)+marginPadding;
    }
    
    
    //原创微博
    CGFloat originalH=cellH;
    self.originalViewF=CGRectMake(0, 0, cellW, originalH);
    
    //转发微博部分-------------------------------------
    if (status.retweeted_status) {
        CGFloat retweetH=0;
        
         YJStatuses_WeiBo *retweetStatus=status.retweeted_status;
         YJUser *retweetStatusUser=retweetStatus.user;
    
        //转发微博正文（昵称+文本）
        CGFloat retweetContentX=iconX;
        CGFloat retweetContentY=marginPadding;
        NSString *retweetContentText=[NSString stringWithFormat:@"%@ %@",retweetStatusUser.name,retweetStatus.text];
        CGSize retweetContentSize=[retweetContentText sizeWithFont:YJStatusRetweetContentFont maxW:cellW];
        self.retweetContentLabelF=CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
        
        //转发微博配图
        if (retweetStatus.pic_urls.count) {
            
            CGFloat retweetPhotosX=iconX;
            CGFloat retweetPhotosY=CGRectGetMaxY(self.retweetContentLabelF)+marginPadding;
            
            CGSize retweetPhotosWH=[YJStatusPhotosView SizeWithCount:retweetStatus.pic_urls.count];
            self.retweetPhotosViewF=CGRectMake(retweetPhotosX, retweetPhotosY, retweetPhotosWH.width, retweetPhotosWH.height);
            retweetH=CGRectGetMaxY(self.retweetPhotosViewF)+marginPadding;
            
        }else{
            retweetH=CGRectGetMaxY(self.retweetContentLabelF)+marginPadding;
        }
        
        //转发微博整体
        self.retweetViewF=CGRectMake(0, originalH, cellW, retweetH);
        cellH+=retweetH;
    }
    
    //工具条
    CGFloat toolbarW=cellW;
    CGFloat toolbarH=30;
    CGFloat toolbarX=0;
    CGFloat toolbarY=cellH;
    self.toolbarF=CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    //设置cell高度
    self.cellHeight=CGRectGetMaxY(self.toolbarF)+marginPadding;
    
    
}

@end
