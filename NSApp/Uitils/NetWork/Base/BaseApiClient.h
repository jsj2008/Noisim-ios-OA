//
//  BaseApiClient.h
//  NSApp
//
//  Created by DongCai on 7/27/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import "API.h"
#import "MBProgressHUD.h"

#import "MBProgressController.h"

typedef enum {
	Get = 0,
	Post,
	Put,
    Delete
} NetworkMethod;

typedef enum {
    NoCache = 0,
    Notice,
    Product,
    Unknown
}CachePolicy;
@protocol QueryDelegate <NSObject>

@optional
-(id)parseResponse:(id)aData;
-(id)parseResponse:(id)aData error:(NSError**)aError;
@end
@interface BaseApiClient : NSObject<QueryDelegate, MBProgressControllerDelegate>
{
    ASIHTTPRequest *_request;
    SEL _didFinishRequest;
    SEL _didFailRequest;
    id _delegate;
    NSString *_path;
    CachePolicy policy;
    NSString *c_path;
    NSMutableDictionary *c_params;
    BOOL withOutVersionCheck;
}
@property (strong,nonatomic)ASIHTTPRequest *request;
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                       delegate:(id)aDelegate
                 withMethodType:(NSString *)NetworkMethod
              didFinishSelector:(SEL)aDidFinishSelector
                didFailSelector:(SEL)aDidFailSelector __attribute__((deprecated));

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                       delegate:(id)aDelegate
                 withMethodType:(NSString *)NetworkMethod
              didFinishSelector:(SEL)aDidFinishSelector
                didFailSelector:(SEL)aDidFailSelector
                withCachePolicy:(CachePolicy)cachePolicy;

- (void)requestXmlDataWithPath:(NSString *)aPath
                    withParams:(NSMutableDictionary*)params
                      delegate:(id)aDelegate
                withMethodType:(NSString *)NetworkMethod
             didFinishSelector:(SEL)aDidFinishSelector
               didFailSelector:(SEL)aDidFailSelector;

-(void)finishedRequest:(ASIHTTPRequest *)request;
-(void)failedRequest:(ASIHTTPRequest *)request;

@end
