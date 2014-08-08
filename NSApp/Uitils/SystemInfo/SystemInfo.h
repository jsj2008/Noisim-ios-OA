//
//  SystemInfo.h
//  NSApp
//
//  Created by DongCai on 7/29/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfo : NSObject

+(NSString*)appVersion;
+(NSString*)systemVersion;
+(NSString*)pushToke;
+(NSString*)uniqueDeviceIdentifier;

+(NSString*)systemInfo;
@end
