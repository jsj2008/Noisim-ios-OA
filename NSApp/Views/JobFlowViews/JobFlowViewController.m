//
//  JobFlowViewController.m
//  NSApp
//
//  Created by DongCai on 8/10/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "JobFlowViewController.h"

@interface JobFlowViewController ()

@end

@implementation JobFlowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _b_label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 160, 20)];
        _b_label.text = @"申请请假单";
        [self.view addSubview:_b_label];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作流";
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
