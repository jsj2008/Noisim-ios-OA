//
//  SystemInfo.m
//  NSApp
//
//  Created by DongCai on 7/29/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "SystemInfo.h"
#import "NSString+MD5Addtion.h"
#import "KeychainItemWrapper.h"

static SystemInfo *singleton = nil;
@implementation SystemInfo

+(SystemInfo*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [SystemInfo new];
    });
    return singleton;
}
+(NSString*)appVersion
{
    NSString *app_Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return app_Version;
}
+(NSString*)systemVersion
{
    NSString *OS_version = [[UIDevice currentDevice] systemVersion];
    return OS_version;
}
+(NSString*)pushToke
{
    NSString *pushToke =[[NSUserDefaults standardUserDefaults]objectForKey:@"pushToken"];
    return pushToke;
}
+(NSString*)uniqueDeviceIdentifier
{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *stringToHashNew = [NSString stringWithFormat:@"%@%@",[singleton keychainItemString],bundleIdentifier];
    NSString *uniqueIdentifierNew = [stringToHashNew stringFromMD5];
    return uniqueIdentifierNew;

}
-(NSString*)keychainItemString
{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
                                         initWithIdentifier:bundleIdentifier accessGroup:nil];
    NSString *strUUID = [keychainItem objectForKey:(__bridge id)kSecValueData];
    if ([strUUID isEqualToString:@""])
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        [keychainItem setObject:strUUID forKey:(__bridge id)kSecValueData];
    }
    return [keychainItem objectForKey:(__bridge id)kSecValueData];
}

+(NSString*)systemInfo
{
    NSString *deviceType=@"";
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPhone)
    {
        deviceType=@"iphone";
    }else
    {
        deviceType=@"ipad";
    }
    NSString *sysInfo =[NSString stringWithFormat:@"/DeviceType=%@&AppVersion=%@&SystemVersion=%@&UniqueDeviceIdentifier=%@",deviceType,[self appVersion],[self systemVersion],[self uniqueDeviceIdentifier]];
    return sysInfo;
}
@end
