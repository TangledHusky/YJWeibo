//
//  YJComposePhotosView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJComposePhotosView.h"


@interface YJComposePhotosView()

@property (nonatomic,weak) UIImageView *photoView;


#define photoWH 70              //照片高宽
#define photoMargin 10          //照片间距
@end

@implementation YJComposePhotosView

-(UIImageView *)photoView{
    if(_photoView==nil){
        UIImageView *imageView=[[UIImageView alloc] init];
        _photoView=imageView;
        self.photoView=imageView;
    }
    return  _photoView;
}

//-(NSMutableArray *)addedPhotoArray{
//    if(_addedPhotoArray==nil){
//        self.addedPhotoArray=[NSMutableArray array];
//    }
//    return  _addedPhotoArray;
//}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor blueColor];
        _addedPhotoArray=[NSMutableArray array];
    }
    
    return  self;
    
}



-(void)addPhoto:(UIImage *)photo{
    UIImageView *imageV=[[UIImageView alloc] init];
    imageV.image=photo;
    [self addSubview:imageV];
    
    
    //存储图
    [self.addedPhotoArray addObject:photo];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //假设一行排列3张图片
    
    int cols=3;
    CGFloat imageWH=photoWH;
    
    int count=self.subviews.count;
    for (int i=0; i<count; i++) {
        self.photoView=self.subviews[i];
        
        int row=i/cols;
        int col=i%cols;
        self.photoView.x=col*imageWH+(col+1)*photoMargin;
        self.photoView.y=row*(imageWH+photoMargin);
        self.photoView.width=imageWH;
        self.photoView.height=imageWH;
    }
    
}



@end
