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
    NSString *_path;
    BOOL withOutVersionCheck;
}
@property (strong,nonatomic)ASIHTTPRequest *request;
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                       delegate:(id)aDelegate
                 withMethodType:(NSString *)NetworkMethod
              didFinishSelector:(SEL)aDidFinishSelector
                didFailSelector:(SEL)aDidFailSelector;

- (void)requestXmlDataWithPath:(NSString *)aPath
                    withParams:(NSMutableDictionary*)params
                      delegate:(id)aDelegate
                withMethodType:(NSString *)NetworkMethod
             didFinishSelector:(SEL)aDidFinishSelector
               didFailSelector:(SEL)aDidFailSelector;

@end
