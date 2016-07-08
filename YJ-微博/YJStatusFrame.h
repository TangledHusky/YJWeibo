//
//  YJStatusFrame.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/28.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YJStatusNameFont [UIFont systemFontOfSize:15]
#define YJStatusTimeFont [UIFont systemFontOfSize:12]
#define YJStatusSourceFont [UIFont systemFontOfSize:12]
#define YJStatusContentFont [UIFont systemFontOfSize:14]
#define YJStatusRetweetContentFont [UIFont systemFontOfSize:14]

@class YJStatuses_WeiBo;

@interface YJStatusFrame : NSObject

/** 微博 */
@property (nonatomic,strong) YJStatuses_WeiBo *status;

/** 原创微博整体  */
@property (nonatomic,assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic,assign) CGRect iconViewF;
/** 会员图标   */
@property (nonatomic,assign) CGRect vipViewF;
/**	配图 */
@property (nonatomic,assign) CGRect photosViewF;
/**	昵称   */
@property (nonatomic,assign) CGRect nameLabelF;
/**	时间  */
@property (nonatomic,assign) CGRect timeLabelF;
/** 来源    */
@property (nonatomic,assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign) CGRect contentLabelF;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;


/** 转发微博 整体   */
@property (nonatomic,assign) CGRect retweetViewF;
/**	转发微博正文   */
@property (nonatomic,assign) CGRect retweetContentLabelF;
/**	转发微博 配图  */
@property (nonatomic,assign) CGRect retweetPhotosViewF;

/** 工具条 整体   */
@property (nonatomic,assign) CGRect toolbarF;

@end
