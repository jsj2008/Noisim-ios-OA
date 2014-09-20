//
//  BootViewController.m
//  NSApp
//
//  Created by DongCai on 8/19/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "BootViewController.h"
#import "HomeNavInitial.h"
#import "AppDelegate.h"
#import "HomeSegInitial.h"
#import "DealViewController.h"
#import "MessagesViewController.h"
#import "MainViewController.h"
#import "BaseNavigationViewController.h"


@interface BootViewController ()

@end

@implementation BootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView{
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *aView= [[UIView alloc] initWithFrame:appFrame];
    aView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view = aView;
    [self.view addSubview:[self subView]];
//    [self bootCheckRequest];
}
-(UIView*)subView
{
    UIImage *bgImage=nil;
    bgImage = [UIImage imageNamed:@"Default.png"];
    CGRect frame = CGRectMake(0, -20, bgImage.size.width, bgImage.size.height);
	UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
	backgroundImageView.image = bgImage;
    return backgroundImageView;
}
- (void)initRootViews
{
    [self.view removeFromSuperview];
    _segment = [HomeSegInitial initSegmentControl];
    [_segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    _vc = [[HomeSegInitial views]objectAtIndex:0];
    [self.view addSubview:_vc.view];
//    UITabBarController *tabbar = [HomeNavInitial initTabBar];
//    UIWindow *aWindow =(UIWindow*)[[UIApplication sharedApplication].windows objectAtIndex:0];
//    aWindow.rootViewController = nav;
//    self.title = @"主页";
//;    tabbar.delegate = appDelegate;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);
    [_vc.view removeFromSuperview];
    _vc = [[HomeSegInitial views]objectAtIndex:segmentedControl.selectedIndex];
    [self.view addSubview:_vc.view];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initRootViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.title=@"主页";
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
