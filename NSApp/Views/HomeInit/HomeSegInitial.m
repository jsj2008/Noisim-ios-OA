//
//  HomeSegInitial.m
//  NSApp
//
//  Created by DongCai on 9/3/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "HomeSegInitial.h"
#import "HMSegmentedControl.h"
#import "DealViewController.h"
#import "MessagesViewController.h"
#import "MainViewController.h"


@implementation HomeSegInitial

+(NSArray *)titles
{
    NSArray *array = [NSArray arrayWithObjects:@"待办事项", @"消息", @"所有应用", nil];
    return array;
}
+(NSArray *)views
{
    DealViewController *dealVC = [[DealViewController alloc]init];
    [dealVC.view setFrame:CGRectMake(0, 95, 280, 360)];
    
    MessagesViewController *msgVC = [[MessagesViewController alloc]init];
    [msgVC.view setFrame:CGRectMake(0, 95, 280, 360)];
    MainViewController *mainVC = [[MainViewController alloc]init];
    [mainVC.view setFrame:CGRectMake(0, 95, 280, 360)];
    NSArray *array = [NSArray arrayWithObjects:dealVC, msgVC, mainVC, nil];
    return array;
}
+(HMSegmentedControl *)initSegmentControl
{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:[HomeSegInitial titles]];
    [segmentedControl setFrame:CGRectMake(0, 60, 320, 30)];
    return segmentedControl;
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);
}

@end
