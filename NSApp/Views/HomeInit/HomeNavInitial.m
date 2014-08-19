//
//  HomeNavInitial.m
//  NSApp
//
//  Created by DongCai on 8/10/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "HomeNavInitial.h"
#import "MainViewController.h"
#import "MessagesViewController.h"
#import "SettingViewController.h"
#import "DealViewController.h"
#import "BaseNavigationViewController.h"

#define TABBER_ITEM_TEXT_FONT_SIZE 14.0


@implementation HomeNavInitial

+(NSArray *)titles
{
    NSArray *array = [NSArray arrayWithObjects:@"应用", @"代办", @"消息", @"设置", nil];
    return array;
}
+(UITabBarController *)initTabBar
{
    NSArray *titles = [HomeNavInitial titles];
    UITabBarController *tabbar = [[UITabBarController alloc]init];
    
    MainViewController *mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    BaseNavigationViewController *nav1 = [[BaseNavigationViewController alloc]initWithRootViewController:mainVC];
    //    nav1.tabBarItem.image = [UIImage imageNamed:@"53-house.png"];
    nav1.tabBarItem.title = [titles objectAtIndex:0];
    [self custumTabbarItem:nav1.tabBarItem];
    [nav1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"zixun_an.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"zixun.png"]];
    
    DealViewController *dealVC = [[DealViewController alloc]init];
    BaseNavigationViewController *nav2 = [[BaseNavigationViewController alloc]initWithRootViewController:dealVC];
    //    nav1.tabBarItem.image = [UIImage imageNamed:@"53-house.png"];
    nav2.tabBarItem.title = [titles objectAtIndex:1];
    [self custumTabbarItem:nav2.tabBarItem];
    [nav2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"zixun_an.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"zixun.png"]];
    
    MessagesViewController *msgVC = [[MessagesViewController alloc]init];
    BaseNavigationViewController *nav3 = [[BaseNavigationViewController alloc]initWithRootViewController:msgVC];
    //    nav1.tabBarItem.image = [UIImage imageNamed:@"53-house.png"];
    nav3.tabBarItem.title = [titles objectAtIndex:2];
    [self custumTabbarItem:nav3.tabBarItem];
    [nav1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"zixun_an.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"zixun.png"]];
    
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    BaseNavigationViewController *nav4 = [[BaseNavigationViewController alloc]initWithRootViewController:settingVC];
    //    nav1.tabBarItem.image = [UIImage imageNamed:@"53-house.png"];
    nav4.tabBarItem.title = [titles objectAtIndex:3];
    [self custumTabbarItem:nav4.tabBarItem];
    [nav4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"zixun_an.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"zixun.png"]];
    
    tabbar.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    [tabbar.tabBar setBackgroundColor:[UIColor blackColor]];
    [tabbar.tabBar setTintColor:[UIColor blackColor]];
    return tabbar;
}

+(void)custumTabbarItem:(UITabBarItem *)tabBarItem
{
    UIEdgeInsets tabBarItemInsets = UIEdgeInsetsMake(4, 0, -8, 0);//统一的背景图片偏移
    UIColor *unSelectedFontColor = [UIColor colorWithRed:77.0/255.0 green:143.0/255.0 blue:12.0/255.0 alpha:1.0];//非选中状态下的文本颜色
    //背景图片的偏移
    tabBarItem.imageInsets = tabBarItemInsets;
    //选中标题的文本属性
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIFont systemFontOfSize:TABBER_ITEM_TEXT_FONT_SIZE], UITextAttributeFont, nil] forState:UIControlStateSelected];
    //非选中标题的文本属性
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:unSelectedFontColor, UITextAttributeTextColor, [UIFont systemFontOfSize:TABBER_ITEM_TEXT_FONT_SIZE], UITextAttributeFont, nil] forState:UIControlStateNormal];
    //将标题文本向上偏移
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
}


@end
