//
//  AppDelegate.h
//  NSApp
//
//  Created by DongCai on 7/26/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseApiClient.h"

@class LoginService;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginService *login;
@end
