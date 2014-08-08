//
//  UIDevice+MYDevice.m
//  NSApp
//
//  Created by DongCai on 8/6/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "UIDevice+MYDevice.h"

@implementation UIDevice (MYDevice)

+ (NSInteger)deviceSystemMajorVersion
{
    static NSInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

@end
