//
//  sdkCall.m
//  sdkDemo
//
//  Created by xiaolongzhang on 13-3-29.
//  Copyright (c) 2013年 xiaolongzhang. All rights reserved.
//

#import "sdkCall.h"
#import "sdkDef.h"
#import <TencentOpenAPI/TencentMessageObject.h>
#import "AFNetworking.h"
#import "AppDelegate.h"

static sdkCall *g_instance = nil;
@interface sdkCall()
@property (nonatomic, retain)NSArray* permissons;

@end

@implementation sdkCall

@synthesize oauth = _oauth;
@synthesize permissons = _permissons;
@synthesize photos = _photos;
@synthesize thumbPhotos = _thumbPhotos;

+ (sdkCall *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[sdkCall alloc] init];
            g_instance = [[super allocWithZone:nil] init];
            [g_instance setPhotos:[NSMutableArray arrayWithCapacity:1]];
            [g_instance setThumbPhotos:[NSMutableArray arrayWithCapacity:1]];
        }
    }

    return g_instance;
}



+ (void)showInvalidTokenOrOpenIDMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)resetSDK
{
    g_instance = nil;
}

- (id)init
{
//    if (self = [super init])
//    {
        NSString *appid = QQAppKey;
        _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                                andDelegate:self];
        
    //}
    return self;
}

- (void)tencentDidLogin
{
  
    
    if (_oauth.accessToken && 0 != [_oauth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
//        showAlert(_oauth.openId);
          NSLog(@"openId:%@    token:%@   appid:%@",_oauth.openId,_oauth.accessToken,_oauth.appId);
//        
//        //https://graph.qq.com/user/get_simple_userinfo?access_token=1234ABD1234ABD&oauth_consumer_key=12345& openid=B08D412EEC4000FFC37CAABBDC1234CC&format=json
//        
//        
//        //2.根据uid调用接口获取用户信息，返回dictionary
//        AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
//        
//        NSMutableDictionary *parms=[NSMutableDictionary dictionary];
//        parms[@"access_token"]=_oauth.accessToken;
//        parms[@"oauth_consumer_key"]=_oauth.appId;
//        parms[@"openid"]=_oauth.openId;
//        
//        [manage GET:@"https://graph.qq.com/user/get_simple_userinfo" parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            YJLog(@"通过qq授权后获取用户信息success----%@",responseObject);
//            //可以取出昵称(name)、头像(profile_image_url)等
//            //
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            YJLog(@"通过qq授权后获取用户信息error-----%@",error);
//        }];
        
        [_oauth getUserInfo];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCancelled object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{

}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    return YES;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}


- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"getUserInfoResponse  %@",response.jsonResponse);
    
    AppDelegate * tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    tempAppDelegate.window.rootViewController=tempAppDelegate.LeftSlideVC;

    
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListPhotoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListPhotoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}   


- (void)checkPageFansResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCheckPageFansResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addShareResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddShareResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)uploadPicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUploadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addOneBlogResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddOneBlogResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addTopicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddTopicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)setUserHeadpicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSetUserHeadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipRichInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipRichInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)sendStoryResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendStoryResponse object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData
{
    
}


- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:tencentOAuth, kTencentOAuth,
                                                                        viewController, kUIViewController, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCloseWnd object:self  userInfo:userInfo];
}


@end
