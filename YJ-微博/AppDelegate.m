//
//  AppDelegate.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/19.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "AppDelegate.h"
#import "YJOAuthViewController.h"
#import "userAccount.h"
#import "YJUserAccountTool.h"
#import "SDWebImageManager.h"
#import "AFNetworking.h"

#import "LeftSortsViewController.h"
#import "YJTabbarViewController.h"
#import "LoginOtherViewController.h"


#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"


@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.创建主窗体
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

    //2.显示作为主窗体
    [self.window makeKeyAndVisible];
    
    //初始化主界面和侧边栏
    self.mainNavigationController = [[YJTabbarViewController alloc] init];
    LeftSortsViewController * lestVC = [[LeftSortsViewController alloc]init];
    self.LeftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:lestVC andMainView:self.mainNavigationController];

    
    //3.判断账号是否授权，并且授权登陆后判断是否有新版本，有则进入新特性，否则直接进入主界面
    userAccount *dictAccount= [YJUserAccountTool getAccount];

    //如果账号不存在
    if (!dictAccount) {
//        LoginOtherViewController *loginVC=[[LoginOtherViewController alloc] init];
//        self.window.rootViewController=loginVC;
        
        //进授权界面
        YJOAuthViewController *oauth=[[YJOAuthViewController alloc] init];//
        self.window.rootViewController=oauth;
        
        
    }else{
        //否则存在则进行下面步骤：判断新特性，进主界面
        
        [UIWindow switchRootController];
    }
    
    [self registerAPPkey];
    
    return YES;
}


-(void)registerAPPkey{
    //微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:weiboAppKey];
    
    //qq
    //不需要，qq有一个自己的类sdkcall，appid在那里设置
    
    
    //weixin
    [WXApi registerApp:WXAppKey withDescription:@"weixin"];
    
}



-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
      NSLog(@"=============openURL=============%@",url);
    
    
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
         return [TencentOAuth HandleOpenURL:url];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self];
        
    }
    
    return  NO;
    
    
}


-(void)onResp:(BaseResp *)resp{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode== 0) {
        NSString *code = aresp.code;
        [self GetUserInfoByWX:code];
    }
}

-(void)GetUserInfoByWX:(NSString *)code{
    //获取access-token
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"appid"]=WXAppKey;
    parms[@"secret"]=WXAppSecret;
    parms[@"code"]=code;
    parms[@"grant_type"]=@"authorization_code";
    
    
    [manage GET:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        YJLog(@"通过wx获取token success----%@",responseObject);
        //可以取出昵称(name)、头像(profile_image_url)等
        NSString *accesstoken=responseObject[@"access_token"];
        
        //https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID   获取用户信息
        AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
        
        NSMutableDictionary *parms=[NSMutableDictionary dictionary];
        parms[@"access_token"]=accesstoken;
        parms[@"openid"]=responseObject[@"openid"];
        
        
        [manage GET:@"https://api.weixin.qq.com/sns/userinfo" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
            YJLog(@"通过wx授权后获取用户信息success----%@",responseObject);
    
            AppDelegate * tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            self.window.rootViewController=tempAppDelegate.LeftSlideVC;

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            YJLog(@"通过wx授权后获取用户信息error-----%@",error);
        }];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"通过wx获取token error-----%@",error);
    }];
    
    
}

//新浪微博授权后代理方法
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
       
        NSString *title = NSLocalizedString(@"认证结果", nil);

        
        if (response.statusCode==0) {
            NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
            
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                            message:@"授权成功"
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            
//            
//            [alert show];
            
              NSLog(@"=============WBAuthorizeResponse授权成功==============\nuid：%@====accessToken:%@======%@",message,[(WBAuthorizeResponse *)response userID],[(WBAuthorizeResponse *)response accessToken]);
            
            //2.根据uid调用接口获取用户信息，返回dictionary
            AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
            
            NSMutableDictionary *parms=[NSMutableDictionary dictionary];
            parms[@"access_token"]=[(WBAuthorizeResponse *)response accessToken];
            parms[@"uid"]=[(WBAuthorizeResponse *)response userID];
            
            [manage GET:@"https://api.weibo.com/2/users/show.json" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
                YJLog(@"通过wb授权后获取用户信息success----%@",responseObject);
                //可以取出昵称(name)、头像(profile_image_url)等
                //
         
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                YJLog(@"通过wb授权后获取用户信息error-----%@",error);
            }];
            
            
          
        }
        
        
    }

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    //在进入后台后，给系统申请继续进行监听获取最新微博数
    //但是此任务是系统根据内存、cpu使用情况决定的，有可能会被杀掉
    UIBackgroundTaskIdentifier task= [application beginBackgroundTaskWithExpirationHandler:^{
        //停止任务
        [application endBackgroundTask:task];
        
    }];
    
    //这里可以伪造一下音频使用
    //利用一个0kb的mp3，循环播放
    
    
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//接受到内存警告时，这里要停止图片下载，并清空下载图片缓存
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //取消下载
    SDWebImageManager *manage=[SDWebImageManager sharedManager];
    [manage cancelAll];
    
    //清除缓存
    [manage.imageCache clearMemory];
    
    
}


@end
