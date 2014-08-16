//
//  BaseApiClient.m
//  NSApp
//
//  Created by DongCai on 7/27/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "BaseApiClient.h"
#import "MBProgressController.h"
#import "RequestCacheService.h"
#import "JSONKit.h"

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
    [_request setDidFinishSelector:@selector(finishedRequest:)];
    [_request setDidFailSelector:@selector(failedRequest:)];
    [_request setRequestMethod:NetworkMethod];
    _request.delegate = self;
    
}
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                       delegate:(id)aDelegate
                 withMethodType:(NSString *)NetworkMethod
              didFinishSelector:(SEL)aDidFinishSelector
                didFailSelector:(SEL)aDidFailSelector
                withCachePolicy:(CachePolicy)cachePolicy
{
    NSString *path = aPath;
    
    _didFinishRequest = aDidFinishSelector;
    _didFailRequest = aDidFailSelector;
    _delegate = aDelegate;
    //获取缓存时间
    NSInteger cacheExpireInterval = [self getCacheIntervalForPolicy:cachePolicy];
    //模式为需要缓存，则进行读取缓存操作，Put方法不做缓存
    if (cacheExpireInterval > 0 && ![NetworkMethod isEqualToString:@"PUT"]) {
        id cachedObject = [[RequestCacheService getService] checkCacheForURL:path AndParams:params AndExpireInterval:cacheExpireInterval];
        if (cachedObject) {
            NSLog(@"命中请求缓存，直接返回结果");
            if (_delegate && [_delegate respondsToSelector:_didFinishRequest]) {
                [_delegate performSelector:_didFinishRequest withObject:cachedObject];
                return;
            }
        }
    }
    policy = cachePolicy;
    c_path = aPath;
    c_params = params;
    NSLog(@"请求参数===>%@", params);
    [self requestJsonDataWithPath:aPath withParams:params delegate:aDelegate withMethodType:NetworkMethod didFinishSelector:aDidFinishSelector didFailSelector:aDidFailSelector];
    
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
#pragma request-delegate
-(void)finishedRequest:(ASIHTTPRequest *)request
{
    NSData *content = [request responseData];
    NSDictionary *kitData = [content objectFromJSONData];
    NSLog(@"%@",kitData);
    if (policy != NoCache) {
        [[RequestCacheService getService]cacheObject:kitData ForURL:c_path AndParams:c_params];
    }
    if (_delegate && [_delegate respondsToSelector:_didFinishRequest]) {
        
        [_delegate performSelector:_didFinishRequest withObject:kitData];
    }
}
-(void)failedRequest:(ASIHTTPRequest *)request
{
    NSLog(@"bad in baseRequest");
}
#pragma cache-check
-(NSInteger)getCacheIntervalForPolicy:(CachePolicy)cachePolicy
{
    NSInteger cacheExpireInterval;
    if (cachePolicy == NoCache) {
        cacheExpireInterval = -1;
    } else if (cachePolicy == Notice) {
        //读取资讯的缓存设置
        NSNumber *stored = [[NSUserDefaults standardUserDefaults] objectForKey:CACHE_LOGIN_KEY];
        if (stored != nil && stored.integerValue > 0) {
            cacheExpireInterval = stored.integerValue;
        } else {
            NSLog(@"未获取到资讯的缓存时间，采用默认3600秒");
            cacheExpireInterval = 3600;
        }
    } else if (cachePolicy == Product) {
        //读取产品的缓存设置
        NSNumber *stored = [[NSUserDefaults standardUserDefaults] objectForKey:CACHE_LOGIN_KEY];
        if (stored != nil && stored.integerValue > 0) {
            cacheExpireInterval = stored.integerValue;
        } else {
            NSLog(@"未获取到资讯的缓存时间，采用默认3600秒");
            cacheExpireInterval = 3600;
        }
    } else {
        cacheExpireInterval = 3600;
    }
    return cacheExpireInterval;
}

@end
