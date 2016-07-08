//
//  YJStatusPhotoView.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/31.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "YJPhotos.h"

@interface YJStatusPhotoView()
@property (nonatomic,weak) UIImageView *gifView;

@end



@implementation YJStatusPhotoView

-(UIImageView *)gifView{
    if(_gifView==nil){
       
        UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:img];
        self.gifView=img;
    }
    return  _gifView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;

    }
    return self;
}

-(void)setPhoto:(YJPhotos *)photo{
    _photo=photo;
    
    //下载
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示/隐藏gif图标
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        //以gif结尾
        self.gifView.hidden=NO;
        
    }else{
        
        self.gifView.hidden=YES;

    }
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //重新布局
    self.gifView.x=self.width-self.gifView.width;
    self.gifView.y=self.height-self.gifView.height;
    
}

@end
