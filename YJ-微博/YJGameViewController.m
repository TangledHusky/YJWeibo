//
//  YJGameViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJGameViewController.h"
#import "CLLockVC.h"

@interface YJGameViewController ()

@end

@implementation YJGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
    
}

-(void)setupNav{
    
    //设置右边不可点击
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.title=@"手势解锁";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  设置密码
 */
- (IBAction)setPwd:(id)sender {
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    hasPwd = NO;
    if(hasPwd){
        
        NSLog(@"已经设置过密码了，你可以验证或者修改密码");
    }else{
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
        }];
    }
}

/*
 *  验证密码
 */
- (IBAction)verifyPwd:(id)sender {
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
    }else {
        
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:1.0f];
        }];
    }
}


/*
 *  修改密码
 */
- (IBAction)modifyPwd:(id)sender {
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
        
    }else {
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:.5f];
        }];
    }
    
}


@end
