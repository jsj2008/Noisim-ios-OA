//
//  LoginService.h
//  NSApp
//
//  Created by DongCai on 7/28/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiClient.h"
#import "LoginItem.h"

@interface LoginService : NSObject
{
    LoginItem *loginItem;
    id _delegate;
    SEL _didFinishSelector;
    SEL _didFailSelector;
}

@property (strong,nonatomic)BaseApiClient *httpRequest;
@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *passWord;
@property (strong,nonatomic)LoginItem *login;
@property (strong,nonatomic)id delegate;

+(LoginService *)shareInstance;
-(NSString *)returnTimeStampe;
+(NSString *)cryptoByDES:(NSString *)userName passWord:(NSString *)passWord;
-(void)login:(SEL)finish fail:(SEL)fail delegate:(id)aDelegate;
@end
