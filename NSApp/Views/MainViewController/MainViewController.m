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
#import "BusinessViewController.h"
#import "BaseNavigationViewController.h"
#import "BootViewController.h"

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
    [_businessMateBtn addTarget:self action:@selector(didClickBusinessMate:) forControlEvents:UIControlEventTouchUpInside];
    [_humanResoucebtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_humanResoucebtn setTitle:nil forState:0];
    [_humanResoucebtn addTarget:self action:@selector(didClickHumanResource:) forControlEvents:UIControlEventTouchUpInside];
    [_jobFlowBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_jobFlowBtn setTitle:nil forState:0];
    [_jobFlowBtn addTarget:self action:@selector(didClickJobFlow:) forControlEvents:UIControlEventTouchUpInside];
    [_attendanceBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_attendanceBtn setTitle:nil forState:0];
    [_attendanceBtn addTarget:self action:@selector(didClickAttendance:) forControlEvents:UIControlEventTouchUpInside];
    [_salaryManagerbtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_salaryManagerbtn setTitle:nil forState:0];
    [_salaryManagerbtn addTarget:self action:@selector(didClickSalaryManager:) forControlEvents:UIControlEventTouchUpInside];
    [_otherBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_otherBtn setTitle:nil forState:0];
    [_otherBtn addTarget:self action:@selector(didClickOther:) forControlEvents:UIControlEventTouchUpInside];
    [_notificationBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_notificationBtn setTitle:nil forState:0];
    [_notificationBtn addTarget:self action:@selector(didClickNotification:) forControlEvents:UIControlEventTouchUpInside];
    [_scheduleBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_scheduleBtn setTitle:nil forState:0];
    [_scheduleBtn addTarget:self action:@selector(didClickSchedule:) forControlEvents:UIControlEventTouchUpInside];
    [_performanceBtn setBackgroundImage:[UIImage imageNamed:@"icon_"] forState:0];
    [_performanceBtn setTitle:nil forState:0];
    [_performanceBtn addTarget:self action:@selector(didClickPefermance:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initViews
{
    _businessView = [[BusinessViewController alloc] init];
    _jobFlowView = [[JobFlowViewController alloc]init];
    _hrView = [[HumanResourceViewController alloc] init];
    _performanceView = [[PerformanceViewController alloc]init];
    _salaryView = [[SalaryManageViewController alloc] init];
    _notificationView = [[NotificationViewController alloc]init];
    _othersView = [[OthersViewController alloc] init];
    _attendanceView = [[AttendanceViewController alloc]init];
    _myScheduleView = [[MyScheduleViewController alloc] init];

}
#pragma btn-action
- (void)didClickBusinessMate:(id)sender
{
    BootViewController *t = (BootViewController *)self.view.superview.nextResponder;
    if(t)
        [t.navigationController pushViewController:_businessView animated:YES];
//    [nav pushViewController:_businessView animated:YES];
}
- (void)didClickJobFlow:(id)sender
{
    [self.navigationController pushViewController:_jobFlowView animated:YES];
}
- (void)didClickAttendance:(id)sender
{
    [self.navigationController pushViewController:_attendanceView animated:YES];
}
-(void)didClickHumanResource:(id)sender
{
    [self.navigationController pushViewController:_hrView animated:YES];
}
-(void)didClickNotification:(id)sender
{
    [self.navigationController pushViewController:_notificationView animated:YES];
}
-(void)didClickOther:(id)sender
{
    [self.navigationController pushViewController:_othersView animated:YES];
}
-(void)didClickSalaryManager:(id)sender
{
    [self.navigationController pushViewController:_salaryView animated:YES];
}
-(void)didClickSchedule:(id)sender
{
    [self.navigationController pushViewController:_myScheduleView animated:YES];
}
-(void)didClickPefermance:(id)sender
{
    [self.navigationController pushViewController:_performanceView animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBtn];
    [self initViews];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
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
