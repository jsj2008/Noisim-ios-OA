//
//  MainViewController.h
//  NSApp
//
//  Created by DongCai on 8/6/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "BaseViewController.h"
#import "BusinessViewController.h"
#import "JobFlowViewController.h"
#import "PerformanceViewController.h"
#import "NotificationViewController.h"
#import "SalaryManageViewController.h"
#import "HumanResourceViewController.h"
#import "MyScheduleViewController.h"
#import "AttendanceViewController.h"
#import "OthersViewController.h"

@interface MainViewController : BaseViewController

//模块按钮
@property (retain, nonatomic) IBOutlet UIButton *businessMateBtn;
//@property (retain, nonatomic) IBOutlet UIButton *projectManagerBtn;
@property (retain, nonatomic) IBOutlet UIButton *performanceBtn;
@property (retain, nonatomic) IBOutlet UIButton *salaryManagerbtn;
@property (retain, nonatomic) IBOutlet UIButton *humanResoucebtn;
@property (retain, nonatomic) IBOutlet UIButton *jobFlowBtn;
@property (retain, nonatomic) IBOutlet UIButton *attendanceBtn;
@property (retain, nonatomic) IBOutlet UIButton *notificationBtn;
@property (retain, nonatomic) IBOutlet UIButton *scheduleBtn;
@property (retain, nonatomic) IBOutlet UIButton *otherBtn;

//模块标签
@property (retain, nonatomic) IBOutlet UILabel *businessMateLab;
//@property (retain, nonatomic) IBOutlet UILabel *projectManagerLab;
@property (retain, nonatomic) IBOutlet UILabel *performanceLab;
@property (retain, nonatomic) IBOutlet UILabel *salaryManagerLab;
@property (retain, nonatomic) IBOutlet UILabel *humanResouceLab;
@property (retain, nonatomic) IBOutlet UILabel *jobFlowLab;
@property (retain, nonatomic) IBOutlet UILabel *attendanceLab;
@property (retain, nonatomic) IBOutlet UILabel *notificationLab;
@property (retain, nonatomic) IBOutlet UILabel *scheduleLab;
@property (retain, nonatomic) IBOutlet UILabel *otherLab;

//下面的按钮
@property (retain, nonatomic) IBOutlet UIButton *webBtn;
@property (retain, nonatomic) IBOutlet UIButton *languageBtn;//简体，繁体
@property (retain, nonatomic) IBOutlet UIButton *helpBtn;

//@property (strong, nonatomic) UINavigationController *navController;
//各个模块入口
@property (strong, nonatomic) BusinessViewController *businessView;
@property (strong, nonatomic) JobFlowViewController *jobFlowView;
@property (strong, nonatomic) PerformanceViewController *performanceView;
@property (strong, nonatomic) SalaryManageViewController *salaryView;
@property (strong, nonatomic) HumanResourceViewController *hrView;
@property (strong, nonatomic) MyScheduleViewController *myScheduleView;
@property (strong, nonatomic) AttendanceViewController *attendanceView;
@property (strong, nonatomic) NotificationViewController *notificationView;
@property (strong, nonatomic) OthersViewController *othersView;

//btn function
- (void)didClickBusinessMate:(id)sender;
- (void)didClickProjectManager:(id)sender;
- (void)didClickPefermance:(id)sender;
- (void)didClickSalaryManager:(id)sender;
- (void)didClickHumanResource:(id)sender;
- (void)didClickJobFlow:(id)sender;
- (void)didClickAttendance:(id)sender;
- (void)didClickedNotification:(id)sender;
- (void)goOA:(id)sender;
- (void)callPhone:(id)sender;
- (void)checkLanguage:(id)sender;
- (void)didClickSchedule:(id)sender;
- (void)didClickOther:(id)sender;

- (void)doPushQuerySuccess:(id)obj;
- (void)doPushQueryFail:(NSError*)error;
- (void)skinManageControl;
- (IBAction)changeSkin:(id)sender;

@end
