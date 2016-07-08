//
//  YJOtherViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJOtherViewController.h"
#import "testNSCoding-save.h"

@interface YJOtherViewController () <UIAlertViewDelegate>

@end

@implementation YJOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"本地存储";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

-(void)alertViewCancel:(UIAlertView *)alertView{
    
    YJLog(@"取消操作");
}
- (IBAction)alterTest:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"这是一个弹出框？" message:@"确定删除？" delegate:self cancelButtonTitle:@"确认？" otherButtonTitles:@"取消？", nil];
    
    [alert show];
    
    //    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"这是一个弹出框？" message:@"确定删除？" delegate:self cancelButtonTitle:@"确认？" otherButtonTitles:nil, nil];
    //
    //    [alert show];
}

- (IBAction)saveByplist:(id)sender {
    //属性列表，一般保存document下
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"];
    
    NSArray *array=@[@1,@2,@"3"];
    [array writeToFile:path atomically:YES];
    
}
- (IBAction)getByplist:(id)sender {
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"];
    
    NSArray *ary=[NSArray arrayWithContentsOfFile:path];
    
    YJLog(@"%@",ary);
    
}

- (IBAction)saveByPrefenrece:(id)sender {
    //偏好设置存储，一般用来记录账号密码、关键字符信息，保存在lib-》prefenrence
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:@"test" forKey:@"userID"];
    [defaults synchronize];
    
}
- (IBAction)getByprefenrence:(id)sender {
    NSString *result=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    YJLog(@"%@",result);
    
}

- (IBAction)saveByCoding:(id)sender {
    //对象归档，能保持对象实体，一般保存在lib-》caches
    //这里要将对象遵循nscoding协议
    
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"];

    
    testNSCoding_save *save=[[testNSCoding_save alloc] init];
    save.ID=1;
    save.name=@"zhagsan";
    [NSKeyedArchiver archiveRootObject:save toFile:path];
    
    
    
}

- (IBAction)getBycoding:(id)sender {
    
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"];

    testNSCoding_save *save=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    YJLog(@"%@",save);
    
}

@end
