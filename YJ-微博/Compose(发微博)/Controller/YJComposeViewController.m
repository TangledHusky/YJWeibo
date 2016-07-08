//
//  YJComposeViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJComposeViewController.h"
#import "YJUserAccountTool.h"
#import "YJTextView.h"
#import "AFNetworking.h"
#import "YJUserAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "YJComposeKeyboardTool.h"
#import "YJComposePhotosView.h"
#import "YJEmotionKeyboard.h"
#import "YJEmotion.h"
#import "YJEmotionTextView.h"


#define YJKeyboardHeight 40

@interface YJComposeViewController() <UITextViewDelegate,YJComposeKeyboardToolDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) YJEmotionTextView *textView;
@property (nonatomic,weak) YJComposeKeyboardTool *keytoolBar;
@property (nonatomic,weak) YJComposePhotosView *photosView;
@property (nonatomic,strong) YJEmotionKeyboard  *emotionKeyboard;
@property (nonatomic,assign) BOOL isSwitch;

@end

@implementation YJComposeViewController

#pragma mark - 懒加载

-(YJEmotionKeyboard *)emotionKeyboard{
    if(_emotionKeyboard==nil){
        self.emotionKeyboard=[[YJEmotionKeyboard alloc] init];
        self.emotionKeyboard.width=self.view.width;
        self.emotionKeyboard.height=216;
        
    }
    return  _emotionKeyboard;
}

#pragma  mark - 初始化方法

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    //添加导航按钮
    [self setupNacButton];
    
    //设置标题
    [self setupNavTitle];
    
    //设置输入框，用自定义控件textview
    [self setupTextView];
    
    //设置键盘工具条
    [self setupKeyboardTool];
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
    
}

//设置按钮的初始不可用
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled=NO;
}


-(void)setupKeyboardTool{
    YJComposeKeyboardTool *keyb=[[YJComposeKeyboardTool alloc] init];
    keyb.width=self.view.width;
    keyb.height=YJKeyboardHeight;
    keyb.delegate=self;
    
//    //这种方式，工具条是永远跟随键盘的
//    //inputAccessoryView:将view添加到键盘上方
//    self.textView.inputAccessoryView=keyb;
    
    keyb.x=0;
    keyb.y=self.view.height-keyb.height;

    [self.view addSubview:keyb];
    self.keytoolBar=keyb;
    
    
    
}


-(void)setupTextView{
    YJEmotionTextView *textView=[[YJEmotionTextView alloc] init];
    textView.frame=self.view.bounds;
    textView.placeholder=@"分享新鲜事...";
    textView.placeholderColor=[UIColor grayColor];
    textView.font=[UIFont systemFontOfSize:15];
    //设置textview的弹簧效果
    textView.alwaysBounceVertical=YES;
    textView.delegate=self;
    
    //插入表情
    
    
    
    [self.view addSubview: textView];
    self.textView=textView;
    
    //添加相册view
    YJComposePhotosView *photoV=[[YJComposePhotosView alloc] init];
    photoV.x=0;
    photoV.y=200;
    photoV.width=self.textView.width;
    photoV.height=self.textView.height;
    self.photosView=photoV;
    
    [self.view addSubview:photoV];
    
    
    //监听输入框文字改变通知，用来控制右上角发生按钮可用不可用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    
    
    //通知：监听键盘位置的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:YJEmotioDidSelectNotification object:nil];
    
    //删除表情
    [YJNotification addObserver:self selector:@selector(emotionDelete) name:YJDeleteEmotionKey object:nil];
    
}

#pragma mark - 表情监听方法
//选择表情
-(void)emotionDidSelect:(NSNotification *)notfication{
    YJEmotion *emotion=notfication.userInfo[YJSelectEmotionKey];
    
    [self.textView insertEmotion:emotion];
    
   
}


//删除表情
-(void)emotionDelete{
    [self.textView deleteBackward];
    
}

-(void)setupNavTitle{
    //设置标题
    UILabel *labelView=[[UILabel alloc]init];
    labelView.width=200;
    labelView.height=44;
    labelView.textAlignment=NSTextAlignmentCenter;
    NSString *name=[YJUserAccountTool getAccount].name;
    NSString *prefix=@"发微博";
    NSString *str=@"";
    if (name) {
       str =[NSString stringWithFormat:@"%@\n%@",prefix,name];
    }else{
       str=[NSString stringWithFormat:@"%@",prefix];
    }
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, prefix.length)];
 
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(prefix.length+1, name.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(prefix.length+1, name.length)];

    
    labelView.attributedText=attrStr;
    
    //换行，很重要，不写不会换行
    labelView.numberOfLines=0;
    
    
    self.navigationItem.titleView=labelView;
    
}

-(void)setupNacButton{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];

    
}

#pragma mark - textview监听方法

-(void)cancel{
    [self.textView endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)send{
    
    //根据是否有图片，选择不同接口
    if (self.photosView.addedPhotoArray.count) {
        [self sendWithPhoto];
    }else{
        [self sendWithoutPhoto];
    }
 
  
    

}

-(void)sendWithPhoto{
    
    YJLog(@"photo");
    
    /**
     https://upload.api.weibo.com/2/statuses/upload.json
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
     post  发送
     */
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"access_token"]=[YJUserAccountTool getAccount].access_token;
    parms[@"status"]=self.textView.fullText;
    
    [manage POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image=[self.photosView.addedPhotoArray firstObject];
        NSData *data=UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [MBProgressHUD showSuccess:@"发送成功！"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD showError:@"发送失败！"];
    }];
    
    //关闭发送界面
    [self cancel];
}

-(void)sendWithoutPhoto{
    /**
     https://api.weibo.com/2/statuses/update.json
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     
     post  发送
     */
    
    
    
        //这种方法只能发送文字
        AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
        NSMutableDictionary *parms=[NSMutableDictionary dictionary];
        parms[@"access_token"]=[YJUserAccountTool getAccount].access_token;
        parms[@"status"]=self.textView.fullText;
    
   
    
        [manage POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
            YJLog(@"发生微博success");
            [MBProgressHUD showSuccess:@"发送成功！"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             YJLog(@"发生微博error");
             [MBProgressHUD showError:@"发送失败！"];
        }];
    
        //关闭发送界面
        [self cancel];
    
}


-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled=[self.textView hasText];
    
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    /**
     userInfo = {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 253}},
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 694.5},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 441.5},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardIsLocalUserInfoKey = 1,
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},
     UIKeyboardAnimationCurveUserInfoKey = 7

     */
    //YJLog(@"%@",notification);
    
    //键盘切换时，阻止keytoolbar位置改变
    if (self.isSwitch) return;
    
    NSDictionary *dict=notification.userInfo;
    double speed=[dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame=[dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:speed animations:^{
        self.keytoolBar.x=frame.origin.x;
        self.keytoolBar.y=frame.origin.y-self.keytoolBar.height;
    }];
    
    
}


#pragma mark - textview代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}




#pragma mark - keyboardTool 代理

-(void)KeyboardTool:(YJComposeKeyboardTool *)toolbar DidClcikButton:(YJKeyboardButtonType)btnType{
  
    switch (btnType) {
        case YJKeyboardButtonTypeCamel:     //相机
            YJLog(@"相机");
            [self openCameral];
            
            break;
        case YJKeyboardButtonTypePhoto:       //照片
            YJLog(@"照片");
            [self openPictures];

            
            break;
        case YJKeyboardButtonTypeHt:       //# 话题
            YJLog(@"话题");

            
            break;
        case YJKeyboardButtonTypeAT:       //@at
            YJLog(@"at");
            
            break;
        case YJKeyboardButtonTypeEmotion:       //表情
            [self switchEmition];

            
            break;
            
        default:
            YJLog(@"error");

            break;
    }
    
}

-(void)openCameral{
    //如果相机不可用，则return
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])   return;
    
    UIImagePickerController *pc=[[UIImagePickerController alloc] init];
    pc.sourceType=UIImagePickerControllerSourceTypeCamera;
    pc.delegate=self;
    [self presentViewController:pc animated:YES completion:nil];
    
}

-(void)openPictures{
    //如果照片不可用，则return
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])   return;
    
    UIImagePickerController *pc=[[UIImagePickerController alloc] init];
    pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pc.delegate=self;
    [self presentViewController:pc animated:YES completion:nil];
}


-(void)switchEmition{
    YJLog(@"dianji qiehuan");
    
    //nil表示是系统键盘
    if (self.textView.inputView==nil) {
       
        self.textView.inputView=self.emotionKeyboard;
        
        //显示键盘图标
        self.keytoolBar.showKeyboard=YES;

    }else{
        self.textView.inputView=nil;
        //显示表情图标
        self.keytoolBar.showKeyboard=NO;

        
    }
    
    //开始切换键盘
    self.isSwitch=YES;
    
    
    [self.textView endEditing:YES];
    
     self.isSwitch=NO;
    
    //给予一个延迟时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
       
    });
}


#pragma mark - UIImagePickerController代理
/*
 从相册库选择完图片后就调用
 
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //打印info数组，选择一个属性
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    
    //添加图片到发送框内的photoview
    [self.photosView addPhoto:image];
    
    
}

@end
