//
//  YJStatusPhotosView.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/31.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatusPhotosView.h"
#import "YJPhotos.h"
#import "YJStatusPhotoView.h"

#define YJStatusPhotosPicWH 70
#define YJStatusPhotosPicMargin 10

@implementation YJStatusPhotosView
//

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor redColor];
    }
    
    return  self;
}


-(void)setPhotos:(NSArray *)photos{
    _photos=photos;
    
    //这里要注意重复利用
    //不够用，再补上,创建缺少的imageview
    while (self.subviews.count<photos.count) {
        //chuangjian
        YJStatusPhotoView *photoView=[[YJStatusPhotoView alloc] init];
        [self addSubview:photoView];
        
    }
    
    
    //遍历图片，设置
    //这里，subviews可能多余photos数量，多余的要隐藏
    
    for (int i=0; i<self.subviews.count; i++) {
        //
        YJStatusPhotoView *photoView=self.subviews[i];
        if (i<photos.count) {
            
            photoView.photo=photos[i];
          
            photoView.hidden=NO;
            
        }else{
            photoView.hidden=YES;
        }
        
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //自己额外处理
    int count=self.photos.count;
    for (int i=0; i<count; i++) {
        YJStatusPhotoView *photoV=self.subviews[i];
        
        int row=i/3;
        int col=i%3;
        
        photoV.x=col*(YJStatusPhotosPicWH+YJStatusPhotosPicMargin);
        photoV.y=row*(YJStatusPhotosPicWH+YJStatusPhotosPicMargin);
        photoV.width=YJStatusPhotosPicWH;
        photoV.height=YJStatusPhotosPicWH;
    }
    
}

//根据照片个数计算相册尺寸
+(CGSize)SizeWithCount:(int)count{
    //每行最多显示3个
    
    //行(利用分页思想)
    int rows=(count+3-1)/3;
    CGFloat h=rows*(YJStatusPhotosPicWH+YJStatusPhotosPicMargin)-YJStatusPhotosPicMargin;
    
    //列
    int cols=count>2?3:count;
    CGFloat w=cols*(YJStatusPhotosPicWH+YJStatusPhotosPicMargin)-YJStatusPhotosPicMargin;
    
    return  CGSizeMake(w, h);
    
    
}

@end




