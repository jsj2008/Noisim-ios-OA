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
    UITabBarController *tabbar = [HomeNavInitial initTabBar];
    UIWindow *aWindow =(UIWindow*)[[UIApplication sharedApplication].windows objectAtIndex:0];
    aWindow.rootViewController = tabbar;
    tabbar.delegate = appDelegate;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initRootViews];
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
