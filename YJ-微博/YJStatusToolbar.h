//
//  YJStatusToolbar.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/30.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJStatuses_WeiBo;

@interface YJStatusToolbar : UIView

+(instancetype)toolbar;

@property (nonatomic,strong) YJStatuses_WeiBo  *status;
@end
