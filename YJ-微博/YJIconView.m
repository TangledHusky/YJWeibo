//
//  YJIconView.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/31.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJIconView.h"
#import "YJUser.h"
#import "UIImageView+WebCache.h"
@interface YJIconView()

@property (nonatomic,strong) UIImageView *verifiedView;

@end


@implementation YJIconView


-(UIImageView *)verifiedView{
    if(_verifiedView==nil){
        UIImageView *icon=[[UIImageView alloc] init];
        [self addSubview:icon];
        self.verifiedView=icon;
    }
    return  _verifiedView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    
    return  self;
}

-(void)setUser:(YJUser *)user{
    _user=user;
    
    //下载头像
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置头像下标
    switch (user.verified_type) {
        case YJUserVerifiedTypePersonal:
            self.verifiedView.hidden=NO;
            self.verifiedView.image=[UIImage imageNamed:@"avatar_vip"];
            break;
        case YJUserVerifiedTypeEnterprice:
        case YJUserVerifiedTypeMedia:
        case YJUserVerifiedTypeWebsite:
            self.verifiedView.hidden=NO;
            self.verifiedView.image=[UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
      
        case YJUserVerifiedTypeDaren:
            self.verifiedView.hidden=NO;
            self.verifiedView.image=[UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden=YES;
            break;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.verifiedView.x=self.width-self.verifiedView.width*0.6;
    self.verifiedView.y=self.height-self.verifiedView.height*0.6;
    self.verifiedView.size=self.verifiedView.image.size;
    
    
}

@end
