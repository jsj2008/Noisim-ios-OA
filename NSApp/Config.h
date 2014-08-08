//
//  Config.h
//  NSApp
//
//  Created by DongCai on 7/30/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

//#import <Foundation/Foundation.h>

extern NSString *BASE_SERVER_URL;
#define LOGIN_URL [BASE_SERVER_URL stringByAppendingString:@"/echo/123"]

#define kAlert(_S_) [[[UIAlertView alloc] initWithTitle:@"提示" message:_S_ delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//----------------判断是否是RETINA屏--------------------------
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
