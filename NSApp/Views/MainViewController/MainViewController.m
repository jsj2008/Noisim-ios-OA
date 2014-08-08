//
//  MainViewController.m
//  NSApp
//
//  Created by DongCai on 8/6/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

//皮肤管理加载目录
#define CURSKINPREFIX @"CurSkin"
#define SkinLoadDirectoryPrefix [NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"SandBoxSkinManage/themeResource",[[NSUserDefaults standardUserDefaults] objectForKey:CURSKINPREFIX]]
//size 3.5
#define BTN_JIPIAOYUDING_SIZE_3_5_NORMAL  [NSString stringWithFormat:@"%@/%@",SkinLoadDirectoryPrefix,@"icon_.png"]
#define BTN_JIPIAOYUDING_SIZE_3_5_RETINA  [NSString stringWithFormat:@"%@/%@",SkinLoadDirectoryPrefix,@"icon_@2x.png"]
#define BTN_JIPIAOYUDING_SIZE_3_5 (isRetina? BTN_JIPIAOYUDING_SIZE_3_5_RETINA:BTN_JIPIAOYUDING_SIZE_3_5_NORMAL)

//size 4
#define BTN_JIPIAOYUDING_SIZE_4  [NSString stringWithFormat:@"%@/%@",SkinLoadDirectoryPrefix,@"icon_retina4.png"]

#define BTN_JIPIAOYUDING (iPhone5? BTN_JIPIAOYUDING_SIZE_4:BTN_JIPIAOYUDING_SIZE_3_5)

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
- (void)initBtn
{
    [_businessMateBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_businessMateBtn setTitle:nil forState:0];
    [_humanResoucebtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_humanResoucebtn setTitle:nil forState:0];
    [_jobFlowBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_jobFlowBtn setTitle:nil forState:0];
    [_attendanceBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_attendanceBtn setTitle:nil forState:0];
    [_salaryManagerbtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_salaryManagerbtn setTitle:nil forState:0];
    [_otherBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_otherBtn setTitle:nil forState:0];
    [_notificationBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_notificationBtn setTitle:nil forState:0];
    [_scheduleBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_scheduleBtn setTitle:nil forState:0];
    [_performanceBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_performanceBtn setTitle:nil forState:0];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.businessMateBtn setImage:[UIImage imageWithContentsOfFile:BTN_JIPIAOYUDING] forState:UIControlStateNormal];
//    [_businessMateBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [self initBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
