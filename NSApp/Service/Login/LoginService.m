//
//  LoginService.m
//  NSApp
//
//  Created by DongCai on 7/28/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "LoginService.h"
#import "NSObject+propertyList.h"
#import "JSONKit.h"

static LoginService *singleton = nil;
@implementation LoginService
@synthesize delegate = _delegate;

+(LoginService *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [LoginService new];
    });
    return singleton;

}
-(void)login:(SEL)finish fail:(SEL)fail delegate:(id)aDelegate{
    NSLog(@"bad");
    _didFinishSelector = finish;
    _delegate = aDelegate;
    _httpRequest = [[BaseApiClient alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_userName,@"userName",_passWord,@"passWord", nil];
    [_httpRequest requestJsonDataWithPath:LOGIN_URL withParams:params delegate:self withMethodType:@"POST" didFinishSelector:@selector(requestFinished:) didFailSelector:@selector(requestFailed:)];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *content = [request responseData];
    NSDictionary *kitData = [content objectFromJSONData];
    NSLog(@"%@",kitData);
    if([[kitData objectForKey:@"Code"] isEqualToString:@"true"]){
        _login = getObjectFromDic([LoginItem class],[kitData objectForKey:@"result"]);
        
        NSLog(@"name: %@",_login.name);
        NSLog(@"uid: %@",_login.uid);
        NSLog(@"token: %@",_login.token);
        if (_delegate && [_delegate respondsToSelector:_didFinishSelector]) {
            //成功
//            dispatch_sync(dispatch_get_main_queue(), ^{
            [_delegate performSelector:_didFinishSelector withObject:_login];
//            });
        }

        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录成功" message:[NSString stringWithFormat:@"用户名: %@ uid: %@ token: %@",_login.name,_login.uid,_login.token] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"账号密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request);
    NSError *error = nil;
}

@end
