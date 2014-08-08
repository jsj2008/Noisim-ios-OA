//
//  BaseApiClient.m
//  NSApp
//
//  Created by DongCai on 7/27/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "BaseApiClient.h"
#import "MBProgressController.h"

@implementation BaseApiClient
//GET,POST,PUT,DELETE
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidEnterBackground" object:nil];
    [_request clearDelegatesAndCancel];
}
- (void)requestInitAndSetting:(NSString *)aPath
                     delegate:(id)aDelegate
               withMethodType:(NSString *)NetworkMethod
            didFinishSelector:(SEL)aDidFinishSelector
              didFailSelector:(SEL)aDidFailSelector
{
    //-------------捕捉没有网络的异常，不进业务逻辑请求-----------------------------
    if (![ASIHTTPRequest isNetworkReachable])
    {
        kAlert(@"网络异常，请检查您的网络环境！");
        return;
    }
    //------------------------------------------------------------------------/
    
    //取消已有请求
    if (_request != nil) {
        [_request clearDelegatesAndCancel];
        _request = nil;
    }
    NSURL* parsedURL = [NSURL URLWithString:aPath];
    NSLog(@"%@",aPath);
    _request = [[ASIHTTPRequest alloc ] initWithURL:parsedURL];
    _request.timeOutSeconds = 60;
    [_request setDidFinishSelector:aDidFinishSelector];
    [_request setDidFailSelector:aDidFailSelector];
    [_request setRequestMethod:NetworkMethod];
    _request.delegate = aDelegate;
    
}
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                       delegate:(id)aDelegate
                 withMethodType:(NSString *)NetworkMethod
              didFinishSelector:(SEL)aDidFinishSelector
                didFailSelector:(SEL)aDidFailSelector
{
    
    [self requestInitAndSetting:aPath delegate:aDelegate withMethodType:NetworkMethod didFinishSelector:aDidFinishSelector didFailSelector:aDidFailSelector];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error: &error];
    NSMutableData *body = [NSMutableData dataWithData:jsonData];
    if([NetworkMethod  isEqual: @"POST"] || [NetworkMethod  isEqual: @"PUT"]){
        [_request setPostBody:body];
    }
    [_request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [_request addRequestHeader:@"Accept" value:@"application/json"];
    
    [_request startAsynchronous];
    
    if([self respondsToSelector:@selector(applicationDidEnterBackground)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    }
}

//xml todo analyse xml-data and append-data
- (void)requestXmlDataWithPath:(NSString *)aPath
                    withParams:(NSMutableDictionary*)params
                      delegate:(id)aDelegate
                withMethodType:(NSString *)NetworkMethod
             didFinishSelector:(SEL)aDidFinishSelector
               didFailSelector:(SEL)aDidFailSelector
{
    [self requestInitAndSetting:aPath delegate:aDelegate withMethodType:NetworkMethod didFinishSelector:aDidFinishSelector didFailSelector:aDidFailSelector];
    
    [_request addRequestHeader:@"Content-Type" value:@"text/xml"];
    
    [_request startAsynchronous];
    
    if([self respondsToSelector:@selector(applicationDidEnterBackground)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    }
}
-(void)applicationDidEnterBackground{
    NSLog(@"进入后台-------------------");
    [_request clearDelegatesAndCancel];
    [MBProgressController dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidEnterBackground" object:nil];
}
#pragma MBProgress delegate
-(void)cancelTheRequest
{
    [_request clearDelegatesAndCancel];
}
//init MBProgressController
-(void)MBProgressControllerInit
{
#ifdef Device_Pad
    if (!withOutVersionCheck && ![self isIPadShowGuidance])
    {
        MBProgressController *tempProgressController=[MBProgressController getCurrentController];
        [_request setDownloadProgressDelegate:tempProgressController];
        [MBProgressController getCurrentController].delegate=self;
        [MBProgressController startQueryProcess];
        
    }
#else
    if (!withOutVersionCheck)
    {
        MBProgressController *tempProgressController=[MBProgressController getCurrentController];
        [_request setDownloadProgressDelegate:tempProgressController];
        [MBProgressController getCurrentController].delegate=self;
        [MBProgressController startQueryProcess];
        
    }
#endif
}
@end
