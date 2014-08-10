//
//  HomeNavInitial.m
//  NSApp
//
//  Created by DongCai on 8/10/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "HomeNavInitial.h"

@implementation HomeNavInitial

+(NSArray *)titles
{
    NSArray *array = [NSArray arrayWithObjects:@"合同管理", @"工作流", @"绩效管理", @"薪资管理", @"人力资源", @"考勤管理", @"我的日程", @"公告", @"其它", nil];
    return array;
}
+(UITabBarController *)initTabBar
{
    UITabBarController *nav = [[UITabBarController alloc]init];
    return nav;
}

@end
