    //
//  NSBundle+NSBundle_ReloadNib.m
//  CSMBP
//
//  Created by 寒山凤鸣 on 12-5-29.
//  Copyright (c) 2012年 Forever OpenSource Software Inc. All rights reserved.
//

#import "NSBundle+NSBundle_ReloadNib.h"

@implementation NSBundle (NSBundle_ReloadNib)

- (NSArray *)loadNibNamed:(NSString *)name owner:(id)owner options:(NSDictionary *)options;
{
//    name = @"SetLanguageController";
//    owner = nil;
//    NSURL *nibURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"nib" subdirectory:nil localization:@"en"];
//    NSURL *nibURL2 = [[NSBundle mainBundle] URLForResource:name withExtension:@"nib" subdirectory:nil localization:@"zh-Hans"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"nib" inDirectory:nil forLocalization:@"en"];
    
    NSString *local = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCAL"];
    
    if (local == nil) {
        local = @"zh-Hans";
    }
    
    
    NSString *directoryName = [NSString stringWithFormat:@"%@.lproj",local];
    NSString *localizedNibPath=@"";
    if (iPhone5) {
        localizedNibPath=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_retina4",name] ofType:@"nib"];
        
    }
    
    if (localizedNibPath.length<=0) {
        //default non-localized nib
        localizedNibPath = [[NSBundle mainBundle] pathForResource:name ofType:@"nib"];
    }else
    {
        name=[NSString stringWithFormat:@"%@_retina4",name];
    }
   
    
    if (![name isEqualToString:@"MainWindow"]) {
        //find localized nib
        NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"nib" inDirectory:directoryName];
        for (NSString *path in paths) {
            if ([path hasSuffix:[NSString stringWithFormat:@"/%@.nib", name]]) {
                localizedNibPath = path;
            }
        }
    }
    
    NSData *nibData = [NSData dataWithContentsOfFile:localizedNibPath];
    
    UINib *nib = [UINib nibWithData:nibData bundle:nil];
    
    NSArray *objs = [nib instantiateWithOwner:owner options:options];
    
    return objs;
}
@end
